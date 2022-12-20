import { LightningElement, wire, api, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getAcc from '@salesforce/apex/OpportunityController.getAcc';

import { NavigationMixin } from 'lightning/navigation';

export default class LightningDatatableExample extends NavigationMixin(LightningElement) {
    @track value;
    @track error;
    @track data;
    @api searchKey = '';
    result;
    @track page = 1;
    @track items = [];
    @track data = [];
    @track startingRecord = 1;
    @track endingRecord = 0;
    @track pageSize = 10;
    @track totalRecountCount = 0;
    @track totalPage = 0;

    @wire(getAcc, { searchKey: '$searchKey' })
    wiredAccounts({ error, data }) {
        if (data) {

            this.items = data;
            this.totalRecountCount = data.length;
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);

            this.data = this.items.slice(0, this.pageSize);
            this.endingRecord = this.pageSize;


            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        }
    }

    //clicking on previous button this method will be called
    previousHandler() {
        if (this.page > 1) {
            this.page = this.page - 1; //decrease page by 1
            this.displayRecordPerPage(this.page);
        }
    }

    //clicking on next button this method will be called
    nextHandler() {
        if ((this.page < this.totalPage) && this.page !== this.totalPage) {
            this.page = this.page + 1; //increase page by 1
            this.displayRecordPerPage(this.page);
        }
    }

    //this method displays records page by page
    displayRecordPerPage(page) {

        this.startingRecord = ((page - 1) * this.pageSize);
        this.endingRecord = (this.pageSize * page);

        this.endingRecord = (this.endingRecord > this.totalRecountCount) ?
            this.totalRecountCount : this.endingRecord;

        this.data = this.items.slice(this.startingRecord, this.endingRecord);

        this.startingRecord = this.startingRecord + 1;
    }

    handleKeyChange(event) {
        this.searchKey = event.target.value;
        return refreshApex(this.result);
    }

    handleClick() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                recordId: '0065j00000CLKkxAAH',
                objectApiName: 'OpportunityLineItem',
                relationshipApiName: 'OpportunityLineItems',
                actionName: 'view'
            },
        });
    }
}