/*
 * Copyright (c) 2021, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

public with sharing class EcoVadis_HttpClient {

    private String method;
    private String url;
    private Boolean isPost = false;
    private EcoVadis_Service service;
    private JSONParser parser;
    private String body;

    // Values for HTTP response
    private String errorMessage;
    private Integer statusCode;
    private String statusMessage;
    private String stringResponse;

    
    public EcoVadis_HttpClient(EcoVadis_Service service, String method) {
        // Get the URL and creds from the custom setting
        ecovadis__EcoVadis_Settings__c settings = ecovadis__EcoVadis_Settings__c.getOrgDefaults();

        this.service = service;
        this.method = method;

        this.url = settings.ecovadis__Environment_URL__c + EcoVadis_Service.VERSION + '/' + method;
    }

    public EcoVadis_HttpClient(EcoVadis_Service service, String method, String body) {
        // Get the URL and creds from the custom setting
        ecovadis__EcoVadis_Settings__c settings = ecovadis__EcoVadis_Settings__c.getOrgDefaults();

        this.service = service;
        this.method = method;
        this.url = settings.ecovadis__Environment_URL__c + EcoVadis_Service.VERSION + '/' + this.method;        
        this.body = body;
        isPost(true);
    }

    public boolean isPost() {
        return isPost;
    }

    public void isPost(boolean isPost) {
        this.isPost = isPost;
    }
    
    public void execute() {
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + getAccessToken());
        request.setTimeout(30000);
        
        request.setMethod('GET');
        if (isPost()) {
            request.setHeader('Content-Type', 'application/json');
            request.setBody(body);
            request.setMethod('POST');
        }

        request.setEndpoint(url);
        Http http = new Http();
        HTTPResponse response = http.send(request);
        updateResponseValues(response);
    }

    public Boolean isError() {
        return (getStatusCode()!=200 && getStatusCode() != 201);
    }

    public Integer getStatusCode() {
        return statusCode;
    }

    public String getStatusMessage() {
        return statusMessage;
    }

    public String getResponseError() {
        return errorMessage;
    }

    public String getUrl() {
        return url;
    }

    public JSONParser getParser() {
        return parser;
    }

    public String getResponseAsString() {
        return stringResponse;
    }

    private void updateResponseValues(HTTPResponse response) {
        statusCode = response.getStatusCode();
        statusMessage = response.getStatus();
        stringResponse = response.getBody();
        System.debug(LoggingLevel.DEBUG, stringResponse);

        // Attempt to parse response into JSON
        try {
            parser = JSON.createParser(response.getBody());
        } catch (Exception e) {
            errorMessage = 'Could not read JSON data';
            return;
        }

        // Some commands return a JSON error message
        if ((getStatusCode()!=200) && (getStatusCode()!=201)) {
            try {
                while (parser.nextToken()!=null) {
                    if (parser.getCurrentToken()==JSONToken.FIELD_NAME) {
                        String currentProperty = parser.getText();
                        if (currentProperty=='error_description') {
                            parser.nextToken();
                            errorMessage = parser.getText();
                            break;
                        }
                    }
                }
            } catch (Exception e) {
                errorMessage = 'Coudl not parse an error_description from the response';
            }
        }
    }

    private static String getAccessToken() {
        return EcoVadis_BearerFlow.getAccessToken();
    }



}