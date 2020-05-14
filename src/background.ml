let commandOfName = function
  | "fill-focused-field" ->
      Some Commands.FillFocusedField
  | _ ->
      None

let injectedTabs = ref @@ Belt.Set.make ~id:(module Browser.TabCmp)

let ensureScriptInjected tab =
  let open Belt.Set in
  if !injectedTabs |. has tab then Js.Promise.resolve ()
  else
    let () = injectedTabs := !injectedTabs |. add tab in
    Browser.executeScriptFileInTab tab "/content.js"

let sendCommand command =
  let open Js.Promise in
  Browser.activeTab ()
  |> then_ (fun tab ->
         ensureScriptInjected tab
         |> then_ (fun _ -> Browser.sendMessageToTab tab command))
  |> ignore

let onCommand name =
  Js.log name ;
  let command = commandOfName name in
  match command with Some command -> sendCommand command | None -> ()

let main () =
  Js.log "background human factory loaded!" ;
  Browser.addCommandListener onCommand

let () = main ()
