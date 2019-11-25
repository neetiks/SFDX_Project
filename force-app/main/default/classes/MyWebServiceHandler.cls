global class MyWebServiceHandler{ 
    webService Static Id createContact(String FirstName, String LastName)
    {
        Contact contRecord = new Contact();
        
        contRecord.FirstName = FirstName; 
        contRecord.LastName = LastName;
        
        insert contRecord;
        return contRecord.Id;
    }
}