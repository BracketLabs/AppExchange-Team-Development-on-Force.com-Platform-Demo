/* 
 * dreamforceDemo.page
 * Author Jordan Baucke, on behalf of Bracket Labs, @jordanbaucke
 *
 * This class and methods are compiled for an original demo at Dreamforce '12 
 * entitled: "Team Development on the Force.com Platform for ISVs"
 *
 */
global class dreamforceDemoController {
	
	/*
	 *	fetchLeads
	 *	Returns Leads for processing on the page
	 */
	 @RemoteAction
	 global static List<sObject> fetchLeads(){
	 	string soql = 'SELECT Id, Name FROM LEAD LIMIT 500';
	 	List<sObject> leads = Database.query(soql);
	 	return leads;	
	 }
	 
	 /* 
	  *	loadLeadDetails()	
	  *	Loads lead details for a particular lead record by id
	  *	Email_Notification_Rates__r is a custom sObject, and will require a namespace
	  *	prefix in a packaged org. 
	  *	Appending namespace prefix is demoed with the Ruby script
	  */
	 @RemoteAction
	 global static sObject loadLeadDetails(string id){
	 	string soql = 'Select Id,Name, (Select Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, '+
	 				  'LastModifiedById, SystemModstamp, Lead__c, Account__c, Rate1__c, Rate2__c, Rate3__c '+
	 				  'From Email_Notification_Rates__r) From Lead l WHERE l.Id = \''+id+'\' LIMIT 1';
	 	sObject leadDetails = Database.query(soql);
	 	return leadDetails;
	 }
	 
	 /* 
	  *	updateEmailNotificationDetails()
	  *	Recieves an update message from the server
	  */
	  @RemoteAction
	  global static boolean updateEmailNotificationDetails(String id, Integer rate1, Integer rate2, Integer rate3){
	  	 // use a list here incase a EmailNotificationRates__c object doesn't exist
	  	 EmailNotificationRates__c rate = database.query('SELECT Id,Lead__c,Rate1__c,Rate2__c,Rate3__c FROM EmailNotificationRates__c WHERE Lead__c = \''+Id+'\' LIMIT 1'); 	 
		 rate.put('Lead__c',id);
		 rate.put('Rate1__c',rate1);
		 rate.put('Rate2__c',rate2);
		 rate.put('Rate2__c',rate3);
		 upsert rate;
	  	 return true;	
	  } 
}