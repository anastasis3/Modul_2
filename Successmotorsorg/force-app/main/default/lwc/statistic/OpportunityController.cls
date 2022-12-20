public class OpportunityController {
    @AuraEnabled(cacheable=true)
public static List<Account> getAcc( String searchKey, integer searchKey2) {
        string searchKeyword = '%' + searchKey + '%';
        integer searchKeyword2 = 0;
       // Integer searchKeyword2=Integer.valueOf(searchKeyword);
     
return [SELECT  Name,Id,  
  (select Id,Name, CloseDate, CreatedDate, Amount FROM Opportunities WHERE StageName = 'Closed Won') 
  FROM Account
  WHERE (Account.Name LIKE : searchKeyword)];

    }    
    
     @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> getProducts(String ids){
        return [SELECT name, Quantity, UnitPrice, TotalPrice, id FROM OpportunityLineItem WHERE opportunityid =: ids];
    }
    
        @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOppoortunitiesForOneAccount(String ids){
        return [SELECT id,name,closedate, createddate, amount FROM Opportunity WHERE accountid =: ids AND StageName = 'Closed Won'];
    }
    }