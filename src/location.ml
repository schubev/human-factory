type t = France | Germany

let is_hostname_german = Js.Re.test_ [%re "/\\.de/"]

let is_hostname_french = Js.Re.test_ [%re "/\\.fr/"]

let of_hostname hostname =
  if is_hostname_german hostname then Some Germany
  else if is_hostname_french hostname then Some France
  else None
