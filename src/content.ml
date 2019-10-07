type eventParams = {target: Element.t; bubbles: bool} [@@bs.deriving abstract]

external createEvent : string -> eventParams -> Event.t = "Event" [@@bs.new]

let setInputValue element value =
  element |. Element.valueSet Js.Nullable.(return value) ;
  let event =
    createEvent "input" (eventParams ~target:element ~bubbles:true)
  in
  element |. Event.dispatch event

let rec firstSome arg =
  match arg with
  | None :: tail | Some "" :: tail ->
      firstSome tail
  | Some x :: _ ->
      Some x
  | [] ->
      None

let fillInput element =
  let type_ = element |> Element.inputTypeGet |> Js.Nullable.toOption in
  let name = element |> Element.nameGet |> Js.Nullable.toOption in
  let placeholder =
    element |> Element.placeholderGet |> Js.Nullable.toOption
  in
  let name = firstSome [name; placeholder] in
  match Field_value.chooseValue {type_; name} with
  | Some value ->
      setInputValue element value ;
      Element.focusNextInput element
  | None ->
      ()

let onTrigger () =
  let element = Element.active () in
  Js.log element ;
  let elementTypeName = element |. Element.tagNameGet in
  if elementTypeName = "INPUT" then fillInput element

let onCommand command =
  Js.log "received command" ;
  Js.log command ;
  match command with Commands.FillFocusedField -> onTrigger ()

let main () =
  Js.log "human factory loaded!" ;
  Commands.addListener onCommand

let () = main ()
