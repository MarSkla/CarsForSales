public class OfferTriggerHandler {

    public static void checkIfPhysicalOfferExists(List<Offer__c> offersToInsert) {
              
        Set<Id> carIdFromNewOffers = new Set<Id>();
        
        for(Offer__c newOffer : offersToInsert){
            carIdFromNewOffers.add(newOffer.Car__c);
        }
               
        List<Offer__c> currentOffers = new List<Offer__c>([SELECT Id, Car__c
                                                           FROM Offer__c
                                                           WHERE Offer_type__c = 'Physical' AND Car__c IN : carIdFromNewOffers]);

        for (Offer__c newOffer : offersToInsert){
            for(Offer__c existingOffer : currentOffers){
                if (newOffer.Car__c == existingOffer.Car__c){
                    newOffer.addError('Offer for '+newOffer.Car__c+' already exists');
                    break;
                }
            }        
        }
    }


    @future
    public static void sendNewOffersToManager(String triggerObjects) {
        
        System.debug('sendNewOffersToManager called');  

        List<Offer__c> newOffers = (List<Offer__c>)JSON.deserialize(triggerObjects, List<Offer__c>.class);

        String body = '';

        for(Integer i = 0; i < newOffers.size(); i++){
            body = body + newOffers[i].Name + ' | ' + newOffers[i].Car_Make_And_Model__c + ' | '
             + newOffers[i].Offer_Amount__c + ' | ' + newOffers[i].Target_Close_Date__c + '\n';
        }
        System.debug('string created: ' + body);

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'marcin.skladanowski@accenture.com'};
        mail.setToAddresses(toAddresses);
        mail.setReplyTo('marcin.skladanowski@accenture.com');
        mail.setSubject('New offers added');
        mail.setPlainTextBody('New offers:\n' + body);
        System.debug('mail created: ' + mail);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});  
        System.debug('email sent (info from handler)');
    }

    
}