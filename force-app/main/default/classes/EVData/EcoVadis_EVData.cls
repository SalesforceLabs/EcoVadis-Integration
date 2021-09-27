/**
 * @description Structure class used by JSON Parser readValueAs, which requires
 * properties to be named as they are named by the external service (with underscores)
 */
@JsonAccess(serializable='always' deserializable='always')
global with sharing class EcoVadis_EVData {

	@AuraEnabled
    global List<String> integration_ids {get; set;}
	@AuraEnabled
    global String ev_supplier_name {get; set;}
	@AuraEnabled
    global String client_supplier_name {get; set;}
	@AuraEnabled
    global String parent_company {get; set;}
	@AuraEnabled
    global String vat_number {get; set;}
	@AuraEnabled
    global String tax_number {get; set;}
	@AuraEnabled
    global String siret_number {get; set;}
	@AuraEnabled
    global Boolean active {get; set;}
	@AuraEnabled
    global String city {get; set;}
	@AuraEnabled
    global String state {get; set;}
	@AuraEnabled
    global String country {get; set;}
	@AuraEnabled
    global String address_1 {get; set;}
	@AuraEnabled
    global String address_2 {get; set;}
	@AuraEnabled
    global String website {get; set;}
	@AuraEnabled
    global String isic_category {get; set;}
	@AuraEnabled
    global String employee_range {get; set;}
	@AuraEnabled
    global String size {get; set;}
	@AuraEnabled
    global String turnover {get; set;}
	@AuraEnabled
    global Boolean risk_country {get; set;}

	@AuraEnabled
    global String supplier_contact_first_name {get; set;}
	@AuraEnabled
    global String supplier_contact_last_name {get; set;}
	@AuraEnabled
    global String supplier_contact_email {get; set;}
	@AuraEnabled
    global String supplier_contact_phone {get; set;}

	@AuraEnabled
    global String campaign_name {get; set;}
	@AuraEnabled
    global String campaign_type {get; set;}
	@AuraEnabled
    global String rfp_campaign_icon {get; set;}
	@AuraEnabled
    global String current_stage {get; set;}
    @AuraEnabled
    global Integer current_stage_code {get; set;}
	@AuraEnabled
    global String progress_status {get; set;}
    @AuraEnabled
    global Integer progress_status_code {get; set;}
	@AuraEnabled
    global String request_outcome {get; set;}
    @AuraEnabled
    global Integer request_outcome_code {get; set;}
	@AuraEnabled
    global String sharing_status {get; set;}
    @AuraEnabled
    global Integer sharing_status_code {get; set;}
	@AuraEnabled
    global String source {get; set;}
	@AuraEnabled
    global Date launch_date {get; set;}
	@AuraEnabled
    global Date deadline {get; set;}
	@AuraEnabled
    global Boolean declined {get; set;}
	@AuraEnabled
    global Date declined_date {get; set;}
	@AuraEnabled
    global String last_comment {get; set;}
	@AuraEnabled
    global Date comment_date {get; set;}
	@AuraEnabled
    global String buyer_action {get; set;}
	@AuraEnabled
    global String specific_comment {get; set;}
	@AuraEnabled
    global Date buyer_last_contacted {get; set;}

	@AuraEnabled
    global Date published_date {get; set;}
	@AuraEnabled
    global Date status_last_update {get; set;}
	@AuraEnabled
    global Integer global_score {get; set;}
	@AuraEnabled
    global Integer env_score {get; set;}
	@AuraEnabled
    global Integer lab_score {get; set;}
	@AuraEnabled
    global Integer fbp_score {get; set;}
	@AuraEnabled
    global Integer sup_score {get; set;}
	@AuraEnabled
    global String global_trend {get; set;}
	@AuraEnabled
    global String env_trend {get; set;}
	@AuraEnabled
    global String lab_trend {get; set;}
	@AuraEnabled
    global String fbp_trend {get; set;}
	@AuraEnabled
    global String sup_trend {get; set;}
	@AuraEnabled
    global String scorecard_link {get; set;}
	@AuraEnabled
    global Boolean expired {get; set;}
	@AuraEnabled
    global Integer documents_number {get; set;}
	@AuraEnabled
    global Boolean scope_change {get; set;}
	@AuraEnabled
    global String initial_requested_scope {get; set;}

	@AuraEnabled
    global String buyer_contact_first_name {get; set;}
	@AuraEnabled
    global String buyer_contact_last_name {get; set;}
	@AuraEnabled
    global String buyer_contact_email {get; set;}
	@AuraEnabled
    global Integer nb_flags {get; set;}
	@AuraEnabled
    global Integer nb_client_filters {get; set;}
	@AuraEnabled
    global Integer nb_integration_ids {get; set;}

	@AuraEnabled
    global Integer nb_client_ca {get; set;}
	@AuraEnabled
    global Integer nb_all_ca {get; set;}
	@AuraEnabled
    global Integer nb_draft_ca {get; set;}
	@AuraEnabled
    global Integer nb_requested_ca {get; set;}
	@AuraEnabled
    global Integer nb_in_progress_ca {get; set;}
	@AuraEnabled
    global Integer nb_rejected_ca {get; set;}
	@AuraEnabled
    global Integer nb_completed_ca {get; set;}
	@AuraEnabled
    global Integer nb_overdue_ca {get; set;}
	@AuraEnabled
    global Integer nb_no_validation_ca {get; set;}
	@AuraEnabled
    global Integer nb_not_validated_ca {get; set;}
	@AuraEnabled
    global Integer nb_validated_ca {get; set;}
	@AuraEnabled
    global Integer nb_closed_ca {get; set;}
	@AuraEnabled
    global String next_deadline {get; set;}
	@AuraEnabled
    global String last_modification {get; set;}
	@AuraEnabled
    global Integer nb_documents {get; set;}
}
