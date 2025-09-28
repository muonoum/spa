import gleam/uri
import lustre
import plinth/browser/window
import spa/app

pub fn main() {
  let app = app.new()
  let assert Ok(uri) = uri.parse(window.location()) as "parse uri"
  let assert Ok(_runtime) = lustre.start(app, "#app", uri)
    as "start application"
}
