(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

let main () =
  GMain.init ();
  let window = GWindow.window ~show:true () in
  let vbox = GPack.vbox ~border_width:5 ~spacing:5 ~packing:window#add () in

  let other = GPack.info_bar ~message_type:`OTHER ~show_close_button:true ~packing:(vbox#pack ~expand:false) () in
  other#content_area#add (GMisc.label ~text:"This is an info bar with message type `OTHER" ())#coerce;
  other#add_buttons ["Yes", `YES; "No", `NO];

  let info = GPack.info_bar ~message_type:`INFO ~show_close_button:true ~packing:(vbox#pack ~expand:false) () in
  info#content_area#add (GMisc.label ~text:"This is an info bar with message type `INFO" ())#coerce;
  info#action_area#add (GButton.button ~label:"Action 1" ())#coerce;
  info#action_area#add (GButton.button ~label:"Action 2" ())#coerce;
  info#connect#close ~callback:(fun () -> Printf.printf "Close event\n%!") |> ignore;

  let warning = GPack.info_bar ~message_type:`WARNING ~show_close_button:true ~packing:(vbox#pack ~expand:false) () in
  warning#content_area#add (GMisc.label ~text:"This is an info bar with message type `WARNING" ())#coerce;
  let error = GPack.info_bar ~message_type:`ERROR ~show_close_button:true ~packing:(vbox#pack ~expand:false) () in
  error#content_area#add (GMisc.label ~text:"This is an info bar with message type `ERROR" ())#coerce;

  let question = GPack.info_bar ~message_type:`QUESTION ~show_close_button:false ~packing:(vbox#pack ~expand:false) () in
  
  question#add_buttons [
    "`NONE", `NONE;
    "`REJECT", `REJECT;
    "`ACCEPT", `ACCEPT;
    "`DELETE_EVENT", `DELETE_EVENT;
    "`OK", `OK;
    "`CANCEL", `CANCEL;
    "`CLOSE", `CLOSE;
    "`YES", `YES;
    "`NO", `NO;
    "`APPLY", `APPLY;
    "`HELP", `HELP;
  ];

  let apply_response infobar = function
    | `CLOSE -> infobar#set_revealed false
    | `OK -> Printf.printf "OK\n%!"
    | `REJECT -> Printf.printf "REJECT\n%!"
    | `NONE -> Printf.printf "NONE\n%!"
    | `YES -> Printf.printf "YES\n%!"
    | `NO -> Printf.printf "NO\n%!"
    | _ -> Printf.printf "%s: nothing to do.\n%!" __FUNCTION__
  in

  [info; question; warning; error; other]
  |> List.iter (fun infobar -> infobar#connect#response ~callback:(apply_response infobar) |> ignore);

  vbox#add (GMisc.label ~text:"An example of different info bars" ())#coerce;

  window#connect#destroy ~callback:GMain.quit;
  window#present ();
  GMain.main ()

let () = main ()
