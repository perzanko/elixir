defmodule Mix.Tasks.Deps.Loadpaths do
  use Mix.Task

  import Mix.Deps, only: [all: 1, deps_path: 1]

  @hidden true
  @shortdoc "Load all dependencies paths"

  @moduledoc """
  Loads all dependencies. This is invoked directly
  by "loadpaths" when the CLI boots.
  """
  def run(args) do
    { opts, _ } = OptionParser.parse(args)

    unless opts[:no_check] do
      Mix.Task.run "deps.check"
    end

    Enum.each all(:ok), fn(dep) ->
      Code.prepend_path File.join deps_path(dep), "ebin"
    end
  end
end
