import { LightningElement, track, api} from 'lwc';
import carsForSale from '@salesforce/resourceUrl/carsForSale'
import getOnwersRecords from '@salesforce/apex/DataCollector.getOnwersRecords';
import getShowrooms from '@salesforce/apex/DataCollector.getShowrooms';
import getCars from '@salesforce/apex/DataCollector.getCars';

export default class SelectCar extends LightningElement {
    @api welcomeModalClosed = false
    @api companySelected = false
    @api showroomSelected = false
    @api askedForDetails = false
    @api receivedId = false;
    @api noShowrooms = false;
    @api noCars = false;
    @api isLoading = false;
    
    @api chosenCarId;

    @track Owners;
    @track chosenShowrooms;
    @track chosenCars;

    carLogo = carsForSale;
    
    constructor(){
        super();
        this.isLoading = true;
        getOnwersRecords()
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

        getShowrooms({owner: id })
        .then(result => {
            if (result.length > 0) {
                {this.companySelected = true};
                {this.showroomSelected = false};
                {this.noShowrooms = false};
                {this.noCars = false};
                {this.chosenShowrooms = result};
            } else {
                {this.companySelected = false};
                {this.showroomSelected = false};
                {this.noCars = false};
                {this.noShowrooms = true};
            }
        })
        .catch(error => {
            console.log('Error - getShowrooms() for company Id = ' + id);
        })
        
        this.askedForDetails = false;
        // this.template.querySelector('c-car-details').hideCArDetails();
        this.isLoading = false;
    }

    askForCars(event){
        this.isLoading = true;
        let id = event.currentTarget.dataset.id;

        getCars({showroom: id })
        .then(result => {
            if (result.length > 0) {
                {this.chosenCars = result};
                {this.noCars = false};
                this.showroomSelected = true;
            } else {
                {this.showroomSelected = false};
                {this.noCars = true};
            };
        })
        .catch(error => {
            console.log('Error - getCars() for showroom Id = ' + id);
        })

        // this.template.querySelector('c-car-details').hideCArDetails();
        this.askedForDetails = false;
        this.isLoading = false;
    }

    passCarId(event){
        this.isLoading = true;
        this.chosenCarId = event.currentTarget.dataset.id;
        // this.template.querySelector('c-car-details').askForCarDetails();
        this.askedForDetails = true;
        this.isLoading = false;
    }

    closeWelcomeModal(event){
        this.welcomeModalClosed = true;
    }
}