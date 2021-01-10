# Pythonプログラマが30分で分かるR

Copyright (c) 2021 Zettsu Tatsuya

Pythonで機械学習や統計処理をプログラマが、Rを使うために最低限必要なことをまとめました。

## 本文をHTMLに変換する

本文は、[R Markdown](r_in_30minutes.Rmd)で書いてあります。HTML化するためには本レポジトリをダウンロードして、同梱の **r_in_30minutes.Rmd** を以下の手順でHTMLに変換します。

1. [R](https://cran.r-project.org/bin/windows/base/) をインストールする
1. [RStudio](https://rstudio.com/products/rstudio/) をインストールする
1. Rに knitr パッケージをインストールする
1. 読み込んでいるデータ(後述)をダウンロードする
1. RStudioで r_in_30minutes.Rmd を開き、knitボタンを押す
1. パッケージが足りないと言われたら、その都度インストールする

図をきれいに描くために、Migu 1Mフォントをインストールして、 extrafont から使えるようにしています。Migu 1Mフォントを使えるように設定していない場合、警告が出るかもしれません。

## 描画するデータを入手する

**r_in_30minutes.Rmd** からHTML文書を生成すると、 [横浜市のオープンデータ](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/) を編集・加工したものが埋め込まれます。これらは [利用条件等](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/opendata.html) に記載の、 CC BY 4.0 に基づいています。

埋め込むデータは、本レポジトリに同梱していません。HTML化するたびに横浜市のサイトにアクセスしないよう、**r_in_30minutes.Rmd** はサイトから自動的に読み込むこともしません。下記リンク先からダウンロードして、 **incoming_yokohama** サブディレクトリに置いてください。

|内容とリンク先|更新日|ファイル名|
|:------------------------------|:------------------------------|:------------------------------|
|[人口と世帯数の推移](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/jinko-setai-suii.html)|最新版(2020年まで)|jinkosetai-sui.csv|
|[男女別人口及び世帯数－行政区](https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/suikei01.html)|令和2年9月(2020年9月)|e1yokohama2009.csv|

## ライセンス

本レポジトリのライセンスは、[MITライセンス](LICENSE.txt)です。
