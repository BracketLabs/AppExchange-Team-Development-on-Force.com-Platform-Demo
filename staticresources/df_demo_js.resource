var fetchLeads;

fetchLeads = function() {
  return dreamforceDemoController.fetchLeads(function(results, status) {
    var leads;
    if (status.status === true) {
      leads = results;
      return $("#lead-sidebar-header");
    }
  });
};

$(function() {
  return fetchLeads();
});
