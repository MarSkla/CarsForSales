public with sharing class OwnerController {
    @AuraEnabled(cacheable=true)
    public static List<Car_Showrooms_Owner__c> getOwners(){
        try {
            return [SELECT Name
                    FROM Car_Showrooms_Owner__c];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
