// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(function() {
	//console.log(document.location.pathname + '.json?' + $( '#graph-data' ).serialize())
	$.getJSON(document.location.pathname + '.json?' + $( '#graph-data' ).serialize(), function(data) {
			$( '#placeholder' ).empty();

			new Morris.Line({
			  // ID of the element in which to draw the chart.
			  element: 'placeholder',
			  // Chart data records -- each entry in this array corresponds to a point on
			  // the chart.
			  data: data.data,
			  // The name of the data record attribute that contains x-values.
			  xkey: 'd',
			  // A list of names of data record attributes that contain y-values.
			  ykeys: ['v'],
			  // Labels for the ykeys -- will be displayed when you hover over the
			  // chart.
			  labels: [data.label]
			});
			//window.history.pushState({"html":document.html,"pageTitle":document.pageTitle},"", document.location.pathname + '?' + $( '#graph-data' ).serialize());
		} )
	$( '#graph-data' ).submit(function(e) {
		e.preventDefault();
		$.getJSON(document.location.pathname + '.json?' + $( '#graph-data' ).serialize(), function(data) {
			$( '#placeholder' ).empty();
			console.log(data.lenght)
			new Morris.Line({
			  // ID of the element in which to draw the chart.
			  element: 'placeholder',
			  // Chart data records -- each entry in this array corresponds to a point on
			  // the chart.
			  data: data.data,
			  // The name of the data record attribute that contains x-values.
			  xkey: 'd',
			  // A list of names of data record attributes that contain y-values.
			  ykeys: ['v'],
			  // Labels for the ykeys -- will be displayed when you hover over the
			  // chart.
			  labels: [data.label]
			});
			//window.history.pushState({"html":document.html,"pageTitle":document.pageTitle},"", document.location.pathname + '?' + $( '#graph-data' ).serialize());
		} )
	})
});