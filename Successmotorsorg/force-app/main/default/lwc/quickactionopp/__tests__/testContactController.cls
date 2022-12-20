@isTest
public with sharing class testContactController {
    
    private static String Invoice_Number;
    private static Id recordId;
    public static ContactController ContactController(Opportunity opp) {
        PageReference testPage = page.PDFGenerator;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', String.valueOf(opp.Id));
        ApexPages.StandardController sc = new  ApexPages.StandardController(opp);     
        return new ContactController(sc); 
    }

 

	
    public static void setupInvoiceNumber() {
        Invoice_Number = [SELECT Invoice_Number__c FROM Opportunity][0].Invoice_Number__c;
    }
 
        @isTest
        public static Contact getSingleContact(){
            setupInvoiceNumber();
            Opportunity opp = [SELECT id, Invoice_Number__c, name FROM Opportunity WHERE Invoice_Number__c =: Invoice_Number];
          return [SELECT Id, Name,  Phone, Email FROM Contact WHERE ContactId=:recordId LIMIT 1];
          ContactController ext = ContactController(opp); 

          System.assertEquals(ext.getContact(), contact);
        }

        @isTest
        public static Opportunity getContact(string recordId){
            setupInvoiceNumber();
            Opportunity opp = [SELECT id, Invoice_Number__c, name FROM Opportunity WHERE Invoice_Number__c =: Invoice_Number];
          return [SELECT Contact.Name,Contact.Email FROM Opportunity WHERE OpportunityId =:  recordId LIMIT 1];
          ContactController ext = ContactController(opp); 

          System.assertEquals(ext.getContact(), contact);
        }

   


    

    @isTest
    public static void testCreatePDFFileWithDocument() {
        setupInvoiceNumber();
        System.debug(testForInvoice.Invoice_Number);
        Opportunity opp = [SELECT id, Invoice_Number__c, name FROM Opportunity WHERE Invoice_Number__c =: Invoice_Number];
        
        ContentVersion contentVersion_1 = new ContentVersion(
      		Title = Invoice_Number,
      		PathOnClient = 'logo.jpg',
      		VersionData = Blob.valueOf('Test Content'),
      		IsMajorVersion = true
    	);
    	insert contentVersion_1;
        
        ForInvoice ext = getForInvoice(opp); 

        System.debug(ext.getOpp()); 
        System.assertEquals(ext.createPDFFile().getUrl(), getPageWhereWeWantToGo(opp).getUrl());
    }

    @isTest
    public static void testCreatePDFFileWithoutDocument() {
        setupInvoiceNumber();
        System.debug(testForInvoice.Invoice_Number);
        Opportunity opp = [SELECT id, Invoice_Number__c, name FROM Opportunity WHERE Invoice_Number__c =: Invoice_Number];
        
        ForInvoice ext = getForInvoice(opp); 

        System.debug(ext.getOpp()); 
        System.assertEquals(ext.createPDFFile().getUrl(), getPageWhereWeWantToGo(opp).getUrl());
    }
    
    public static Pagereference getPageWhereWeWantToGo(Opportunity opp) {
        PageReference pageWhereWeWantToGo = Page.PDFGenerator;
        pageWhereWeWantToGo.getParameters().put('id', opp.Id); 
        pageWhereWeWantToGo.setRedirect(true);
        return pageWhereWeWantToGo;
    }
}