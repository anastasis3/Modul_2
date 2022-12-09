@isTest
@TestSetup public with sharing class ControllerData {
    @isTest 
public static void unitTest1(){
    List<OpportunityLineItem> testOpp =  [SELECT  Opportunity.Name, Opportunity.CloseDate, Opportunity.CreatedDate, Opportunity.Amount, Opportunity.Account.Name, 
    Quantity, UnitPrice, TotalPrice, PricebookEntry.Product2.Name FROM 
     OpportunityLineItem
    WHERE Opportunity.Account.Name='Comp'];
}


@isTest 
public static void unitTest2(){
    List<OpportunityLineItem> testOpp =  [SELECT  Opportunity.Name, Opportunity.CloseDate, Opportunity.CreatedDate, Opportunity.Amount, Opportunity.Account.Name, 
    Quantity, UnitPrice, TotalPrice, PricebookEntry.Product2.Name FROM 
     OpportunityLineItem
    WHERE Opportunity.Account.Name='Opportunity'];
}

}

