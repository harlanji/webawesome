/// <reference path="../../d.ts/DefinitelyTyped/node/node.d.ts" />
/// <reference path="../../d.ts/DefinitelyTyped/express/express.d.ts" />


var express = require('express');

var app = express();

app.use(express.static(__dirname + '/public'));

// -- Run!
app.listen(1337, '127.0.0.1');
console.log('Listening on port 1337...');