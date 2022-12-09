import { LightningElement, track, wire, api } from 'lwc';
import retrieveContactData from '@salesforce/apex/ControllerData.retrieveContactData';
import accountsData from '@salesforce/apex/ControllerAccountList.accountsData';
import retrieveContactDataByAmount from '@salesforce/apex/ControllerAmount.retrieveContactDataByAmount';
import FIELDS from '@salesforce/schema/Opportunity.Name';
import AMOUNT from '@salesforce/schema/Opportunity.Amount';
import EmailPreferencesStayInTouchReminder from '@salesforce/schema/User.EmailPreferencesStayInTouchReminder';
import { getPagesOrDefault, handlePagerChanged } from './pagerUtils';

const PAGER_NAME = "c-pager";

export default class Statistic extends LightningElement {

    /*pagination
     _currentlyVisible = [];


     getPagesOrDefault = getPagesOrDefault.bind(this);
     handlePagerChanged = handlePagerChanged.bind(this);

     @api
     get currentlyVisible() {
         const pages = this.getPagesOrDefault();
         return pages.length === 0 ? this._currentlyVisible : pages;
     }
     set currentlyVisible(value) {
         this._currentlyVisible = value;
     }*/


    handlePagerChange() {
        this.currentlyVisible = this._getPagesOrDefault();
    }


    @track currentAccountName;
    @track searchAccountName;
    @track searchAmount;
    @track currentAmount;
    @track activeSections = false;
    @track activeSections2 = true;


    handleSectionToggle(event) {
        console.log(event.detail.openSections);
    }

    handleChangeAmount(event) {
        this.currentAmount = event.target.value;
    }

    handleAmountSearch() {
        this.searchAmount = this.currentAmount;
        this.activeSections3 = true;
        this.activeSections2 = false;
    }

    handleChangeAccName(event) {
        this.currentAccountName = event.target.value;
    }

    handleAccountSearch() {

        this.searchAccountName = this.currentAccountName;
        this.activeSections = true;
        this.activeSections2 = false;
    }

    @track totalAccount;
    @track dataNotFound;
    visibleAccounts

    @wire(retrieveContactData, { keySearch: '$searchAccountName' })
    wireRecord({ data, error }) {
        if (data) {
            this.records = data;
            this.error = undefined;
            this.dataNotFound = '';
            if (this.totalAccount == '') {
                this.dataNotFound = 'There is no Opportunities found related to Account name';
            }

        } else {
            this.error = error;
            this.data = undefined;
        }
    }
    @wire(retrieveContactData, { recordId: '$recordId', fields: FIELDS, AMOUNT })
    opportunity;

    get name() {
        return this.opportunity.data ? getSObjectValue(this.opportunity.data, FIELDS) + ' ' + this.AMOUNT : '';
    }


    @wire(retrieveContactDataByAmount, { keySearch: '$searchAmount' })
    wireRecord2({ data, error }) {
        if (data) {
            this.records4 = data;
            this.error = undefined;
            this.dataNotFound = '';
            if (this.totalAccount == '') {
                this.dataNotFound = 'There is no Opportunities found related to Amount';
            }

        } else {
            this.error = error;
            this.data = undefined;
        }
    }



    @track bShowModal = false;
    @track bShowModal2 = false;


    openModal() {
        this.bShowModal = true;
    }

    closeModal() {

        this.bShowModal = false;
    }

    openModal2() {
        this.bShowModal2 = true;
    }

    closeModal2() {

        this.bShowModal2 = false;
    }

    @wire(accountsData) opportunityLineItem;


    updateAccountHundler(event) {
        this.visibleAccounts = [...event.detail.records]
        console.log(event.detail.records)

    }

    /*pagination
    @track totalRecordCount
    @track totalPage
    @track endingRecord = 0
    @track pageSize = 3
    @track startingRecord = 1
        */
    @track records2
    @wire(accountsData) opportunityLineItem2({ data, error }) {
        if (data) {

            this.records2 = data;
            // this.totalRecordCount = data.lenght;
            //this.totalPage = Math.ceil(this.totalRecordCount / this.PageSize)
            //this.data = this.records2.slice(0, this.pageSize)
            //this.endingRecord = this.pageSize
            console.log(this.records)

            //this.updateRecords()

        } else if (error) {
            console.log(error);
        }
    }

    prevHandler(event) {
        if (this.page > 1) {
            this.page = this.page - 1;
            this.displayRecordPage(this.page)
        }

    }

    nextHandler(event) {
        if (this.page < this.totalPage && this.page !== this.totalPage) {
            this.page = this.page + 1;
            this.displayRecordPage(this.page)
        }
    }

    displayRecordPage(page) {
        this.startingRecord = (page - 1) * this.pageSize;
        this.endingRecord = page * this.pageSize;
        this.endingRecord = (this.endingRecord > this.totalRecordCount) ? this.totalRecordCount : this.endingRecord;
        this.data = this.records2.slice(this.startingRecord, this.endingRecord);
        this.startingRecord = this.startingRecord + 1;
    }




    /*let selectedAccId = event.target.name;
    this.accountId = selectedAccId;
    let selectedAccLocalId = event.target.Id;
    this.filteredConList = this.conList.filter(function(currentItem, Index, array) {
        if (currentItem.AccountId == selectedAccId) {
            return currentItem;
        }
    });*/
}