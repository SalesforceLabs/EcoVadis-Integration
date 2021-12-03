/*
 * Copyright (c) 2021, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

/**
 * @description Retrieves EVData from service
 */
public with sharing class EcoVadis_EVDataHelper {

    /**
     * @description processes the given request to return data
     * @return service response
     */
    public static EcoVadis_EVDataServiceResponse getEVData(EcoVadis_EVDataServiceRequest request) {

        EcoVadis_Service service = new EcoVadis_Service();
        List<EcoVadis_EVData> response;

        EcoVadis_MultipleFilter mf = new EcoVadis_MultipleFilter();
        mf.filters = new List<EcoVadis_Filter>();

        if (!String.isBlank(request.integrationId)) {
            EcoVadis_Filter filter = new EcoVadis_Filter();
            filter.filteringElement = EcoVadis_Filter.Element.INTEGRATION_ID;
            
            // could be a single id with no quotes, or a list of ids separated by commas
            String value = '"' + request.integrationId.replaceAll(',\\s?', '","') + '"';
            filter.value = EncodingUtil.urlEncode(value, 'UTF-8');

            mf.filters.add(filter);
        }

        if (!String.isBlank(request.launchDate)) {
            EcoVadis_Filter filter = new EcoVadis_Filter();
            filter.filteringElement = EcoVadis_Filter.Element.LAUNCH_DATE;
            filter.filteringOperator = EcoVadis_Filter.Operator.GE;
            filter.value = request.launchDate;
            mf.filters.add(filter);
        }

        if (!String.isBlank(request.publishedDate)) {
            EcoVadis_Filter filter = new EcoVadis_Filter();
            filter.filteringElement = EcoVadis_Filter.Element.PUBLISHED_DATE;
            filter.filteringOperator = EcoVadis_Filter.Operator.GE;
            filter.value = request.publishedDate;
            mf.filters.add(filter);
        }

        if (!String.isBlank(request.statusLastUpdate)) {
            EcoVadis_Filter filter = new EcoVadis_Filter();
            filter.filteringElement = EcoVadis_Filter.Element.STATUS_LAST_UPDATE;
            filter.filteringOperator = EcoVadis_Filter.Operator.GE;
            filter.value = request.statusLastUpdate;
            mf.filters.add(filter);
        }

        if (!(request.declined == null)) {
            EcoVadis_Filter filter = new EcoVadis_Filter();
            filter.filteringElement = EcoVadis_Filter.Element.DECLINED;
            filter.value = String.valueOf(request.declined);
            mf.filters.add(filter);
        }

        if (!(request.buyerAction == null)) {
            EcoVadis_Filter filter = new EcoVadis_Filter();
            filter.filteringElement = EcoVadis_Filter.Element.BUYER_ACTION;
            filter.value = String.valueOf(request.buyerAction);
            mf.filters.add(filter);
        }

        if (!(request.globalScore == null)) {
            EcoVadis_Filter filter = new EcoVadis_Filter();
            filter.filteringElement = EcoVadis_Filter.Element.GLOBAL_SCORE;
            filter.filteringOperator = EcoVadis_Filter.Operator.GE;
            filter.value = String.valueOf(request.globalScore);
            mf.filters.add(filter);
        }

        if (!(request.expired == null)) {
            EcoVadis_Filter filter = new EcoVadis_Filter();
            filter.filteringElement = EcoVadis_Filter.Element.EXPIRED;
            filter.value = String.valueOf(request.expired);
            mf.filters.add(filter);
        }

        if (mf.filters?.size() > 1) {

            if (String.isBlank(request.mode) || request.mode.equalsIgnoreCase('or')) {
                mf.mode = EcoVadis_MultipleFilter.FilterMode.OR_MODE;
            } else {
                mf.mode = EcoVadis_MultipleFilter.FilterMode.AND_MODE;
            }

            response = service.EVData(mf);    

        } else if (mf.filters?.size() == 1) {
            response = service.EVData(mf.filters[0]);
        } else {
            response =  service.EVData();
        }

        EcoVadis_EVDataServiceResponse returnItem = new EcoVadis_EVDataServiceResponse();
        returnItem.data = response;
        returnItem.jsonResponse = service.httpResponseJson;
        return returnItem;
    }
}
