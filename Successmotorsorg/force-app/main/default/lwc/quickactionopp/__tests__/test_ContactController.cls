@isTest
public with sharing class test_ContactController {


 private static String ids;
 public static void setupIds() {

        String ids = [SELECT accountid FROM Opportunity].accountid;
        String accountWithoutCLosedOppIds = [SELECT id FROM Account WHERE id !=: ids][0].id;
        
 
        System.Debug(ids);
      
    }
    
        @testSetup
    public static void createRecordsForTest() {

        Account acc = new Account(name='xx');
        insert acc;
        
        Opportunity opp = new Opportunity(name='vvv', closedate=Date.today(), StageName='Closed Won');
        insert opp;

       
        Contact contact = new Contact(FirstName='12',
        LastName='234',email='123@gmail.com', phone='2233221122', accountid=acc.id);
        insert contact;
        
        OpportunityContactRole oppcontact = new OpportunityContactRole(contactid=contact.id, opportunityid=opp.id, isprimary=true);
        insert oppcontact;

    }
 
 @isTest
    public static void getContact(){
    setupIds(); 
      OpportunityContactRole getContact= [SELECT OpportunityId, ContactId,Contact.Name, Contact.Email  FROM OpportunityContactRole WHERE OpportunityId =:  Ids LIMIT 1];
        System.assertEquals(getContact, ContactController.getContact(ids));
    }

}

