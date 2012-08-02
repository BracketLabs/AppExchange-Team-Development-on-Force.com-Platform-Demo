var fetchLeads;
var loadLeadDetails;
var setupLeadDetails;
var updateEmailNotificationDetails;

updateEmailNotificationDetails = function(){
	/*NS*/dreamforceDemoController.updateEmailNotificationDetails($('li.active').find('a').attr('id'),
												$('#email-1').slider('value'),
												$('#email-2').slider('value'),
												$('#email-2').slider('value'),
	function(results,status){
		if(status.status){
		
		}	
	});
}

setupLeadDetails = function(defaultDetails){
    $('#email-1').slider({
    	value: defaultDetails.Rate1__c,
		orientation: "horizontal",
		min: 0,
		max: 10,
		step: 1,
		slide: function( event, ui ) {
			
		},
		stop: function(event, ui) { 
			updateEmailNotificationDetails();
		},
		animate: true
    });
    
    $('#email-2').slider({
    	value: defaultDetails.Rate2__c,
		orientation: "horizontal",
		min: 0,
		max: 10,
		step: 1,
		slide: function( event, ui ) {
		
		},
		stop: function(event, ui) { 
			updateEmailNotificationDetails();
		},
		animate: true
    });
    
    $('#email-3').slider({
    	value: defaultDetails.Rate3__c,
		orientation: "horizontal",
		min: 0,
		max: 10,
		step: 1,
		slide: function( event, ui ) {
		
		},
		stop: function(event, ui) { 
			updateEmailNotificationDetails();
		},
		animate: true
    });
}

loadLeadDetails = function(id){
    return /*NS*/dreamforceDemoController.loadLeadDetails(id,function(results,status){
         if(status.status){
             setupLeadDetails(results);
         }
    });
}

fetchLeads = function(callback) {
  return /*NS*/dreamforceDemoController.fetchLeads(function(results, status) {
    var leads;
    var leadString = '';
    if (status.status) {
      leads = results;
      $(leads).each(function(i,element){
         leadString = leadString + '<li class="no-margin"><a id="'+element.Id+'" class="lead-name">'+element.Name+'</a></li>';
      });
      $('#leads-sidebar').append(leadString);
      callback();
    }
  });
};

$(function() {
  return fetchLeads(function(){
     $('.lead-name').click(function(){
        $(this).parent().addClass('active');
        loadLeadDetails($(this).attr('id')); 
     });
  });
});