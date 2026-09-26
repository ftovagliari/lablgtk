(* 

  dune exec examples/issue_174.exe --profile release 

*)

let column_list = new GTree.column_list in
let column = column_list#add Gobject.Data.string in
let model = GTree.list_store column_list in
for i = 1 to 1_000_000 do
  let row = model#append () in
  model#set ~row ~column ("Value " ^ string_of_int i);
done;
match model#get_iter_first with
| None -> ()
| Some row ->
  let rec loop i =
    let str = model#get ~row ~column in
    if String.sub str 0 5 <> "Value" then
      Printf.printf "model[%d] = %S\n%!" i str;
    if model#iter_next row then loop (i + 1) in
  loop 0
