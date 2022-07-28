import { LightningElement, track, api} from 'lwc';
import getOnwersRecords from '@salesforce/apex/DataCollector.getOnwersRecords';
import getShowrooms from '@salesforce/apex/DataCollector.getShowrooms';
import getCars from '@salesforce/apex/DataCollector.getCars';

export default class SelectCar extends LightningElement {
    @api companySelected = false
    @api showroomSelected = false
    @api askedForDetails = false
    @api receivedId = false;
    @api noShowrooms = false;
    @api noCars = false;
    
    @api chosenCarId;

    @track Owners;
    @track chosenShowrooms;
    @track chosenCars;
    

    constructor(){
        super();
        getOnwersRecords()
        .then(result => {
            this.Owners = result
        })
        .catch(error => {
            console.log('Constructor Error')
        }) 
    }

    askForShowrooms(event){
        let id = event.currentTarget.dataset.id

        getShowrooms({owner: id })
        .then(result => {
            if (result.length > 0) {
                {this.companySelected = true}
                {this.showroomSelected = false}
                {this.noShowrooms = false}
                {this.noCars = false}
                {this.chosenShowrooms = result}
            } else {
                {this.companySelected = false}
                {this.showroomSelected = false}
                {this.noCars = false}
                {this.noShowrooms = true}
            }
        })
        .catch(error => {
            console.log('Error - getShowrooms() for company Id = ' + id)
        })
        
        this.askedForDetails = false
        // this.template.querySelector('c-car-details').hideCArDetails();
    }

    askForCars(event){
        let id = event.currentTarget.dataset.id

        getCars({showroom: id })
        .then(result => {
            if (result.length > 0) {
                {this.chosenCars = result}
                {this.noCars = false}
                this.showroomSelected = true
            } else {
                {this.showroomSelected = false}
                {this.noCars = true}
            };
        })
        .catch(error => {
            console.log('Error - getCars() for showroom Id = ' + id)
        })

        // this.template.querySelector('c-car-details').hideCArDetails();
        this.askedForDetails = false
    }

    passCarId(event){
        this.chosenCarId = event.currentTarget.dataset.id
        // this.template.querySelector('c-car-details').askForCarDetails();
        this.askedForDetails = true;

    }
}