@isTest
public with sharing class ShowroomTriggersHandlerTest {

    @IsTest
    static void testShowroomStatusClosedPositiveResponse(){

        Test.setMock(HttpCalloutMock.class, new ShowroomTriggersHandlerMock());

        Integer numOfCasesBeforeStatusUpdate = [SELECT count() FROM Case];
        System.debug('SETUP: num of cases before update: ' + numOfCasesBeforeStatusUpdate);
        
        Integer numOfLogsBefore = [Select count() FROM Log__c];
        System.debug('SETUP: num of logs before update: ' + numOfLogsBefore);
        
        Car_Showrooms_Owner__c testOwner = new Car_Showrooms_Owner__c(Name = 'Test Owner');
        System.debug('SETUP: testOwner created');
        
        insert testOwner;
        System.debug('SETUP: testOwner inserted');
        
        Showroom__c testShowroom = new Showroom__c(Type__c = 'Passenger', Street__c = 'Test Street',
        City__c = 'Test City', Internet_Site__c = 'www.google.com', Showroom_Owner__c = testOwner.id);
        System.debug('SETUP: testShowroom created');
        
        insert testShowroom;
        System.debug('SETUP: testShowroom inserted');
        
        testShowroom.Status__c = 'Closed';      
        System.debug('testShowroom "Closed" status assigned - switching to handler');

                
        Test.startTest();
        
        update testShowroom;
        System.debug('inside Test() - testShowroom status changed to "Closed"');

        System.assertEquals(numOfCasesBeforeStatusUpdate + 1, [SELECT count() FROM Case], 'new cases should be created');
        System.debug('num of cases after update: ' + [SELECT count() FROM Case]);
        
        Test.stopTest();
    }

    @IsTest
    static void testShowroomStatusClosedNegativeResponse(){

        Test.setMock(HttpCalloutMock.class, new ShowroomTriggersHandlerNegativeMock());

        Integer numOfCasesBeforeStatusUpdate = [SELECT count() FROM Case];
        System.debug('SETUP: num of cases before update: ' + numOfCasesBeforeStatusUpdate);
        
        Integer numOfLogsBefore = [Select count() FROM Log__c];
        System.debug('SETUP: num of logs before update: ' + numOfLogsBefore);
        
        Car_Showrooms_Owner__c testOwner = new Car_Showrooms_Owner__c(Name = 'Test Owner');
        System.debug('SETUP: testOwner created');
        
        insert testOwner;
        System.debug('SETUP: testOwner inserted');
        
        Showroom__c testShowroom = new Showroom__c(Type__c = 'Passenger', Street__c = 'Test Street',
        City__c = 'Test City', Internet_Site__c = 'www.google.com', Showroom_Owner__c = testOwner.id);
        System.debug('SETUP: testShowroom created');
        
        insert testShowroom;
        System.debug('SETUP: testShowroom inserted');
        
        testShowroom.Status__c = 'Closed';      
        System.debug('testShowroom "Closed" status assigned - switching to handler');

                
        Test.startTest();
        
        update testShowroom;
        System.debug('inside Test() - testShowroom status changed to "Closed"');

        System.assertEquals(numOfCasesBeforeStatusUpdate + 1, [SELECT count() FROM Case], 'new cases should be created');
        System.debug('num of cases after update: ' + [SELECT count() FROM Case]);
        
        Test.stopTest();
    }

    @IsTest
    static void testShowroomStatusClosedError(){

        Integer numOfCasesBeforeStatusUpdate = [SELECT count() FROM Case];
        System.debug('SETUP: num of cases before update: ' + numOfCasesBeforeStatusUpdate);
        
        Integer numOfLogsBefore = [Select count() FROM Log__c];
        System.debug('SETUP: num of logs before update: ' + numOfLogsBefore);
        
        Car_Showrooms_Owner__c testOwner = new Car_Showrooms_Owner__c(Name = 'Test Owner');
        System.debug('SETUP: testOwner created');
        
        insert testOwner;
        System.debug('SETUP: testOwner inserted');
        
        Showroom__c testShowroom = new Showroom__c(Type__c = 'Passenger', Street__c = 'Test Street',
        City__c = 'Test City', Internet_Site__c = 'www.google.com', Showroom_Owner__c = testOwner.id);
        System.debug('SETUP: testShowroom created');
        
        insert testShowroom;
        System.debug('SETUP: testShowroom inserted');
        
        testShowroom.Status__c = 'Closed';      
        System.debug('testShowroom "Closed" status assigned - switching to handler');

                
        Test.startTest();

        update testShowroom;
        
        Test.stopTest();

        System.assertEquals(numOfLogsBefore + 1, [Select count() FROM Log__c]);
        System.debug('num of logs: =' + [Select count() FROM Log__c]);
    }

}