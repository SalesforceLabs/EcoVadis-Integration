@IsTest
public with sharing class Test_EcoVadis {
    static testMethod void Filters() {
        EcoVadis_Filter filter = new EcoVadis_Filter();
        filter.filteringElement = EcoVadis_Filter.Element.INTEGRATION_ID;
        filter.filteringOperator = EcoVadis_Filter.Operator.EQ;
        filter.value = 'foo';
        System.assertEquals('integration_id=%22foo%22', filter.queryString);

        filter.filteringElement = EcoVadis_Filter.Element.LAUNCH_DATE;
        filter.filteringOperator = EcoVadis_Filter.Operator.LT;
        System.assertEquals('f__launch_date__lt=%22foo%22', filter.queryString);
    }
    static testMethod void MultipleFilters() {
        EcoVadis_Filter filter = new EcoVadis_Filter();
        filter.filteringElement = EcoVadis_Filter.Element.INTEGRATION_ID;
        filter.filteringOperator = EcoVadis_Filter.Operator.EQ;
        filter.value = 'foo';
        EcoVadis_Filter filter2 = new EcoVadis_Filter();
        filter2.filteringElement = EcoVadis_Filter.Element.PUBLISHED_DATE;
        filter2.filteringOperator = EcoVadis_Filter.Operator.LT;
        filter2.value = '2020-01-01';
        List<EcoVadis_Filter> filters = new List<EcoVadis_Filter>();
        filters.add(filter);
        filters.add(filter2);
        EcoVadis_MultipleFilter mf = new EcoVadis_MultipleFilter();
        mf.filters = filters;
        mf.mode = EcoVadis_MultipleFilter.FilterMode.AND_MODE;
        System.assertEquals('?integration_id=%22foo%22&f__published_date__lt=%222020-01-01%22&filter_mode=and', mf.queryString);
    }

    static testMethod void accessToken() {
        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('noFilters'));

        test.startTest();
        String access_token = EcoVadis_BearerFlow.getAccessToken();
        System.assertEquals('YrAnhFOn1TULsX5KA5RHIzYOZCZHySISK-MR93-pXJ88IOpp7CPRDV14TlyxJjqrkGjz7GWYiwj5FqwszxKivdeiJLkUm1Hz8tGCeLiTPBh03Q0UuMkrInQV1cuYi1L_OudK56u_lUroYb-OAvcdaNSfj-Z1kznKkkDdTCH-DTVO6RGkELYDvMu-Asj0KFnAdfII0WpLPI74OqEhim_kYluQSXS7Jkj-f71KgnVzT8xxFnoB-pVfXlNpjWSYccC5vFMk19p32UwH9UGYT0QKHtumvULtG_6XzNCBKtsNm52xSzCW475Z871qPCsv0etcdfDVESc6OONz6nOucHKJYtLSJwRjOwigk-ZiSYgJJ-5QqQfUzHRI7GwqvlwWyt941erbvsfviwEreLOwYKGGDJwj_HlXvtQZEzy1SNCsG7WdHsJNli8DowM35m3pcLO_1kXUeLFrHRbxevTmSNmWrJqXSgKS-bVsw4LUK5NZrBoYuc9l', access_token);
        test.stopTest();
    }
    static testMethod void EVDataNoFilters() {
        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('noFilters'));

        test.startTest();
        EcoVadis_Service service = new EcoVadis_Service();
        List<EcoVadis_EVData> response = service.EVData();
        test.stopTest();

        System.assertEquals(22, response.size());
    }

    static testMethod void EVDataSingleFilter() {
        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('singleFilter'));

        EcoVadis_Service service = new EcoVadis_Service();
        EcoVadis_Filter filter = new EcoVadis_Filter();
        filter.filteringElement = EcoVadis_Filter.Element.PUBLISHED_DATE;
        filter.filteringOperator = EcoVadis_Filter.Operator.GT;
        filter.value = '2017-01-01';

        test.startTest();
        List<EcoVadis_EVData> response = service.EVData(filter);
        test.stopTest();

        System.assertEquals(2, response.size());
        System.assertEquals('DUMMY SUPPLIER 222', response[0].ev_supplier_name);
        System.assertEquals('MARCO MECA SPA', response[1].ev_supplier_name);
    }

    static testMethod void EVDataMultipleFilters() {
        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('multipleFilters'));

        EcoVadis_Service service = new EcoVadis_Service();
        EcoVadis_Filter filter = new EcoVadis_Filter();
        filter.filteringElement = EcoVadis_Filter.Element.INTEGRATION_ID;
        filter.filteringOperator = EcoVadis_Filter.Operator.EQ;
        filter.value = 'foo';
        EcoVadis_Filter filter2 = new EcoVadis_Filter();
        filter2.filteringElement = EcoVadis_Filter.Element.PUBLISHED_DATE;
        filter2.filteringOperator = EcoVadis_Filter.Operator.LT;
        filter2.value = '2020-01-01';
        List<EcoVadis_Filter> filters = new List<EcoVadis_Filter>();
        filters.add(filter);
        filters.add(filter2);
        EcoVadis_MultipleFilter mf = new EcoVadis_MultipleFilter();
        mf.filters = filters;
        mf.mode = EcoVadis_MultipleFilter.FilterMode.AND_MODE;

        test.startTest();
        List<EcoVadis_EVData> response = service.EVData(mf);
        test.stopTest();

        System.assertEquals(1, response.size());
        System.assertEquals('ID12354', response[0].integration_ids[0]);
        System.assertEquals('MARCO MECA SPA', response[0].ev_supplier_name);
        System.assertEquals('MARCO MECA SPA', response[0].client_supplier_name);
        System.assertEquals('', response[0].parent_company);
        System.assertEquals('                                                                                                    ', response[0].vat_number);
        System.assertEquals('', response[0].tax_number);
        System.assertEquals('', response[0].siret_number);
        System.assertEquals(true, response[0].active);
        System.assertEquals('', response[0].city);
        System.assertEquals('', response[0].state);
        System.assertEquals('Italy', response[0].country);
        System.assertEquals('', response[0].address_1);
        System.assertEquals('', response[0].address_2);
        System.assertEquals('www.marcomeca.com', response[0].website);
        System.assertEquals('Processing and preserving of fruit and vegetables', response[0].isic_category);
        System.assertEquals('100-499', response[0].employee_range);
        System.assertEquals('M ', response[0].size);
        System.assertEquals('_100_Million', response[0].turnover);
        System.assertEquals(false, response[0].risk_country);
        System.assertEquals('Daria', response[0].supplier_contact_first_name);
        System.assertEquals('Marcinkowski', response[0].supplier_contact_last_name);
        System.assertEquals('dmarcinkowski@ecovadis.com', response[0].supplier_contact_email);
        System.assertEquals('', response[0].supplier_contact_phone);
        System.assertEquals('EcoVadis Demo 2017', response[0].campaign_name);
        System.assertEquals('Standard', response[0].campaign_type);
        System.assertEquals('', response[0].rfp_campaign_icon);
        System.assertEquals('Invited', response[0].source);
        System.assertEquals(null, response[0].launch_date);
        System.assertEquals(Date.newInstance(2017,02,06), response[0].deadline);
        System.assertEquals(false, response[0].declined);
        System.assertEquals(null, response[0].declined_date);
        System.assertEquals('', response[0].last_comment);
        System.assertEquals(null, response[0].comment_date);
        System.assertEquals('No', response[0].buyer_action);
        System.assertEquals('', response[0].specific_comment);
        System.assertEquals(null, response[0].buyer_last_contacted);
        System.assertEquals(Date.newInstance(2017,01,30), response[0].published_date);
        System.assertEquals(Date.newInstance(2017,01,26), response[0].status_last_update);
        System.assertEquals(56, response[0].global_score);
        System.assertEquals(50, response[0].env_score);
        System.assertEquals(60, response[0].lab_score);
        System.assertEquals(50, response[0].fbp_score);
        System.assertEquals(60, response[0].sup_score);
        System.assertEquals('https://www.ecovadis-surveys.com/ecoportal/images/palito_3.gif', response[0].global_trend);
        System.assertEquals('https://www.ecovadis-surveys.com/ecoportal/images/palito_3.gif', response[0].env_trend);
        System.assertEquals('https://www.ecovadis-surveys.com/ecoportal/images/palito_3.gif', response[0].lab_trend);
        System.assertEquals('https://www.ecovadis-surveys.com/ecoportal/images/palito_3.gif', response[0].fbp_trend);
        System.assertEquals('https://www.ecovadis-surveys.com/ecoportal/images/palito_3.gif', response[0].sup_trend);
        System.assertEquals('https://integration.ecovadis-survey.com/?key=hgYFm5IwXFGKLk8k/P/ADOILbpw1P8FQMRUS6ExLknRBJVxtuRt2pBZ0hXnkLk9FrrnvOcTtU9FV8Zu6bdurdw==', response[0].scorecard_link);
        System.assertEquals(true, response[0].expired);
        System.assertEquals(5, response[0].documents_number);
        System.assertEquals(false, response[0].scope_change);
        System.assertEquals(null, response[0].initial_requested_scope);
        System.assertEquals('John', response[0].buyer_contact_first_name);
        System.assertEquals('Doe', response[0].buyer_contact_last_name);
        System.assertEquals('lspaeth+art-sonic@ecovadis.com', response[0].buyer_contact_email);
        System.assertEquals(0, response[0].nb_flags);
        System.assertEquals(1, response[0].nb_client_filters);
        System.assertEquals(10, response[0].nb_integration_ids);
        System.assertEquals(8, response[0].nb_client_ca);
        System.assertEquals(8, response[0].nb_all_ca);
        System.assertEquals(4, response[0].nb_draft_ca);
        System.assertEquals(1, response[0].nb_requested_ca);
        System.assertEquals(0, response[0].nb_in_progress_ca);
        System.assertEquals(0, response[0].nb_rejected_ca);
        System.assertEquals(3, response[0].nb_completed_ca);
        System.assertEquals(15, response[0].nb_overdue_ca);
        System.assertEquals(23, response[0].nb_no_validation_ca);
        System.assertEquals(0, response[0].nb_not_validated_ca);
        System.assertEquals(0, response[0].nb_validated_ca);
        System.assertEquals(0, response[0].nb_closed_ca);
        System.assertEquals(null, response[0].next_deadline);
        System.assertEquals('2019-04-22', response[0].last_modification);
        System.assertEquals(4, response[0].nb_documents);
}

    static testMethod void errorResponse() {
        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('error'));

        EcoVadis_Service service = new EcoVadis_Service();
        test.startTest();
        List<EcoVadis_EVData> response = service.EVData();
        test.stopTest();

        System.assertEquals(400, service.httpStatusCode);
        System.assertEquals('Bad Request', service.httpStatusMessage);
        System.assertEquals('Wrong username or password.', service.httpErrorMessage);
    }

    static testMethod void invocableEVDataNoFilters() {
        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('noFilters'));

        List<EcoVadis_EVDataServiceRequest> requestList = new List<EcoVadis_EVDataServiceRequest>();
        EcoVadis_EVDataServiceRequest request = new EcoVadis_EVDataServiceRequest();
        requestList.add(request);

        test.startTest();
        List<EcoVadis_EVDataServiceResponse> response = EcoVadis_EVDataService.execute(requestList);
        test.stopTest();

        System.assertEquals(1, response.size());
        System.assertEquals(22, response[0].data.size());
    }

    static testMethod void invocableEVDataWithFilters() {
        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('multipleFilters'));

        EcoVadis_EVDataServiceRequest request = new EcoVadis_EVDataServiceRequest();
        request.integrationId = 'foo';
        request.publishedDate = '2020-01-01';
        request.launchDate = '2020-01-01';
        request.statusLastUpdate = '2020-01-01';
        request.declined = false;
        request.buyerAction = false;
        request.globalScore = 1;
        request.expired = false;
        request.mode = 'and';
        List<EcoVadis_EVDataServiceRequest> requestList = new List<EcoVadis_EVDataServiceRequest>(); 
        requestList.add(request);

        test.startTest();
        List<EcoVadis_EVDataServiceResponse> response = EcoVadis_EVDataService.execute(requestList);
        test.stopTest();

        System.assertEquals(1, response.size());
        System.assertEquals(1, response[0].data.size());
        System.assertEquals('ID12354', response[0].data[0].integration_ids[0]);
        System.assertEquals('MARCO MECA SPA', response[0].data[0].ev_supplier_name);

    }

    static testMethod void invocableEVDataWithSingleFilter() {
        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('singleFilter'));

        EcoVadis_EVDataServiceRequest request = new EcoVadis_EVDataServiceRequest();
        request.publishedDate = '2017-01-01';
        List<EcoVadis_EVDataServiceRequest> requestList = new List<EcoVadis_EVDataServiceRequest>();
        requestList.add(request);

        test.startTest();
        List<EcoVadis_EVDataServiceResponse> response = EcoVadis_EVDataService.execute(requestList);
        test.stopTest();

        System.assertEquals(1, response.size());
        System.assertEquals(2, response[0].data.size());
        System.assertEquals('DUMMY SUPPLIER 222', response[0].data[0].ev_supplier_name);
        System.assertEquals('MARCO MECA SPA', response[0].data[1].ev_supplier_name);

    }

    static testMethod void evRequest() {
        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('singleRequest'));

        EcoVadis_EVRequest request = new EcoVadis_EVRequest();
        request.integration_id = '1234';
        request.client_supplier_name = 'ACME';
        request.country = 'United States of America';
        request.supplier_contact_first_name = 'Joe';
        request.supplier_contact_last_name = 'Supplier';
        request.supplier_contact_email = 'joe@supplier.com';
        request.supplier_contact_phone = '123-456-7890';
        request.buyer_contact_first_name = 'John';
        request.buyer_contact_last_name = 'Buyer';
        request.buyer_contact_email = 'john@buyer.com';
        request.campaign_type = 'RFP';

        EcoVadis_Service service = new EcoVadis_Service();
        Test.startTest();
        String response = service.evRequest(request);
        Test.stopTest();

        System.assertEquals('Assessment request has been successfully created', response);
    }

    static testMethod void evRequestMissingCoutry() {
        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('singleRequestMissingCountry'));

        EcoVadis_EVRequest request = new EcoVadis_EVRequest();
        request.integration_id = '1234';
        request.client_supplier_name = 'ACME';
        request.supplier_contact_first_name = 'Joe';
        request.supplier_contact_last_name = 'Supplier';
        request.supplier_contact_email = 'joe@supplier.com';
        request.supplier_contact_phone = '123-456-7890';
        request.buyer_contact_first_name = 'John';
        request.buyer_contact_last_name = 'Buyer';
        request.buyer_contact_email = 'john@buyer.com';
        request.campaign_type = 'RFP';

        EcoVadis_Service service = new EcoVadis_Service();
        Boolean exceptionThrown = false;
        String exceptionText = '';
        Test.startTest();
        try {
            String response = service.evRequest(request);
        } catch (Exception e) {
            exceptionThrown = true;
            exceptionText = e.getMessage();            
        }
        Test.stopTest();

        System.assert(exceptionThrown);
        System.assert(exceptionText.contains('Required fields are missing'));
    }

    static testMethod void invocableEVRequest() {
        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('request'));

        List<EcoVadis_EVRequestServiceRequest> requestList = new List<EcoVadis_EVRequestServiceRequest>();
        EcoVadis_EVRequestServiceRequest request = new EcoVadis_EVRequestServiceRequest();
        request.integrationId = '1234';
        request.country = 'United States of America';
        request.clientSupplierName = 'ACME';
        request.supplierContactFirstName = 'Joe';
        request.supplierContactLastName = 'Supplier';
        request.supplierContactEmail = 'joe@supplier.com';
        request.supplierContactPhone = '123-456-7890';
        request.buyerContactFirstName = 'John';
        request.buyerContactLastName = 'Buyer';
        request.buyerContactEmail = 'john@buyer.com';
        request.campaignType = 'RFP';
        requestList.add(request);

        test.startTest();
        List<EcoVadis_EVRequestServiceResponse> response = EcoVadis_EVRequestService.execute(requestList);
        test.stopTest();

        System.assertEquals(1, response.size());
        System.assertEquals('Assessment request has been successfully created', response[0].data);
    }



    static testMethod void setupTestConnection() {

        createSettings();
        Test.setMock(HttpCalloutMock.class, new Test_EcoVadis_HttpMockResponse('noFilters'));


        test.startTest();
        Boolean result = EcoVadis_SetupHelper.testConnection();
        System.assertEquals(true, result); 
        test.stopTest();
    }

    static testMethod void setupGetSettings() {
        createSettings();

        test.startTest();
        ecovadis__EcoVadis_Settings__c settings = EcoVadis_SetupHelper.getSettings();
        test.stopTest();

        System.assertEquals('https://api.ecovadis-survey.com/', settings.ecovadis__Environment_URL__c);
        System.assertEquals('username@test.test', settings.ecovadis__Username__c);
        System.assertEquals('password', settings.ecovadis__Password__c);
    }

    static testMethod void setupSaveSettings() {

        ecovadis__EcoVadis_Settings__c settings = new ecovadis__EcoVadis_Settings__c();
        settings.ecovadis__Environment_URL__c = 'https://api.ecovadis-survey.com/';
        settings.ecovadis__Username__c = 'username@test.test';
        settings.ecovadis__Password__c = 'password';

        test.startTest();
        EcoVadis_SetupHelper.saveSettings(settings);
        test.stopTest();

        ecovadis__EcoVadis_Settings__c settings2 = EcoVadis_SetupHelper.getSettings();

        System.assertEquals(settings.ecovadis__Environment_URL__c, settings2.ecovadis__Environment_URL__c);
        System.assertEquals(settings.ecovadis__Username__c, settings2.ecovadis__Username__c);
        System.assertEquals(settings.ecovadis__Password__c, settings2.ecovadis__Password__c);
    }

    static testMethod void setupSaveExistingSettings() {

        createSettings();

        ecovadis__EcoVadis_Settings__c settings = new ecovadis__EcoVadis_Settings__c();
        settings.ecovadis__Environment_URL__c = 'https://api.ecovadis-survey.new/';
        settings.ecovadis__Username__c = 'username@test.new';
        settings.ecovadis__Password__c = 'passwordnew';

        test.startTest();
        EcoVadis_SetupHelper.saveSettings(settings);
        test.stopTest();

        ecovadis__EcoVadis_Settings__c settings2 = EcoVadis_SetupHelper.getSettings();

        System.assertEquals(settings.ecovadis__Environment_URL__c, settings2.ecovadis__Environment_URL__c);
        System.assertEquals(settings.ecovadis__Username__c, settings2.ecovadis__Username__c);
        System.assertEquals(settings.ecovadis__Password__c, settings2.ecovadis__Password__c);
    }

    static private void createSettings() {
        ecovadis__EcoVadis_Settings__c settings = new ecovadis__EcoVadis_Settings__c();
        settings.ecovadis__Environment_URL__c = 'https://api.ecovadis-survey.com/';
        settings.ecovadis__Username__c = 'username@test.test';
        settings.ecovadis__Password__c = 'password';
        upsert settings;
    }
}
