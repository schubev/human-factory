module type P = sig
  type el

  val elements : el array
end

module type S = sig
  include P

  val choose : unit -> el
end

module Make (M : P) : S with type el = M.el
