import { LightningElement, track, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import carsForSale from '@salesforce/resourceUrl/carsForSale'
import getOwnersRecords from '@salesforce/apex/DataCollector.getOwnersRecords';
import getShowrooms from '@salesforce/apex/DataCollector.getShowrooms';
import getCars from '@salesforce/apex/DataCollector.getCars';

export default class SelectCar extends LightningElement {
    @api isWelcomeModalClosed = false
    @api isCompanySelected = false
    @api isShowroomSelected = false
    @api isAskedForDetails = false
    // @api receivedId = false;
    @api isNoShowrooms = false;
    @api isNoCars = false;
    @api isLoading = false;
    
    @api chosenCarId;

    @track Owners;
    @track chosenShowrooms;
    @track chosenCars;

    _toastTitle;
    _toastMessage;


    carLogo = carsForSale;
    
    constructor(){
        super();
        this.isLoading = true;
        getOwnersRecords()
        .then(result => {
            this.Owners = result
        })
        .catch(error => {
            console.log('Constructor Error')
        })
        this.isLoading = false; 
    }

    askForShowrooms(event){
        
        // console.log('askForShowrooms testing spinner')
        this.isLoading = true;
        // console.log('askForShowrooms isLoading: ', this.isLoading);
        let id = event.currentTarget.dataset.id;
        setTimeout(() =>         
            getShowrooms({outOwner: id })
            .then(result => {
                // console.log('getShowrooms called');
                // console.log('isShowroomSelected: ', this.isShowroomSelected);

                {this.isShowroomSelected = false};
                // console.log('isShowroomSelected: ', this.isShowroomSelected);
                
                // console.log('isNoCars: ', this.isNoCars);
                {this.isNoCars = false};
                // console.log('isNoCars: ', this.isNoCars);
                
                // console.log('result.length: ', result.length);
                if (result.length > 0) {
                    // console.log('if >=0: isCompanySelected: ', this.isCompanySelected);
                    {this.isCompanySelected = true};
                    // console.log('if >=0: isCompanySelected: ', this.isCompanySelected);
                    // {this.isShowroomSelected = false};
                    // console.log('if >=0: isNoShowrooms', this.isNoShowrooms);
                    {this.isNoShowrooms = false};
                    // console.log('if >=0: isNoShowrooms', this.isNoShowrooms);
                    // {this.isNoCars = false};
                    // console.log('if >=0: chosenShowrooms:', this.chosenShowrooms);
                    {this.chosenShowrooms = result};
                    // console.log('if >=0: chosenShowrooms:', this.chosenShowrooms);
                    {this.isLoading = false};
                    console.log('getShowrooms isLoading: ', this.isLoading);
                }
                // else {
                //     {this.isCompanySelected = false};
                //     // {this.isShowroomSelected = false};
                //     {this.isNoShowrooms = true};
                //     // {this.isNoCars = false};
                // }

            })
            .catch(error => {
                // console.log('entered .catch');
                // console.log('.catch: isCompanySelected: ', this.isCompanySelected);

                {this.isCompanySelected = false};
                // console.log('.catch: isCompanySelected: ', this.isCompanySelected);

                // {this.isNoShowrooms = true};
                {this._toastTitle = 'Company selection:'};
                // console.log('_toastMessage:', this._toastMessage);
                {this._toastMessage = 'No showroms owned by selected company.'};
                // console.log('_toastMessage:', this._toastMessage);
                this.showToast();
                {this.isLoading = false};


                // console.error('Error - getShowrooms() for company Id = ' + id);
            })
        , 1500);

        this.isAskedForDetails = false;
        // this.template.querySelector('c-car-details').hideCArDetails();

    }

    askForCars(event){
        // console.log('askForCars isLoading start: ', this.isLoading);
        this.isLoading = true;
        console.log('askForCars isLoading changed: ', this.isLoading);
        let id = event.currentTarget.dataset.id;
        
        setTimeout(()=>
        getCars({outShowroom: id })
        .then(result => {
            if (result.length >= 1) {
                {this.isNoCars = false};
                {this.isShowroomSelected = true};
                {this.chosenCars = result};
                {this.isLoading = false};
                console.log('askForCars isLoading: ', this.isLoading);
            // } else {
            //     {this.isShowroomSelected = false};
            //     {this.isNoCars = true};
            };
        })
        .catch(error => {
            {this.isShowroomSelected = false};
            {this._toastTitle = 'Showroom selection:'}
            // {this.isNoCars = true};
            {this._toastMessage = 'No cars stored in selected showroom.'}
            this.showToast()
            this.isLoading = false;

            // console.log('Error - getCars() for showroom Id = ' + id);
        })
        , 1500);
        // this.template.querySelector('c-car-details').hideCArDetails();
        this.isAskedForDetails = false;
    }

    passCarId(event){
        this.isLoading = true;
        this.chosenCarId = event.currentTarget.dataset.id;
        // this.template.querySelector('c-car-details').askForCarDetails();
        this.isAskedForDetails = true;
        this.isLoading = false;
    }

    closeWelcomeModal(event){
        this.isWelcomeModalClosed = true;
    }

    showToast() {
        const event = new ShowToastEvent({
            title: this._toastTitle,
            message: this._toastMessage,
            variant: 'error',
            // mode: 'sticky'
        });
        this.dispatchEvent(event);
    }
}