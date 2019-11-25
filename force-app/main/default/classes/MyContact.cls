public class MyContact {
 @AuraEnabled
public static list<Contact> getContact(list<Id> accountIds)
{
    list<Contact> contactList=[select Id,name,email,AccountId from Contact where AccountId in : accountIds];  
    return contactList;
}

}