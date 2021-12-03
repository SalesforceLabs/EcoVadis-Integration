/*
 * Copyright (c) 2021, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

global with sharing class EcoVadis_EVDataService {

    @InvocableMethod(label='EcoVadis Data Retrieve' description='Retrieves data from EcoVadis' category='EcoVadis')
	global static List<EcoVadis_EVDataServiceResponse> execute(List<EcoVadis_EVDataServiceRequest> eVDataRequests) {
        List<EcoVadis_EVDataServiceResponse> responses = new List<EcoVadis_EVDataServiceResponse>();
        for (EcoVadis_EVDataServiceRequest req : eVDataRequests) {
            EcoVadis_EVDataServiceResponse resp = new EcoVadis_EVDataServiceResponse();
            resp = EcoVadis_EVDataHelper.getEVData(req);
            responses.add(resp);
        }
        return responses;
    }
}