public class MypageController
{
public String inputname{get;set;}
public String location{get;set;}

    public MypageController()
     {
       Map<String,String> paraMap=ApexPages.currentPage().getParameters();
       location=paraMap.get('location');
     }

}