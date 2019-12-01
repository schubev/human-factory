type t =
  { first_name: string
  ; last_name: string
  ; birthdate: Js.Date.t
  ; phone_number: string }

let random () =
  let first_name = Random_first_name.choose () in
  let last_name = Random_last_name.choose () in
  let birthdate = Random_birthdate.choose () in
  let phone_number = Random_phone_number.choose () in
  {first_name; last_name; birthdate; phone_number}

let first_name {first_name} = first_name

let last_name {last_name} = last_name

let birthdate {birthdate} = birthdate

let phone_number {phone_number} = phone_number

let email {first_name; last_name} =
  let open Js.String2 in
  let domain = "example.com" in
  first_name
  |. concatMany [|"."; last_name; "@"; domain|]
  |. Normalize.withoutAccent
