# Statistical analysis for Indian Car Sales Analysis (2019 vs 2021)
# Uses base R only.

quarterly_path <- file.path("data", "processed", "quarterly_sales_2019_2021.csv")
yearly_path <- file.path("data", "processed", "yearly_sales_2019_2021.csv")

if (!file.exists(quarterly_path) || !file.exists(yearly_path)) {
  stop("Processed data not found. Run R/01_prepare_data.R first.")
}

quarterly <- read.csv(quarterly_path, check.names = FALSE)
yearly <- read.csv(yearly_path, check.names = FALSE)

year_table <- xtabs(Annual_Sales ~ Company + Year, data = yearly)
year_chi <- chisq.test(year_table)

quarter_chi <- list()
for (yr in c(2019, 2021)) {
  temp <- quarterly[quarterly$Year == yr, ]
  qmat <- as.matrix(temp[c("Q1", "Q2", "Q3", "Q4")])
  rownames(qmat) <- temp$Company
  quarter_chi[[as.character(yr)]] <- chisq.test(qmat)
}

anova_results <- list()
for (yr in c(2019, 2021)) {
  temp <- quarterly[quarterly$Year == yr, ]
  long <- reshape(
    temp[c("Company", "Q1", "Q2", "Q3", "Q4")],
    varying = c("Q1", "Q2", "Q3", "Q4"),
    v.names = "Sales",
    timevar = "Quarter",
    times = c("Q1", "Q2", "Q3", "Q4"),
    direction = "long"
  )
  long$Company <- factor(long$Company)
  long$Quarter <- factor(long$Quarter, levels = c("Q1", "Q2", "Q3", "Q4"))
  fit <- aov(Sales ~ Company + Quarter, data = long)
  anova_results[[as.character(yr)]] <- summary(fit)
}

cat("\n=== Brand x Year Chi-square Test ===\n")
print(year_chi)

for (yr in c(2019, 2021)) {
  cat("\n=== Brand x Quarter Chi-square Test:", yr, "===\n")
  print(quarter_chi[[as.character(yr)]])
  cat("\n=== Two-way ANOVA without replication:", yr, "===\n")
  print(anova_results[[as.character(yr)]])
}
