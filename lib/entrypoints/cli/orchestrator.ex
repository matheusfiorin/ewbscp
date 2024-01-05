defmodule Ewbscp.Entrypoints.CLI.Orchestrator do
  alias Ewbscp.Port.Workflow.Articles.Models.ArticleRequest
  alias Ewbscp.Entrypoints.CLI.Command
  alias Ewbscp.Port.Workflow.Articles.External.CLIArticle

  def orchestrate_command(%Command{command: :fetch_wikipedia_page, args: {uri, _}}) do
    CLIArticle.fetch_article(%ArticleRequest{uri: List.first(uri)})
  end

  def orchestrate_command(%Command{}) do
    IO.puts("Unknown command.")
    IO.puts("Run 'make help' to see what you can do.")
    System.halt(1)
  end
end
