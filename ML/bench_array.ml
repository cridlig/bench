(* bench_array.ml *)

let time_begin = Sys.time();;

let rss() =
    ignore (Unix.system ("echo $(expr `ps -o rss= -p " ^ (string_of_int (Unix.getpid ())) ^ "` / 1024) MB"))
;;

let num_rows = 1000;; (* 100000 *)
let num_cols = 10;;
let count = ref 0;;

let xx = String.make 1000 'x';;

rss();;

let gen _ = (
    incr count;
    string_of_int(!count) ^ xx
);;

let concat s arr =
  let rec iter i =
    if i <= 0 then
      arr.(0)
    else
      (iter (i-1)) ^ s ^ arr.(i)
  in iter (Array.length arr - 1)
;;

let makeCSV() =
    let data = Array.init num_rows (function _ -> Array.init num_cols gen) in
    print_int !count;
    print_newline ();
    let csv = concat "\n" (Array.map (function row -> concat "," row) data) in
    rss();
    csv
;;

for i=1 to 10 do
    print_int (String.length (makeCSV ()));
    print_newline ()
done;;

Printf.printf "%.2f\n" (Sys.time() -. time_begin);;
