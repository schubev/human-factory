type t = France | Germany

let isHostnameGerman = Js.Re.test_ [%re "/\\.de/"]

let isHostnameFrench = Js.Re.test_ [%re "/\\.fr/"]

let of_hostname hostname =
  if isHostnameGerman hostname then Some Germany
  else if isHostnameFrench hostname then Some France
  else None
