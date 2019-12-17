let randomYear () = Js.Math.random_int 1960 2010

let randomMonth () = Js.Math.random_int 1 13

let randomDay () = Js.Math.random_int 1 29

let randomBirthdate () =
  Js.Date.makeWithYMD
    ~year:(float_of_int @@ randomYear ())
    ~month:(float_of_int @@ randomMonth ())
    ~date:(float_of_int @@ randomDay ())
    ()

let choose () = randomBirthdate ()
