@isTest
public class BatchClassTest 
{
    
    public static testmethod void t1()
    {
        Position__c ps=new Position__c(name='newPosting');
        insert ps;
        Job_Posting_Site__c jps= new Job_Posting_Site__c(name='newJPS');
        insert jps;
         
        Job_Posting1__c jp1 = new Job_Posting1__c();
        jp1.JPS__c=jps.id;
        jp1.Position2__c=ps.Id;
        jp1.Check__c=true;
        insert jp1;
       Database.executeBatch(new BatchClass());
        
    }
}