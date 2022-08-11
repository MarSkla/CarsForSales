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

    @api isLoading = false;
    
    @api chosenCarId;

    @api Owners;
    @api chosenShowrooms;
    @api chosenCars;

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
            {this._toastTitle = 'Ups'};
            {this._toastMessage = 'There are no data for this app'};
            this.showToast();
        })
        this.isLoading = false; 
    }

    askForShowrooms(event){
        
        this.isLoading = true;
        let id = event.currentTarget.dataset.id;

        // setTimeout(() =>         
            getShowrooms({outOwner: id })
            .then(result => {
                {this.isShowroomSelected = false};

                if (result.length > 0) {
                    {this.isCompanySelected = true};
                    {this.chosenShowrooms = result};
                    {this.isLoading = false};
                    // console.log('getShowrooms isLoading: ', this.isLoading);
                }
            })
            .catch(error => {
                {this.isCompanySelected = false};
                {this._toastTitle = 'Company selection:'};
                {this._toastMessage = 'No showroms owned by selected company.'};
                this.showToast();
                {this.isLoading = false};
            })
        // , 1000);

        this.isAskedForDetails = false;

    }

    askForCars(event){
        this.isLoading = true;
        // console.log('askForCars isLoading changed: ', this.isLoading);
        let id = event.currentTarget.dataset.id;
        
        // setTimeout(()=>
        getCars({outShowroom: id })
        .then(result => {
            if (result.length >= 1) {
                {this.isShowroomSelected = true};
                {this.chosenCars = result};
                {this.isLoading = false};
                // console.log('askForCars isLoading: ', this.isLoading);

            };
        })
        .catch(error => {
            {this.isShowroomSelected = false};
            {this._toastTitle = 'Showroom selection:'}
            {this._toastMessage = 'No cars stored in selected showroom.'}
            this.showToast()
            this.isLoading = false;

        })
        // , 1000);
        this.isAskedForDetails = false;
    }

    passCarId(event){
        this.isLoading = true;
        this.chosenCarId = event.currentTarget.dataset.id;
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
            variant: 'warning',
        });
        this.dispatchEvent(event);
    }
}