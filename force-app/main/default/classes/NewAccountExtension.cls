public class NewAccountExtension
{
public ApexPages.StandardController stdConOfClass{get;set;}

public NewAccountExtension(ApexPages.StandardController stdCon)
{
stdConOfClass=stdCon;
}
public PageReference save()
{
//1.save account
PageReference pgRefToAccountRecord=stdConOfClass.save();
stdConOfClass.save();
//2.create opp
Opportunity opp=new Opportunity();
opp.Name='Default Opp';
opp.CloseDate=System.today()+5;
opp.Amount=10000;
opp.StageName='Prospecting';
opp.AccountId=stdConOfClass.getId();
insert opp;
return pgRefToAccountRecord;
}
}