public with sharing class DataCollector {

    /**
    * @date 29.07.2022
    * @description Method used to get list of all companies in datatbase
    * @return a list of all records stored in "Car_Showrooms_Owner__c" sObject
    * @return fields included (api names): Id, Name
    */

    
    @AuraEnabled
    public static List<Car_Showrooms_Owner__c> getOwnersRecords(){
        
        List<Car_Showrooms_Owner__c> ownerRecords = [SELECT Id, Name
                                                    FROM Car_Showrooms_Owner__c];

        return ownerRecords;

    }

    /**
    * @date 29.07.2022
    * @description Method used to get list of all showrooms owned by selected company
    * @param owner Id value (string type) for selected company
    * @return a list of records related to selected company and stored in "Showroom__c" sObject
    * @return fields included (api names): Id, Name
    */

    @AuraEnabled
    public static List<Showroom__c> getShowrooms(String owner) {

        return [SELECT Id, Name FROM Showroom__c WHERE Showroom_Owner__c =: owner];
        
    }

    /**
    * @date 29.07.2022
    * @description Method used to get list of all cars physically located in selected showroom
    * @param showroom Id value (string type) for selected showrom
    * @return a list of records related to selected showroom and stored in "Car__c" sObject
    * @return field included (api names): Full_Name__c
    */

    @AuraEnabled
    public static List<Car__c> getCars(String showroom){

        return [SELECT Full_Name__c FROM Car__c WHERE Physically_Located__c =: showroom];

    }

    /**
    * @date 29.07.2022
    * @description Method used to get list of all cars physically located in selected showroom
    * @param car Id value (string type) for selected car
    * @return a list of records related to selected showroom and stored in "Car__c" sObject
    * @return field included (api names): Id, Car_Make__c, Car_Model__c, Serial_Number__c, Type__c,
    *           Price__c, Status__c, Power__c, Fuel_Consumption_L__c, Load_Capacity__c,
                Manager_Notes__c, interested__c
    */

    @AuraEnabled
    public static Car__c getCarDetails(String car){

        return [SELECT Id,
                    Car_Make__c,
                    Car_Model__c,
                    Serial_Number__c,
                    Type__c,
                    Price__c,
                    Status__c,
                    Power__c,
                    Fuel_Consumption_L__c,
                    Load_Capacity__c,
                    Manager_Notes__c,
                    interested__c
                    FROM Car__c
                    WHERE Id =: car];

    }
}
