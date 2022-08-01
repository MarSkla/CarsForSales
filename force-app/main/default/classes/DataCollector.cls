public with sharing class DataCollector {

    /**
    * @date 29.07.2022
    * @Description Method used to get list of all companies in datatbase
    * @return a list of all records stored in "Car_Showrooms_Owner__c" sObject
    * @return fields included (api names): Id, Name
    */

    @AuraEnabled
    public static List<Car_Showrooms_Owner__c> getOwnersRecords(){
        
        List<Car_Showrooms_Owner__c> ownerRecords = [SELECT Id, Name
                                                    FROM Car_Showrooms_Owner__c];

        List<Car_Showrooms_Owner__c> finalOwners = new List<Car_Showrooms_Owner__c>();
        List<Car_Showrooms_Owner__c> errorOwners = new List<Car_Showrooms_Owner__c>();

        for (Car_Showrooms_Owner__c owner : ownerRecords) {
            if (isAllowedIdType(owner.Id, 'Car_Showrooms_Owner__c')){
                finalOwners.add(owner);
            }
            else {
                errorOwners.add(owner);
            }   
        }

        if(finalOwners.Size() > 0) {
            return finalOwners;  
          } 
          else {
              return null;
          }
    }

    /**
    * @date 29.07.2022
    * @Description Method used to get list of all showrooms owned by selected company
    * @param owner Id value (string type) for selected company
    * @return a list of records related to selected company and stored in "Showroom__c" sObject
    * @return fields included (api names): Id, Name
    */

    @AuraEnabled
    public static List<Showroom__c> getShowrooms(String outOwner) {

        if(isAllowedIdType(outOwner, 'Car_Showrooms_Owner__c')) {
            List<Showroom__c> showrooms = [SELECT Id, Name
                                            FROM Showroom__c
                                            WHERE Showroom_Owner__c =: outOwner];

            if(showrooms.Size() > 0) {
                return showrooms;  
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    /**
    * @date 29.07.2022
    * @Description Method used to get list of all cars physically located in selected showroom
    * @param showroom Id value (string type) for selected showrom
    * @return a list of records related to selected showroom and stored in "Car__c" sObject
    * @return field included (api names): Full_Name__c
    */

    @AuraEnabled
    public static List<Car__c> getCars(String outShowroom){

        if(isAllowedIdType(outShowroom, 'Showroom__c')) {
            List<Car__c> cars = [SELECT Full_Name__c
                                FROM Car__c
                                WHERE Physically_Located__c =: outShowroom];

            if(cars.Size() > 0) {
                return cars;  
            } else {
                return null;
            }
        } else {
            return null;
        }
    }


    /**
    * @date 29.07.2022
    * @Description Private method used to validate presence and type of Id for each record in a list of records
    *        returned by parent method.
    * @param inputId field's api name contating Id value for an object
    * @param objectType object's api name
    * @return a list of records related to selected showroom and stored in "Car__c" sObject
    * @return field included (api names): Id, Car_Make__c, Car_Model__c, Serial_Number__c, Type__c,
    *           Price__c, Status__c, Power__c, Fuel_Consumption_L__c, Load_Capacity__c,
                Manager_Notes__c, interested__c
    */

    private static Boolean isAllowedIdType( String inputId, String objectType )
    {
        if ( !String.isBlank( inputId ) && inputId instanceof Id )
        {
            Id verifyId = Id.valueOf( inputId );
            if ( objectType.equalsIgnoreCase( verifyId.getSobjectType( ).getDescribe( ).getName( ) ) )
            {
                return true;
            }
        }
        return false;
    }
}
