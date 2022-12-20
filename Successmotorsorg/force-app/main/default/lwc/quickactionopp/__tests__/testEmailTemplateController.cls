
@isTest
public with sharing class EmailTemplateController {
  
    public static EmailTemplate getEmailTemplate(){
        EmailTemplate emailtemp = [SELECT subject, body, id FROM EmailTemplate WHERE name =: 'ApproveEmail'];
		system.debug(emailtemp.body);
        Test.startTest();
        System.assertEquals(SendEmailController.getEmailTemplate(), emailtemp);
        Test.stopTest();
   }
}