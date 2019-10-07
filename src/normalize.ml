let withoutAccent s =
  let open Js.String2 in
  s |. normalizeByForm "NFD" |. replaceByRe [%re "/[\\u0300-\\u036f]/g"] ""
