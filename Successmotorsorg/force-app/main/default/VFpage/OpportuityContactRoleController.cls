public with sharing class OpportunityContactRoleController {

    public OpportunityContactRoleController(ApexPages.StandardController controller) {

    }

    public OpportunityContactRole getContactId() {
      return [SELECT ContactId, Contact.Email FROM OpportunityContactRole WHERE IsPrimary = true ];
    }
  }