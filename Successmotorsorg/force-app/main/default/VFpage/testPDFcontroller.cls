
    
@isTest
public with sharing class testPDFcontroller {
    
    private static String Invoice_Number;
    private static Id Ids;
    public static PDFcontroller getForInvoice(Opportunity opp) {
        PageReference testPage = page.SuccessmotorsPage;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', String.valueOf(opp.Id));
        ApexPages.StandardController sc = new  ApexPages.StandardController(opp);     
        return new PDFcontroller(sc); 
    }
 

    
    public static void setupInvoiceNumber() {
        Invoice_Number = [SELECT Invoice_Number__c FROM Opportunity][0].Invoice_Number__c;
    }
 



    @isTest
    public static void testCreatePDFFileWithDocument() {
        setupInvoiceNumber();
        System.debug(testPDFcontroller.Invoice_Number);
        Opportunity opp = [SELECT id, Invoice_Number__c, name FROM Opportunity WHERE Invoice_Number__c =: Invoice_Number];
        
        ContentVersion contentVersion_1 = new ContentVersion(
            Title = Invoice_Number,
            PathOnClient = 'Penguins.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true
        );
        insert contentVersion_1;
        
     
    }

    @isTest
    public static void testCreatePDFFileWithoutDocument() {
        setupInvoiceNumber();
        System.debug(testPDFcontroller.Invoice_Number);
        Opportunity opp = [SELECT id, Invoice_Number__c, name FROM Opportunity WHERE Invoice_Number__c =: Invoice_Number];
   
    }
    
    public static Pagereference getPageWhereWeWantToGo(Opportunity opp) {
        PageReference pageWhereWeWantToGo = Page.SuccessmotorsPage;
        pageWhereWeWantToGo.getParameters().put('id', opp.Id); 
        pageWhereWeWantToGo.setRedirect(true);
        return pageWhereWeWantToGo;
    }
    }