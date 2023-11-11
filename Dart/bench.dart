import "package:intl/intl.dart";
import 'dart:io';

var num_rows = 100000;
var num_cols = 10;
var count = 0;

void rss() {
  stdout.write(Process.runSync('bash', ["-c", "echo \$(expr `ps -o rss= -p " + pid.toString() + "` / 1024) MB"]).stdout);
}

var xx;

String multiply_string(s, n) {
    if (n <= 1)
        return s;
    else
        return s + multiply_string(s, n-1);
}

String gen (var _) {
    count++;
    return count.toString() + xx;
}

String makeCSV() {
  // var data = new List.generate(num_rows, (_) => new List.generate(num_cols, gen));
    var rows = new List(num_rows);
    var cols = new List(num_cols);
    var data = rows.map((_) => cols.map(gen));

    var csv = data.map((row) => row.join(',')).join("\n");
    print(count);
    rss();
    return csv;
}
main() { 
 DateTime startWall = new DateTime.now();
  rss();
  xx = multiply_string("x", 1000);
  for (var i=1; i<=10; i++) {
      print(makeCSV().length);
  }
  DateTime endWall = new DateTime.now();
  var f = new NumberFormat("###.00");
  print("real time = ${f.format(endWall.difference(startWall).inMilliseconds/1000)} s");
}