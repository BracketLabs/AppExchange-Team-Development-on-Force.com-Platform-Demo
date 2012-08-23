@isTest
private class dreamforceDemoControllerTest{
	
	@isTest
	static void testdreamforceDemoController(){
		Lead l = new Lead(FirstName='Test', LastName='Lead', Company='Test Lead Company');
		insert l;
		
		EmailNotificationRates__c notificationRate = new EmailNotificationRates__c();
		notificationRate.Lead__c = l.Id;
		insert notificationRate;
		
		List<sObject> leads = dreamforceDemoController.fetchLeads();
		
		dreamforceDemoController.updateEmailNotificationDetails(l.Id,1,2,3);
		
		List<sObject> leadDetails = dreamforceDemoController.loadLeadDetails(l.id);
	
		system.debug(leadDetails);
		
		system.assert(leadDetails[0].get('Rate1__c') == 1);
		system.assert(leadDetails[0].get('Rate2__c') == 2);
		system.assert(leadDetails[0].get('Rate3__c') == 3);
		
		Lead l2 = new Lead(FirstName='Test', LastName='Lead', Company = 'Test Lead Company');
		insert l2;
		
		// create a new EmailNotificationRate__c for l2
		dreamforceDemoController.updateEmailNotificationDetails(l2.Id,1,2,3);
		
		// fetch the details.
		List<sObject> leadDetails2 = dreamforceDemoController.loadLeadDetails(l2.id);
		system.debug(leadDetails2); // since this is a custom object I'm going to look at it in the debugger to figure out how to get
									// the sobject properties
									
		system.assert(leadDetails2[0].get('Rate1__c') == 1);
		system.assert(leadDetails2[0].get('Rate2__c') == 2);
		system.assert(leadDetails2[0].get('Rate3__c') == 3);
				
	}
}