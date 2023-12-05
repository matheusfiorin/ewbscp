# ewbscp

## Usage
First, make sure you have `make` installed on your sistem. Then:

```
$ make help

Usage:
  make build                   - Builds project with Mix
  make run <path> -- [<flags>] - Execute the compiled file and <path> doesn't have quotes
  make zip <path> -- [<flags>] - Same as run, but it builds before running
   || possible flags:
   ||   --allow-empty :: Includes empty directories

  make help                    - Shows this help
```

## Architecture implementation
### Namespace convention

```
import application.workflow.articles.article
```

### Folder structure

```
-   /application
    -   /workflow
        -   /articles
            -   article.ex (orchestrates things to fetch an article)
        -   /mangas
            -   manga.ex
    -   /domain
        -   content.ex (represents a content)
        -   page.ex    (represents a web page)
        -   manga.ex   (represents a manga :tophat:)
        -   scraper.ex (represents a scraper client)
        -   article.ex
        -   *.ex       (models)
-   /port
    -   article.ex (get_article)
    -   cli.ex (get_article)
-   /adapter
    -   /external
        -   wikipedia.ex (makes a http call)
        -   wordpress.ex (makes a http call)
        -   cli.ex       (handles cli interaction)
        -   ...
    -   /internal
        -   wikipedia_handler.ex
        -   wordpress_handler.ex
        -   cli_handler.ex
        -   ...
```
