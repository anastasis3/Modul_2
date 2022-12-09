global class OpportunityUpdateEmailHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(
    Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
      String subject = email.subject;
      Pattern idPattern = Pattern.compile('006[A-Za-z0-9]{12}');
      Matcher matcher = idPattern.matcher(subject);
      if (!matcher.find()) System.assert(false, 'No Opportunity ID found in the Subject!');
      
        Opportunity opp = [SELECT Name, StageName, InvoiceNumber__c FROM Opportunity WHERE InvoiceNumber__c = :matcher.group(0)];
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
        opp.StageName='Closed Lost';
       }
        opp.StageName = email.plainTextBody;       
        update opp;
      
      Messaging.InboundEmailresult result = new Messaging.InboundEmailResult();
      result.message = 'You have successfully updated this Opportunities stage to ' + opp.StageName;
      return result;
    }
}