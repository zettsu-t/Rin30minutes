# Pythonプログラマが30分でわかるR

Copyright (c) 2021-2022 Zettsu Tatsuya

Pythonで機械学習や統計的分析をするプログラマが、Rを使うために最低限必要なことをまとめました。

## HTML版を読みたい

Releases にある、 r_in_30minutes.html をダウンロードしてご覧ください。

## RStudio環境を簡単に構築して本文をHTMLに変換する

同梱のDockerfileから、Dockerコンテナを作成して、コンテナ上でRStudio Serverを起動します。

### Dockerコンテナをビルドする

Dockerfileがあるディレクトリ( **Rin30minutes/** 直下)に移動して、Dockerコンテナをビルドします。イメージ名は **r30min** とします。動作確認を Windows 10 上のDockerで行いました。必要なら sudo をつけて実行して下さい。

```{bash}
cd /path/to/Dockerfile
docker build -t r30min .
```

### Dockerコンテナを起動する

ビルドしたのと同じディレクトリに移動して、Dockerコンテナを起動します。詳しい起動オプションは、[rocker/rstudio](https://hub.docker.com/r/rocker/rstudio)に載っています。ここでは以下の通り設定します。

```{bash}
docker run -e PASSWORD=yourpassword -p 8787:8787 -d r30min
```

+ ログインアカウントは、Dockerイメージのデフォルト設定である rstudio のままにする
+ パスワードは、上記の -e PASSWORD 引数で指定する。指定しないと、RStudio Server を起動できない。
+ RStudio Server のポートは、デフォルト通り TCP 8787 を使い、ホストOSの同一ポートから転送する
+ -d オプションをつけて、 detached で実行する
+ イメージ名はビルド時に指定した r30min とする

Dockerコンテナを起動したホスト [http://example.com:8787/](http://example.com:8787/) に、Webブラウザからログインすると、RStudio Serverの画面が出ます。ホスト名は適宜読み替えてください。

### 描画するデータを入手する

後述の通り、描画するデータを横浜市のオープンデータのサイトからダウンロードします。敢えてDockerコンテナのビルド時ではなく、実行時にダウンロードするようにしています。

RStudio Server上で **download_data.R** を開き、Ctrl-Alt-R を押してこのRスクリプトを実行します。ダウンロードに成功したら、**incoming_yokohama** サブディレクトリにCSVファイルが2つできています。

### HTMLに変換する

RStudio Server上で **r_in_30minutes.Rmd** を開き、**Knit** ボタンを押してHTMLに変換します。HTML文書が別ウィンドウで表示されますが、Webブラウザがポップアップウィンドウをブロックすると思いますので、ブロックを解除してください。

変換後のHTMLファイルを、DockerコンテナからホストOSに移動することもできます。そのためにはDockerコンテナを起動する時に、ホストOSのファイルシステムをDockerコンテナにマウントする必要があります。具体的な方法は別途検索ください。おそらく、コンテナ上のユーザ rstudio と、ホストOSのユーザアカウントをあわせる必要があるでしょう。

WindowsのドライブをDockerコンテナにマウントするには、以下のように -v オプションを使います。ドライブ名を指定する:をつけるので、 -v オプションの引数に:が2回出ます。

```{bash}
docker run -e PASSWORD=yourpassword -p 8787:8787 -v c:/path/to/Rin30minutes:/home/rstudio/work -d r30min
```

### GitHub flavored markdown (GFM) に変換する

RStudio Server の Console上で、 `rmarkdown::render` を実行します。デフォルトでは長い行を折り返しますが、改行をそのままHTML文書の改行にする markdown もあるので、下記のオプションの設定して折り返さない方がよいでしょう。

```{r}
rmarkdown::render("r_in_30minutes.Rmd",
  rmarkdown::github_document(
    toc = TRUE, hard_line_breaks = TRUE, pandoc_args = c("--wrap=none")))
```

### Dockerfileは何をしているか

以下の設定を行います。加えて、ロケールを ja_JP.UTF-8 に変更しています。ロケールの設定が無いと、環境によっては日本語の出力が文字化けするかもしれません。

## RStudio環境をstep-by-stepで構築して本文をHTMLに変換する

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

RStudioを開いて以下を実行して、 **r_in_30minutes.Rmd** が必要とするパッケージをインストールしてください。 Dockerを使う場合、親イメージ(rocker/tidyverse)に用意されているパッケージは、明示的にインストールする必要はありません。

```{r}
install.packages("assertthat")
install.packages("cloc", repos = c("https://cinc.rud.is", "https://cloud.r-project.org/"))
install.packages("extrafont")
install.packages("functional")
install.packages("jsonlite")
install.packages("kableExtra")
install.packages("knitr")
install.packages("lintr")
install.packages("lubridate")
install.packages("markdown")
install.packages("plotly")
install.packages("R6")
install.packages("RColorBrewer")
install.packages("reticulate")
install.packages("rlang")
install.packages("styler")
install.packages("tidyverse")
install.packages("xfun")
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

Windows では環境変数PATHに、Python と Perl へのパスを通します。 Perlは [Rtools](https://cran.r-project.org/bin/windows/Rtools/rtools40.html) に含まれている実行ファイルを使えばよいですが、Cygwin などを入れている場合は Rtools と混ざらないように環境変数PATHを設定します。

NumPyがインストールされていなければ、インストールしてください。

### 描画するデータを入手する

**r_in_30minutes.Rmd** からHTML文書を生成すると、 [横浜市のオープンデータ](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/) を編集・加工したものが埋め込まれます。これらは [利用条件等](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/opendata.html) に記載の、 CC BY 4.0 に基づいています。

埋め込むデータは、本レポジトリに同梱していません。HTML化するたびに横浜市のサイトにアクセスしないよう、**r_in_30minutes.Rmd** はサイトから自動的に読み込むこともしません。下記リンク先からダウンロードして、 **incoming_yokohama** サブディレクトリに置いてください。

|内容とリンク先|更新日|ファイル名|
|:------------------------------|:------------------------------|:------------------------------|
|[人口と世帯数の推移](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/jinko-setai-suii.html)|最新版(2020年まで)|jinkosetai-sui.csv|
|[男女別人口及び世帯数－行政区](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/suikei01.html)|令和3年12月(2021年12月)|e1yokohama2112.csv|

## ライセンス

本レポジトリのライセンスは、[MITライセンス](LICENSE.txt)です。

## Rプログラマが30分ではじめるStan

R から Stan を使う方法を stan_example.Rmd に書きました。 Releases に含めましたのでご覧ください。Dockerコンテナをビルド、起動するには、以下のコマンドを実行します。

```{bash}
cd /path/to/Dockerfile
docker build -t r30min .
docker build -f Dockerfile_stan -t stan .
docker run -e PASSWORD=yourpassword -p 8787:8787 -d stan
```
