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
        this.isLoading = true;
        let id = event.currentTarget.dataset.id;

        getShowrooms({outOwner: id })
        .then(result => {

            {this.isShowroomSelected = false};
            {this.isNoCars = false};
            
            if (result.length > 0) {
                {this.isCompanySelected = true};
                // {this.isShowroomSelected = false};
                {this.isNoShowrooms = false};
                // {this.isNoCars = false};
                {this.chosenShowrooms = result};
            }
            // else {
            //     {this.isCompanySelected = false};
            //     // {this.isShowroomSelected = false};
            //     {this.isNoShowrooms = true};
            //     // {this.isNoCars = false};
            // }
        })
        .catch(error => {
            {this.isCompanySelected = false};
            // {this.isNoShowrooms = true};
            this._toastMessage = 'No showroms owned by selected company.'
            this.showToast()

            // console.error('Error - getShowrooms() for company Id = ' + id);
        })
        
        this.isAskedForDetails = false;
        // this.template.querySelector('c-car-details').hideCArDetails();
        this.isLoading = false;
    }

    askForCars(event){
        this.isLoading = true;
        let id = event.currentTarget.dataset.id;

        getCars({outShowroom: id })
        .then(result => {
            if (result.length >= 1) {
                {this.isNoCars = false};
                this.isShowroomSelected = true;
                {this.chosenCars = result};
            // } else {
            //     {this.isShowroomSelected = false};
            //     {this.isNoCars = true};
            };
        })
        .catch(error => {
            {this.isShowroomSelected = false};
            // {this.isNoCars = true};
            this._toastMessage = 'No cars stored in selected showroom.'
            this.showToast()


            // console.log('Error - getCars() for showroom Id = ' + id);
        })

        // this.template.querySelector('c-car-details').hideCArDetails();
        this.isAskedForDetails = false;
        this.isLoading = false;
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
            title: 'Ekhm...',
            message: this._toastMessage,
            variant: 'error',
            mode: 'sticky'
        });
        this.dispatchEvent(event);
    }
}