"use strict"; 

var d = new Date;
var time_begin = d.getTime();

var sys = require('util');
var exec = require('child_process').execSync;

function rss() {
    process.stdout.write(exec("echo $(expr `ps -o rss= -p " + process.pid + "` / 1024) MB"));
}

var num_rows = 100000;
var num_cols = 10;
var count = 0;

function multiply_string(s, n) {
    if (n <= 1)
        return s;
    else
        return s + multiply_string(s, n-1);
}

var xx = multiply_string("x", 1000);
    
rss();

function gen () {
    count++;
    return count + xx;
}

function createArray(n) {
    return Array.apply(null, Array(n));
}

function makeCSV() {
    var rows = createArray(num_rows);
    var cols = createArray(num_cols);
    var data = rows.map(_ => cols.map(gen));
    console.log(count);
    var csv = data.map(row => row.join()).join("\n");

    rss();
    return csv;
}

for (var i=1; i<=10; i++) {
    console.log(makeCSV().length);
}
    
d = new Date;
console.log(((d.getTime() - time_begin)/1000).toFixed(2));
