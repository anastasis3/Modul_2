import { LightningElement, api, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { getSObjectValue } from '@salesforce/apex';


import getContact from '@salesforce/apex/ContactController.getContact';
import getEmailTemplate from '@salesforce/apex/EmailTemplateController.getEmailTemplate';

import sendEmail from '@salesforce/apex/EmailHandler.sendEmail';


import INVOICE_NUM from "@salesforce/schema/Opportunity.Invoice_Number__c";
import INVOICE_NUMBER from "@salesforce/schema/Opportunity.Invoice_Number__c";
import CONTACT from "@salesforce/schema/Contact.Name";


import NAME_FIELD from '@salesforce/schema/OpportunityContactRole.Contact.Name';
import EMAIL_FIELD from '@salesforce/schema/OpportunityContactRole.Contact.Email';

import SUBJECT_FIELD from '@salesforce/schema/EmailTemplate.Subject';
import BODY_FIELD from '@salesforce/schema/EmailTemplate.Body';

import { getRecord, getFieldValue } from 'lightning/uiRecordApi';



export default class Quickactionopp extends NavigationMixin(LightningElement) {
    @api recordId;
    @api objectApiName;
    invoiceNumber = INVOICE_NUM;
    contactName = CONTACT;

    get getInvoice() {
        return this.invoiceNumber;
    }



    /* sendAction() {
         this.dispatchEvent(new SendEmail());
     }*/

    savePdfHundler(event) {
        savePdf({ parentId: this.recordId, pdfName: 'SuccessmotorsPage' });
    }


    sendEmailHandler(event) {
        // send mail
        console.log("Sending email to", this.email);
        sendEmail({ toAddress: this.email, subject: this.subject, body: this.body });
    }


    actionToVFNav() {
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__webPage',
            attributes: {
                url: '/apex/PAGE?id=' + this.recordId
            }

        }).then(generatedUrl => {
            window.open(generatedUrl);
        });
    }
    handleCLick() {

        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'PAGE'
            },
            state: {
                recordIds: this.files.data.ContentDocumentId,
                selectedRecordId: this.files.data.ContentDocumentId
            }
        });
    }

    record

    @wire(getContact, { recordId: '$recordId', fields: [EMAIL_FIELD, NAME_FIELD] }) contact;

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
        return getFieldValue(this.opportunityContactRole.data, CONTACT);
    }

    @wire(getEmailTemplate) EmailTemplate;

    get subject() {
        return this.EmailTemplate.data ? getSObjectValue(this.EmailTemplate.data, SUBJECT_FIELD) + ' ' + this.invoice_number : '';
    }

    get body() {
        return this.EmailTemplate.data ? getSObjectValue(this.EmailTemplate.data, BODY_FIELD) : '';
    }
}