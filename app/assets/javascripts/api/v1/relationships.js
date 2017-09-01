/* global Vue, Rails */
document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#show',
    data: {
      message: 'Hello Vue!',
      relationship: {step: {}},
      status: '',
      statusOptions: ['red', 'yellow', 'green']
    },
    mounted: function() {
      console.log('relationshipId', relationshipId);
      Rails.ajax({
        url: "/api/v1/relationships/" + relationshipId,
        type: "get",
        success: function(response) {
          console.log('response', response);
          this.relationship = response;
          this.status = this.relationship.user_status;
        }.bind(this)
      });
    },
    methods: {

    },
    computed: {

    },
    watch: {
      status: function() {
        console.log('status changed', this.status);
        Rails.ajax({
          url: "/api/v1/relationships/" + relationshipId,
          type: "patch",
          data: "step_status=" + this.status,
          success: function(response) {
            console.log('response', response);
            this.relationship = response;
            this.status = this.relationship.user_status;
          }.bind(this)
        });
      }
    },
  });
});