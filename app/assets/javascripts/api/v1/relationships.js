/* global Vue, Rails */
document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#update',
    data: {
      message: 'Hello Vue!'
    },
    mounted: function() {
      Rails.ajax({
        url: "/api/v1/relationships",
        type: "PATCH",
        success: function(response) {
          console.log(response);
          this.relationships = response;
        }.bind(this)
      });
    },
    methods: {

    },
    computed: {

    }
  });
});