/*
 * Copyright (c) 2021, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

public with sharing class EcoVadis_EVRequestHelper {
    public static EcoVadis_EVRequestServiceResponse sendEVRequest(EcoVadis_EVRequestServiceRequest request) {

        EcoVadis_Service service = new EcoVadis_Service();
        EcoVadis_EVRequest serviceRequest = new EcoVadis_EVRequest();

        serviceRequest.integration_id = request.integrationId;
        serviceRequest.client_supplier_name = request.clientSupplierName;
        serviceRequest.parent_company = request.parentCompany;
        serviceRequest.client_procurement_category = request.clientProcurementCategory;
        serviceRequest.tax_number = request.taxNumber;
        serviceRequest.vat_number = request.vatNumber;
        serviceRequest.brn_number = request.brnNumber;
        serviceRequest.duns_number = request.dunsNumber;
        serviceRequest.website = request.website;
        serviceRequest.turnover = request.turnover;
        serviceRequest.number_employees = request.numberEmployees;
        serviceRequest.address = request.address;
        serviceRequest.city = request.city;
        serviceRequest.zip_code = request.zipCode;
        serviceRequest.country = request.country;
        serviceRequest.supplier_contact_title = request.supplierContactTitle;
        serviceRequest.supplier_contact_first_name = request.supplierContactFirstName;
        serviceRequest.supplier_contact_last_name = request.supplierContactLastName;
        serviceRequest.supplier_contact_function = request.supplierContactFunction;
        serviceRequest.supplier_contact_email = request.supplierContactEmail;
        serviceRequest.supplier_contact_phone = request.supplierContactPhone;
        serviceRequest.cf_1_code = request.cf1Code;
        serviceRequest.cf_2_code = request.cf2Code;
        serviceRequest.buyer_contact_title = request.supplierContactTitle;
        serviceRequest.buyer_contact_first_name = request.buyerContactFirstName;
        serviceRequest.buyer_contact_last_name = request.buyerContactLastName;
        serviceRequest.buyer_contact_email = request.buyerContactEmail;
        serviceRequest.buyer_contact_phone = request.buyerContactPhone;
        serviceRequest.campaign_type = request.campaignType;
        serviceRequest.vi_code = request.viCode;
        serviceRequest.evid = request.evid;

        String response = service.evRequest(serviceRequest);
        EcoVadis_EVRequestServiceResponse returnItem = new EcoVadis_EVRequestServiceResponse();
        returnItem.data = response;
        returnItem.jsonResponse = service.httpResponseJson;
        return returnItem;

    }
}
