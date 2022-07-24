import { LightningElement, api, wire } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Car_Showrooms_Owner__c.Name';
import getOwners from '@salesforce/apex/OwnerController.getOwners';
const COLUMNS = [
    {label: 'Name', fieldName: NAME_FIELD.fieldApiName, type: 'text'}
];

export default class Owners extends LightningElement {
    columns = COLUMNS
    @wire(getOwners)
    owners;
}