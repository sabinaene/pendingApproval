public with sharing class AccountController2 {
    @AuraEnabled(cacheable=true)
    public static Integer getApprovalCount(){
        Integer myApprovals = 0;
        Id userId = UserInfo.getUserId();

        List<ProcessInstance> processList = [SELECT Id, (SELECT Id FROM StepsAndWorkitems WHERE ActorId =: userId AND IsPending = TRUE) FROM ProcessInstance];
        for(ProcessInstance allApproval : processList){
            for(ProcessInstanceHistory myActions : allApproval.StepsAndWorkItems)
            {
                myApprovals++;
            }
        }
        system.debug('myApprovals === ' + myApprovals);
        return myApprovals;
    }

    @AuraEnabled(cacheable=true)
    public static String getFirstName(){
        Id userId = UserInfo.getUserId();
        User usr = [SELECT FirstName FROM User WHERE Id =: userId];
        system.debug('usr === ' + usr.FirstName);
        return usr.FirstName;

    }
}