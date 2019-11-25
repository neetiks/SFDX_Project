public class WBSRVCwithRestAPI{

private final string  client_key='YjkyMzJmNDUzMGNmOTYzODVlNDQ0ZjE2OTUxOTU1NDI5MGViN2I3NWU3YTFjNmY300D6F0000029WeH';
private final string client_secret='6325939669257960137';
private final string username='integration@sfmarvel.com';
private final string password='password1$';
public class deserializeResponse

   {

      public String id;

      public String access_token;

   }

public String ReturnAccessToken (WBSRVCwithRestAPI acount)

   {

      String reqbody = 'grant_type=password&client_id='+client_key+'&client_secret='+client_secret+'&username='+username+'&password='+password;

       Http h = new Http();

      HttpRequest req = new HttpRequest();

      req.setBody(reqbody);

      req.setMethod('POST');

      req.setEndpoint('https://marvel-us-sf-dev-ed.my.salesforce.com/services/oauth2/token');

      HttpResponse res = h.send(req);

      deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);

      return resp1.access_token;

   }

  @future(callout=true)
    //invoke from account trigger handler
   public static void callcreateAcc (String accName, String accId)

   {

      WBSRVCwithRestAPI acount1 = new WBSRVCwithRestAPI();

      String accessToken;

      accessToken = acount1.ReturnAccessToken (acount1);

if(accessToken != null){
    String endPoint = 'https://marvel-us-sf-dev-ed.my.salesforce.com/services/data/v43.0/sobjects/Account/';//Use custom domain of target SB as end-point URL
    String jsonstr = '{"Name" : "' + accName + '"}';

      Http h2 = new Http();
      HttpRequest req1 = new HttpRequest();
      req1.setHeader('Authorization','Bearer ' + accessToken);
      req1.setHeader('Content-Type','application/json');
      req1.setHeader('accept','application/json');
      req1.setBody(jsonstr);
      req1.setMethod('POST');
      req1.setEndpoint(endPoint);
      HttpResponse res1 = h2.send(req1);

      deserializeResponse resp2 = (deserializeResponse)JSON.deserialize(res1.getbody(),deserializeResponse.class);
    Account a = [SELECT Id FROM Account WHERE Id = :accId];
    a.Response__c = resp2.id;//update account with target response
      update a;
   }
}
   }