/* global Vue, | */
document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#relationship',
    data: {
      relationships: [],
      show: true,
      status: 'yellow',
      statusOptions: ['red', 'yellow', 'green']
    },
    mounted: function() {
      Rails.ajax({
        url: "/api/v1/relationships",
        type: "get",
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
