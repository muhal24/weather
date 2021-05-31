# Dependency

Dependency injection for Elixir. [Full documentation](https://hexdocs.pm/dependency)

Dependency injection allows you to swap out dependencies when unit testing your modules.

In test mode a `Registry` is used that holds a mapping between dependency name and implementation.
In dev and production mode, the dependency is compiled inline - there is no perormance hit.

Inspired by [constantizer](https://github.com/aaronrenner/constantizer)

## Installation

The package can be installed by adding `dependency` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:dependency, "~> 0.2.0"}
  ]
end
```

Also, you'll need to add the application to your list of applications

```elixir
def application do
  [
    # ...
    extra_applications: [:dependency],
  ]
end
```

## Usage

### Resolving a dependency

```elixir
import Dependency

mod = Dependency.resolve(MyModule)
```

### Registering an implementation

```elixir
Dependency.register(MyModule, MyImplementation)
```

### Defining a constant

```elixir
defmodule Example do
  import Dependency

  # define a public constant/accesor
  defconst :foo, Foo
end

# call accesor to resolve dependecy
Example.foo == Foo
```

## License

MIT
