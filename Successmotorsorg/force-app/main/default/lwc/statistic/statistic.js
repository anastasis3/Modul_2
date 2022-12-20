import { LightningElement, wire, api, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getAcc from '@salesforce/apex/OpportunityController.getAcc';
import getProducts from '@salesforce/apex/OpportunityController.getProducts';
import retrieveContactDataByAmount from '@salesforce/apex/ControllerAmount.retrieveContactDataByAmount';
import { NavigationMixin } from 'lightning/navigation';
import AMOUNT from '@salesforce/schema/Opportunity.Amount';




import prName from '@salesforce/schema/OpportunityLineItem.Name';
import Quantity from '@salesforce/schema/OpportunityLineItem.Quantity';
import UnitPrice from '@salesforce/schema/OpportunityLineItem.UnitPrice';
import TotalPrice from '@salesforce/schema/OpportunityLineItem.TotalPrice';
import Amount from '@salesforce/schema/Opportunity.Amount';



const productColumns = [
    { label: 'Name', fieldName: prName.fieldApiName, type: 'text' },
    { label: 'Quantity', fieldName: Quantity.fieldApiName, type: 'text' },
    {
        label: 'Unit Price',
        fieldName: UnitPrice.fieldApiName,
        type: 'currency',
        typeAttributes: { maximumFractionDigits: '2' }
    },
    {
        label: 'Total Price',
        fieldName: TotalPrice.fieldApiName,
        type: 'currency',
        typeAttributes: { maximumFractionDigits: '2' }
    }
]

export default class LightningDatatableExample extends NavigationMixin(LightningElement) {
    @track value;
    @track error;
    @track data;
    @api searchKey = '';
    @track page = 1;
    @track items = [];
    @track data = [];
    @track startingRecord = 1;
    @track endingRecord = 0;
    @track pageSize = 10;
    @track totalRecountCount = 0;
    @track totalPage = 0;
    @api recordId;
    @track record;
    @track bShowModal2 = false;
    @track Products;
    productColumns = productColumns;
    @track AMOUNT = AMOUNT;



    //@wire(retrieveContactDataByAmount, { searchKey: '$searchKey2' })
    wiredAccounts2({ error, data2 }) {
        //if(this.searchKey.type.)
        if (data2) {

            this.items = data2;
            this.totalRecountCount = data2.length;
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);

            this.data2 = this.items.slice(0, this.pageSize);
            this.endingRecord = this.pageSize;


            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        }
    }
    @wire(retrieveContactDataByAmount, { recordId: '$recordId' }) amount;
    get amount() {
        return getFieldValue(this.amount.data, AMOUNT) + ' close: ' + this.AMOUNT;
        //  return this.EmailTemplate.data ? getSObjectValue(this.EmailTemplate.data, SUBJECT_FIELD) + ' ' + this.invoice_number : '';
        //return this.account.data.fields.Name.value;
    }


    @wire(getAcc, { searchKey: '$searchKey' })

    wiredAccounts({ error, data }) {
        //if(this.searchKey.type.)
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
    numberField;
    handleKeyChange(event) {
        if (event.target.dataset.id === 'numberField') {
            this.numberField = event.target.value;
        }
        this.searchKey = event.target.value;
        return refreshApex(this.result);
    }
    numberField2;
    handleKeyChange2(event) {
        if (event.target.dataset.id === 'numberField2') {
            this.numberField2 = event.target.value;
        }
        this.searchKey2 = event.target.value;
        return refreshApex(this.result);
    }

    openModal2(row) {
        this.bShowModal2 = true;
        this.record = row;

        getProducts({ ids: '$searchKey' })
            .then(result => {

                if (result.length >= 1) {
                    this.Products = result;
                } else {
                    this.Products = null;
                }
            })
            .catch(error => {
                console.log('open modal wndow error');
            });
    }

    closeModal2() {

        this.bShowModal2 = false;
    }

    handleClick() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                recordId: '0065h00000GP52TAAT',
                objectApiName: 'OpportunityLineItem',
                relationshipApiName: 'OpportunityLineItems',
                actionName: 'view'
            },
        });
    }
}