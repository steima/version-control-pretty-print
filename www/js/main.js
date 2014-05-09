/**
 * JavaScript module that is able to format repository data with D3
 */
function RepositoryCharts(datafile) {
	this._datafile = datafile;
	
	// Bind Events
	this.bindEvents = function() {
		console.log('binding events');
	};
	
	// Load D3
	this.loadD3 = function() {
		var _this = this;
		d3.csv(this._datafile, function(error, data) {
			if(error) {
				// TODO write to an error div -> jQuery UI
				console.log(error);
				$('#errors').html(error);
			}else{
				_this.setupD3(data);
				_this.printList($('#list'), data);
			}
		});
	};
	
	// Prepare and render the charts
	this.setupD3 = function(data) {
		// some data reformatting
		data.forEach(function(d, i) {
			d.index = i;
			var fixed = fixDate(d.date);
			d.date = fixed.substring(0, 10);
			d.time = fixed.substring(11);
		});
		var nestByDate = d3.nest().key(function(d) {
			return d3.time.day(d.date);
		});
		var repo = crossfilter(data);
		var all = repo.groupAll();
		console.log(data[0]);
	};
	
	// print a list
	this.printList = function(div, data) {
		div.html('');
		data.forEach(function (d, i) {
			var html = '<div><div class="indexCol">';
			html += d.index;
			html += '</div><div class="projectCol">';
			html += d.project;
			html += '</div><div class="authorCol">';
			html += d.author;
			html += '</div><div class="dateCol">';
			html += d.date;
			html += '</div><div class="timeCol">';
			html += d.time;
			html += '</div></div>';
			div.append(html);
		});
	};
	
	// Application setup
	this.initialize = function() {
		this.bindEvents();
		this.loadD3();
		$('#loading').hide();
	};
	
	this.initialize();
};

// fix dates
function fixDate(date) {
	var tpos = date.indexOf('T');
	if(tpos > -1 && date.indexOf('Z') > -1) {
		date = date.replace('T', ' ');
		var dotPos = date.indexOf('.');
		date = date.substring(0, dotPos);
	}else{
		var plusPos = date.indexOf(' +');
		date = date.substring(0, plusPos);
	}
	return date;
};

// Call Initialize on document ready
$(document).ready(function() {
	charts = new RepositoryCharts('data/combined.csv');
});