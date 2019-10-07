let commandOfName = function
  | "fill-focused-field" ->
      Some Commands.FillFocusedField
  | _ ->
      None

let sendCommand command = ignore @@ Browser.sendToActiveTab command

let onCommand name =
  Js.log name ;
  let command = commandOfName name in
  match command with Some command -> sendCommand command | None -> ()

let main () =
  Js.log "background human factory loaded!" ;
  Browser.addCommandListener onCommand

let () = main ()
