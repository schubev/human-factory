open Jest
open Expect

let basicCases =
  [| (" ", 0, "", "")
   ; (" ", 3, "", "   ")
   ; (" ", 3, "x", "  x")
   ; (" ", 3, "xxx", "xxx")
   ; (" ", 3, "xxxx", "xxxx")
   ; ("ab", 0, "", "")
   ; ("ab", 0, "x", "x")
   ; ("ab", 1, "x", "x")
   ; ("ab", 2, "xy", "xy")
   ; ("ab", 3, "xy", "axy")
   ; ("ab", 4, "xy", "abxy")
   ; ("ab", 5, "xy", "abaxy")
   ; ("ab", 6, "xy", "ababxy")
   ; ("0", 7, "123456789", "123456789")
   ; ("", 2, "toto", "toto") |]

let basicTest (padWith, outputLength, contents, expected) =
  let testName =
    Printf.sprintf "Pad.left %S %d %S = %S" padWith outputLength contents
      expected
  in
  test testName (fun () ->
      expect (Pad.left ~padWith outputLength contents) |> toEqual expected)

let () =
  describe "Pad.left" (fun () -> basicCases |. Js.Array2.forEach basicTest)
