@IsTest
global with sharing class ShowroomTriggersHandlerNegativeMock implements HttpCalloutMock{

    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(400);
        return response;
    }

}