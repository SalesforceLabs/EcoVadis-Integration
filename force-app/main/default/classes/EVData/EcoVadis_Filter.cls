global with sharing class EcoVadis_Filter {
    
    global Element filteringElement {get; set;}
    global Operator filteringOperator {get; set;}
    global String value {get; set;}

    global enum Element {
        INTEGRATION_ID, 
        LAUNCH_DATE,
        PUBLISHED_DATE,
        STATUS_LAST_UPDATE,
        DECLINED,
        BUYER_ACTION,
        GLOBAL_SCORE,
        EXPIRED}

    global enum Operator {
        EQ, 
        IS_IN, 
        NE, 
        LT, 
        LE, 
        GT, 
        GE, 
        IS_NULL}

    global String queryString {
        get {
            // Docs imply that adding an operator for integration id is ok, but it isn't.
            string operatorString;
            if ((this.filteringElement == Element.INTEGRATION_ID) || (this.filteringOperator == null)) {
                operatorString = '';
            } else {
                operatorString = operatorMap.get(this.filteringOperator);
            }

            return elementMap.get(this.filteringElement) + operatorString + '=%22' + this.value + '%22';
            //TODO: values can be lists
        }

    }

    private Map<Element, String> elementMap = new Map<Element, String> {
        Element.INTEGRATION_ID => 'integration_id',
        Element.LAUNCH_DATE => 'f__launch_date',
        Element.PUBLISHED_DATE => 'f__published_date',
        Element.STATUS_LAST_UPDATE => 'f__status_last_update',
        Element.DECLINED => 'f_declined',
        Element.BUYER_ACTION => 'f_buyer_action',
        Element.GLOBAL_SCORE => 'f__global_score',
        Element.EXPIRED => 'f__expired'
    };

    private Map<Operator, String> operatorMap = new Map<Operator, String> {
        Operator.EQ => '__eq',
        Operator.IS_IN => '__in',
        Operator.NE => '__ne',
        Operator.LT => '__lt',
        Operator.LE => '__le',
        Operator.GT => '__gt',
        Operator.GE => '__ge',
        Operator.IS_NULL => '__null'
    };
}
