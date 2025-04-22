#' @noRd
bacen_api <- function(url, httr = TRUE) {
  `%>%` <- magrittr::`%>%`
  message("Starting connection to the Bacen API...\n")
  attempt <- 0

  # --- Using httr --- #
  if (httr) {
    api_response <- tryCatch(httr::GET(url = url), error = function(e) return(NULL))

    while (attempt < 3 && (is.null(api_response) || api_response$status_code != 200)) {
      attempt <- attempt + 1
      Sys.sleep(attempt * 2)  # Progressive delay
      message(paste("Connection attempt", attempt, "failed. Retrying...\n"))
      api_response <- tryCatch(httr::GET(url = url), error = function(e) return(NULL))
    }

    if (is.null(api_response) || api_response$status_code != 200) {
      message("Connection failed. Please try again later.")
      return(NULL)
    }

    message("Connection successful! Fetching data...\n")

    parsed_data <- tryCatch({
      rawToChar(api_response$content) %>%
        jsonlite::fromJSON(flatten = TRUE)
    }, error = function(e) {
      message("Error decoding API response.")
      return(NULL)
    })

    # --- Using httr2 --- #
  } else {
    api_response <- tryCatch(httr2::request(url) %>% httr2::req_perform(), error = function(e) return(NULL))

    while (attempt < 3 && (is.null(api_response) || api_response$status_code != 200)) {
      attempt <- attempt + 1
      Sys.sleep(attempt * 2)
      message(paste("Connection attempt", attempt, "failed. Retrying...\n"))
      api_response <- tryCatch(httr2::request(url) %>% httr2::req_perform(), error = function(e) return(NULL))
    }

    if (is.null(api_response) || api_response$status_code != 200) {
      message("Connection failed. Please try again later.")
      return(NULL)
    }

    message("Connection successful! Fetching data...\n")

    parsed_data <- tryCatch({
      rawToChar(api_response$body) %>%
        jsonlite::fromJSON(flatten = TRUE)
    }, error = function(e) {
      message("Error decoding API response.")
      return(NULL)
    })
  }

  return(parsed_data)
}
