public with sharing class statisticDetailController {
 
  @AuraEnabled(cacheable=true)
  public static List<OpportunityLineItem> accountData (Id accId){       
return [SELECT  Opportunity.Name, Opportunity.CloseDate, Opportunity.CreatedDate, Opportunity.Amount, Opportunity.Account.Name, 
Quantity, UnitPrice, TotalPrice, PricebookEntry.Product2.Name FROM 
 OpportunityLineItem
WHERE Opportunity.AccountId=:accId];
  }
}