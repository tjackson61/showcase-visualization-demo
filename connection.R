app_pool <- pool::dbPool(
  odbc::odbc(),
  Driver = "{ODBC DRIVER 17 for SQL Server}",
  Server = "GONE-PHISING",
  Database = "AVIATION_WAREHOUSE",
  Uid = "app_pool",
  Pwd = "Remote11!!",
  trusted_connection = "yes",
  minSize = 1,
  maxSize = Inf,
  onCreate = NULL,
  idleTimeout = 60,
  validationInterval = 60,
  validateQuery = NULL
)
