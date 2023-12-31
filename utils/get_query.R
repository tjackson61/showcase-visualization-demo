get_query <- function(path = "./query/") {
  sql_file <- list.files(path, full.names = TRUE)
  sql_query <- readr::read_file(sql_file) |>
    dplyr::sql()
  return(sql_query)
}

# Add Dimension Parameter
inject_parameters <- function(query, dimension, measure) {
  dimension <- glue::glue("{dimension}")

  DBI::sqlInterpolate(
    DBI::ANSI(),
    query,
    dimension = DBI::dbQuoteIdentifier(DBI::ANSI(), dimension),
    measure = DBI::dbQuoteIdentifier(DBI::ANSI(), DBI::SQL(measure))
  )
}
