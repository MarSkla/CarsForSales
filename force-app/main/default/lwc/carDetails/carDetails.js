import { LightningElement, api, track } from 'lwc';
// import getCarDetails from '@salesforce/apex/DataCollector.getCarDetails';

export default class CarDetails extends LightningElement {
    @api isAskedForDetails = false;
    @api recordId;
    // @api passed;

    // _passed;

    // @api
    // get passed () {
    //     return this._passed
    // }

    // set passed(value) {
    //     this._passed = value
    // }

    // @api
    // askForCarDetails(event){
    //     this.isAskedForDetails = true
    // }

    // @api
    // hideCArDetails(){
    //     this.isAskedForDetails = false
    // }
}