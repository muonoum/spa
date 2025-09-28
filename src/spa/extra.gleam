import gleam/string
import lustre/attribute.{type Attribute}

pub fn return(wrap: fn(a) -> b, body: fn() -> a) -> b {
  wrap(body())
}

pub fn classes(names: List(String)) -> Attribute(message) {
  attribute.class(string.join(names, " "))
}
