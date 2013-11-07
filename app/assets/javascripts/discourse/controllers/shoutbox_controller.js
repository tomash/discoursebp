/**
  This controller supports all actions related to a Shoutbox

  @class ShoutboxController
  @extends Discourse.ObjectController
  @namespace Discourse
  @module Discourse
**/
Discourse.ShoutboxController = Ember.ArrayController.extend({
  loading: false,

  content: function() {
    var messages = Ember.ArrayProxy.create({
      content: []
    });

    var self = this;
   
    Discourse.Topic.find(4, {}).then(function(data) {
      console.log(data.post_stream);
      messages.set('content', data.post_stream.posts);
      self.set('loading', false);
    }, function() {
      // error
    });
   
    return messages;
  }.property(),

  shoutCount: function() {
    return 30;
  }.property()
});