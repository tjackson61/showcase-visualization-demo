get_csv_data <- function() {
  # assumes data folder created
  path <- list.files("./data", full.names = TRUE)
  df <- readr::read_csv(path)
  return(df)
}