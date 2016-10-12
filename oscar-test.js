
var request = require('request');
var crypto = require('crypto');

function RestClient()
{
	this.baseUrl = 'http://10.211.55.6/OscarServer/api/';
	this.sessionId = '';
}

RestClient.prototype.request = function(method, url, body, callback)
{
	var options = {
		method: method,
		uri: this.baseUrl + url,
		headers: {},
		json: true
	}
	if (body)
		options.body = body;

	console.log('==================================');
	console.log('REQUEST: ' + method + ' @ ' + url);
	var that = this;
	request(options, function(error, response)
	{
		if (error)
		{
			console.log('ERROR ', error);
		}
		else
		{
			if (response.statusCode >= 200 && response.statusCode < 300)
			{
				console.log('RESPONSE: 200 OK; ' + response.headers['content-type']);				if (response.body)
				{
					console.log('----------------');
					console.log(JSON.stringify(response.body, null, 2));
					console.log('----------------');
				}
				//console.log(response.headers);
			}
			else
			{
				console.log('RESPONSE: ', response.statusCode);
				if (response.statusCode == 500)
					console.log(response.body);
				//console.log(response.headers);
			}

			if (typeof callback === 'function')
				callback(response.body);
		}
	});
}

RestClient.prototype.POST = function(url, body, callback)
{
	this.request('POST', url, body, callback);
}

RestClient.prototype.GET = function(url, callback)
{
	this.request('GET', url, undefined, callback);
}

RestClient.prototype.PUT = function(url, body, callback)
{
	this.request('PUT', url, body, callback);
}

RestClient.prototype.PATCH = function(url, body, callback)
{
	this.request('PATCH', url, body, callback);
}

var client = new RestClient();

var tests = [

	function (cb) {
		
		// get all members
		client.GET('members', cb);
		
	},
	function (cb) {
	
		// get single member
		client.GET('members/7', cb);
		
	},
	function (cb) {
		
		// create new member
		client.POST('members', 
		  {
		    "FirstName": "John",
		    "LastName": "Appleseed",
		    //"RegistrationDate": new Date().toISOString().substr(0, 19),
		    "Notes": "Hello!"
		  }, cb);
		
	},
	function (cb) {
		
		// change member data
		client.PUT('members/8',
		  {
		    "FirstName": "Sara",
			"LastName": "Morgan",
			"Notes": "Never returns clean!"
		  }, cb);
		
	},
	function (cb) {
		
		// get available movies
		client.GET('movies', cb);
		
	},
	function (cb) {
		
		// get items for a move
		client.GET('movies/2/items', cb);
		
	},
	function (cb) {
		
		// get member rentals
		client.GET('members/1/rentals', cb);
		
	},
	function (cb) {
		
		// rent an item
		client.POST('rentals', 
		  {
		    "ItemID": 2,
			"MemberID": 1,
			"RentalState": 3,
			"ReturnState": null
		  }, cb);
		
	},
	function(cb) {
		
		setTimeout(cb, 1000); // don't return too fast ;)
		
	},
	function (cb) {
		
		// return an item
		client.PUT('rentals/1', 
		  {
			"ReturnState": 2
		  }, cb);
		
	}
	
];

function runTestAt(at)
{
	if (at < tests.length)
		tests[at](function() { runTestAt(at + 1); });
}

runTestAt(0);


