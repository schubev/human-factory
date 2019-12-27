let timeoutMilliseconds = 4000

let current = ref None

let timeout = ref None

let clear () =
  current := None ;
  timeout := None

let bumpTimeout () =
  ( match !timeout with
  | Some timeout ->
      Js.Global.clearTimeout timeout
  | None ->
      () ) ;
  timeout := Some (Js.Global.setTimeout clear timeoutMilliseconds)

let reset location = current := Some (Human.random ~location ())

let rec getCurrentHuman ~location =
  match !current with
  | Some currentHuman when Human.location currentHuman = location ->
      bumpTimeout () ; currentHuman
  | _ ->
      clear () ; reset location ; bumpTimeout () ; getCurrentHuman ~location
