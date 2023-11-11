(* bench.ml
   ocamlc unix.cma bench.ml -o bench
   ocamlopt unix.cmxa bench.ml  -o benchopt
*)

let time_begin = Sys.time();;

let rss() =
    ignore (Unix.system ("echo $(expr `ps -o rss= -p " ^ (string_of_int (Unix.getpid ())) ^ "` / 1024) MB"))
;;

let num_rows = 100000;;
let num_cols = 10;;
let count = ref 0;;

let xx = String.make 1000 'x';;

rss();;

let gen _ = (
    incr count;
    string_of_int(!count) ^ xx
);;

let makeCSV() =
    let data = Array.init num_rows (function _ -> Array.init num_cols gen) in
    print_int !count;
    print_newline ();
    let csv = String.concat "\n"
      (Array.to_list (Array.map (function row -> String.concat "," (Array.to_list row)) data)) in
    rss();
    csv
;;

for i=1 to 10 do
    print_int (String.length (makeCSV ()));
    print_newline ()
done;;

Printf.printf "Real time is %.2f seconds\n" (Sys.time() -. time_begin);;
