let randomYear () = 1960 + Random.int 50

let randomMonth () = 1 + Random.int 12

let randomDay () = 1 + Random.int 25

let randomBirthdate () =
  Js.Date.makeWithYMD
    ~year:(float_of_int @@ randomYear ())
    ~month:(float_of_int @@ randomMonth ())
    ~date:(float_of_int @@ randomDay ())
    ()

let choose () = randomBirthdate ()
