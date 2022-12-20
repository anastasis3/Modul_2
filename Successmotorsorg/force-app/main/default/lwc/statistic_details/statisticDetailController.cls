public with sharing class statisticDetailController {
 
  @AuraEnabled(cacheable=true)
  public static List<OpportunityLineItem> accountData (Id accId){       
return [SELECT  Opportunity.Name, Opportunity.CloseDate, Opportunity.CreatedDate, Opportunity.Amount, Opportunity.Account.Name, 
Quantity, UnitPrice, TotalPrice, PricebookEntry.Product2.Name FROM 
 OpportunityLineItem
WHERE Opportunity.AccountId=:accId LIMIT 1 ];
  }
  
     @AuraEnabled(cacheable=true)
  public static List<OpportunityLineItem> getProducts(String ids){
      return [SELECT name, Quantity, UnitPrice, TotalPrice, id FROM OpportunityLineItem WHERE opportunityid =: ids];
  }
}