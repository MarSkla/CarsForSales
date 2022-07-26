import { LightningElement, api, track } from 'lwc';
import getCarDetails from '@salesforce/apex/DataCollector.getCarDetails';

export default class CarDetails extends LightningElement {
    @api askedForDetails = false;
    @api passed;
    @api details;

    @api
    askForCarDetails(event){
        this.askedForDetails = true
    }

    
}