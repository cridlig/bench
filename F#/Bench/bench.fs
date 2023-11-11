(* bench.fs
    fsharpc -O
    mono
*)

let time_begin = System.DateTime.Now;;

(*let rss() =
    ignore (Unix.system ("echo $(expr `ps -o rss= -p " ^ (string_of_int (Unix.getpid ())) ^ "` / 1024) MB"))
;;*)

let num_rows = 100000;;
let num_cols = 10;;
let count = ref 0;;

let xx = String.replicate 1000 "x";;

//rss();;

let gen _ = (
    incr count;
    string(!count) + xx
);;

let makeCSV() =
    let data = Array.init num_rows (function _ -> Array.init num_cols gen) in
    printf "%d\n" !count;
    let csv = String.concat "\n" (Array.toList (Array.map (function row -> String.concat "," (Array.toList row)) data)) in
//    rss();
    csv
;;

for i=1 to 10 do
    printf "%d\n" (String.length (makeCSV ()));
done;;

printf "%s\n" (string(System.DateTime.Now.Subtract(time_begin)));;
