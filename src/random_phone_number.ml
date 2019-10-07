let choose () =
  let digits = Random.int 1000000 |> string_of_int in
  "+33782" |> Js.String.concat (Pad.left ~padWith:"0" 6 digits)
