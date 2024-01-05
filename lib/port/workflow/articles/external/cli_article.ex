defmodule Ewbscp.Port.Workflow.Articles.External.CLIArticle do
  alias Ewbscp.Domain.Workflow.Articles.Orchestrator
  alias Ewbscp.Port.Workflow.Articles.Models.ArticleRequest

  def fetch_article(%ArticleRequest{uri: uri}) do
    Orchestrator.fetch_article_by_uri(uri)
  end
end
