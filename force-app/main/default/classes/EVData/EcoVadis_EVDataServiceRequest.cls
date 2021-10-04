global with sharing class EcoVadis_EVDataServiceRequest {

    @InvocableVariable(required=false description='Single or comma separated list of integration IDs.')
    global String integrationId;

    @InvocableVariable(required=false description='In YYY-MM-DD format.  Returns all entries with this date or after')
    global String launchDate;

    @InvocableVariable(required=false description='In YYY-MM-DD format.  Returns all entries with this date or after')
    global String publishedDate;

    @InvocableVariable(required=false description='In YYY-MM-DD format.  Returns all entries with this date or after')
    global String statusLastUpdate;

    @InvocableVariable(required=false description='True or False')
    global Boolean declined;

    @InvocableVariable(required=false description='True or False')
    global Boolean buyerAction;

    @InvocableVariable(required=false description='Integer.  Returns all entries equal to or greater than value')
    global Integer globalScore;

    @InvocableVariable(required=false description='True or False')
    global Boolean expired;

    @InvocableVariable(required=false description='"and" or "or".  Used to combine multiple filters')
    global String mode;
    
}
