public with sharing class EcoVadis_EVDataServiceRequest {

    @InvocableVariable(required=false description='Single or comma separated list of integration IDs.')
    public String integrationId;

    @InvocableVariable(required=false description='In YYY-MM-DD format.  Returns all entries with this date or after')
    public String launchDate;

    @InvocableVariable(required=false description='In YYY-MM-DD format.  Returns all entries with this date or after')
    public String publishedDate;

    @InvocableVariable(required=false description='In YYY-MM-DD format.  Returns all entries with this date or after')
    public String statusLastUpdate;

    @InvocableVariable(required=false description='True or False')
    public Boolean declined;

    @InvocableVariable(required=false description='True or False')
    public Boolean buyerAction;

    @InvocableVariable(required=false description='Integer.  Returns all entries equal to or greater than value')
    public Integer globalScore;

    @InvocableVariable(required=false description='True or False')
    public Boolean expired;

    @InvocableVariable(required=false description='"and" or "or".  Used to combine multiple filters')
    public String mode;
    
}
