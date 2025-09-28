import gleam/uri.{type Uri}
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import web/pages/home

pub opaque type Model {
  Home(home.Model)
  NotFound(Uri)
}

pub type Message {
  HomeMessage(home.Message)
}

pub fn init(uri: Uri) -> #(Model, Effect(Message)) {
  case uri.path_segments(uri.path) {
    [] -> {
      let #(model, effect) = home.init(uri)
      #(Home(model), effect.map(effect, HomeMessage))
    }

    _else -> #(NotFound(uri), effect.none())
  }
}

pub fn update(model: Model, _uri: Uri, message: Message) {
  case model, message {
    Home(model), HomeMessage(message) -> {
      let #(model, effect) = home.update(model, message)
      #(Home(model), effect.map(effect, HomeMessage))
    }

    NotFound(..), _message -> #(model, effect.none())
  }
}

pub fn view(model: Model, _uri: Uri) -> Element(Message) {
  case model {
    Home(model) -> element.map(home.view(model), HomeMessage)
    NotFound(_uri) -> element.none()
  }
}
