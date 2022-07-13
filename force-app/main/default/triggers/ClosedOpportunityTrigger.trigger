trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
   
    List<Task> tasksToBeCreated = new List<Task>();

    for (Opportunity opp : [SELECT Id, AccountId, Name FROM Opportunity
                                    WHERE StageName = 'Closed Won']) {
        tasksToBeCreated.add(new Task(WhatID = opp.Id,
                             Subject = 'Follow Up Test Task',
                             Priority = 'High'));
    }
    
    if(tasksToBeCreated.size() > 0) {
        insert tasksToBeCreated;
    }

}