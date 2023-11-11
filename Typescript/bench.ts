"use strict"; 

const d = new Date;
const time_begin = d.getTime();

import child_process = require('child_process');
const exec = child_process.execSync;

function rss() {
    process.stdout.write(exec("echo $(expr `ps -o rss= -p " + process.pid + "` / 1024) MB"));
}

const num_rows = 100000;
const num_cols = 10;
var count = 0;

function multiply_string(s : string, n : number) : string {
    if (n <= 1)
        return s;
    else
        return s + multiply_string(s, n-1);
}

const xx = multiply_string("x", 1000);
    
rss();

function gen () {
    count++;
    return count + xx;
}

function createArray(n : number) : any[] {
    return Array.apply(null, Array(n));
}

function makeCSV() {
    const rows = createArray(num_rows);
    const cols = createArray(num_cols);
    const data = rows.map(_ => cols.map(gen));
    console.log(count);
    const csv = data.map(row => row.join()).join("\n");

    rss();
    return csv;
}

for (var i=1; i<=10; i++) {
    console.log(makeCSV().length);
}
    
const dd = new Date;
console.log(((dd.getTime() - time_begin)/1000).toFixed(2));
