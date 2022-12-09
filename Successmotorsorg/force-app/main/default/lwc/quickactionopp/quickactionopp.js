import { LightningElement, api, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import { getSObjectValue } from '@salesforce/apex';

import getSingleContact from '@salesforce/apex/ContactController.getSingleContact';
import getOpp from '@salesforce/apex/getOppController.getOpp';
import sendEmailTemplate from '@salesforce/apex/SendEmailController.sendEmailTemplate';
import getEmailTemplate from '@salesforce/apex/EmailTemplateController.getEmailTemplate';

import sendEmail from '@salesforce/apex/EmailHandler.sendEmail';

import INVOICE_NUM from "@salesforce/schema/Opportunity.Invoice_Number__c";
import INVOICE_NUMBER from "@salesforce/schema/Opportunity.Invoice_Number__c";
import CONTACT from "@salesforce/schema/OpportunityContactRole.Contact.Name";
import CONTACT_EMAIL from "@salesforce/schema/Contact.Email";

import NAME_FIELD from "@salesforce/schema/Contact.Name";
import NAME_FIELD2 from "@salesforce/schema/OpportunityContactRole.Contact.Email";
import NAME_ACCOUNT from "@salesforce/schema/Opportunity.Account.Name";

import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import SUBJECT_FIELD from '@salesforce/schema/EmailTemplate.Subject';
import BODY_FIELD from '@salesforce/schema/EmailTemplate.Body';

import { getRecord, getFieldValue } from 'lightning/uiRecordApi';



export default class Quickactionopp extends NavigationMixin(LightningElement) {

    invoiceNumber = INVOICE_NUM;
    contactName = CONTACT;

    get getInvoice() {
        return this.invoiceNumber;
    }
    @api recordId;
    @api objectApiName;


    @wire(sendEmailTemplate) EmailTemplate;

    sendAction() {
        this.dispatchEvent(new SendEmail());
    }


    @track subject_field = SUBJECT_FIELD;
    sendEmailHandler(event) {
        // send mail
        console.log("Sending email to", this.email);
        sendEmail({ toAddress: this.email, subject: this.subject, body: this.body });
    }


    actionToVFNav() {
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__webPage',
            attributes: {
                url: '/apex/SuccessmotorsPage?id=' + this.recordId
            }
        }).then(generatedUrl => {
            window.open(generatedUrl);
        });
    }



    @wire(getSingleContact, { recordId: '$recordId', fields: INVOICE_NUM }) contact;

    get email() {
        return this.contact.data ? getSObjectValue(this.contact.data, EMAIL_FIELD) : '';
    }
    get Name() {
        return this.contact.data ? getSObjectValue(this.contact.data, NAME_FIELD) : '';
    }



    @wire(getRecord, { recordId: '$recordId', fields: INVOICE_NUMBER }) opportunity;
    get invoice_number() {

        return getFieldValue(this.opportunity.data, INVOICE_NUMBER);
    }
    @wire(getRecord, { recordId: '$recordId', fields: CONTACT }) opportunityContactRole;
    get contactName() {
        return getFieldValue(this.opportunity.data, CONTACT);
    }
    get contactEmail() {
        return getFieldValue(this.opportunity.data, CONTACT_EMAIL);
    }


    @wire(getEmailTemplate) EmailTemplate;

    get subject() {
        return this.EmailTemplate.data ? getSObjectValue(this.EmailTemplate.data, SUBJECT_FIELD) + ' ' + this.invoice_number : '';
    }

    get body() {
        return this.EmailTemplate.data ? getSObjectValue(this.EmailTemplate.data, BODY_FIELD) : '';
    }
}