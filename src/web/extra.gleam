import gleam/string
import lustre/attribute.{type Attribute}

pub fn classes(names: List(String)) -> Attribute(message) {
  attribute.class(string.join(names, " "))
}
