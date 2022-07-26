import { LightningElement, track, api} from 'lwc';
import getOnwersRecords from '@salesforce/apex/DataCollector.getOnwersRecords';
import getShowrooms from '@salesforce/apex/DataCollector.getShowrooms';
import getCars from '@salesforce/apex/DataCollector.getCars';
// import getCompanyName from '@salesforce/apex/DataCollector.getCompanyName';


export default class SelectCar extends LightningElement {
    // @api title = "Select your company";
    @api companySelected = false
    @api showroomSelected = false
    @api receivedId = false;
    @api chosenCarId;

    @track Owners;
    @track chosenShowrooms;
    @track chosenCars;
    
    // @api recordId;

    constructor(){
        super();
        getOnwersRecords()
        .then(result => {this.Owners = result})
        // console.log('owners:', Owners);
    }

    askForShowrooms(event){
        // console.log('company event invoked')
        // this.title = "Select your showroom"
        this.companySelected = true
        this.showroomSelected = false
        // console.log('companySelected = ', this.companySelected)
        let id = event.currentTarget.dataset.id
        // console.log('received id = ', id)
        // console.log('company chosen = ', getCompanyName({owner: id}))
        
        getShowrooms({owner: id })
        .then(result => {this.chosenShowrooms = result})
        // console.log('ilośc salonów = ', this.chosenShowrooms.length)
    }

    askForCars(event){
        // console.log('showroom event invoked')
        // this.title = "Select your car"
        this.showroomSelected = true
        // console.log('showroomSelected = ', this.showroomSelected)
        let id = event.currentTarget.dataset.id
        // console.log('received id = ', id)
        // console.log('company chosen = ', getCompanyName(id))
        
        getCars({showroom: id })
        .then(result => {this.chosenCars = result})
        // console.log('ilośc salonów = ', this.chosenShowrooms.length)
    }

    passCarId(event){
        console.log('passCarID works')
        this.chosenCarId = event.currentTarget.dataset.id
        console.log('chosenCarId: ', this.chosenCarId)
        this.template.querySelector('c-car-details').askForCarDetails();
    }

    //dodać eventHandler przy kliklnięciu auta, żeby otrzyamć jego Id do przekazania do dziecka
}