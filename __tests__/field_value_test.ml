open Jest
open Expect
open Field_value

let stringOfInputType = function
  | None ->
      "none"
  | Some Email ->
      "email"
  | Some PhoneNumber ->
      "phone number"
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
      Printf.sprintf " name=%S" name

let basicCases =
  [| ({type_= None; name= None}, None)
   ; ({type_= Some "email"; name= None}, Some Email)
   ; ({type_= Some "email"; name= Some "email"}, Some Email)
   ; ({type_= Some "email"; name= Some "toto"}, Some Email)
   ; ({type_= Some "email"; name= Some "phone_number"}, Some Email)
   ; ({type_= Some "tel"; name= None}, Some PhoneNumber)
   ; ({type_= Some "tel"; name= Some "phone"}, Some PhoneNumber)
   ; ({type_= Some "tel"; name= Some "toto"}, Some PhoneNumber)
   ; ({type_= Some "tel"; name= Some "email"}, Some PhoneNumber)
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
   ; ({type_= Some "text"; name= Some "phone"}, Some PhoneNumber)
   ; ({type_= Some "text"; name= Some "phone_number"}, Some PhoneNumber)
   ; ({type_= Some "text"; name= Some "telephone"}, Some PhoneNumber)
   ; ({type_= Some "text"; name= Some "telephone_number"}, Some PhoneNumber)
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
  test testName (fun () -> expect (chooseType input) |> toEqual expected)

let () =
  describe "Field_value.chooseType" (fun () ->
      basicCases |. Js.Array2.forEach basicTest)
