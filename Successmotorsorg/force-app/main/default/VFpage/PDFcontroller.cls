public class PDFcontroller {

    public List<OpportunityLineItem> products {get; set;} 
    public List<OpportunityContactRole> contactRoles {get; set;} 
    public List<User> user {get; set;} 

    public PDFcontroller(ApexPages.StandardController controller) {
     this.contactRoles = [SELECT Id, Role, ContactId, Contact.Name, Contact.Phone, Contact.OtherPhone, Contact.Email
                            FROM OpportunityContactRole
                            WHERE IsPrimary = true];

    }

    public void ShowRelatedProducts()
    {
        List <OpportunityLineItem> prod_InfoList = [SELECT Name, ListPrice, 
                                                           ProductCode,Quantity,
                                                           UnitPrice,TotalPrice 
                                                    FROM OpportunityLineItem];
    }
    
        public void ShowContacts()
    {
        List <OpportunityContactRole> con_role = [SELECT ContactId, Contact.Name
                                                  FROM OpportunityContactRole
                                                  WHERE IsPrimary = true];
    }
    
}