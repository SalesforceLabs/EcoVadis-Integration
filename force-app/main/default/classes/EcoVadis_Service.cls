/*
 * Copyright (c) 2021, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

/**
 * @description Apex code wrapper for EcoVadis API service
 */
global with sharing class EcoVadis_Service {
	global Integer httpStatusCode = 0;
    global String httpStatusMessage = '';
	global String httpErrorMessage = '';
    global String httpResponseJson = '';
    
    global static final String VERSION = 'v2.1';

    /**
     * @description Sends a request for assessment to the EcoVadis service
     * 
     * @param request - Data to be sent with the request
     * @return Status of the request
     *
     */
    global String evRequest(EcoVadis_EVRequest request) {
        String uri = 'EVRequest';

        // Make sure all the required fields have been provided
        if ((request.integration_id == null) ||
            (request.client_supplier_name == null) ||
            (request.country == null) ||
            (request.supplier_contact_first_name == null) ||
            (request.supplier_contact_last_name == null) ||
            (request.supplier_contact_email == null) ||
            (request.supplier_contact_phone == null) ||
            (request.buyer_contact_first_name == null) ||
            (request.buyer_contact_last_name == null) ||
            (request.buyer_contact_email == null) ||
            (request.campaign_type == null)) {
            throw new EcoVadis_Exception('Required fields are missing');
        }

        // Serialize the request, ignoring any null values, and place it in an array
        String body = '[' + JSON.serialize(request, true) + ']';

        EcoVadis_HttpClient client = new EcoVadis_HttpClient(this, uri, body);
        System.debug(LoggingLevel.DEBUG, 'Target URL: ' + client.getUrl());
        client.execute();

        handleError(client.getStatusCode(), client.getStatusMessage(), client.getResponseError());
        httpResponseJson = client.getResponseAsString();
        if ( client.isError() ) {
            return null;
        } else {
            return client.getResponseAsString();
        }
    }



    /**
     * @description Retrieves ALL available company data.  Use of this method in
     * production is not recommended.  Use filtered methods instead.
     *
     * @return List of EcoVadis_EVData records
     */
    global List<EcoVadis_EVData> eVData() {
        String uri = 'EVData';
        return eVData(uri);
    }

    /**
     * @description Retrieves company data records based on a single filter
     *
     * @param filter - Single filter
     * @return List of EcoVadis_EVData records
     */
    global List<EcoVadis_EVData> eVData(EcoVadis_Filter filter) {
        String uri = 'EVData';
        if (filter != null) {
            uri += '?' + filter.queryString;
        }
        return eVData(uri);
    }

    /**
     * @description Retrieves company data records based on multiple filters
     *
     * @param filter - Multiple filter construct
     * @return List of EcoVadis_EVData records
     */
    global List<EcoVadis_EVData> eVData(EcoVadis_MultipleFilter filter) {
        String uri = 'EVData';
        if (filter != null) {
            uri += filter.queryString;
        }
        return eVData(uri);
    }


    // Private methods
    private List<EcoVadis_EVData> eVData(String uri) {
        System.debug(LoggingLevel.DEBUG, 'EVData');

        EcoVadis_HttpClient client = new EcoVadis_HttpClient(this, uri);
        System.debug(LoggingLevel.DEBUG, 'Target URL: ' + client.getUrl());
        client.execute();

        if ( !client.isError() ) {
            try {
                List<EcoVadis_EVData> response = (List<EcoVadis_EVData>)client.getParser().readValueAs(List<EcoVadis_EVData>.class);
                httpResponseJson = JSON.serializePretty(response);
                return response;
            } catch (Exception e) {
                httpResponseJson = 'Unable to parse JSON from returned data';
                return null;
            }
        }
        handleError(client.getStatusCode(), client.getStatusMessage(), client.getResponseError());
        
        // Catch all.  If an error occurred, make up some data to return, but indicate the error in the JSON.
        httpResponseJson = '{\n    "Estimation": "Simulated data being used", \n' +
                    '    "httpStatusCode": ' + client.getStatusCode() + ',\n' +
                    '    "httpStatusMessage": "' + client.getStatusMessage() + '",\n' +
                    '    "httpErrorMessage": "' + client.getResponseError() + '"\n}';
        return null;
    }

	private void handleError(Integer statusCode, String statusMessage, String message) {
		httpStatusCode = statusCode;
        httpStatusMessage = statusMessage;
		httpErrorMessage = message;
		System.debug(LoggingLevel.Error, 'Response finished with Error: ' + message + ' (status code: ' + statusCode + ')');
	}
}
