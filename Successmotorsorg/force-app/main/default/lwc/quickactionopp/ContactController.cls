// ContactController.cls
public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static Contact getSingleContact(){
      return [SELECT Id, Name,  Phone, Email FROM Contact WHERE ContactId=:recordId LIMIT 1];
    }

    public static OpportunityContactRole getOpp(string recordId){
      return [SELECT Contact.Name,Contact.Email,Opportunity.Invoice_Number__c FROM OpportunityContactRole WHERE OpportunityId =:  recordId LIMIT 1];

 }
  
}