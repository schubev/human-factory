val addCommandListener : (string -> unit) -> unit

type tab

type tabId

module TabCmp : Belt.Id.Comparable with type t = tab

val activeTab : unit -> tab Js.Promise.t

val sendMessageToTab : tab -> 'a -> unit Js.Promise.t

val executeScriptFileInTab : tab -> string -> unit Js.Promise.t

val addMessageListener : ('a -> unit) -> unit
