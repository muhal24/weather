defmodule Dependency do
  @moduledoc """
  Fuctions to build soft dependencies between modules. This is useful when you want to test different implementations in test mode.

  The resolution is dynamic in test mode (uses a `Registry`).

  In dev and production modes, the dependency in compiled inline.
  """

  @doc """
  Starts the dependency registry.

  This is done for you if you add `:dependency` to list of apps in your `mix.exs`.

  Returns `{:ok, pid}`
  """
  @spec start_link :: {:ok, pid()} | {:error, atom()}
  def start_link do
    Registry.start_link(keys: :unique, name: Dependency.Registry)
  end

  @doc """
  Register an implementation for a module.

  Returns `{:ok, module}`


  ## Examples

    iex> Dependency.register(Foo, Bar)
    {:ok, Bar}

  """
  @spec register(module(), module()) :: {:ok, module()}
  def register(mod, implementation) do
    case Registry.register(Dependency.Registry, mod, implementation) do
      {:ok, _pid} ->
        {:ok, implementation}

      {:error, {:already_registered, _pid}} ->
        :ok = Registry.unregister(Dependency.Registry, mod)
        register(mod, implementation)
    end
  end

  @doc """
  Resolve the implementation for a module.

  Returns `module`


  ## Examples

    iex> Dependency.register(Foo, Bar)
    {:ok, Bar}
    iex> Dependency.resolve(Foo)
    Bar

  """
  @spec resolve(module()) :: module()
  defmacro resolve(mod) do
    quote do
      if Mix.env() == :test do
        Dependency.dynamically_resolve(unquote(mod))
      else
        unquote(mod)
      end
    end
  end

  @doc """
  Defines a public constant

  Returns `module`

  ## Examples

    iex> defmodule Bar do
    iex>   def value, do: 123
    iex> end
    iex>
    iex> defmodule Foo do
    iex>   import Dependency
    iex>
    iex>   defconst :bar, Bar
    iex> end
    iex>
    iex> Foo.bar().value()
    123

  """
  @spec defconst(atom() | String.t, module()) :: module()
  defmacro defconst(name, module) do
    quote do
      def unquote(name)() do
        resolve(unquote module)
      end
    end
  end

  @doc """
  Defines a private constant

  Returns `module`

  ## Examples

    iex> defmodule Baz do
    iex>   def value, do: 123
    iex> end
    iex>
    iex> defmodule Qux do
    iex>   import Dependency
    iex>
    iex>   defconstp :baz, Baz
    iex>
    iex>   def value, do: baz().value
    iex> end
    iex>
    iex> Qux.value()
    123

  """
  @spec defconstp(atom() | String.t, module()) :: module()
  defmacro defconstp(name, module) do
    quote do
      defp unquote(name)() do
        resolve(unquote module)
      end
    end
  end

  @doc false
  def dynamically_resolve(mod) do
    case Registry.lookup(Dependency.Registry, mod) do
      [{_pid, implementation}] ->
        implementation

      [] ->
        mod
    end
  end
end
