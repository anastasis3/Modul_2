global class OpportunityUpdateEmailHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(
    Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
      String subject = email.subject;
      Pattern idPattern = Pattern.compile('(?m)^([\\w\\s]*):(.*)$');
      Matcher matcher = idPattern.matcher(subject);
      if (someErrorCondition) throw new MyCustomException('Nothing opportunitie was found');
      
        Opportunity opp = [SELECT Name, StageName, InvoiceNumber__c FROM Opportunity WHERE InvoiceNumber__c = :matcher.group(0)];

        String approve= 'Approve';
        boolean approveMe;
        approveMe=body.contains(approve);
        String body = email.plainTextBody;

        if (approveMe==true)
        {
       if(opp.StageName=='Prospecting'){
        opp.StageName='Qualification';
       }else if(opp.StageName=='Qualification'){
        opp.StageName='Needs Analysis';
       }else if(opp.StageName=='Needs Analysis'){
        opp.StageName='Value proposition';
       }else if(opp.StageName=='Value proposition'){
        opp.StageName='Decision Makers';
       }else if(opp.StageName=='Decision Makers'){
        opp.StageName='Perception Analysis';
       }else if(opp.StageName=='Perception Analysis'){
        opp.StageName='Perception Analysis';
       }
       else {
        opp.StageName='Closed Won';
       }
      //  opp.StageName = email.plainTextBody;   
      }    
        update opp;
      
      Messaging.InboundEmailresult result = new Messaging.InboundEmailResult();
      result.message = 'You have successfully updated this Opportunities stage to ' + opp.StageName;
      return result;
    }
}