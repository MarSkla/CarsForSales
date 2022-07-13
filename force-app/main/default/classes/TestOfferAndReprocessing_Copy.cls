@isTest
private class TestOfferAndReprocessing_Copy {
   
     
    @isTest static void testReprocessingRecord(){

        Car__c testCarOut = new Car__c(Car_Make__c = 'Test', Car_Model__c = 'Test', Serial_Number__c = 'TestTestTest', Fuel_Consumption_L__c = 8);

        insert testCarOut;
    
        Test.startTest();
        Database.delete(testCarOut);
        Test.stopTest();
        
        System.assertEquals(1, [SELECT count() FROM Car_Reprocessing__c WHERE Car__c = 'Test Test']);
    }
    
    @isTest static void testValidOffer(){

        Car__c testCarVirtual = new Car__c(Car_Make__c = 'Virtual', Car_Model__c = 'Offer', Serial_Number__c = 'VirtualOfferTest', Fuel_Consumption_L__c = 6);

        insert testCarVirtual;        

        Offer__c virtualOffer = new Offer__c(car__c = testCarVirtual.Id);
        
        Integer offersCount = [SELECT count() FROM Offer__c];
        
        Test.startTest();
        insert virtualOffer;
        Test.stopTest();
        
        System.assertEquals(offersCount + 1, [SELECT count() FROM Offer__c]);
        
    }     
    
    
	@isTest static void testInvalidOffer(){

        Car__c testCar = new Car__c(Car_Make__c = 'Test', Car_Model__c = 'Test', Serial_Number__c = 'TestTestTest', Fuel_Consumption_L__c = 8);

        insert testCar;

        Offer__c existingOffer = new Offer__c(car__c = testCar.Id, Offer_type__c = 'Physical');

        insert existingOffer;
       
        Offer__c secondPhysicalOffer = new Offer__c(car__c = testCar.Id);

        Boolean exceptionThrown = false;
        
        Test.startTest();
            try {
                insert secondPhysicalOffer;
            } catch(Exception e) {
                exceptionThrown = true;
            }
        Test.stopTest();
        System.assertEquals(true, exceptionThrown);
    }       

    @isTest static void testEmailSending(){

        Car__c testCar = new Car__c(Car_Make__c = 'Test', Car_Model__c = 'Test', Serial_Number__c = 'TestTestTest', Fuel_Consumption_L__c = 8);

        insert testCar;

        
        Offer__c existingOffer = new Offer__c(car__c = testCar.Id, Offer_type__c = 'Physical');

        Test.startTest();
        insert existingOffer;
        Test.stopTest();
    }
 
}