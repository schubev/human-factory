type inputTag = {type_: string option; name: string option}

type inputType = Email | PhoneNumber | FirstName | LastName | Birthdate

val chooseType : inputTag -> inputType option

val chooseValue : inputTag -> string option
