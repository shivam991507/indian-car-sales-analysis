# Original analysis code reconstructed from the appendix of the academic report
# -----------------------------------------------------------------------------
# This file preserves the analysis approach shown in the submitted report.
# The original screenshots used absolute Windows paths and separate prepared CSV
# files. Here, those paths are replaced by repository-relative processed files so
# the same analyses can be inspected and re-run.
#
# For the cleaned, fully reproducible workflow, use:
#   R/01_prepare_data.R
#   R/02_statistical_analysis.R
#   R/03_visualization.R

yearly <- read.csv("data/processed/yearly_sales_2019_2021.csv", header = TRUE)
annual_table <- xtabs(Annual_Sales ~ Company + Year, data = yearly)
print(annual_table)
chi_result_year <- chisq.test(annual_table)
print(chi_result_year)

quarterly <- read.csv("data/processed/quarterly_sales_2019_2021.csv", header = TRUE)

q2019 <- quarterly[quarterly$Year == 2019, ]
table_2019 <- as.matrix(q2019[, c("Q1", "Q2", "Q3", "Q4")])
rownames(table_2019) <- q2019$Company
print(table_2019)
chi_result_2019 <- chisq.test(table_2019)
print(chi_result_2019)

q2021 <- quarterly[quarterly$Year == 2021, ]
table_2021 <- as.matrix(q2021[, c("Q1", "Q2", "Q3", "Q4")])
rownames(table_2021) <- q2021$Company
print(table_2021)
chi_result_2021 <- chisq.test(table_2021)
print(chi_result_2021)

if (requireNamespace("car", quietly = TRUE)) {
  carsale_2019 <- c(
    1464450, 510260, 152002, 219682, 45497, 134738, 126701,
    88869, 73636, 6910, 15932, 32324, 15284, 10935
  )
  carsale_2021 <- c(
    1364787, 505033, 330552, 203124, 180261, 89153, 130799,
    95878, 33481, 39090, 39858, 26064, 23857, 11652
  )
  company <- factor(c(
    "Maruti Suzuki", "Hyundai", "Tata", "Mahindra", "Kia", "Honda", "Toyota",
    "Renault", "Ford", "Nissan", "MG", "Volkswagen", "Skoda", "Jeep"
  ))
  df_2019 <- data.frame(carsale = carsale_2019, Company = company)
  df_2021 <- data.frame(carsale = carsale_2021, Company = company)
  # Original appendix form:
  # car::leveneTest(carsale ~ Company, data = df_2019)
  # car::leveneTest(carsale ~ Company, data = df_2021)
} else {
  message("Package 'car' is not installed; Levene-test appendix code was not run.")
}
