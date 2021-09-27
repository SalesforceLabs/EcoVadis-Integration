/**
 * @description retrieves and returns the access token
 */
public with sharing class EcoVadis_BearerFlow {


    /**
     * @description retrieves and returns the access token
     * @return String access token
     */
    public static String getAccessToken() {

        // Get the URL and creds from the custom setting
        // The EcoVadis server does not accept an HTML encoded password, only URL encoded passwords.  Since there is no way to get the
        // actual password in code to use EncodingUtil, I cannot use Named Credentials, hence the custom setting.
        ecovadis__EcoVadis_Settings__c settings = ecovadis__EcoVadis_Settings__c.getOrgDefaults();

        String accessToken = null;
        String body = 'grant_type=password&' + 
        'username=' + settings.ecovadis__Username__c.escapeHtml4() + '&' +
        'password=' + EncodingUtil.urlEncode(settings.ecovadis__Password__c, 'UTF-8');

        // System.debug(LoggingLevel.DEBUG, body);
       
        HttpRequest req = new HttpRequest();
        req.setEndpoint(settings.ecovadis__Environment_URL__c + 'EVToken');
        req.setMethod('POST');
        req.setBody(body);
        req.setHeader('Content-type', 'application/x-www-form-urlencoded');
        Http http = new Http();

        HTTPResponse res = http.send(req);
        if ( res.getStatusCode() == 200 ) {
            try {
                System.JSONParser parser = System.JSON.createParser(res.getBody());
                while (parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'access_token')) {
                        parser.nextToken();
                        accessToken = parser.getText();
                        break;
                    }
                }
            } catch (Exception e) {
                System.debug(LoggingLevel.ERROR, 'Error parsing JSON: ' + e.getMessage() + res.getBody());
            }
		} else {
            System.debug(LoggingLevel.ERROR, 'Error: ' + res.getStatusCode() + ' ' + res.getStatus());
        }
		return accessToken;

    }
}
