library(purrr)
library(assertthat)

download_data <- function() {
  currend_wd <- getwd()
  on.exit(setwd(currend_wd))

  setwd("~/Rin30minutes")
  data_dir_name <- "incoming_yokohama"
  dir.create(data_dir_name, showWarnings = FALSE)

  url_history <- "https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/jinko-setai-suii.files/jinkosetai-sui.csv"
  url_202009 <- "https://www.city.yokohama.lg.jp/city-info/yokohamashi/tokei-chosa/portal/opendata/suikei01.files/e1yokohama2112.csv"
  urls <- c(url_history, url_202009)

  all(purrr::map_lgl(urls, function(in_url) {
    out_filename <- file.path(data_dir_name, basename(in_url))
    if (!file.exists(out_filename)) {
      download.file(in_url, out_filename)
    }

    assertthat::assert_that(file.exists(out_filename))
    assertthat::assert_that(file.size(out_filename) > 0)
  }))
}

download_data()
