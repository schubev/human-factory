let left ?(padWith = " ") outputLength contents =
  let padder = padWith in
  let padderLength = String.length padder in
  let contentsLength = String.length contents in
  let minPadLength = outputLength - contentsLength in
  let padCount = 1 + (minPadLength / padderLength) in
  let rec go padCount padder acc =
    let acc =
      if 1 land padCount = 1 then acc |. Js.String2.concat padder else acc
    in
    let padCount = padCount asr 1 in
    let padder = padder |. Js.String2.concat padder in
    if padCount = 0 then acc else go padCount padder acc
  in
  go padCount padder ""
  |. Js.String2.substring ~from:0 ~to_:minPadLength
  |. Js.String2.concat contents
