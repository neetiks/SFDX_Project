@isTest
public class TestSendMail1 {
static testmethod void myTestMethod()
{
    SessionName__c ses=new SessionName__c();
    ses.Name='java training';
    ses.Label__c='Immidiate';
    ses.SessionDate__c=system.today()+30;
    ses.Description1__c='java training conduct by me';
    insert ses;
    
    Speaker__c spk=new Speaker__c();
    spk.First_Name__c='saket';
    spk.Last_Name__c='sinha';
    spk.Bio__c='saket is from bihar';
    spk.Email__c='sk@gmail.com';
    insert spk;
    
    Session_Speaker1__c ss=new Session_Speaker1__c();
    ss.Session__c=ses.Id;
    ss.Speaker__c=spk.Id;
    insert ss; 
}
}