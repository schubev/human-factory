let randomSuffixFrance prefix =
  let suffix =
    Js.Math.random_int 0 1000000 |> string_of_int |> Pad.left ~padWith:"0" 6
  in
  prefix ^ suffix

let chooseMobileFrance () =
  (* Check out docs/fictitious_phone_numbers.org. *)
  randomSuffixFrance "+3363998"

let chooseLandlineFrance () =
  let prefixes =
    (* Check out docs/fictitious_phone_numbers.org. *)
    [|"+3319900"; "+3326191"; "+3335301"; "+3346571"; "+3353649"|]
  in
  let prefix_index = Js.Math.random_int 0 (Array.length prefixes) in
  let prefix = prefixes.(prefix_index) in
  randomSuffixFrance prefix

let chooseLandlineGermany () =
  let digits =
    Js.Math.random_int 0 1000000000 |> string_of_int |> Pad.left ~padWith:"0" 7
  in
  "+4930" ^ digits

let chooseMobileGermany () =
  let digits =
    Js.Math.random_int 0 1000000000 |> string_of_int |> Pad.left ~padWith:"0" 7
  in
  "+4915" ^ digits

let chooseMobile ?(location = Location.France) =
  match location with
  | France ->
      chooseMobileFrance
  | Germany ->
      chooseMobileGermany

let chooseLandline ?(location = Location.France) =
  match location with
  | France ->
      chooseLandlineFrance
  | Germany ->
      chooseLandlineGermany
