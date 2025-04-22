#' Retrieve Data from BACEN API
#'
#' This function establishes a connection with the Central Bank of Brazil (BACEN) API
#' to retrieve data in JSON format and convert it into a readable format such as a data frame or list.
#' The connection is attempted up to 3 times in case of failure.
#'
#' @param urls A string containing the BACEN API URL for the desired series.
#' @param httr A logical value. If `TRUE`, the function uses the `httr` package to connect.
#' If `FALSE`, the function uses the `httr2` package. Default is `TRUE`.
#'
#' @return Returns the content of the API response converted into an R object (usually a list or data frame),
#' or `NULL` if the connection fails after 3 attempts.
#'
#' @examples
#' # Example using the httr package
#' url <- bacen_url(c('433', '13005'), "01/01/2023", "31/12/2023")  # Date format: "dd/mm/yyyy"
#' bacen_series(url, httr = TRUE)
#'
#' @export
bacen_series <- function(urls, httr = TRUE) {
  `%>%` <- magrittr::`%>%`

  if (!is.vector(urls)) {
    stop("The 'urls' argument must be a vector of URLs.")
  }

  series_list <- lapply(seq_along(urls), function(i) {
    data <- bacen_api(urls[i], httr = httr)

    if (is.null(data)) {
      return(NULL)
    }

    # Convert data types
    data$date <- as.Date(data$data, format = "%d/%m/%Y")
    data$value <- as.numeric(data$valor)

    # Select and rename columns
    data <- data[, c("date", "value")]
    colnames(data)[2] <- paste0("series_", i)

    return(data)
  })

  # Remove failed series
  series_list <- series_list[!sapply(series_list, is.null)]

  if (length(series_list) == 0) {
    message("No series were successfully loaded.")
    return(NULL)
  }

  # Merge data.frames by the date column
  final_df <- Reduce(function(x, y) merge(x, y, by = "date", all = TRUE), series_list)

  return(final_df)
}

