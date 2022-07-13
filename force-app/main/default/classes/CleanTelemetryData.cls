public with sharing class CleanTelemetryData implements Database.Batchable<sObject>, Schedulable {

    public static Integer recordsDeleted;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT id, CreatedDate FROM Telemetry__C WHERE CreatedDate != LAST_90_DAYS');
    }

    public void execute(Database.BatchableContext bc, List<Telemetry__c> scope) {
        System.debug('scope size = ' + scope.size());
        for (Telemetry__c scopeElement : scope) {
            System.debug('scope element = ' + scopeElement);
        }
        delete scope;
    }
    
    public void finish(Database.BatchableContext bc) {
        System.debug('no of records deleted: ' + recordsDeleted);
        AsyncApexJob job = [Select Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :bc.getJobId()];
        System.debug('job id = ' + job.Id);
   
    }

    public void execute(SchedulableContext sctx) {
        System.debug('Schedulable execute() called');
        CleanTelemetryData ctd = new CleanTelemetryData();
        Id batch = Database.executeBatch(ctd);
    }
    
}