trigger UpdateProfile on Account (after update) {

    List<Contact> updatedContact=new List<Contact>();
    List<Contact> RelatedContacts=[SELECT Profile__c,FirstName,LastName FROM Contact WHERE AccountId IN :Trigger.new];
        for(Account acct:Trigger.new){
            if(acct.Website!=''){
                for(Contact ct:RelatedContacts){
                    ct.Profile__c=acct.Website+'/'+ct.FirstName.charAt(0)+ ct.LastName;
		    updatedContact.add(ct);
                }           
            }
        }
	if(updatedContact.size()>=1){
            update updatedContact;   
        }
}