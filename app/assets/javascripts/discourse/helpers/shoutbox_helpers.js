/**
  Strips html

  @method stripHTML
  @for Handlebars
**/
Handlebars.registerHelper('stripHTML', function(property, options) {
  return Ember.Handlebars.get(this, property, options).replace(/<.*?>/g," ").trim();
});