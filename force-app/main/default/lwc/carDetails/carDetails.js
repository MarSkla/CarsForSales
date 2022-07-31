import { LightningElement, api, track } from 'lwc';
// import getCarDetails from '@salesforce/apex/DataCollector.getCarDetails';

export default class CarDetails extends LightningElement {
    @api isAskedForDetails = false;
    @api recordId;
}