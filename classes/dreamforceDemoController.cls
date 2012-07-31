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
}