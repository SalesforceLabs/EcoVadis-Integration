/*
 * Copyright (c) 2021, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

global with sharing class EcoVadis_EVDataServiceResponse {

    @InvocableVariable
    global List<EcoVadis_EVData> data;

    @InvocableVariable
    global String jsonResponse;

}
