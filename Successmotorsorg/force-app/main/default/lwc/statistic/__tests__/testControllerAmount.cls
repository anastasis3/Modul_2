@isTest
@TestSetup public with sharing class ControllerAmount {
    @isTest 
public static void unitTest1(){
    List<OpportunityLineItem> testOpp =  [SELECT  Opportunity.Name, Opportunity.CloseDate, Opportunity.CreatedDate, Opportunity.Amount, Opportunity.Account.Name, 
    Quantity, UnitPrice, TotalPrice, PricebookEntry.Product2.Name FROM 
     OpportunityLineItem
    WHERE Opportunity.Amount=900];
}

}

