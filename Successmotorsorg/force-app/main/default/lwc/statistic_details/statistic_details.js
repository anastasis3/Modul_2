import { LightningElement, track, wire, api } from 'lwc';
import accountData from '@salesforce/apex/statisticDetailController.accountData';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';


import FIELDS from '@salesforce/schema/Opportunity.Name';
import AMOUNT from '@salesforce/schema/Opportunity.Amount';

export default class Statistic_details extends LightningElement {



    @api recordId;
    @track error;
    @track activeSections2 = true;
    @track currentAccountName;

    @track records6
    @wire(accountData, { accId: '$recordId' })
    wireConRecord({ error, data }) {
        if (data) {
            this.records6 = data;
            console.log(this.records6)
        } else {
            console.log(error);
        }
    }

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    opportunity;

    get name() {
        return getFieldValue(this.opportunity.data, FIELDS);
        //return this.account.data.fields.Name.value;
    }

    get amount() {
        return getFieldValue(this.opportunity.data, AMOUNT);
        //return this.account.data.fields.Name.value;
    }

    handleSectionToggle(event) {
        console.log(event.detail.openSections);
    }

    @track totalAccount;
    @track dataNotFound;


    @track bShowModal2 = false;


    openModal2() {
        this.bShowModal2 = true;
    }

    closeModal2() {

        this.bShowModal2 = false;
    }





}