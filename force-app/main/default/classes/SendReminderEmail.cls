global class SendReminderEmail implements Database.Batchable<sObject>{
    global string query;
                global string subject;
                            global string body;
    global SendReminderEmail(string query,string subject,string body){
        this.query=query;
        this.subject=subject;
        this.body=body;
    }
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
      return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc,List<Speaker__c>scope){
       string[] emailid=new string[]{},
            subject= new string[]{},
                message =new string[]{};
                    for(Speaker__c speaker:scope)
                {
                    emailid.add(speaker.Email__c);
                    subject.add(this.subject);
                    message.add(this.body);
                }
        EmailManager.sendMail(emailid,subject,message);
    }
    global void finish(Database.BatchableContext bc){
        
    }
}