type t

external dispatch : Element.t -> t -> unit = "dispatchEvent" [@@bs.send]
