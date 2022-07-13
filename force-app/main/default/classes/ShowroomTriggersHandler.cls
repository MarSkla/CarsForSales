public with sharing class ShowroomTriggersHandler {

    // private List<Showroom__c> showroomWithStatusClosed;

    public static void showroomStatusUpdate(List<Showroom__c> updates, Map<Id, Showroom__c> oldShowrooms) {

        Set<Showroom__c> closedShowrooms = new Set<Showroom__c>();

        for (Showroom__c showroom : updates) {
            if (oldShowrooms.get(showroom.Id).Status__c != showroom.Status__c && showroom.Status__c == 'Closed'){
                closedShowrooms.add(showroom);
            }            
        }

        if (closedShowrooms.size() > 0){
            System.debug('list size verified, calling createCases');
            createCases(closedShowrooms);    
        }
    }
    
    private static void createCases(Set<Showroom__c> showrooms) {
        
        System.debug('createCases called');

        List<Case> createdCases = new List<Case>();
    
        for (Showroom__c showroomClosed : showrooms) {
            Case newCase = new Case(Showroom_direct__c = showroomClosed.Id, Status = 'New', Reason = 'Renovation Case');
            createdCases.add(newCase);
        }
        
        insert createdCases;
        System.debug('cases created for showrooms with "closed" status');

        String newCasesToJson = JSON.serialize(createdCases); 
        
        System.debug('calling checkRepairCrewAvailability ');
        checkRepairCrewAvailability(newCasesToJson); 
    }
        
    @future(callout = true)
    private static void checkRepairCrewAvailability(String createdCasesInJson) {

        System.debug('checkRepairCrewAvailability called');
        
        List<Case> casesIn = (List<Case>)JSON.deserialize(createdCasesInJson, List<Case>.class);

        System.debug('cases deserialized from JSON');
        
        Http server = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://jsonplaceholder.typicode.com/posts');
        req.setMethod('POST');
        req.setHeader( 'Content-Type', 'application/json' );
        req.setBody(JSON.serialize(casesIn));

        System.debug('request body: ' + req.getBody()); 

        HttpResponse resp;

        try{
            resp = server.send(req);
            System.debug('-----> response code obtained');
            if(resp.getStatusCode() == 201) {
                System.debug('201');
                for(Case singleCase : casesIn){
                    singleCase.Status = 'Closed';
                }
                System.debug('status "closed" set');                
            } else {
                System.debug(LoggingLevel.ERROR,'Błąd połączenia');
                for (Case singleCase : casesIn) {
                    singleCase.Status = 'Failed';
                }
                System.debug('status "failed" set');                    
            }
            update casesIn;
        } catch (Exception e) {

            createLogRecord(e);
            
            System.debug(LoggingLevel.ERROR,'repair crew verification ERROR');
        }
    }

    private static void createLogRecord(Exception e) {
        Log__c logRec = new Log__c(Source_Class__c = 'ShowroomTriggersHandler', Source_Method__c = 'checkRepairCrewAvailability', Error_Message__c = String.valueof(e));
        insert logRec;
    }    
}