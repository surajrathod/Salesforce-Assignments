trigger updateAccount on Contact (after insert, after update) {
Set<Id> acct = new Set<Id>();

for (Contact cnt : trigger.new) {
    acct.add(cnt.AccountId);
}
List<Contact> cnt = new List<Contact>([Select Id from Contact where AccountId IN:acct]);

Integer totlCnts = cnt.Size();

List<Account> acctList = new List<Account>([Select Id from Account where Id IN:acct]);

if (totlCnts == 1) {
    for (Account act : acctList) {
    act.Only_Default_Contact__c = TRUE;
    update act;
    }
} else if (totlCnts > 1) {
    for (Account act : acctList) {
    act.Only_Default_Contact__c = False;
    update act;
    }
    }
}