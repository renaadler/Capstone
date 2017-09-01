/* global Vue, | */
document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#relationship',
    data: {
      message: 'Hello',
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
      changeStatus: function(status, relationship) {
        console.log('status', status);
        console.log('relationship', relationship);
        if (status === 'yellow') {
          relationship.user_status = 'Yellow';
        }
        if (status === 'green') {
          relationship.user_status = 'Green';
        }
        // Rails.ajax({
        //   url: "/api/v1/relationships",
        //   type: "patch",
        //   success: function(response) {
        //     console.log('Hello');
        //     // @user.status = status;
        //   }
        // });
      }
    },
    computed: {
      greenRelationships: function() {
        return this.relationships.filter(function(relationship) {
          return relationship.user_status === "Green";
        });
      },
      yellowRelationships: function() {
        return this.relationships.filter(function(relationship) {
          return relationship.user_status === "Yellow";
        });

      },
      redRelationships: function() {
        return this.relationships.filter(function(relationship) {
          return relationship.user_status !== "Green" 
          && relationship.user_status !== "Yellow";
        });
      }
    }
  });
});
