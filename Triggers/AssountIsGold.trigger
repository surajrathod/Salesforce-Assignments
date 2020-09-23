trigger AccountIsGold on Opportunity (before insert,before update) {
    
    List<Account> acctsisgold = new List<Account>();
    
    for(Opportunity opps: Trigger.new){
        if(opps.Amount>20000){
            acctsisgold.add([Select is_gold__c from Account where ID=:opps.AccountId]);
        }
    }
    for(Account acct:acctsisgold){
        acct.is_gold__c=true;
    }
    if(acctsisgold.size()>=1){
          update acctsisgold;  
        }
}