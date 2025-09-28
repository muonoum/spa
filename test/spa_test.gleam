import birdie
import gleam/json
import gleam/list
import gleam/string
import gleam/uri
import gleeunit
import lustre/dev/query
import lustre/dev/simulate
import lustre/element
import spa/app
import spa/extra

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn click_test() {
  let button = query.element(query.tag("button"))

  app.simulate()
  |> simulate.start(uri.empty)
  |> simulate.event(button, "click", [])
  |> format_simulation
  |> birdie.snap("click")
}

fn format_simulation(app: simulate.Simulation(model, message)) -> String {
  let view =
    simulate.view(app)
    |> element.to_string

  let history =
    simulate.history(app)
    |> list.map(format_event)
    |> string.join("\n")

  [view, "---", history]
  |> string.join("\n")
}

fn format_event(event: simulate.Event(message)) -> String {
  use <- extra.return(string.join(_, ","))

  case event {
    simulate.Dispatch(message:) -> ["message", string.inspect(message)]
    simulate.Event(target:, name:, data:) -> {
      ["event", query.to_readable_string(target), name, json.to_string(data)]
    }
    simulate.Problem(name:, message:) -> {
      ["problem", name, string.inspect(message)]
    }
  }
}
