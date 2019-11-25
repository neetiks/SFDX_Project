public class AccountSearchController
{
public List<account> acclist{get;set;}
public String accname{get;set;}
public AccountSearchController()
{
acclist=new List<account>();
accname='';
}
public void accsearch()
{
String searchstr='%'+accname+'%';
acclist=[SELECT Id,Name,Type FROM Account WHERE Name LIKE:searchstr];
}  
}