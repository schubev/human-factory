type t

val random : unit -> t

val first_name : t -> string

val last_name : t -> string

val birthdate : t -> Js.Date.t

val phone_number : t -> string

val email : t -> string
