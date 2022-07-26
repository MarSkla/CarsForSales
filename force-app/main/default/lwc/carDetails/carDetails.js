import { LightningElement, api, track } from 'lwc';
import getCarDetails from '@salesforce/apex/DataCollector.getCarDetails';

export default class CarDetails extends LightningElement {
    // @api chosencar;
    @api askedForDetails = false;
    @api passed;
    @api details;

    @api
    askForCarDetails(event){
        // console.log('company event invoked')
        // this.title = "Select your showroom"
        this.askedForDetails = true
        console.log('askedForDetails: ', this.askedForDetails)
        console.log('passed Id - value: ', this.passed)

        // console.log('companySelected = ', this.companySelected)
        // let id = event.currentTarget.dataset.id
        // console.log('received id = ', id)
        // console.log('company chosen = ', getCompanyName({owner: id}))
        
        // getCarDetails({car: this.chosenCar })
        // .then(result => {this.details = result})
        // console.log('ilośc salonów = ', this.chosenShowrooms.length)
    }

    
}