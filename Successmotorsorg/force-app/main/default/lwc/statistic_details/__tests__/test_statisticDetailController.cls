@isTest
public with sharing class test_statisticDetailController {


 private static String ids;
 public static void setupIds() {

        String ids = [SELECT accountid FROM Opportunity].accountid;
        String accountWithoutCLosedOppIds = [SELECT id FROM Account WHERE id !=: ids][0].id;
        
 
        System.Debug(ids);
      
    }
    
        @testSetup
    public static void createRecordsForTest() {

         Account acc = new Account(name='lll');
        Account accWithoutOpp = new Account(name='kkk');

        insert acc;
        insert accWithoutOpp;

        Opportunity opp = new Opportunity(accountId=acc.id, name='kk', closedate=Date.today(), StageName='Closed Won');
        insert opp;
        Opportunity oppWithoutProduct = new Opportunity(accountId=acc.id, name='opppp', closedate=Date.today(), StageName='Closed Won');
        insert oppWithoutProduct;

        Product2 objProduct = new Product2();
        objProduct.Name = 'Test';
        objProduct.Description = 'Test';
        Insert objProduct;
        
        PricebookEntry objPBEntry = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id=objProduct.Id,UnitPrice=2,IsActive=true);
        Insert objPBEntry;
        OpportunityLineItem product = new OpportunityLineItem(PriceBookEntryId =objPBEntry.id, Quantity=4, UnitPrice=2,opportunityid=opp.id);
        insert product;
    }
 
    @isTest
    public static void TestaccountData (){  
     setupIds();     
 List<OpportunityLineItem> accountData = [SELECT  Opportunity.Name, Opportunity.CloseDate, Opportunity.CreatedDate,
  Opportunity.Amount, Opportunity.Account.Name, 
  Quantity, UnitPrice, TotalPrice, PricebookEntry.Product2.Name FROM 
   OpportunityLineItem
  WHERE Opportunity.AccountId=:ids LIMIT 1 ];
  System.assertEquals(accountData, statisticDetailController.accountData(ids));
    }
    
       @isTest
    public static void TestgetProducts(){
         setupIds(); 
         List<OpportunityLineItem> getProducts=[SELECT name, Quantity, UnitPrice, TotalPrice, id FROM OpportunityLineItem WHERE opportunityid =: ids];
           System.assertEquals(getProducts, statisticDetailController.getProducts(ids));
    }
}

