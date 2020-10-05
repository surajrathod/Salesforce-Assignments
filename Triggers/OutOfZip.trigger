trigger OutOfZip on Account (after update) {
    
    
    List<Account> accountToUpdate=new List<Account>();
    List<Account> accounts =[select Id, Name,BillingStreet,BillingPostalCode from Account Where Id IN :Trigger.new];
    for(Account acct:accounts){
        Account oldAcc=Trigger.oldMap.get(acct.Id);
        
        if((acct.BillingStreet != oldAcc.BillingStreet) && (acct.BillingPostalCode != oldAcc.BillingPostalCode)){
            system.debug('run');
            List<Contact> contactList=[Select Id, Name,MailingPostalCode from Contact where (AccountId =:acct.Id AND MailingPostalCode != :acct.BillingPostalCode)];
            if(contactList.size()>0){
                accountToUpdate.add(acct);
                system.debug('run2');
            }
        }
        
    }
    for(Account acc: accountToUpdate){
        acc.Out_of_Zip__c=true;
    }
    if(accountToUpdate.size()>0){
        System.debug(accountToUpdate);
        update accountToUpdate;   
    }
    
}