/**
 * @description Data structure used to request an EcoVadis assessment
 */
@JsonAccess(serializable='always' deserializable='always')
global with sharing class EcoVadis_EVRequest {

	@AuraEnabled
    global String integration_id {get; set;}
	@AuraEnabled
    global String client_supplier_name {get; set;}
	@AuraEnabled
    global String parent_company {get; set;}
    @AuraEnabled
    global String client_procurement_category {get; set;}
	@AuraEnabled
    global String tax_number {get; set;}
	@AuraEnabled
    global String vat_number {get; set;}
	@AuraEnabled
    global String brn_number {get; set;}
	@AuraEnabled
    global Integer duns_number {get; set;}
	@AuraEnabled
    global String website {get; set;}
	@AuraEnabled
    global Integer turnover {get; set;}
	@AuraEnabled
    global Integer number_employees {get; set;}
	@AuraEnabled
    global String address {get; set;}
	@AuraEnabled
    global String city {get; set;}
	@AuraEnabled
    global String zip_code {get; set;}
	@AuraEnabled
    global String country {get; set;}
	@AuraEnabled
    global String supplier_contact_title {get; set;}
	@AuraEnabled
    global String supplier_contact_first_name {get; set;}
	@AuraEnabled
    global String supplier_contact_last_name {get; set;}
	@AuraEnabled
    global String supplier_contact_function {get; set;}
	@AuraEnabled
    global String supplier_contact_email {get; set;}
	@AuraEnabled
    global String supplier_contact_phone {get; set;}
    @AuraEnabled
    global String cf_1_code {get; set;}
    @AuraEnabled
    global String cf_2_code {get; set;}
	@AuraEnabled
    global String buyer_contact_title {get; set;}
	@AuraEnabled
    global String buyer_contact_first_name {get; set;}
	@AuraEnabled
    global String buyer_contact_last_name {get; set;}
	@AuraEnabled
    global String buyer_contact_email {get; set;}
	@AuraEnabled
    global String buyer_contact_phone {get; set;}
	@AuraEnabled
    global String campaign_type {get; set;}
	@AuraEnabled
    global String vi_code {get; set;}
	@AuraEnabled
    global String evid {get; set;}

}
