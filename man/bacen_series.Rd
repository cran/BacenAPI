% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bacen_series.R
\name{bacen_series}
\alias{bacen_series}
\title{Retrieve Data from BACEN API}
\usage{
bacen_series(urls, httr = TRUE)
}
\arguments{
\item{urls}{A string containing the BACEN API URL for the desired series.}

\item{httr}{A logical value. If `TRUE`, the function uses the `httr` package to connect.
If `FALSE`, the function uses the `httr2` package. Default is `TRUE`.}
}
\value{
Returns the content of the API response converted into an R object (usually a list or data frame),
or `NULL` if the connection fails after 3 attempts.
}
\description{
This function establishes a connection with the Central Bank of Brazil (BACEN) API
to retrieve data in JSON format and convert it into a readable format such as a data frame or list.
The connection is attempted up to 3 times in case of failure.
}
\examples{
# Example using the httr package
url <- bacen_url(c('433', '13005'), "01/01/2023", "31/12/2023")  # Date format: "dd/mm/yyyy"
bacen_series(url, httr = TRUE)

}
