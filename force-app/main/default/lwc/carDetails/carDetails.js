import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CarDetails extends LightningElement {
    @api isAskedForDetails = false;
    @api recordId;

    confirmationSuccessToast() {
        const event = new ShowToastEvent({
            title: 'Confirmed',
            message: 'Will send the package immediately',
            variant: 'success',
        });
        this.dispatchEvent(event);
    }

}