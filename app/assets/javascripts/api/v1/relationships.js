/* global Vue, Rails */
document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#show',
    data: {
      message: 'Hello Vue!',
      relationship: {}
    },
    mounted: function() {
      console.log('relationshipId', relationshipId);
      Rails.ajax({
        url: "/api/v1/relationships/" + relationshipId,
        type: "get",
        success: function(response) {
          console.log('response', response);
          this.relationship = response;
        }.bind(this)
      });
    },
    methods: {

    },
    computed: {

    }
  });
});