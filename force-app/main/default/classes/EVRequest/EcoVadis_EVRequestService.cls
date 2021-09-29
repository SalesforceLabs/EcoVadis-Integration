/**
 * @description contains the invocable action for EcoVadis Request Assessment
 */
public with sharing class EcoVadis_EVRequestService {

    @InvocableMethod(label='EcoVadis Request Assessment' description='Requests an assessment by EcoVadis' category='EcoVadis')
    /**
     * @description Invocable Apex action for EcoVadis Request Assessment
     * @param eVRequestRequests - list of requests as requred by invocable Apex
     * @return List of responses as requred by invocable Apex
     */
	public static List<EcoVadis_EVRequestServiceResponse> execute(List<EcoVadis_EVRequestServiceRequest> eVRequestRequests) {
        List<EcoVadis_EVRequestServiceResponse> responses = new List<EcoVadis_EVRequestServiceResponse>();
        for (EcoVadis_EVRequestServiceRequest req : eVRequestRequests) {
            EcoVadis_EVRequestServiceResponse resp = new EcoVadis_EVRequestServiceResponse();
            resp = EcoVadis_EVRequestHelper.sendEVRequest(req);
            responses.add(resp);
        }
        return responses;
    }
}
