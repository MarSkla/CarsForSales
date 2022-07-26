import { LightningElement, track, api} from 'lwc';
import getOnwersRecords from '@salesforce/apex/DataCollector.getOnwersRecords';
import getShowrooms from '@salesforce/apex/DataCollector.getShowrooms';
import getCars from '@salesforce/apex/DataCollector.getCars';

export default class SelectCar extends LightningElement {
    @api companySelected = false
    @api showroomSelected = false
    @api receivedId = false;
    @api chosenCarId;

    @track Owners;
    @track chosenShowrooms;
    @track chosenCars;
    

    constructor(){
        super();
        getOnwersRecords()
        .then(result => {this.Owners = result})
    }

    askForShowrooms(event){
        this.companySelected = true
        this.showroomSelected = false
        let id = event.currentTarget.dataset.id
        
        getShowrooms({owner: id })
        .then(result => {this.chosenShowrooms = result})
    }

    askForCars(event){
        this.showroomSelected = true
        let id = event.currentTarget.dataset.id
        
        getCars({showroom: id })
        .then(result => {this.chosenCars = result})
    }

    passCarId(event){
        console.log('passCarID works')
        this.chosenCarId = event.currentTarget.dataset.id
        console.log('chosenCarId: ', this.chosenCarId)
        this.template.querySelector('c-car-details').askForCarDetails();
    }
}