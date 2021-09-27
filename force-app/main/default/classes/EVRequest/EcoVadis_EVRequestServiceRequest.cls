public with sharing class EcoVadis_EVRequestServiceRequest {

    @InvocableVariable(required=true description='The integration ID to match the company in both systems')
    public String integrationId;

    @InvocableVariable(required=true description='Legal entity to be assessed')
    public String clientSupplierName;

    @InvocableVariable(required=false description='Parent company (if applicable)')
    public String parentCompany;

    @InvocableVariable(required=false description='Procurement category/material group of the company in the Client System')
    public String clientProcurementCategory;

    @InvocableVariable(required=false description='Company Tax ID')
    public String taxNumber;

    @InvocableVariable(required=false description='Company VAT number')
    public String vatNumber;

    @InvocableVariable(required=false description='Company business registration number')
    public String brnNumber;

    @InvocableVariable(required=false description='DUNS: Dun & Bradstreet (D&B) company number')
    public Integer dunsNumber;

    @InvocableVariable(required=false description='Company’s website URL')
    public String website;

    @InvocableVariable(required=false description='Company turnover/revenue (in USD). Should be an integer greater than or equal to 0')
    public Integer turnover;

    @InvocableVariable(required=false description='Number of company employees. Should be an integer greater than 0')
    public Integer numberEmployees;

    @InvocableVariable(required=false description='Company address')
    public String address;

    @InvocableVariable(required=false description='Company city')
    public String city;

    @InvocableVariable(required=false description='Company postal code')
    public String zipCode;

    @InvocableVariable(required=true description='Company country (in English).')
    public String country;

    @InvocableVariable(required=false description='Primary contact title (e.g., Mr., Mrs., Ms. or Dr.)')
    public String supplierContactTitle;

    @InvocableVariable(required=false description='Primary contact first name')
    public String supplierContactFirstName;

    @InvocableVariable(required=false description='Primary contact last name')
    public String supplierContactLastName;

    @InvocableVariable(required=false description='Primary contact position')
    public String supplierContactFunction;

    @InvocableVariable(required=true description='Primary contact email (any valid email format)')
    public String supplierContactEmail;

    @InvocableVariable(required=true description='Primary contact phone (recommendation to follow standard of International Telecommunications Union E.123 e.g., +33 182 838 625)')
    public String supplierContactPhone;

    @InvocableVariable(required=false description='Tag 1 code (if used in the EcoVadis platform). If entry doesn’t exist, the companies will be added to “Un-matched” tag.')
    public String cf1Code;

    @InvocableVariable(required=false description='Tag 2 code (if used in the EcoVadis platform). If entry doesn’t exist, the companies will be added to “Un-matched” tag.')
    public String cf2Code;

    @InvocableVariable(required=false description='Requesting contact title (e.g., Mr., Mrs., Ms. or Dr.)')
    public String buyerContactTitle;

    @InvocableVariable(required=true description='Requesting contact first name')
    public String buyerContactFirstName;

    @InvocableVariable(required=true description='Requesting contact last name')
    public String buyerContactLastName;

    @InvocableVariable(required=true description='Requesting contact email (valid email format)')
    public String buyerContactEmail;

    @InvocableVariable(required=false description='Requesting contact phone (recommendation to follow standard of International Telecommunications Union E.123, e.g., +33 182 838 625)')
    public String buyerContactPhone;

    @InvocableVariable(required=true description='STD or RFP')
    public String campaignType;

    @InvocableVariable(required=true description='Sector initiative code (one possible code per assessment or assessment-sharing request) if applicable.')
    public String viCode;

    @InvocableVariable(required=true description='EVID - company’s unique ID in the EcoVadis database')
    public String evid;

}
