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
            // Type__c = 'Passenger',
            Internet_Site__c = 'www.google.com'
        );

        insert testShowroom;

        Test.startTest();
            List<Showroom__c> testShowrooms = DataCollector.getShowrooms(testOwner.Id);
            System.assert(testShowrooms != null);
            System.assertEquals(testShowroom.Id, testShowrooms[0].Id);
            // System.debug('testOwner Id: ' + testOwner.Id);
            // System.debug('testShowroom Id: ' + testShowroom.Id);
            // System.debug('testOwner Name (List): ' + testShowrooms[0].Name);
            // System.debug('testOwner Id (List): ' + testShowrooms[0].Id);
            delete testShowroom;
            System.assertEquals(null, DataCollector.getShowrooms(testOwner.Id));
        Test.stopTest();    
    }

    // @isTest static void getShowroomsNullParameterTest() {
    //     Id testId = null;
    //     // System.debug('testId: ' + testId);
    //     Boolean exceptionThrown = false;
    //     // System.debug('exceptionThrown: ' + exceptionThrown);

    //     try {
    //         // System.debug('tried');
    //         DataCollector.getShowrooms(testId);
    //     } catch (NullPointerException e) {
    //         // System.debug('catch');
    //         // System.debug('exceptionThrown: ' + exceptionThrown);

    //         exceptionThrown = true;
    //         // System.debug('exceptionThrown: ' + exceptionThrown);

    //     }
        
    //     // System.debug('after STOPTEST exceptionThrown: ' + exceptionThrown);
    //     System.assert(exceptionThrown);
        
    // }

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
            // Type__c = 'Passenger',
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
            System.debug('testOwner Id: ' + testOwner.Id);
            System.debug('testShowroom Id: ' + testShowroom.Id);
            System.debug('testCar Id: ' + testCar.Id);
            System.debug('testCars Name (List): ' + testCars[0].Full_Name__c);
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
            // Type__c = 'Passenger',
            Internet_Site__c = 'www.google.com'
        );

        insert testShowroom;

        Test.startTest();
            List<Car__c> testCars = DataCollector.getCars(testShowroom.Id);
            System.assertEquals(null, DataCollector.getCars(testShowroom.Id));
            // System.assert(testCars != null);
            // System.assertEquals(testCar.Id, testCars[0].Id);
            // System.debug('testOwner Id: ' + testOwner.Id);
            // System.debug('testShowroom Id: ' + testShowroom.Id);
            // System.debug('testCar Id: ' + testCar.Id);
            // System.debug('testCars Name (List): ' + testCars[0].Full_Name__c);
        Test.stopTest();    
    }


    // @isTest static void getCarDetailsTest() {

    //     Car_Showrooms_Owner__c testOwner = new Car_Showrooms_Owner__c(
    //         Name = 'Owner Test'
    //     );

    //     insert testOwner;

    //     Showroom__c testShowroom = new Showroom__c(
    //         Name = 'Showroom Test',
    //         Showroom_Owner__c = testOwner.Id,
    //         Street__c = 'Showroom Test',
    //         City__c = 'Showroom Test',
    //         // Type__c = 'Passenger',
    //         Internet_Site__c = 'www.google.com'
    //     );

    //     insert testShowroom;
        
    //     Car__c testCar = new Car__c(
    //         Car_Make__c = 'Car Test Maker',
    //         Car_Model__c = 'Car Test Model',
    //         Serial_Number__c = 'Car Test SN',
    //         Type__c = 'Sport',
    //         Price__c = 15000,
    //         Status__c = 'Needs Repair',
    //         Power__c = 100,
    //         Fuel_Consumption_L__c = 12,
    //         Load_Capacity__c = 1000,
    //         Manager_Notes__c = '',
    //         interested__c = false,
    //         Physically_Located__c = testShowroom.id
    //     );

    //     insert testCar;

    //     Test.startTest();
    //     Car__c testCarDetails = DataCollector.getCarDetails(testCar.id);
    //     System.assertEquals(testCar.id, testCarDetails.id);
    // }

    // @isTest static void getCarDetailsWrongIdTest() {

    //     Test.startTest();
    //     Car__c testCarDetails = DataCollector.getCarDetails('blabla');
    //     System.assertEquals(null, testCarDetails);
    // }

}
