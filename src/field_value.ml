type inputTag = {type_: string option; name: string option}

type inputType =
  | Email
  | MobilePhoneNumber
  | LandlinePhoneNumber
  | FirstName
  | LastName
  | Birthdate

let isFirstNameClass s =
  [%re "/first.*name/i"] |. Js.Re.test_ s
  || [%re "/given.*name/i"] |. Js.Re.test_ s
  || [%re "/prenom/i"] |. Js.Re.test_ s

let isLastNameClass s =
  [%re "/name/i"] |. Js.Re.test_ s || [%re "/nom/i"] |. Js.Re.test_ s

let isPhoneClass s =
  [%re "/phone/i"] |. Js.Re.test_ s
  || [%re "/telefon/i"] |. Js.Re.test_ s
  || [%re "/festnetz/i"] |. Js.Re.test_ s

let isMobileClass s =
  [%re "/mob/i"] |. Js.Re.test_ s || [%re "/portable/i"] |. Js.Re.test_ s

let isMobilePhoneClass s = isPhoneClass s && isMobileClass s

let isEmailClass s = [%re "/mail/i"] |. Js.Re.test_ s

let isBirthdateClass s =
  [%re "/birth/i"] |. Js.Re.test_ s || [%re "/naissance/i"] |. Js.Re.test_ s

let optionMap f = function Some x -> Some (f x) | None -> None

let chooseType {type_; name} =
  let name = name |> optionMap Normalize.withoutAccent in
  match (type_, name) with
  | Some _, Some name when isBirthdateClass name ->
      Some Birthdate
  | Some "email", _ ->
      Some Email
  | Some "tel", Some name when isMobileClass name ->
      Some MobilePhoneNumber
  | Some "tel", _ ->
      Some LandlinePhoneNumber
  | Some "text", Some name when isFirstNameClass name ->
      Some FirstName
  | Some "text", Some name when isLastNameClass name ->
      Some LastName
  | Some "text", Some name when isMobilePhoneClass name ->
      Some MobilePhoneNumber
  | Some "text", Some name when isPhoneClass name ->
      Some LandlinePhoneNumber
  | Some "text", Some name when isEmailClass name ->
      Some Email
  | Some type_, _ when isPhoneClass type_ ->
      Some LandlinePhoneNumber
  | _ ->
      None

external location_hostname : string = "location.hostname" [@@bs.val]

let currentLocation () =
  location_hostname |. Location.of_hostname
  |. Belt.Option.getWithDefault France

let chooseValue inputTag =
  let open Human in
  let location = currentLocation () in
  let human = Current_human.getCurrentHuman ~location in
  Js.log inputTag ;
  chooseType inputTag
  |> optionMap (function
       | Email ->
           human |> email
       | LandlinePhoneNumber ->
           human |> landlinePhoneNumber
       | MobilePhoneNumber ->
           human |> mobilePhoneNumber
       | FirstName ->
           human |> firstName
       | LastName ->
           human |> lastName
       | Birthdate ->
           human |> birthdate |> Js.Date.toLocaleString)
