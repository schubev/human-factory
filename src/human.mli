type t

val random : ?location:Location.t -> unit -> t

val firstName : t -> string

val lastName : t -> string

val birthdate : t -> Js.Date.t

val mobilePhoneNumber : t -> string

val landlinePhoneNumber : t -> string

val email : t -> string

val emailOfNames : string -> string -> string

val location : t -> Location.t
