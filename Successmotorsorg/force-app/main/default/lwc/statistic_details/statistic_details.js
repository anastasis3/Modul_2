import { LightningElement, track, wire, api } from 'lwc';
import accountData from '@salesforce/apex/statisticDetailController.accountData';
import productData from '@salesforce/apex/ProductController.productData';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import retrieveContactDataByAmount from '@salesforce/apex/ControllerAmount.retrieveContactDataByAmount';

import FIELDS from '@salesforce/schema/Opportunity.Name';
import AMOUNT from '@salesforce/schema/Opportunity.Amount';
import TOTAL from '@salesforce/schema/Opportunity.TotalOpportunityQuantity';


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

    @wire(retrieveContactDataByAmount, { recordId: '$recordId', fields: AMOUNT })
    amount;

    get amount2() {
        return getFieldValue(this.amount.data, AMOUNT) + ' close: ' + this.AMOUNT;
        return this.amount.data ? getSObjectValue(this.amount.data, SUBJECT_FIELD) + ' ' + this.invoice_number : '';
        //return this.account.data.fields.Name.value;
    }

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    opportunity;

    get name() {
        return getFieldValue(this.opportunity.data, FIELDS) + ' close: ' + this.AMOUNT;
        //  return this.EmailTemplate.data ? getSObjectValue(this.EmailTemplate.data, SUBJECT_FIELD) + ' ' + this.invoice_number : '';
        //return this.account.data.fields.Name.value;
    }

    get amount() {
        return getFieldValue(this.opportunity.data, AMOUNT);
        //return this.account.data.fields.Name.value;
    }

    get total() {
        return getFieldValue(this.opportunity.data, TOTAL);

        //return this.account.data.fields.Name.value;
    }

    get labelValue() {
        return this.name + ' - ' + this.total;
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


    handleClick() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                recordId: '$recordId',
                objectApiName: 'OpportunityLineItem',
                relationshipApiName: 'OpportunityLineItems',
                actionName: 'view'
            },
        });
    }


}