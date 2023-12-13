exec_query <- function(query) {
  source("connection.R")
  pool::dbGetQuery(app_pool, dplyr::sql(query))
}


