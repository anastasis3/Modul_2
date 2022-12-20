public with sharing class EmailHandler {
    @AuraEnabled
    public static void sendEmail(List<String> toAddress, String subject, String body) {      
        Messaging.reserveSingleEmailCapacity(1);
        try{
        messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
        
        System.debug(toAddress);
        System.debug(body);
        System.debug(subject);
        toAddress.add('anastacia3a@gmail.com');
        //toAddress.add('anastasiyakupr11@gmail.com');
                
        mail.setToAddresses(toAddress);
        mail.setReplyTo('anastacia3a@gmail.com');
        mail.setSenderDisplayName('Name');
        mail.setSubject(subject);
        mail.setHtmlBody(body);
        // mail.setEntityAttachments(files);
        Messaging.sendEmail(new List<messaging.SingleEmailMessage> {mail});
        }
        catch (exception e){
            throw new AuraHandledException(e.getMessage());
            //return null;
        }
    }
}