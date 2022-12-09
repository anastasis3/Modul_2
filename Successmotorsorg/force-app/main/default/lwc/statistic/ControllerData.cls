public with sharing class ControllerData {
 
    @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> retrieveContactData (string keySearch){       
 return [SELECT  Opportunity.Name, Opportunity.CloseDate, Opportunity.CreatedDate, Opportunity.Amount, Opportunity.Account.Name, 
  Quantity, UnitPrice, TotalPrice, PricebookEntry.Product2.Name FROM 
   OpportunityLineItem
  WHERE Opportunity.Account.Name=:keySearch];
    }
}

/*public with sharing class ControllerData {
 
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> retrieveContactData (string keySearch){       
 return [SELECT Id, Name, CloseDate, CreatedDate, Amount, Account.Name,
  (SELECT Quantity, UnitPrice, TotalPrice, 
   PricebookEntry.Name, PricebookEntry.Product2.Name FROM 
   OpportunityLineItems) 
FROM Opportunity WHERE Account.Name=:keySearch];
    }
}*/
/*public with sharing class ControllerData {
 
    @AuraEnabled(cacheable=true)
    public static List<Contact> retrieveContactData(string keySearch){       
        
        List<Contact> contactList = [Select Id, FirstName, LastName, Email, Phone, Account.Name From Contact Where Account.Name=:keySearch];
        return contactList;
    }
}*/

/*select id, quantity, unitPrice, totalPrice, productCode, product2.someFldOnProduct2, 
       opportunity.name, opportunity.amount, opportunity.somefieldOnOppo
    from OpportunityLineItem 
    where opportunity.stageName = 'Closed'*/


    
