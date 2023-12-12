sql_query_fn <- function(query) {
  readr::read_file(list.files("./query/", full.names = TRUE)) |> dplyr::sql()
}

sql_query <- sql_query_fn()