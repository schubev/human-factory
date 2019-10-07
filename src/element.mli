type t

val active : unit -> t

val tagNameGet : t -> string

val inputTypeGet : t -> string Js.Nullable.t

val nameGet : t -> string Js.Nullable.t

val placeholderGet : t -> string Js.Nullable.t

val valueGet : t -> string Js.Nullable.t

val valueSet : t -> string Js.Nullable.t -> unit

val parentElement : t -> t option

val nextElementSibling : t -> t option

val firstElementChild : t -> t option

val next : ?childAllowed:bool -> t -> t option

val findNext : (t -> bool) -> t -> t option

val isInput : t -> bool

val focusNextInput : t -> unit
