/*
 * Copyright (c) 2021, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

global with sharing class EcoVadis_MultipleFilter {

    global List<EcoVadis_Filter> filters;
    global FilterMode mode;

    global enum FilterMode {
        AND_MODE,
        OR_MODE
    }

    global String queryString {
        get {
            String queryStringVal = '';
            Boolean firstFilter = true;
            for (EcoVadis_Filter filter : this.filters) {
                if (firstFilter) {
                    queryStringVal += '?' + filter.queryString;
                    firstFilter = false;
                } else {
                    queryStringVal += '&' + filter.queryString;
                }
            }

            // Add the mode on the end
            queryStringVal += '&filter_mode=' + filterMap.get(this.mode);

            return queryStringVal;
        }
    }

    private Map<FilterMode, String> filterMap = new Map<FilterMode, String> {
        FilterMode.AND_MODE => 'and',
        FilterMode.OR_MODE => 'or'
    };
}
