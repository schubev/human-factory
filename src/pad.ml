external padStart : string -> int -> string -> string = "padStart" [@@bs.send]

let left ?(padWith = " ") outputLength contents =
  contents |. padStart outputLength padWith
