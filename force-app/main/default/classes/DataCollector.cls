public with sharing class DataCollector {
    
    @AuraEnabled(cacheable=true)
    public static List<Car_Showrooms_Owner__c> getOnwersRecords(){
        
        List<Car_Showrooms_Owner__c> ownerRecords = [SELECT Id, Name
                                                    FROM Car_Showrooms_Owner__c];

        return ownerRecords;

    }

    @AuraEnabled(cacheable=true)
    public static List<Showroom__c> getShowrooms(String owner) {

        return [SELECT id, Name FROM Showroom__c WHERE Showroom_Owner__c =: owner];
        
    }

    @AuraEnabled
    public static List<Car__c> getCars(String showroom){

        return [SELECT Full_Name__c FROM Car__c WHERE Physically_Located__c =: showroom];

    }

    @AuraEnabled
    public static Car__c getCarDetails(String car){

        return [SELECT id,
                    Car_Make__c,
                    Car_Model__c,
                    Serial_Number__c,
                    Type__c,
                    Price__c,
                    Status__c,
                    // Physically_Located__c,
                    Power__c,
                    Fuel_Consumption_L__c,
                    Load_Capacity__c,
                    Manager_Notes__c
                    FROM Car__c
                    WHERE Id =: car];

    }

    // @AuraEnabled
    // public static List<Car_Showrooms_Owner__c> getCompanyName(String chosenCompany){

    //     return [SELECT Name FROM Car_Showrooms_Owner__c WHERE Id =: chosenCompany];
    // }
}
