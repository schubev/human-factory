type t =
  { tagName: string
  ; inputType: string Js.Nullable.t [@bs.as "type"]
  ; name: string Js.Nullable.t
  ; placeholder: string Js.Nullable.t
  ; mutable value: string Js.Nullable.t
  ; parentElement: t Js.Null.t
  ; nextElementSibling: t Js.Null.t
  ; firstElementChild: t Js.Null.t }
[@@bs.deriving abstract]

external activeElement : t = "window.document.activeElement" [@@bs.val]

let active () = activeElement

external focus : t -> unit = "focus" [@@bs.send]

let parentElement element = parentElementGet element |> Js.Null.toOption

let nextElementSibling element =
  nextElementSiblingGet element |> Js.Null.toOption

let firstElementChild element =
  firstElementChildGet element |> Js.Null.toOption

let rec next ?(childAllowed = true) element =
  match firstElementChild element with
  | Some child when childAllowed ->
      Some child
  | _ -> (
    match nextElementSibling element with
    | Some sibling ->
        Some sibling
    | None -> (
      match parentElement element with
      | Some parent ->
          next ~childAllowed:false parent
      | None ->
          None ) )

let rec findNext predicate element =
  match next element with
  | Some nextElement when predicate nextElement ->
      Some nextElement
  | Some element ->
      findNext predicate element
  | None ->
      None

let isInput element =
  match element |. tagNameGet with "INPUT" -> true | _ -> false

let focusNextInput element =
  match findNext isInput element with
  | Some nextInput ->
      nextInput |. focus
  | None ->
      ()
