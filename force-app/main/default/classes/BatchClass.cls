global class BatchClass implements Database.Batchable<sObject>{
  global Database.QueryLocator start(Database.BatchableContext BC){
      String query= 'select Id from Job_Posting1__c where Check__c=true';
      return Database.getQueryLocator(query);
   }
   global void execute(Database.BatchableContext BC, List<sObject> scope)
   {
       List<Job_Posting1__c> jp=(List<Job_Posting1__c>)scope;
       for(Job_Posting1__c jp1:jp)
       {
           jp1.Status__c='process';
       }
       update jp;//
   }
   global void finish(Database.BatchableContext BC){
   }
}