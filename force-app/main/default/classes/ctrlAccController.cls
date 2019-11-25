public class ctrlAccController {
public String selectedPicklst{get;set;}
   // public list<account>selectedList{get;set;}
    public list<account> showList = new list<account>([select Id, Name,Phone from Account]);
    Public list<account> getshowList(){
        
        return showList;
    }
  public list<account> selectedList=[select Id, Name,Phone from Account where name=:selectedPicklst];
    public list<account> getselectedList(){
        
      
        return selectedList;
    }
   
}