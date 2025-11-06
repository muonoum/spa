import gleam/int
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import spa/extra
import spa/shared

pub opaque type Model {
  Model(count: Int)
}

pub opaque type Message {
  Increment
}

pub fn init(_args) -> #(Model, Effect(Message)) {
  #(Model(count: 0), effect.none())
}

pub fn update(model: Model, message: Message) -> #(Model, Effect(Message)) {
  case message {
    Increment -> #(Model(count: model.count + 1), effect.none())
  }
}

pub fn from_shared(model: Model, _shared: shared.Model) -> Model {
  model
}

pub fn view(model: Model) -> Element(Message) {
  html.button(
    [
      event.on_click(Increment),
      extra.classes([
        "flex justify-center items-center w-screen h-screen",
        "bg-pink-200 text-pink-900 text-8xl text-shadow-sm",
        "cursor-pointer select-none",
      ]),
    ],
    [element.text(int.to_string(model.count))],
  )
}
