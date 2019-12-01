let choose () =
  let open Js.String2 in
  let first_name = Random_first_name.choose () |> toLowerCase in
  let last_name = Random_last_name.choose () |> toLowerCase in
  let domain = "example.com" in
  first_name
  |. concatMany [| "."; last_name; "@"; domain |]
  |. Normalize.withoutAccent
