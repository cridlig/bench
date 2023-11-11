(* bench_list.ml
   ocamlc unix.cma bench_list.ml
   ocamlopt unix.cmxa bench_list.ml
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

let list_init n f =
  let rec iter i =
  if i >= n then
    []
  else
    (f i) :: iter (i+1)
  in iter 0
;;

let makeCSV() =
    let data = list_init num_rows (function _ -> list_init num_cols gen) in
(*    rss(); *)
    print_int !count;
    print_newline ();
    let csv = String.concat "\n"
      (List.map (function row -> String.concat "," row) data) in
    rss();
    csv
;;

for i=1 to 10 do
    print_int (String.length (makeCSV ()));
    print_newline ()
done;;

Printf.printf "%.2f\n" (Sys.time() -. time_begin);;
