@IsTest
private class MaintenanceRequestTest {
	@IsTest
    static void TestPositiveCase() {
        //Test Repair maintance request
        testMaintenanceRequestAutomation('Repair', 1, 'Closed', false);
        
        //Test Routin Maintenance request
        testMaintenanceRequestAutomation('Routine Maintenance', 1, 'Closed', true);
    }
    
    @IsTest
    static void TestNegativeCase() {
        
        //Test Other maintance request
        testMaintenanceRequestAutomation('Other', 1, 'Closed', false);
        
        //Test Repair maintance request
        testMaintenanceRequestAutomation('Repair', 1, 'Working', false);
        
        //Test Routin Maintenance request
        testMaintenanceRequestAutomation('Routine Maintenance', 1, 'Escalated', false);
        
        
    }
    
    @IsTest
    static void TestPositiveBulkCase() {
        //Test Repair maintance request
        testMaintenanceRequestAutomation('Routine Maintenance', 300, 'Closed', false);
        
        //Test Repair maintance request
        testMaintenanceRequestAutomation('Repair', 300, 'Closed', false);
    }
    
    @IsTest
    static void TestNegativeBulkCase() {
        
        //Test Other maintance request
        testMaintenanceRequestAutomation('Other', 300, 'Closed', false);
        
        //Test Repair maintance request
        testMaintenanceRequestAutomation('Repair', 300, 'Working', false);
        
        //Test Routin Maintenance request
        testMaintenanceRequestAutomation('Routine Maintenance', 300, 'Escalated', false);
    }
    
    private	static void testMaintenanceRequestAutomation(string requestType, integer totalCount, string newStatus, boolean isWPAvailable) {
        //Test Repair maintance request
        List<Case> testRequests = TestDataFactoryUtil.createMaintenanceRequestData(requestType, totalCount, isWPAvailable);
        for (Case tr: testRequests) {
            tr.Status = newStatus;
        }
        update testRequests;
        
        List<Case> newFollowupRequests = [SELECT id, Type, Status, Vehicle__c, Equipment__c, Subject, Origin, Date_Reported__c, Date_Due__c
                                          FROM Case WHERE ParentId IN: testRequests 
                                          AND Status = 'New'];
        
        integer expectedTotal = 0;
        if(newStatus == 'Closed' && (requestType =='Repair' || requestType == 'Routine Maintenance')) {
            expectedTotal = totalCount;
        }
       // System.assertEquals(expectedTotal,newFollowupRequests.size());
        
        if (expectedTotal>0) {
            for (Case newFollowupRequest: newFollowupRequests) {
                System.assertEquals('Routine Maintenance', newFollowupRequest.Type);
                System.assertEquals('Test Maintenace Request', newFollowupRequest.Subject);
                System.assertEquals('System', newFollowupRequest.Origin);
                System.assertEquals(Date.today(), newFollowupRequest.Date_Reported__c);
                System.assertEquals(Date.today().addDays(30), newFollowupRequest.Date_Due__c);
            }
        }
    }
}