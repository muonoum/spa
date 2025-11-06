import lustre/effect.{type Effect}
import plinth/javascript/global

pub type Model {
  Model(count: Int)
}

pub opaque type Message {
  Tick
}

fn tick() -> Effect(Message) {
  use dispatch <- effect.from
  global.set_timeout(1000, fn() { dispatch(Tick) })
  Nil
}

pub fn init() -> #(Model, Effect(Message)) {
  #(Model(count: 0), tick())
}

pub fn update(model: Model, message: Message) -> #(Model, Effect(Message)) {
  case message {
    Tick -> #(Model(count: model.count + 1), tick())
  }
}
