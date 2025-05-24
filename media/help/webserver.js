var http = require('http');
var fs = require('fs');
var baseUrl = "127.0.0.1";
var basePort = 1337;

var server = http.createServer(
	//options,
	function(req, res)
	{
		//res.writeHead(200, {'Content-Type': 'application/json'});

		var oneof = false;

		if (req.headers.origin)
		{
			res.setHeader('Access-Control-Allow-Origin', req.headers.origin);
			oneof = true;
		}

		if (req.headers['access-control-request-method'])
		{
			res.setHeader('Access-Control-Allow-Methods', req.headers['access-control-request-method']);
			oneof = true;
		}

		if (req.headers['access-control-request-headers'])
		{
			res.setHeader('Access-Control-Allow-Headers', req.headers['access-control-request-headers']);
			oneof = true;
		}

		if (oneof)
		{
			res.setHeader('Access-Control-Max-Age', 60 * 60 * 24 * 365);
		}

		// intercept OPTIONS method
		if (oneof && req.method == 'OPTIONS')
		{
			res.writeHead(200);
			res.end();
			return;
		}

		var method = req["method"];

		if (method === "GET")
		{
			get(req, res);
		}
		else if (method === "POST")
		{
			post(req, res);
		}
		else if (method == "PUT")
		{
			put(req, res);
		}
		else if (method === "DELETE")
		{
			del(req, res);
		}
		else
		{
			res.end("method unknown: " + method);
		}
	}
);

server.listen(basePort, baseUrl);
console.log('Server running at http://' + baseUrl + ":" + basePort);

//
// Functions.
//

function params(req, res)
{
	var url = trimSlashes(req["url"]);
	var bits = [];
	var tmp = url.split("/");
	var ret = {};
	var idx = 0;
	var type = "";
	//var appId = "E8CCB97D-7762-02A8-FF3F-7648D0539800";
	var appId = "B7E052EB-DB27-E0CB-FFA3-94BF43983B00";
	var api = false;
	var pos;

	return ret;
}

function trimSlashes(str)
{
	if (str.substr(0, 1) == "/")
	{
		str = str.slice(1);
	}

	if (str.substr(str.length - 1, 1) == "/")
	{
		str = str.substr(0, str.length - 1);
	}

	return str;
}

function get(req, res)
{
	var obj = { "hello" : "world" };
	var str = JSON.stringify(obj);
	res.writeHead(200, "OK", {'Content-Type' : 'text/html'});
	res.write(str);
	res.end();
	return;
}

function post(req, res)
{
	//console.log("post called: url='" + req["url"] + "'");

	var ps = params(req);
	console.log("ps=" + JSON.stringify(ps));

	var post = "";

	req.on('data',
		function(data)
		{
			//console.log("Received body data:");
			post += data;
			//console.log(post);
		}
	);

	req.on('end',
		function()
		{
			var json = JSON.parse(post.toString());

			// empty 200 OK response for now
			res.writeHead(200, "OK", {'Content-Type' : 'application/json'});
			var str = JSON.stringify(obj);
			//cnsole.log("str=" + str);
			res.end(str);
		}
	);

	//res.end("post end");
}

function put(req, res)
{
	//console.log("put called: url='" + req["url"] + "'");

	var ps = params(req);
	//console.log("ps=" + JSON.stringify(ps));

	var post = "";

	req.on('data',
		function(data)
		{
			//console.log("Received body data:");
			post += data;
			//console.log(post);
		}
	);

	req.on('end',
		function()
		{
			var json = JSON.parse(post.toString());
			var obj;

			// empty 200 OK response for now
			res.writeHead(200, "OK", {'Content-Type' : 'application/json'});
			var str = JSON.stringify(obj);
			res.end(str);
		}
	);

	//res.end("put end");
}

function del(req, res)
{
	//console.log("delete called: url='" + req["url"] + "'");

	var ps = params(req);
	//console.log("ps=" + JSON.stringify(ps));

	res.writeHead(200, "OK", {'Content-Type' : 'application/json'});
	var obj = {deletedTime : Util.getDate()};
	var str = JSON.stringify(obj);
	res.end(str);
}
