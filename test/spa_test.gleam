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

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn click_test() {
  app.simulate()
  |> simulate.start(uri.empty)
  |> simulate.event(query.element(query.tag("button")), "click", [])
  |> snapshot
  |> birdie.snap("click")
}

fn snapshot(app: simulate.Simulation(model, message)) -> String {
  let output = simulate.view(app) |> element.to_string
  let history = list.map(simulate.history(app), format_event)
  string.join([output, string.join(history, "\n")], "\n")
}

fn format_event(event: simulate.Event(message)) -> String {
  case event {
    simulate.Dispatch(message:) -> "message: " <> string.inspect(message)

    simulate.Event(target:, name:, data:) ->
      ["event", query.to_readable_string(target), name, json.to_string(data)]
      |> string.join(",")

    simulate.Problem(name:, message:) ->
      "problem: " <> name <> " " <> string.inspect(message)
  }
}
