type onCommand

type tabs

external addCommandListener : onCommand -> (string -> unit) -> unit
  = "addListener"
  [@@bs.send]

type tabsQueryParam = {currentWindow: bool; active: bool}
[@@bs.deriving abstract]

type tabId

type tab = {id: tabId} [@@bs.deriving abstract]

module TabCmp = Belt.Id.MakeComparable (struct
  type t = tab

  let cmp a b = compare (a |. idGet) (b |. idGet)
end)

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

let sendMessageToTab tab message =
  let tabId = tab |. idGet in
  labelLog "sending message" message ;
  labelLog "to tab" tabId ;
  browser |. tabsGet |. sendMessage tabId message

let activeTab () =
  let params = tabsQueryParam ~currentWindow:true ~active:true in
  Js.Promise.make (fun ~resolve ~reject ->
      browser |. tabsGet
      |. query params (fun tabs ->
             match Array.length tabs with
             | 0 -> (
                 reject Not_found [@bs] )
             | 1 -> (
                 resolve tabs.(0) [@bs] )
             | _ -> (
                 reject (Failure "matched many tabs") [@bs] )))

type executeScriptFileParam = {file: string} [@@bs.deriving abstract]

external executeScript :
  tabId -> executeScriptFileParam -> (('a -> unit)[@bs]) -> unit
  = "chrome.tabs.executeScript"
  [@@bs.val]

let executeScriptFileInTab tab file =
  let param = executeScriptFileParam ~file in
  let tabId = tab |. idGet in
  Js.Promise.make (fun ~resolve ~reject:_ -> executeScript tabId param resolve)

external _addMessageListener : ('a -> unit) -> unit
  = "chrome.runtime.onMessage.addListener"
  [@@bs.val]

let addMessageListener listener = _addMessageListener listener
