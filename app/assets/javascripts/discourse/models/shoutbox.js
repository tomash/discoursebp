/**
  A data model representing a Shoutbox

  @class Shoutbox
  @extends Discourse.Model
  @namespace Discourse
  @module Discourse
**/
Discourse.Shoutbox = Discourse.Model.extend({

  postStream: function() {
    return Discourse.PostStream.create({topic: this});
  }.property(),
});
