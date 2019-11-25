public class wf {
 public list<schema.account> showList = new list<schema.account>([select Id, Name,Phone from Account ]);
    Public list<schema.account> getshowList(){
        
        return showList;
    }
    }