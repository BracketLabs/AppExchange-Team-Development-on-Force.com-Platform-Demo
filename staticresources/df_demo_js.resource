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
	var rate1 = 0;
	var rate2 = 0;
	var rate3 = 0;
	if(defaultDetails != undefined){
		rate1 = defaultDetails.Rate1__c;
		rate2 = defaultDetails.Rate2__c;
		rate3 = defaultDetails.Rate3__c;	
	}
	
	$('#rate1').text(rate1);
	$('#rate2').text(rate2);
	$('#rate3').text(rate3);

    $('#email-1').slider({
    	range: "min",
    	value: rate1,
		orientation: "horizontal",
		min: 0,
		max: 10,
		step: 1,
		slide: function( event, ui ) {
			$('#rate1').text(ui.value);
		},
		stop: function(event, ui) { 
			updateEmailNotificationDetails();
		},
		animate: true
    });
    
    $('#email-2').slider({
		range: "min",
    	value: rate2,
		orientation: "horizontal",
		min: 0,
		max: 10,
		step: 1,
		slide: function( event, ui ) {
			$('#rate2').text(ui.value);
		},
		stop: function(event, ui) { 
			updateEmailNotificationDetails();
		},
		animate: true
    });
    
    $('#email-3').slider({
    	range: "min",
    	value: rate3,
		orientation: "horizontal",
		min: 0,
		max: 10,
		step: 1,
		slide: function( event, ui ) {
			$('#rate3').text(ui.value);
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
             setupLeadDetails(results[0]);
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
  	 $('.lead-name:eq(0)').parent().addClass('active');
     loadLeadDetails($('.lead-name:eq(0)').attr('id'));
     $('.lead-name').click(function(){
        $('.lead-name').parent().removeClass('active');
        $(this).parent().addClass('active');
        loadLeadDetails($(this).attr('id')); 
     });
  });
});