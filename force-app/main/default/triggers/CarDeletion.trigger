trigger CarDeletion on Car__c (after delete) {
    
    if(Trigger.isAfter){
        if(Trigger.isDelete){
            CarTriggersHandler.createArchiveNote(Trigger.old);    	        
        }
    }
    
    
/*
    List<Car_Reprocessing__c> archiveRecords = new List<Car_Reprocessing__c>();
    System.debug('archiveRecords created');
    
    for(Car__c deletedCar : Trigger.old){
        System.debug('current deletedCar = '+deletedCar);
        Car_Reprocessing__c archiveNote = new Car_Reprocessing__c(Car__c = (deletedCar.Car_Make__c + ' ' + deletedCar.Car_Model__c),
                                                                 Reprocessing_completed__c = true,
                                                                 Exhaust_gases_limitation__c = (deletedCar.Fuel_Consumption_L__c * 3.27));
        
        System.debug('archiveNote: ('+ deletedCar.Car_Make__c + ' ' + deletedCar.Car_Model__c + '), ' + deletedCar.Fuel_Consumption_L__c * 3.27);
        archiveRecords.add(archiveNote);
        System.debug('archive note added');
    }
    insert archiveRecords;
    System.debug('Insertion ok');
*/
}