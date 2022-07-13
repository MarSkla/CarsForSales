trigger OfferExists on Offer__c (before insert, after insert) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            OfferTriggerHandler.checkIfPhysicalOfferExists(Trigger.new);
        }
    }

    if(Trigger.isAfter){
        if(Trigger.isInsert){

            String triggerNewToJson = JSON.serialize(Trigger.new);            
            System.debug('serialization ok');
            System.debug('JASON: ' + triggerNewToJson);
            OfferTriggerHandler.sendNewOffersToManager(triggerNewToJson);
            System.debug('calling handler method');
        }
    }

    
    
    /*
    List<Offer__c> currentOffers = [SELECT Car__c
                                    FROM Offer__c
                                    WHERE Offer_type__c = 'Physical'];
    
    List<Offer__c> offersToInsert = new List<Offer__c>();
    
    for (Offer__c newOffer : Trigger.New){
        for(Offer__c existingOffer : currentOffers){
            if (newOffer.Car__c == existingOffer.Car__c){
                newOffer.addError('Offer for '+newOffer.Car__c+' already exists');
                break;
            } else {
                offersToInsert.add(newOffer);
            }
        }        
    }    
//    insert offersToInsert - nie jest potrzebny w przypadku "before" - logiczne...
    */
}