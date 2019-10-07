module type P = sig
  type el

  val elements : el array
end

module type S = sig
  include P

  val choose : unit -> el
end

let randomFrom ary =
  let open Js.Array in
  unsafe_get ary @@ Js.Math.random_int 0 (length ary)

module Make (M : P) = struct
  include M

  let choose () = randomFrom elements
end
