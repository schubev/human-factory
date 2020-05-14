module Int32Kv : sig
  type t

  val make : int -> t

  val capacity : t -> int

  val get : t -> int -> int option

  val resize : t -> int -> unit

  val set : t -> int -> int -> unit

  val clear : t -> int -> unit
end = struct
  module Int32Array = Js.TypedArray2.Int32Array

  external mathFloor : float -> int = "Math.floor" [@@bs.val]

  external int32ArraySet : Int32Array.t -> Int32Array.t -> unit = "set"
    [@@bs.send]

  type t = Int32Array.t ref

  let make length =
    let array = Int32Array.fromLength length in
    let _ = Int32Array.fillInPlace array (-1l) in
    ref array

  let capacity kv = Int32Array.length !kv

  let get kv k =
    if capacity kv <= k then None
    else
      let v = Int32Array.unsafe_get !kv k in
      if v < 0l then None else Some (Int32.to_int v)

  let resize kv size =
    let cap = capacity kv in
    let newLength =
      mathFloor @@ Js.Math.exp @@ ( +. ) 1.0 @@ Js.Math.log
      @@ float_of_int size
    in
    let newKv = Int32Array.fromLength newLength in
    let () = int32ArraySet newKv !kv in
    kv := Int32Array.fillFromInPlace newKv (-1l) ~from:cap

  let set kv k v =
    let () = if capacity kv <= k then resize kv k in
    Int32Array.unsafe_set !kv k @@ Int32.of_int v

  let clear kv k = if k < capacity kv then Int32Array.unsafe_set !kv k (-1l)
end
