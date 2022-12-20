@isTest
public with sharing class testEmailHundler {
    
    static String emailAddress = 'anastacia3a@gmail.com';
    static String subject = 'INV-000004';
    static String body = 'sssss';
@isTest
static void testSendEmailToController(){
   
    Opportunity opp= [SELECT id, Invoice_number__c FROM Opportunity WHERE Invoice_number__c =: subject];
    Test.startTest();
    SendEmailController.sendEmailToController( emailAddress, 'test', subject, body);
    Test.stopTest();
}
}