(* bench_array.fs 
    fsharpc -O
    mono
*)

let time_begin = System.DateTime.Now

(*let rss() =
    ignore (Unix.system ("echo $(expr `ps -o rss= -p " ^ (string_of_int (Unix.getpid ())) ^ "` / 1024) MB"))
;;*)

let num_rows = 10000 (* 100000 *)
let num_cols = 10
let count = ref 0

let xx = String.replicate 1000 "x"

//rss();;

let gen _ =
    incr count
    string !count + xx

let concat s (arr : string []) =
  let rec iter i =
    if i <= 0 then
      arr.[0]
    else
      iter (i-1) + s + arr.[i]
  iter (Array.length arr - 1)

let makeCSV() =
    let data = Array.init num_rows (fun _ -> Array.init num_cols gen)
    printf "%d\n" !count
    let csv = concat "\n" (Array.map (fun row -> concat "," row) data)
 //   rss();
    csv

for i=1 to 10 do
     printf "%d\n" (String.length (makeCSV ()))

printf "%s\n" (string (System.DateTime.Now.Subtract time_begin))
