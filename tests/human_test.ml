open Jest
open Expect

let cases =
  [| ("Victor", "Schubert", "victor.schubert@example.com")
   ; ({js|Céline|js}, "Dion", "celine.dion@example.com")
   ; ({js|Loïc|js}, "Toto", "loic.toto@example.com")
   ; ("Jean-Baptiste", "Toto", "jean.baptiste.toto@example.com")
   ; ("William", {js|Groß|js}, "william.gross@example.com")
   ; ("x", {js|ü|js}, "x.ue@example.com")
   ; ("x", {js|ä|js}, "x.ae@example.com")
   ; ("x", {js|ö|js}, "x.oe@example.com")
   ; ("Toto", {js|Günther|js}, "toto.guenther@example.com") |]

let basicTest (firstName, lastName, email) =
  let testName =
    Printf.sprintf "Human.email %s %s = %s" firstName lastName email
  in
  test testName (fun () ->
      expect (Human.emailOfNames firstName lastName) |> toEqual email)

let () =
  describe "Human.email" (fun () -> cases |. Js.Array2.forEach basicTest)
