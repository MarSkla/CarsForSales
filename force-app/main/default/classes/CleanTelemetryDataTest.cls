@isTest
public with sharing class CleanTelemetryDataTest {

    @TestSetup
    static void setup(){

        Car__c testCar = new Car__c(Car_Make__c = 'Test', Car_Model__c = 'Test', Serial_Number__c = '88888888');
        insert testCar;
        
        List<Telemetry__c> testTelemetryRecords = new List<Telemetry__c>();

        for (Integer i = 0; i < 25; i++) {
            testTelemetryRecords.add(new Telemetry__c(Car__c = testCar.Id));            
        }
        // System.debug('testTelemetryRecords with test data = ' + testTelemetryRecords.size());

        insert testTelemetryRecords;
        // System.debug('testTelemetryRecords inserted');

        for (Telemetry__c tel : testTelemetryRecords) {
            Test.setCreatedDate(tel.id, Datetime.newInstance(2022, 04, 01));
        }
        // System.debug('CreatedDates updated');

        // for (Telemetry__c testData : [SELECT Car__c, CreatedDate FROM Telemetry__c]) {
        //     System.debug(testData);
        // }
        
    }
    @isTest static void testSchedule(){

        String CRON_EXP = DateTime.now().second() + ' ' + (Datetime.now().minute() + 1) +' * * * ? *';
        System.debug('Cron_exp: ' + Cron_EXP);

        Test.startTest();

        String schedule = System.schedule('Clean old telemetries', CRON_EXP, new CleanTelemetryData());

        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :schedule];
        // System.debug('current salesforce time' + DateTime.now());
        // System.debug('next fire - from CronTrigger' + ct.NextFireTime);
        
        System.assertEquals(0, ct.TimesTriggered);
        System.assertEquals(Datetime.now().addMinutes(1), ct.NextFireTime);
        System.assertEquals(null, CleanTelemetryData.recordsDeleted);
        
        Test.stopTest();

        System.assertEquals(25, [SELECT count() FROM Telemetry__c WHERE CreatedDate < 2022-04-02T23:59:59Z]);
        System.debug('records deleted (after Test.stopTest()): ' + CleanTelemetryData.recordsDeleted);
    }

    // @isTest static void testTelemetryDataCleaning(){

    //     Test.startTest();

    //     CleanTelemetryData ctd = new CleanTelemetryData();
    //     Id batch = Database.executeBatch(ctd);

    //     Test.stopTest();

    //     System.assertEquals(25, CleanTelemetryData.recordsDeleted);
    //     System.assertEquals(0, [SELECT count() FROM Telemetry__c WHERE CreatedDate < 2022-04-02T23:59:59Z]);
    // }

    

}