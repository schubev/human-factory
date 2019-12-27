type t =
  { location: Location.t
  ; firstName: string
  ; lastName: string
  ; birthdate: Js.Date.t
  ; phoneNumber: string }

let random ?(location = Location.France) () =
  let firstName = Random_first_name.choose () in
  let lastName = Random_last_name.choose () in
  let birthdate = Random_birthdate.choose () in
  let phoneNumber = Random_phone_number.choose ~location () in
  {location; firstName; lastName; birthdate; phoneNumber}

let firstName {firstName} = firstName

let lastName {lastName} = lastName

let birthdate {birthdate} = birthdate

let phoneNumber {phoneNumber} = phoneNumber

let location {location} = location

let emailOfNames firstName lastName =
  let open Js.String2 in
  let domain = "example.com" in
  firstName
  |. concatMany [|"."; lastName; "@"; domain|]
  |. Normalize.withoutAccent |. toLowerCase
  |. replaceByRe [%re "/ß/g"] "ss"
  |. replaceByRe [%re "/-/g"] "."

let email {firstName; lastName} = emailOfNames firstName lastName
