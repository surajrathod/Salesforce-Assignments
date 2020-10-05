trigger TaskComplete on Task (after insert,after update) {
    List<Task> taskList;
        
        List<Account> accountToUpdateIncrement=new List<Account>();
        List<Account> accountToUpdateDecrement=new List<Account>();
    if(Trigger.isAfter){
        
        
        if(Trigger.isInsert){
            System.debug('From Insert');
            taskList=Trigger.new;
            for(Task task:taskList){
                //check for the AccountId and Status to Complete
                if(task.AccountId != null && task.Status == 'Completed'){
                    accountToUpdateIncrement.add([Select Id, Number_of_Complete_Task__c from Account where Id=:task.AccountId]);
                }
                System.debug(accountToUpdateIncrement);
                
            }
            for(Account UpdateTaskCompleted:accountToUpdateIncrement){
                if(UpdateTaskCompleted.Number_of_Complete_Task__c == null){
                    UpdateTaskCompleted.Number_of_Complete_Task__c=1;
                }else{
                    UpdateTaskCompleted.Number_of_Complete_Task__c++; 
                }
                
            }
        }else if(Trigger.isUpdate){
            System.debug('From Update');
            taskList=Trigger.new;
            for(Task task:taskList){
                if(task.AccountId != null && task.Status == 'Completed'){
                    accountToUpdateIncrement.add([Select Id, Number_of_Complete_Task__c from Account where Id=:task.AccountId]);
                }else{
                    accountToUpdateDecrement.add([Select Id, Number_of_Complete_Task__c from Account where Id=:task.AccountId]);
                }
            }
            System.debug(accountToUpdateIncrement);
            for(Account UpdateTaskCompleted:accountToUpdateIncrement){
                if(UpdateTaskCompleted.Number_of_Complete_Task__c == null){
                    UpdateTaskCompleted.Number_of_Complete_Task__c=1;
                }else{
                    UpdateTaskCompleted.Number_of_Complete_Task__c++; 
                }   
            }
            for(Account UpdateTaskCompleted:accountToUpdateDecrement){
                UpdateTaskCompleted.Number_of_Complete_Task__c--;    
            }
            System.debug(accountToUpdateDecrement);
            
        }
        
    }
    System.debug(accountToUpdateIncrement);
        System.debug(accountToUpdateDecrement);
        if(!accountToUpdateIncrement.isEmpty()){
            update accountToUpdateIncrement;
        }
        if(!accountToUpdateDecrement.isEmpty()){
            update accountToUpdateDecrement;
        }
}