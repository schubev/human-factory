open Jest
open Expect
open Field_value

let stringOfInputType = function
  | None ->
      "none"
  | Some Email ->
      "email"
  | Some MobilePhoneNumber ->
      "mobile phone number"
  | Some LandlinePhoneNumber ->
      "landline phone number"
  | Some FirstName ->
      "first name"
  | Some LastName ->
      "last name"
  | Some Birthdate ->
      "birth date"

let stringOfTypeField = function
  | None ->
      ""
  | Some _type ->
      Printf.sprintf " type=%S" _type

let stringOfNameField = function
  | None ->
      ""
  | Some name ->
      Printf.sprintf " name=\"%s\"" name

let basicCases =
  [| ({type_= None; name= None}, None)
   ; ({type_= Some "email"; name= None}, Some Email)
   ; ({type_= Some "email"; name= Some "email"}, Some Email)
   ; ({type_= Some "email"; name= Some "toto"}, Some Email)
   ; ({type_= Some "email"; name= Some "phone_number"}, Some Email)
   ; ({type_= Some "tel"; name= None}, Some LandlinePhoneNumber)
   ; ({type_= Some "tel"; name= Some "patient.birthdate"}, Some Birthdate)
   ; ({type_= Some "tel"; name= Some "mobile"}, Some MobilePhoneNumber)
   ; ({type_= Some "tel"; name= Some "mobile_phone"}, Some MobilePhoneNumber)
   ; ({type_= Some "tel"; name= Some "num_mobile"}, Some MobilePhoneNumber)
   ; ({type_= Some "tel"; name= Some "phone"}, Some LandlinePhoneNumber)
   ; ({type_= Some "tel"; name= Some "toto"}, Some LandlinePhoneNumber)
   ; ({type_= Some "tel"; name= Some "email"}, Some LandlinePhoneNumber)
   ; ({type_= Some "text"; name= Some "Mobiltelefon"}, Some MobilePhoneNumber)
   ; ( {type_= Some "text"; name= Some {js|Téléphone portable|js}}
     , Some MobilePhoneNumber )
   ; ( {type_= Some "text"; name= Some {js|Téléphone fixe|js}}
     , Some LandlinePhoneNumber )
   ; ( {type_= Some "text"; name= Some "Festnetzanschluss"}
     , Some LandlinePhoneNumber )
   ; ({type_= Some "text"; name= None}, None)
   ; ({type_= Some "text"; name= Some "email"}, Some Email)
   ; ({type_= Some "text"; name= Some "mail"}, Some Email)
   ; ({type_= Some "text"; name= Some "email_address"}, Some Email)
   ; ({type_= Some "text"; name= Some "name"}, Some LastName)
   ; ({type_= Some "text"; name= Some "lastname"}, Some LastName)
   ; ({type_= Some "text"; name= Some "last_name"}, Some LastName)
   ; ({type_= Some "text"; name= Some "surname"}, Some LastName)
   ; ({type_= Some "text"; name= Some "nom"}, Some LastName)
   ; ({type_= Some "text"; name= Some "nom_de_famille"}, Some LastName)
   ; ({type_= Some "text"; name= Some "firstname"}, Some FirstName)
   ; ({type_= Some "text"; name= Some "first_name"}, Some FirstName)
   ; ({type_= Some "text"; name= Some "givenname"}, Some FirstName)
   ; ({type_= Some "text"; name= Some "given_name"}, Some FirstName)
   ; ({type_= Some "text"; name= Some {js|prénom|js}}, Some FirstName)
   ; ({type_= Some "text"; name= Some "phone"}, Some LandlinePhoneNumber)
   ; ({type_= Some "text"; name= Some "mobile_phone"}, Some MobilePhoneNumber)
   ; ({type_= Some "text"; name= Some "phone_number"}, Some LandlinePhoneNumber)
   ; ({type_= Some "text"; name= Some "telephone"}, Some LandlinePhoneNumber)
   ; ( {type_= Some "text"; name= Some "telephone_number"}
     , Some LandlinePhoneNumber )
   ; ({type_= Some "text"; name= Some "birthdate"}, Some Birthdate)
   ; ({type_= Some "text"; name= Some "birth"}, Some Birthdate)
   ; ({type_= Some "text"; name= Some "birth_date"}, Some Birthdate)
   ; ({type_= Some "text"; name= Some "dateofbirth"}, Some Birthdate)
   ; ({type_= Some "text"; name= Some "date_of_birth"}, Some Birthdate)
   ; ({type_= Some "text"; name= Some "date_de_naissance"}, Some Birthdate)
   ; ({type_= Some "text"; name= Some "date_naissance"}, Some Birthdate) |]

let basicTest (input, expected) =
  let testName =
    Printf.sprintf "Field_value.chooseType <input%s%s> = %s"
      (stringOfTypeField input.type_)
      (stringOfNameField input.name)
      (stringOfInputType expected)
  in
  test testName (fun () ->
      let expectedAsString = stringOfInputType expected in
      let actualAsString = chooseType input |> stringOfInputType in
      expect actualAsString |> toEqual expectedAsString)

let () =
  describe "Field_value.chooseType" (fun () ->
      basicCases |. Js.Array2.forEach basicTest)
