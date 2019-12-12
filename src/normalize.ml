let withoutAccent s =
  let open Js.String2 in
  s |. normalizeByForm "NFD"
  |. replaceByRe [%re "/u\\u0308/g"] "ue"
  |. replaceByRe [%re "/o\\u0308/g"] "oe"
  |. replaceByRe [%re "/a\\u0308/g"] "ae"
  |. replaceByRe [%re "/[\\u0300-\\u036f]/g"] ""
