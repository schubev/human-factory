type inputTag = {type_: string option; name: string option}

type inputType = Email | PhoneNumber | FirstName | LastName | Birthdate

let isFirstNameClass s =
  [%re "/first.*name/i"] |. Js.Re.test_ s
  || [%re "/given.*name/i"] |. Js.Re.test_ s
  || [%re "/prenom/i"] |. Js.Re.test_ s

let isLastNameClass s =
  [%re "/name/i"] |. Js.Re.test_ s || [%re "/nom/i"] |. Js.Re.test_ s

let isPhoneClass s = [%re "/phone/i"] |. Js.Re.test_ s

let isEmailClass s = [%re "/mail/i"] |. Js.Re.test_ s

let isBirthdateClass s =
  [%re "/birth/i"] |. Js.Re.test_ s || [%re "/naissance/i"] |. Js.Re.test_ s

let optionMap f = function Some x -> Some (f x) | None -> None

let chooseType {type_; name} =
  let name = name |> optionMap Normalize.withoutAccent in
  match (type_, name) with
  | Some "email", _ ->
      Some Email
  | Some "tel", _ ->
      Some PhoneNumber
  | Some "text", Some name when isFirstNameClass name ->
      Some FirstName
  | Some "text", Some name when isLastNameClass name ->
      Some LastName
  | Some "text", Some name when isPhoneClass name ->
      Some PhoneNumber
  | Some "text", Some name when isEmailClass name ->
      Some Email
  | Some "text", Some name when isBirthdateClass name ->
      Some Birthdate
  | _ ->
      None

let chooseValue inputTag =
  chooseType inputTag
  |> optionMap (function
       | Email ->
           Random_email.choose ()
       | PhoneNumber ->
           Random_phone_number.choose ()
       | FirstName ->
           Random_first_name.choose ()
       | LastName ->
           Random_last_name.choose ()
       | Birthdate ->
           Random_birthdate.choose ())
