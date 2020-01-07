open Jest
open Expect

let frenchMobileTest () =
  let phoneNumber =
    Random_phone_number.chooseMobile ~location:Location.France ()
  in
  let testName = phoneNumber ^ " is a french mobile phone number" in
  test testName (fun () ->
      expect phoneNumber |> toMatchRe [%re "/^\\+336\\d{8}$/"])

let frenchLandlineTest () =
  let phoneNumber =
    Random_phone_number.chooseLandline ~location:Location.France ()
  in
  let testName = phoneNumber ^ " is a french landline phone number" in
  test testName (fun () ->
      expect phoneNumber |> toMatchRe [%re "/^\\+33[1-5]\\d{8}$/"])

let germanMobileTest () =
  let phoneNumber =
    Random_phone_number.chooseMobile ~location:Location.Germany ()
  in
  let testName = phoneNumber ^ " is a german mobile phone number" in
  test testName (fun () ->
      expect phoneNumber |> toMatchRe [%re "/^\\+4915\\d{7,9}$/"])

let germanLandlineTest () =
  let phoneNumber =
    Random_phone_number.chooseLandline ~location:Location.Germany ()
  in
  let testName = phoneNumber ^ " is a berlin landline phone number" in
  test testName (fun () ->
      expect phoneNumber |> toMatchRe [%re "/^\\+4930\\d{7,9}$/"])

let () =
  describe "Random_phone_number.chooseMobile" (fun () ->
      for _ = 1 to 5 do
        frenchMobileTest ()
      done ;
      for _ = 1 to 5 do
        frenchLandlineTest ()
      done ;
      for _ = 1 to 5 do
        germanMobileTest ()
      done ;
      for _ = 1 to 5 do
        germanLandlineTest ()
      done)
