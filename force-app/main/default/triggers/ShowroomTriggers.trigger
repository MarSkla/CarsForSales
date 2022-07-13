trigger ShowroomTriggers on Showroom__c (after update) {

    if(Trigger.isAfter){
        if(trigger.isUpdate){
            ShowroomTriggersHandler.showroomStatusUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}