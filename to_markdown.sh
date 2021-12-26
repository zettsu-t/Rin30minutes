#!/bin/bash
Rscript -e 'rmarkdown::render("r_in_30minutes.Rmd", rmarkdown::github_document(toc = TRUE, hard_line_breaks = TRUE, pandoc_args = c("--wrap=none")))'
cat r_in_30minutes.md | tr -d '\r' | sed -e 's/<!--.*-->//g' | sed -E -e '/## +データ出典/q' | egrep -v '#\s*(その他|実行環境|本文書のライセンス)' | sed -E -e 's/[[:space:]]*$//' -e 's/``` *[[:alnum:]]+-output/```/g' -e 's/``` *python\s*$/``` python:Python/g' -e 's/``` *r\s*$/``` r:R/g' > r_in_30minutes_plus.md
diff --ignore-trailing-space --strip-trailing-cr r_in_30minutes.md r_in_30minutes_plus.md
