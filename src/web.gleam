import gleam/uri
import lustre
import plinth/browser/window
import web/app

pub fn main() {
  let app = app.new()
  let assert Ok(uri) = uri.parse(window.location()) as "window location"
  let assert Ok(_) = lustre.start(app, "#app", uri) as "application"
}
