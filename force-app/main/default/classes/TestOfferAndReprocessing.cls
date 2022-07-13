@isTest
private class TestOfferAndReprocessing {
    
    static Car__c testCar = new Car__c(Car_Make__c = 'Test',
        			                   Car_Model__c = 'Test',
    	            		           Serial_Number__c = 'TestTestTest',
                            		   Fuel_Consumption_L__c = 8);
    
    static Car__c testCarVirtual = new Car__c(Car_Make__c = 'Virtual',
        			                   Car_Model__c = 'Offer',
    	            		           Serial_Number__c = 'VirtualSN',
                            		   Fuel_Consumption_L__c = 6);
    
    static Offer__c existingOffer = new Offer__c(car__c = testCar.Id,
                                             Offer_type__c = 'Physical');
     
    @isTest static void TestReprocessingRecord(){
        
        insert testCar;
    
        Test.startTest();
        Database.delete(testCar);
        Test.stopTest();
        
        System.assertEquals(1, [SELECT count() FROM Car_Reprocessing__c WHERE Car__c = 'Test Test']);
    }
    
    @isTest static void TestValidOffer(){
        
        insert testCarVirtual;
                
        insert existingOffer;
        
        Offer__c virtualOffer = new Offer__c(car__c = testCarVirtual.Id);
        
        Integer offersCount = [SELECT count() FROM Offer__c];
        
        Test.startTest();
        insert virtualOffer;
        Test.stopTest();
        
        System.assertEquals(offersCount + 1, [SELECT count() FROM Offer__c]);
        
    }     
    
    
	    @isTest static void TestInvalidOffer(){
        
        insert testCar;
        
//        Offer__c existingOffer = new Offer__c(car__c = testCar.Id,
//                                             Offer_type__c = 'Physical');
        
        insert existingOffer;
        
        Offer__c secondPhysicalOffer = new Offer__c(car__c = testCar.Id);
        
        Test.startTest();
            try {
                System.debug('trying to add secondPhysicalOffer');
                insert secondPhysicalOffer;
                System.debug('secondPhysicalOffer inserted');
            } catch(Exception e) {
                System.debug('catched error: ' + e.getMessage());
                Boolean exceptionThrown = (e.getMessage().contains('Offer for '+secondPhysicalOffer.Car__c+' already exists'));
                System.debug('exception boolean = ' + exceptionThrown);
                System.assert(exceptionThrown);
            }
        Test.stopTest();
            
    }      
    
    @isTest static void testEmailSending(){

        Car__c testCar = new Car__c(Car_Make__c = 'Test', Car_Model__c = 'Test', Serial_Number__c = 'TestTestTest', Fuel_Consumption_L__c = 8);

        insert testCar;
        System.debug('car inserted');

        Offer__c existingOffer = new Offer__c(car__c = testCar.Id, Offer_type__c = 'Physical');
        
        System.assertEquals(0, Limits.getEmailInvocations());
        System.debug('emails sent: ' + Limits.getEmailInvocations());

        Test.startTest();
        
        insert existingOffer;
        
        System.assertEquals(0, Limits.getEmailInvocations());
        // System.assertEquals(1, Limits.getEmailInvocations()); assert for synchronous OfferTrig   gerHandler.sendNewOffersToManager()
        System.debug('emails sent: ' + Limits.getEmailInvocations());
        
        Test.stopTest();
    }
 
}