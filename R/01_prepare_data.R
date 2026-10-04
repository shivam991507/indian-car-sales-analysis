# Data preparation for Indian Car Sales Analysis (2019 vs 2021)
# Uses base R only.

raw_path <- file.path("data", "raw", "car_sales_india_2019_2021.csv")

if (!file.exists(raw_path)) {
  stop(
    paste0(
      "Raw dataset not found at ", raw_path, ".\n",
      "Download it from Kaggle and save it with this filename.\n",
      "See data/raw/README.md for the source link."
    )
  )
}

raw <- read.csv(raw_path, check.names = FALSE)
months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

required_cols <- c("Company", "Year", months)
missing_cols <- setdiff(required_cols, names(raw))
if (length(missing_cols) > 0) {
  stop(paste("Missing required columns:", paste(missing_cols, collapse = ", ")))
}

selected <- raw[raw$Year %in% c(2019, 2021), required_cols]
selected <- selected[order(selected$Year, match(selected$Company,
                     unique(raw$Company[raw$Year == 2019]))), ]

selected$Q1 <- rowSums(selected[c("Jan", "Feb", "Mar")])
selected$Q2 <- rowSums(selected[c("Apr", "May", "Jun")])
selected$Q3 <- rowSums(selected[c("Jul", "Aug", "Sep")])
selected$Q4 <- rowSums(selected[c("Oct", "Nov", "Dec")])
selected$Annual_Sales <- rowSums(selected[months])

monthly <- selected[c("Company", "Year", months)]
quarterly <- selected[c("Company", "Year", "Q1", "Q2", "Q3", "Q4")]
yearly <- selected[c("Company", "Year", "Annual_Sales")]

if (!dir.exists(file.path("data", "processed"))) {
  dir.create(file.path("data", "processed"), recursive = TRUE)
}

write.csv(monthly,
          file.path("data", "processed", "monthly_sales_2019_2021.csv"),
          row.names = FALSE)
write.csv(quarterly,
          file.path("data", "processed", "quarterly_sales_2019_2021.csv"),
          row.names = FALSE)
write.csv(yearly,
          file.path("data", "processed", "yearly_sales_2019_2021.csv"),
          row.names = FALSE)

market_totals <- aggregate(Annual_Sales ~ Year, yearly, sum)
names(market_totals)[2] <- "Total_Market_Sales"
base_2019 <- market_totals$Total_Market_Sales[market_totals$Year == 2019]
market_totals$Change_vs_2019_pct <-
  100 * (market_totals$Total_Market_Sales / base_2019 - 1)

write.csv(market_totals,
          file.path("data", "processed", "market_totals.csv"),
          row.names = FALSE)

cat("Processed data files created successfully.\n")
