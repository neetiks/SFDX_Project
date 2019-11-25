public class AccountDisplayController
{
public Account accInstance{get;set;}

public AccountDisplayController(ApexPages.StandardController stdCon)
{
 Id accId=stdCon.getId();
 accInstance =[SELECT Id, name,AccountSource,Site from Account WHERE Id=:accId];
} 
}