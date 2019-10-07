type t = FillFocusedField

let send message = ignore @@ Browser.sendToActiveTab message

let addListener listener = Browser.addMessageListener listener
