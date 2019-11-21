let choose ?(location = Location.France) () =
  match location with
  | France ->
      let digits =
        Random.int 1000000 |> string_of_int |> Pad.left ~padWith:"0" 6
      in
      "+33782" ^ digits
  | Germany ->
      let digits =
        Random.int 1000000000 |> string_of_int |> Pad.left ~padWith:"0" 7
      in
      "+4930" ^ digits
