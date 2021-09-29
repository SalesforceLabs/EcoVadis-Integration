/**
 * @description retrieves and returns the access token
 */
public with sharing class EcoVadis_BearerFlow {


    private static String accessToken = null;
    private static DateTime expiry = null;

    /**
     * @description retrieves and returns the access token
     * @return String access token
     */
    public static String getAccessToken() {

        // If we have already gotten an access token and it is still valid...
        if ((accessToken != null) && (expiry != null) && (expiry > DateTime.now().addMinutes(5))) {
            // System.debug('current access token');
            return accessToken;
        }

        // Get the URL and creds from the custom setting
        // The EcoVadis server does not accept an HTML encoded password, only URL encoded passwords.  Since there is no way to get the
        // actual password in code to use EncodingUtil, I cannot use Named Credentials, hence the custom setting.
        ecovadis__EcoVadis_Settings__c settings = ecovadis__EcoVadis_Settings__c.getOrgDefaults();

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
                    }
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == '.expires')) {
                        parser.nextToken();
                        String expiryStr = parser.getText();
                        try {
                            expiry = parseExpiry(expiryStr);
                        } catch (Exception e) {
                            expiry = null;
                        }
                    }
                }
            } catch (Exception e) {
                throw new EcoVadis_Exception('Error parsing JSON: ' + e.getMessage() + res.getBody());
            }
		} else {
            throw new EcoVadis_Exception('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
        }
		return accessToken;

    }

    private static DateTime parseExpiry(String expiryString) {
        List<String> parts = expiryString.split(' ');
        String day = parts[1];
        String month = monthIndex(parts[2]);
        String year = parts[3];
        String timestr = parts[4];
        
        String isoString = year + '-' + month + '-' + day + ' ' + timestr;
        return DateTime.valueOfGMT(isoString);
    }

    private static String monthIndex(String monthText) {
        
        switch on monthText.toLowerCase() {
            when 'jan' {
                return '01';
            }
            when 'feb' {
                return '02';
            }
            when 'mar' {
                return '03';
            }
            when 'apr' {
                return '04';
            }
            when 'may' {
                return '05';
            }
            when 'jun' {
                return '06';
            }
            when 'jul' {
                return '07';
            }
            when 'aug' {
                return '08';
            }
            when 'sep' {
                return '09';
            }
            when 'oct' {
                return '10';
            }
            when 'nov' {
                return '11';
            }
            when 'dec' {
                return '12';
            }
            when else {
                throw new EcoVadis_Exception('Unknown month string');
            }
        }
    }    
}
