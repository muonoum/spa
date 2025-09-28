import gleam/int
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import spa/extra

pub opaque type Model {
  Model(Int)
}

pub opaque type Message {
  Increment
}

pub fn init(_args) -> #(Model, Effect(f)) {
  #(Model(0), effect.none())
}

pub fn update(model: Model, message: Message) -> #(Model, Effect(Message)) {
  let Model(count) = model

  case message {
    Increment -> #(Model(count + 1), effect.none())
  }
}

pub fn view(model: Model) -> Element(Message) {
  let Model(count) = model

  html.button(
    [
      event.on_click(Increment),
      extra.classes([
        "flex justify-center items-center w-screen h-screen",
        "bg-pink-200 text-pink-900 text-8xl text-shadow-sm",
        "cursor-pointer select-none",
      ]),
    ],
    [
      element.text(int.to_string(count)),
    ],
  )
}
