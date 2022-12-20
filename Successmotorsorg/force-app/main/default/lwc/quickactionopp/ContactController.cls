public with sharing class ContactController {
  @AuraEnabled(cacheable=true)

  public static OpportunityContactRole getContact(string recordId){
    return [SELECT OpportunityId, ContactId,Contact.Name, Contact.Email  FROM OpportunityContactRole WHERE OpportunityId =:  recordId LIMIT 1];

}

}