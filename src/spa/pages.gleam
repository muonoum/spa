import gleam/uri.{type Uri}
import lustre/dev/simulate
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import spa/pages/home
import spa/shared

pub opaque type Model {
  HomePage(home.Model)
  NotFound(Uri)
}

pub type Message {
  HomeMessage(home.Message)
}

pub fn simulate() -> simulate.App(Uri, Model, Message) {
  simulate.application(init:, update:, view:)
}

pub fn init(uri: Uri) -> #(Model, Effect(Message)) {
  case uri.path_segments(uri.path) {
    [] -> {
      let #(model, effect) = home.init(Nil)
      #(HomePage(model), effect.map(effect, HomeMessage))
    }

    _else -> #(NotFound(uri), effect.none())
  }
}

pub fn update(model: Model, message: Message) {
  case model, message {
    HomePage(model), HomeMessage(message) -> {
      let #(model, effect) = home.update(model, message)
      #(HomePage(model), effect.map(effect, HomeMessage))
    }

    NotFound(..), _message -> #(model, effect.none())
  }
}

pub fn from_shared(model: Model, shared: shared.Model) -> Model {
  case model {
    HomePage(page) -> HomePage(home.from_shared(page, shared))
    NotFound(..) -> model
  }
}

pub fn view(model: Model) -> Element(Message) {
  case model {
    HomePage(model) -> home.view(model) |> element.map(HomeMessage)
    NotFound(..) -> element.none()
  }
}
