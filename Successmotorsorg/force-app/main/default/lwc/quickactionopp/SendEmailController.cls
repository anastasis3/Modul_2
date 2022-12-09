/*public with sharing class SendEmailController {

    @AuraEnabled(cacheable=true)
    public static void sendEmailTemplate(){
  
  List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

  EmailTemplate emailTemp = [Select id, Subject, Body From EmailTemplate Where DeveloperName = 'ApproveEmail'];

  Contact con = [Select Id, Email from Contact where FirstName =''];

  

  Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

  mail.setTemplateId(emailTemp.Id);

  mail.setTargetObjectId(con.Id);

  emailList.add(mail);

  

  if(!emailList.isEmpty()){

      Messaging.sendEmail(emailList);

  }    
}
}*/


  
/*@AuraEnabled(cacheable=true)
public static void sendEmailTemplate(String body, String toSend, String subject){
    try{
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {toSend};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setHtmlBody('<h1>'+ body + '</h1>');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }catch(Exception ex){
        throw new AuraHandledException(ex.getMessage());
    }
}*/