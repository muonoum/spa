import birdie
import gleam/json
import gleam/list
import gleam/string
import gleeunit
import lustre/dev/query
import lustre/dev/simulate
import lustre/element
import spa/pages/home

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn home_page_test() {
  simulate.application(init: home.init, update: home.update, view: home.view)
  |> simulate.start(0)
  |> simulate.event(query.element(query.tag("button")), "click", [])
  |> snapshot
  |> birdie.snap("home page click")
}

fn snapshot(app) {
  let output =
    simulate.view(app) |> element.to_readable_string |> string.replace("\n", "")

  let history =
    list.map(simulate.history(app), format_event)
    |> string.join("\n")

  string.join([output, history], "\n")
}

fn format_event(event: simulate.Event(a)) -> String {
  case event {
    simulate.Dispatch(message:) -> "message: " <> string.inspect(message)

    simulate.Event(target:, name:, data:) ->
      "event: "
      <> [query.to_readable_string(target), name, json.to_string(data)]
      |> string.join(",")

    simulate.Problem(name:, message:) ->
      "problem: " <> name <> " " <> string.inspect(message)
  }
}
