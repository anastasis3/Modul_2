public class PDFcontroller {
    private final Opportunity opportunity;
   
       public PDFcontroller(ApexPages.StandardController stdController){
           this.opportunity=(Opportunity)stdController.getRecord();
       }
   
   
   
   
       public void ShowRelatedProducts()
       {
           List <OpportunityLineItem> prod_InfoList = [SELECT Name, ListPrice, 
                                                              ProductCode,Quantity,
                                                              UnitPrice,TotalPrice 
                                                       FROM OpportunityLineItem];
       }
       
           public void ShowContacts()
       {
           List <OpportunityContactRole> con_role = [SELECT ContactId, Contact.Email
                                                     FROM OpportunityContactRole
                                                     WHERE IsPrimary = true];
       }
       
       String ids;
       Opportunity opps;
       String str;
       
         public PageReference createPDFFile() {
           PageReference pdfPage = Page.SuccessmotorsPage;
           pdfPage.getParameters().put('id', opportunity.Id);
           opps = [SELECT Invoice_Number__c, id FROM Opportunity WHERE id =: opportunity.id];
           str = opps.Invoice_Number__c;
       
           Blob pdfBlob; 
   
           if (!Test.isRunningTest()) { 
               pdfBlob = pdfPage.getContentasPDF(); 
           } else { 
               pdfBlob = Blob.valueOf('Some Text');
           }
   
       
           
           List<ContentDocument> document=[SELECT id, title FROM ContentDocument WHERE title=:str limit 1];
           
           if(document.size() > 0){
               document[0].parentId = opportunity.id;
               ContentVersion version = new ContentVersion();
               version.versionData = pdfBlob;
               version.title = str;
               version.ContentLocation = 'S';
               version.PathOnClient = str + '.pdf';
               version.ContentDocumentId = document[0].id;
               insert version;
           
               delete [SELECT id FROM ContentDocumentLink WHERE LinkedEntityId =: opportunity.id];
   
               ContentDocumentLink link = new ContentDocumentLink();
               link.LinkedEntityId = opportunity.id;
               link.Visibility  = 'AllUsers';
               link.ShareType = 'V';
               link.ContentDocumentId = document[0].id;
               insert link;
   
           }  
           else{
               ContentVersion version = new ContentVersion();
               version.versionData = pdfBlob;
               version.title = str;
               version.ContentLocation = 'S';
               version.PathOnClient = str+'.pdf';
               insert version;
           }
           
           
   
           PageReference pageWhereWeWantToGo = Page.SuccessmotorsPage;
           pageWhereWeWantToGo.getParameters().put('id',opportunity.Id); 
           pageWhereWeWantToGo.setRedirect(true);
           return pageWhereWeWantToGo;    
       }
   }