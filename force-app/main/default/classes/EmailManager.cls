public class EmailManager
{
public static void sendMail(List<string> emailid,List<string> subject,List<string> message)
{
    List<Messaging.SingleEmailMessage> emailList= new List<Messaging.SingleEmailMessage>{};
        Integer totalMails=emailid.size();
    for(Integer i=0;i<totalmails;i++)
    {
        Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
        email.setsubject(subject[i]);
        email.setToAddresses(new list<string> {emailid[i]});
        email.setplainTextBody(message[i]);
        emailList.add(email);      
    }
    Messaging.sendEmail(emailList);
}
}