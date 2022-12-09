public with sharing class ControllerAmount {
 
    @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> retrieveContactDataByAmount (integer keySearch){       
 return [SELECT  Opportunity.Name, Opportunity.CloseDate, Opportunity.CreatedDate, Opportunity.Amount, Opportunity.Account.Name, 
  Quantity, UnitPrice, TotalPrice, PricebookEntry.Product2.Name FROM 
   OpportunityLineItem
  WHERE Opportunity.Amount=:keySearch];
    }
}