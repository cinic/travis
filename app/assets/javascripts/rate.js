// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(function() {
	Number.prototype.formatMoney = function(c, d, t){
		var n = this, c = isNaN(c = Math.abs(c)) ? 2 : c, d = d == undefined ? "," : d, t = t == undefined ? "." : t, s = n < 0 ? "-" : "",
		i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
		return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t)
		+ (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
	};
	$.getJSON(document.location.pathname + '.json?' + $( '#graph-data' ).serialize(), function(data) {
			$( '#placeholder' ).empty();
			/*
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
			*/
		} )
	$( '#graph-data' ).submit(function(e) {
		e.preventDefault();
		$.getJSON(document.location.pathname + '.json?' + $( '#graph-data' ).serialize(), function(data) {
			$( '#placeholder' ).empty();
			// jQuery Flot Chart
			//var visits = [[1, 50], [2, 40], [3, 45], [4, 23],[5, 55],[6, 65],[7, 61],[8, 70],[9, 65],[10, 75],[11, 57],[12, 59]];
			//var visitors = [[1, 25], [2, 50], [3, 23], [4, 48],[5, 38],[6, 40],[7, 47],[8, 55],[9, 43],[10,50],[11,47],[12, 39]];

			var plot = $.plot($("#placeholder"),
				/*[ { data: visits, label: "Signups"},
				 { data: visitors, label: "Visits" }]*/data, {
					series: {
						lines: { 
							show: true,
							lineWidth: 1
								//fill: true, 
								//fillColor: { colors: [ { opacity: 0.1 }, { opacity: 0.13 } ] }
						},
						points: { show: true, 
								 lineWidth: 2,
								 radius: 3
							 },
						shadowSize: 0//,
						//stack: true
					},
					grid: { hoverable: true, 
						   clickable: true, 
						   tickColor: "#f9f9f9",
						   borderWidth: 0
						},
					legend: {
							// show: false
							labelBoxBorderColor: "#fff"
						},  
					colors: ["#a7b5c5", "#30a0eb", "#29e9b1", "#d029e9", "#f76e00", "#00a3f7"],
					xaxis: {
						mode: "time", 
						minTickSize: [1, "month"],
						timeformat: "%b %y",
						monthNames: ['ЯНВ', 'ФЕВ', 'МАР', 'АПР', 'МАЙ', 'ИЮН', 'ИЮЛ', 'АВГ', 'СЕН', 'ОКТ', 'НОЯ', 'ДЕК'],
						alignTicksWithAxis: true
						
					},
					yaxis: {
						tickDecimals: 0,
						font: {size:12, color: "#9da3a9"},
						tickFormatter: formatter
					}
				 });
			function formatter (val, axis) {
				var n = new Number(val);
				return n.formatMoney(0, '', ' ') + ' руб.';
			}
			function showTooltip(x, y, contents) {
				$('<div id="tooltip">' + contents + '</div>').css( {
					position: 'absolute',
					display: 'none',
					top: y - 30,
					left: x - 50,
					color: "#fff",
					padding: '2px 5px',
					'border-radius': '6px',
					'background-color': '#000',
					opacity: 0.80
				}).appendTo("body").fadeIn(200);
			}

			var previousPoint = null;
			$("#placeholder").bind("plothover", function (event, pos, item) {
				if (item) {
					if (previousPoint != item.dataIndex) {
						previousPoint = item.dataIndex;

						$("#tooltip").remove();
						var x = new Date(item.datapoint[0]),
							y = new Number(item.datapoint[1].toFixed(0));
						//var month = item.series.xaxis.ticks[item.dataIndex].label;
						
						var month = item.datapoint[0].toFixed(0);
						showTooltip(item.pageX, item.pageY, item.series.label + '<br>' + item.series.xaxis.options.monthNames[x.getMonth()] + ' ' + x.getFullYear() + '<br>' + y.formatMoney(0, '', ' ') + ' руб.');
					}
				}
				else {
					$("#tooltip").remove();
					previousPoint = null;
				}
			});
		} )
	})
});