# Pythonプログラマが30分でわかるR

Copyright (c) 2021 Zettsu Tatsuya

Pythonで機械学習や統計的分析をするプログラマが、Rを使うために最低限必要なことをまとめました。

## HTML版を読みたい

Releases にある、 r_in_30minutes.html をダウンロードしてご覧ください。

## 本文をHTMLに変換する

本文は、[R Markdown](r_in_30minutes.Rmd)で書いてあります。HTML化するためには本レポジトリをダウンロードして、同梱の **r_in_30minutes.Rmd** を以下の手順でHTMLに変換します。

1. [R](https://cran.r-project.org/bin/windows/base/) をインストールする
1. [RStudio](https://rstudio.com/products/rstudio/) をインストールする
1. Rに [必要なパッケージ](#必要なパッケージをインストールする) をインストールする
1. Rで [日本語フォント](#日本語フォントをインストールする) を使えるようにする
1. Python, Perlおよび各種UNIXコマンドを実行できるようにする
1. 読み込んでいる [データ](#描画するデータを入手する) をダウンロードする
1. RStudioで r_in_30minutes.Rmd を開き、knitボタンを押す
1. パッケージが足りないと言われたら、その都度インストールする

### 必要なパッケージをインストールする

RStudioを開いて以下を実行して、 **r_in_30minutes.Rmd** が必要とするパッケージをインストールしてください。

```{r}
install.packages("tidyverse")
install.packages("assertthat")
install.packages("extrafont")
install.packages("functional")
install.packages("jsonlite")
install.packages("kableExtra")
install.packages("lubridate")
install.packages("plotly")
install.packages("RColorBrewer")
install.packages("reticulate")
install.packages("rlang")
install.packages("xfun")
install.packages("cloc", repos = c("https://cinc.rud.is", "https://cloud.r-project.org/"))
```

**r_in_30minutes.Rmd** が必要とするパッケージは、以下のbashスクリプトを実行すると得られます。 cloc パッケージはダウンロード元を指定する必要があります。

```{r}
bash list_packages.sh
```

### 日本語フォントをインストールする

図をきれいに描くために、 Migu 1M フォントを使用しています。 [こちら](https://mix-mplus-ipa.osdn.jp/migu/) からダウンロードして、インストールしてください。

RStudioを開いて以下を実行して、RでMigu 1M フォントが使えるようにします。この処理は数分かかります。詳しくは [こちら](https://qiita.com/zakkiiii/items/9bbfdaf46a097677205d) に説明があります。

```{r}
library(extrafont)
extrafont::font_import()
extrafont::loadfonts()
View(extrafont::fonttable())
```

### RからPythonとPerlを使えるようにする

Linuxであれば特に何もしなくても、RおよびRStudioからPython, Perlおよび各種UNIXコマンドを実行できるでしょう。Python3のコマンド名がpython以外の場合、 reticulateパッケージで [設定](https://rstudio.github.io/reticulate/articles/r_markdown.html) します。

```{r}
library(reticulate)
reticulate::use_python("/path/to/python3")
```

Windowsでは例えば以下のように設定します。

- 環境変数PATHに、Pythonへのパスを通す。Windows版 Python 3.9.1の [完全版インストーラ](https://docs.python.org/ja/3/using/windows.html#windows-full)を使った場合は、 %LOCALAPPDATA%\Programs\Python\Python39 にパスを通すと思います。
- 環境変数PATHに、Perlへのパスを通す。ここではPerlは [ActivePerl Community Edition](https://www.activestate.com/products/perl/downloads/) を想定しています。ディレクトリ構成が異なる場合やCygwin版 Perlを使う場合は適宜変更してください。
- 環境変数 R_USER のディレクトリにある .Rprofile (なければ新規に作る)に以下のように書いてPATHを追加します。Cygwin pythonはPython2なので、WindowsのPython3が先に見つかるようにします。

```{r}
Sys.setenv(PATH=paste0(
  c(gsub("/", "\\", file.path(Sys.getenv("LOCALAPPDATA"),
    "Programs", "Python", "Python39"), fixed=TRUE),
  "C:\\Perl64\\bin", Sys.getenv("PATH")), sep="", collapse=";"))
```

## 描画するデータを入手する

**r_in_30minutes.Rmd** からHTML文書を生成すると、 [横浜市のオープンデータ](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/) を編集・加工したものが埋め込まれます。これらは [利用条件等](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/opendata.html) に記載の、 CC BY 4.0 に基づいています。

埋め込むデータは、本レポジトリに同梱していません。HTML化するたびに横浜市のサイトにアクセスしないよう、**r_in_30minutes.Rmd** はサイトから自動的に読み込むこともしません。下記リンク先からダウンロードして、 **incoming_yokohama** サブディレクトリに置いてください。

|内容とリンク先|更新日|ファイル名|
|:------------------------------|:------------------------------|:------------------------------|
|[人口と世帯数の推移](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/jinko-setai-suii.html)|最新版(2020年まで)|jinkosetai-sui.csv|
|[男女別人口及び世帯数－行政区](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/suikei01.html)|令和2年9月(2020年9月)|e1yokohama2009.csv|

## ライセンス

本レポジトリのライセンスは、[MITライセンス](LICENSE.txt)です。
