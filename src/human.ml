type t =
  { location: Location.t
  ; firstName: string
  ; lastName: string
  ; birthdate: Js.Date.t
  ; mobilePhoneNumber: string
  ; landlinePhoneNumber: string }

let random ?(location = Location.France) () =
  let firstName = Random_first_name.choose () in
  let lastName = Random_last_name.choose () in
  let birthdate = Random_birthdate.choose () in
  let mobilePhoneNumber = Random_phone_number.chooseMobile ~location () in
  let landlinePhoneNumber = Random_phone_number.chooseLandline ~location () in
  { location
  ; firstName
  ; lastName
  ; birthdate
  ; mobilePhoneNumber
  ; landlinePhoneNumber }

let firstName {firstName} = firstName

let lastName {lastName} = lastName

let birthdate {birthdate} = birthdate

let mobilePhoneNumber {mobilePhoneNumber} = mobilePhoneNumber

let landlinePhoneNumber {landlinePhoneNumber} = landlinePhoneNumber

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
