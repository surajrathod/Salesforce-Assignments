trigger createContact on Account (after insert) {
List<Contact> conList=new List<Contact>();
        for(Account AccountList:trigger.new){
            conList.add(new Contact(LastName='Default',FirstName='Info',Email='info@websitedomain.tld',AccountId=AccountList.Id));
        }
        if(conList.size()>0){
             insert conList; 
        }
}