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
	 global static List<sObject> loadLeadDetails(string id){
	 	string soql = 'SELECT Lead__c,Rate1__c,Rate2__c,Rate3__c,Lead__r.Id,Lead__r.Name FROM EmailNotificationRates__c '+
	 							' WHERE Lead__c =\''+id+'\' LIMIT 1';
	 	List<sObject> leadDetails = Database.query(soql);
	 	system.debug(leadDetails);
	 	return leadDetails;
	 }
	 
	 /* 
	  *	updateEmailNotificationDetails()
	  *	Recieves an update message from the server
	  */
	  @RemoteAction
	  global static boolean updateEmailNotificationDetails(String id, Integer rate1, Integer rate2, Integer rate3){
	 	 system.debug('Lead Id: '+id+' Rate1: '+rate1+' Rate2: '+rate2+' Rate3: '+rate3);
	  	 List<EmailNotificationRates__c> rates = new List<EmailNotificationRates__c>();
	  	 // assign to a list so that a new record will be created if none exists
	  	 rates = [SELECT Id,Lead__c,Rate1__c,Rate2__c,Rate3__c FROM EmailNotificationRates__c WHERE Lead__c = :id LIMIT 1]; 	 
		 if(rates.size() == 0){
		 	EmailNotificationRates__c rate = new EmailNotificationRates__c(Lead__c=id,Rate1__c=rate1,Rate2__c=rate2,Rate3__c=rate3);
		 	rates.add(rate);
		 }
		 else{
			 rates[0].put('Rate1__c',rate1);
			 rates[0].put('Rate2__c',rate2);
			 rates[0].put('Rate3__c',rate3);	
		 }
			system.debug('Rates to be inserted: '+rates);
		 upsert rates;
	  	 return true;	
	  } 
	  
	  /* 
	   * updateEmailNotificationDetailsV1	
	   *	Method stub -- need to finish implementing V1 of this WS call!
	   *
	  @RemoteAction
	  global static boolean updateEmailNotificationDetailsV1(String id, Integer rate1, Integer rate2, Integer rate3){
	  	return true;	
	  }
	  
	  global class preferencesWrapper{
	  	Lead lead {get; set;}
	  	EmailNotificationRates__c rate {get; set;}
	  	
	  	public preferencesWrapper(Lead l, EmailNotificationRates__c r){
	  		lead = l;
	  		rate = r;
	  	}
	  }*/
}