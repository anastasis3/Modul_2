
@isTest
public with sharing class testOpportunityUpdateEmailHandler {
    

    static String emailAddress = 'anastacia3a@gmail.com';
    static String subject;

    @TestSetup
    public static void makeData(){
        Opportunity opp = new Opportunity(name = 'Name', closedate=Date.today(), StageName='Prospecting');
        insert opp;
    }
    
    public static void setupInvoiceNumber() {
        subject = [SELECT Invoice_Number__c FROM Opportunity][0].Invoice_Number__c;
    }
    
    @isTest
    static void testInboundEmailWithoutNormalPlainTextBody(){
        setupInvoiceNumber();
        
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

        email.plainTextBody = 'tetxtt';
        email.fromAddress = emailAddress;
        email.subject = subject;

        myHandler edr = new myHandler();
        edr.handleInboundEmail(email,env); 

        Test.startTest();
        Messaging.InboundEmailResult result = edr.handleInboundEmail(email, env);
        System.assertEquals(result.success, true);
        Test.stopTest();
    }

    @isTest
    static void testInboundEmailWithApproved(){
        setupInvoiceNumber();
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

        email.plainTextBody = 'Approved';
        email.fromAddress = emailAddress;
        email.subject = subject;

        myHandler edr = new myHandler();
        edr.handleInboundEmail(email,env); 

        Test.startTest();
        Messaging.InboundEmailResult result = edr.handleInboundEmail(email, env);
        System.assertEquals(result.success, true);
        Test.stopTest();
    }

    @isTest
    static void testInboundEmailWithRejected(){
        setupInvoiceNumber();
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

        email.plainTextBody = 'Rejected';
        email.fromAddress = emailAddress;
        email.subject = subject;

        myHandler edr = new myHandler();
        edr.handleInboundEmail(email,env); 

        Test.startTest();
        Messaging.InboundEmailResult result = edr.handleInboundEmail(email, env);
        System.assertEquals(result.success, true);
        Test.stopTest();
    }
}
