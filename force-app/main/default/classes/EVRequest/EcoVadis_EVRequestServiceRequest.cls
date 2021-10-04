global with sharing class EcoVadis_EVRequestServiceRequest {

    @InvocableVariable(required=true description='The integration ID to match the company in both systems')
    global String integrationId;

    @InvocableVariable(required=true description='Legal entity to be assessed')
    global String clientSupplierName;

    @InvocableVariable(required=false description='Parent company (if applicable)')
    global String parentCompany;

    @InvocableVariable(required=false description='Procurement category/material group of the company in the Client System')
    global String clientProcurementCategory;

    @InvocableVariable(required=false description='Company Tax ID')
    global String taxNumber;

    @InvocableVariable(required=false description='Company VAT number')
    global String vatNumber;

    @InvocableVariable(required=false description='Company business registration number')
    global String brnNumber;

    @InvocableVariable(required=false description='DUNS: Dun & Bradstreet (D&B) company number')
    global Integer dunsNumber;

    @InvocableVariable(required=false description='Company’s website URL')
    global String website;

    @InvocableVariable(required=false description='Company turnover/revenue (in USD). Should be an integer greater than or equal to 0')
    global Integer turnover;

    @InvocableVariable(required=false description='Number of company employees. Should be an integer greater than 0')
    global Integer numberEmployees;

    @InvocableVariable(required=false description='Company address')
    global String address;

    @InvocableVariable(required=false description='Company city')
    global String city;

    @InvocableVariable(required=false description='Company postal code')
    global String zipCode;

    @InvocableVariable(required=true description='Company country (in English).')
    global String country;

    @InvocableVariable(required=false description='Primary contact title (e.g., Mr., Mrs., Ms. or Dr.)')
    global String supplierContactTitle;

    @InvocableVariable(required=false description='Primary contact first name')
    global String supplierContactFirstName;

    @InvocableVariable(required=false description='Primary contact last name')
    global String supplierContactLastName;

    @InvocableVariable(required=false description='Primary contact position')
    global String supplierContactFunction;

    @InvocableVariable(required=true description='Primary contact email (any valid email format)')
    global String supplierContactEmail;

    @InvocableVariable(required=true description='Primary contact phone (recommendation to follow standard of International Telecommunications Union E.123 e.g., +33 182 838 625)')
    global String supplierContactPhone;

    @InvocableVariable(required=false description='Tag 1 code (if used in the EcoVadis platform). If entry doesn’t exist, the companies will be added to “Un-matched” tag.')
    global String cf1Code;

    @InvocableVariable(required=false description='Tag 2 code (if used in the EcoVadis platform). If entry doesn’t exist, the companies will be added to “Un-matched” tag.')
    global String cf2Code;

    @InvocableVariable(required=false description='Requesting contact title (e.g., Mr., Mrs., Ms. or Dr.)')
    global String buyerContactTitle;

    @InvocableVariable(required=true description='Requesting contact first name')
    global String buyerContactFirstName;

    @InvocableVariable(required=true description='Requesting contact last name')
    global String buyerContactLastName;

    @InvocableVariable(required=true description='Requesting contact email (valid email format)')
    global String buyerContactEmail;

    @InvocableVariable(required=false description='Requesting contact phone (recommendation to follow standard of International Telecommunications Union E.123, e.g., +33 182 838 625)')
    global String buyerContactPhone;

    @InvocableVariable(required=true description='STD or RFP')
    global String campaignType;

    @InvocableVariable(required=true description='Sector initiative code (one possible code per assessment or assessment-sharing request) if applicable.')
    global String viCode;

    @InvocableVariable(required=true description='EVID - company’s unique ID in the EcoVadis database')
    global String evid;

}
