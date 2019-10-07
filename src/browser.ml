type onCommand

type tabs

external addCommandListener : onCommand -> (string -> unit) -> unit
  = "addListener"
  [@@bs.send]

type tabsQueryParam = {currentWindow: bool; active: bool}
[@@bs.deriving abstract]

type tabId

type tab = {id: tabId} [@@bs.deriving abstract]

external query : tabs -> tabsQueryParam -> (tab array -> unit) -> unit
  = "query"
  [@@bs.send]

external sendMessage : tabs -> tabId -> 'a -> unit Js.Promise.t = "sendMessage"
  [@@bs.send]

type commands = {onCommand: onCommand} [@@bs.deriving abstract]

type t = {commands: commands; tabs: tabs} [@@bs.deriving abstract]

external labelLog : string -> 'a -> unit = "console.log" [@@bs.val]

external browser : t = "chrome" [@@bs.val]

let addCommandListener listener =
  browser |. commandsGet |. onCommandGet |. addCommandListener listener

let sendMessageToTab message tab =
  let tabId = tab |. idGet in
  labelLog "sending message" message ;
  labelLog "to tab" tabId ;
  browser |. tabsGet |. sendMessage tabId message

let sendMessageToTabs message tabs =
  ignore (tabs |. Js.Array2.map (sendMessageToTab message))

let sendToActiveTab message =
  let params = tabsQueryParam ~currentWindow:true ~active:true in
  browser |. tabsGet |. query params (sendMessageToTabs message)

external _addMessageListener : ('a -> unit) -> unit
  = "chrome.runtime.onMessage.addListener"
  [@@bs.val]

let addMessageListener listener = _addMessageListener listener
