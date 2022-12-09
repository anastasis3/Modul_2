public with sharing class EmailTemplateController {
    @AuraEnabled(cacheable=true)
    public static EmailTemplate getEmailTemplate(){
      return[Select id, Subject, Body From EmailTemplate Where DeveloperName = 'ApproveEmail'];
    }
   }