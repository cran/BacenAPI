# Accessing Brazil Central Bank Data via API

## Overview
This simple library allows users to access Brazil Central Bank (BACEN) data by interacting with its API. The library consists of three main R scripts that work together:

1. **bacen_URL**: Generates the URL where the data is available.
2. **bacen_series**: Retrieves data from multiple Central Bank series, given a vector of series IDs and corresponding names.
3. **bacen_search**: Searches for financial indicator series by keyword.

This README provides a detailed guide on how to use each function.

---

## Bacen_URL

### Description
This function generates the URL for accessing BACEN data by specifying three arguments:
- `series`: The series code.
- `star_date`: The start date.
- `end_date`: The end date.

### Important Notes
- Use the Brazilian date format: `dd/mm/yyyy`.
- Ensure dates are provided as strings/characters.
- The function accepts either a single series or a vector of series.

### Example
```r
# Generate URL for IPCA series from 01/01/2003 to 31/12/2023
ipca_br_url <- bacen_url(433, '01/01/2003', '31/12/2023')

# Output
print(ipca_br_url)
```
**Result:**
```
[1] "https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/2003&dataFinal=31/12/2023"
```

---

## Bacen_series

### Description
This function retrieves data from multiple Central Bank series, given a vector of series IDs and corresponding names:

### Arguments

- `url`: Variable containing a vector of URLs.
- `httr`: A logical value indicating whether to use `httr` (`TRUE`) or `httr2` (`FALSE`). Default is TRUE.

### Example
```r
# Retrieve data for multiple series
url <- bacen_url(c('433', '13005'), "01/01/2023", "31/12/2023")  # Date format: "dd/mm/yyyy"
data <- bacen_series(url, httr = TRUE)

# Display results
print(head(data))
```
**Sample Output:**
```
         date series_1 series_2
1  01/01/2013    0.79     0.74
2  01/02/2013    0.60     0.53
3  01/03/2013    0.47     0.40
4  01/04/2013    0.55     0.50
5  01/05/2013    0.37     0.32
6  01/06/2013    0.26     0.21
```

---

## Footnotes
- Customize series codes and date ranges as per your needs.

