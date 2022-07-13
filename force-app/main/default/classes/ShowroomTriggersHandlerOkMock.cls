@IsTest
global with sharing class ShowroomTriggersHandlerOkMock implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(201);
        return response;
    }

}