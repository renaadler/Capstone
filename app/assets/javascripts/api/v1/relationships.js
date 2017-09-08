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
      var that = this;
      App.activity = App.cable.subscriptions.create("ActivityChannel", {
        connected: function() {
          // Called when the subscription is ready for use on the server
        },

        disconnected: function() {
          // Called when the subscription has been terminated by the server
        },

        received: function(data) {
          // Called when there's incoming data on the websocket for this channel
          // app.__vue__.messages.unshift(data);
          console.log('actioncable', data);
          // var relationship = app.__vue__.relationship;
          if (that.relationship.id === data.relationship_id) {
            that.relationship.step.id = data.step_id;
            that.relationship.connection_status = data.step_status;
            that.status = data.inverse_step_status;
          }
        }
      });

    },
    methods: {
      updateStatus: function(event) {
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
    computed: {

    },
    watch: {
      // status: function() {
      //   console.log('status changed', this.status);
      //   Rails.ajax({
      //     url: "/api/v1/relationships/" + relationshipId,
      //     type: "patch",
      //     data: "step_status=" + this.status,
      //     success: function(response) {
      //       console.log('response', response);
      //       this.relationship = response;
      //       this.status = this.relationship.user_status;
      //     }.bind(this)
      //   });
      // }
    },
  });
});