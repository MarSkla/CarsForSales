@isTest
public with sharing class DataCollectorTest {

    @isTest static void getOwnersRecordsTest() {
        Car_Showrooms_Owner__c testOwner = new Car_Showrooms_Owner__c(
            Name = 'Owner Test'
        );

        insert testOwner;

        Test.startTest();
            List<Car_Showrooms_Owner__c> owners = DataCollector.getOwnersRecords();
            System.assert(owners != null);
            System.debug('finalOwners size: ' + owners.Size());
            System.debug('testOwner Name (List): ' + owners[0].Name);
            System.debug('testOwner Id (List): ' + owners[0].Id);
            delete testOwner;
            System.assertEquals(null, DataCollector.getOwnersRecords());
        Test.stopTest();
    }

    @isTest static void getShowroomsTest() {

        Car_Showrooms_Owner__c testOwner = new Car_Showrooms_Owner__c(
            Name = 'Owner Test'
        );

        insert testOwner;

        Showroom__c testShowroom = new Showroom__c(
            Name = 'Showroom Test',
            Showroom_Owner__c = testOwner.Id,
            Street__c = 'Showroom Test',
            City__c = 'Showroom Test',
            Internet_Site__c = 'www.google.com'
        );

        insert testShowroom;

        Test.startTest();
            List<Showroom__c> testShowrooms = DataCollector.getShowrooms(testOwner.Id);
            System.assert(testShowrooms != null);
            System.assertEquals(testShowroom.Id, testShowrooms[0].Id);

            delete testShowroom;
            System.assertEquals(null, DataCollector.getShowrooms(testOwner.Id));
        Test.stopTest();    
    }

    @isTest static void getShowroomsNullReturnTest() {

        Test.startTest();
            System.assertEquals(null, DataCollector.getShowrooms('1000000000zzzzz'));
        Test.stopTest();
    }

    @isTest static void getCarsTest() {

        Car_Showrooms_Owner__c testOwner = new Car_Showrooms_Owner__c(
            Name = 'Owner Test'
        );

        insert testOwner;

        Showroom__c testShowroom = new Showroom__c(
            Name = 'Showroom Test',
            Showroom_Owner__c = testOwner.Id,
            Street__c = 'Showroom Test',
            City__c = 'Showroom Test',
            Internet_Site__c = 'www.google.com'
        );

        insert testShowroom;
        
        Car__c testCar = new Car__c(
            Car_Make__c = 'Car Test Maker',
            Car_Model__c = 'Car Test Model',
            Serial_Number__c = 'Car Test SN',
            Physically_Located__c = testShowroom.id
        );

        insert testCar;

        Test.startTest();
            List<Car__c> testCars = DataCollector.getCars(testShowroom.Id);
            System.assert(testCars != null);
            System.assertEquals(testCar.Id, testCars[0].Id);
        Test.stopTest();    
    }

    @isTest static void getCarsEmptyTest() {

        Car_Showrooms_Owner__c testOwner = new Car_Showrooms_Owner__c(
            Name = 'Owner Test'
        );

        insert testOwner;

        Showroom__c testShowroom = new Showroom__c(
            Name = 'Showroom Test',
            Showroom_Owner__c = testOwner.Id,
            Street__c = 'Showroom Test',
            City__c = 'Showroom Test',
            Internet_Site__c = 'www.google.com'
        );

        insert testShowroom;

        Test.startTest();
            List<Car__c> testCars = DataCollector.getCars(testShowroom.Id);
            System.assertEquals(null, DataCollector.getCars(testShowroom.Id));
        Test.stopTest();    
    }

    @isTest static void getCarsNullReturnTest() {

        Test.startTest();
            System.assertEquals(null, DataCollector.getCars('car1768'));
        Test.stopTest();
    }

}
