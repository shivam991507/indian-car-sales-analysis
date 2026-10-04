# Indian Car Sales Analysis: 2019 vs 2021

A statistical analysis of monthly and quarterly passenger-car sales in India, comparing **2019** with **2021** across 14 automobile brands.

This project began as an undergraduate Statistics project and has been reorganized here as a reproducible portfolio project. The analysis covers data preparation, quarterly aggregation, exploratory visualization, Pearson chi-square tests, and two-way ANOVA without replication.

## Project question

How did the distribution and seasonal pattern of car sales across major brands differ between 2019 and 2021?

> Note: 2019 is used as the pre-pandemic baseline. Because COVID-19 was still affecting India during 2021, this repository describes 2021 as a **pandemic/recovery-period comparison year**, rather than treating it as a fully post-pandemic year.

## Data source

Original dataset: **Car Sales in India (2019-2021)** on Kaggle  
https://www.kaggle.com/datasets/subhadeeptasahoo/car-sales-in-india-20192021

The source file contains 2019, 2020 and 2021 monthly sales. This project intentionally filters the data to **2019 and 2021**. The raw Kaggle file is not redistributed in this repository because its license could not be verified while preparing the public version; see `data/raw/README.md`.

## Data preparation

For each brand:

- Monthly sales for 2019 and 2021 are retained.
- Quarterly totals are calculated directly from the source months:
  - Q1 = Jan + Feb + Mar
  - Q2 = Apr + May + Jun
  - Q3 = Jul + Aug + Sep
  - Q4 = Oct + Nov + Dec
- Annual totals are calculated as the sum of all 12 months.
- Source-data zeros are preserved exactly in the reproducible version.

## Repository structure

```text
indian-car-sales-analysis/
├── README.md
├── R/
│   ├── original_report_code.R
│   ├── 01_prepare_data.R
│   ├── 02_statistical_analysis.R
│   └── 03_visualization.R
├── report/
│   ├── original_academic_report.pdf
│   └── README.md
├── data/
│   ├── raw/
│   │   └── README.md
│   └── processed/
│       ├── monthly_sales_2019_2021.csv
│       ├── quarterly_sales_2019_2021.csv
│       ├── yearly_sales_2019_2021.csv
│       └── market_totals.csv
├── docs/
│   └── data_quality_notes.md
└── figures/
    ├── annual_sales_by_brand.png
    └── quarterly_market_sales.png
```

## Original academic submission

The **[original academic report](report/original_academic_report.pdf)** is preserved unchanged. It contains the original monthly and quarterly tables, graphs, hypothesis tests, ANOVA calculations, interpretations, conclusion, and appendix screenshots of the R code.

A repository-friendly reconstruction of the appendix code is available in **[R/original_report_code.R](R/original_report_code.R)**.

### Conclusions reported in the original project

The submitted report concluded that:

- Brand-wise sales differed significantly in both 2019 and 2021.
- Maruti Suzuki and Hyundai dominated sales relative to the other brands.
- Quarter-wise variation was not significant in 2019, but was significant in 2021.
- The report interpreted the comparison as showing pandemic-related changes in brand-level sales, highlighting declines for brands such as Hyundai, Honda and Ford and growth for Kia and MG.

These are the conclusions from the original academic submission and are retained because they are the basis of the project description used on the resume.

## Reproducibility check

A later reconstruction was carried out directly from the supplied Kaggle CSV so that the project could be rerun from raw monthly values. During that process, a few manual/transcription differences were found between the report tables and the raw data. They are documented in **[docs/data_quality_notes.md](docs/data_quality_notes.md)** rather than altering the original PDF.

### Overall total from the reconstructed source data

Across the 14 brands:

| Year | Total units |
|---|---:|
| 2019 | 2,897,215 |
| 2021 | 3,073,588 |

The combined total is about **6.1% higher** in 2021, so the reconstructed data support a **brand-specific change** interpretation rather than a blanket decline across all selected brands.

![Annual sales by brand](figures/annual_sales_by_brand.png)

### Pearson chi-square tests

Using the reconstructed source values:

| Test | Chi-square | df | Result |
|---|---:|---:|---|
| Brand x Year (annual counts) | 205,684.50 | 13 | p < 0.001 |
| Brand x Quarter, 2019 | 105,473.74 | 39 | p < 0.001 |
| Brand x Quarter, 2021 | 53,411.02 | 39 | p < 0.001 |

These show strong association between the distribution of recorded sales and brand/year or brand/quarter.

### Two-way ANOVA without replication

| Year | Brand effect | Quarter effect |
|---|---|---|
| 2019 | F = 189.02, p < 0.001 | F = 2.70, p = 0.0588 |
| 2021 | F = 105.69, p < 0.001 | F = 3.37, p = 0.0280 |

Brand-to-brand differences are significant in both years. Quarter-to-quarter variation is not significant at the 5% level in 2019, but it is significant in 2021.

![Quarterly market sales](figures/quarterly_market_sales.png)

## Reproducibility

The cleaned workflow uses base R.

1. Download the original Kaggle CSV.
2. Save it as `data/raw/car_sales_india_2019_2021.csv`.
3. Run:

```r
source("R/01_prepare_data.R")
source("R/02_statistical_analysis.R")
source("R/03_visualization.R")
```

The first script recreates the processed monthly, quarterly and annual tables from the original monthly data.

## Methodological notes

- Genuine zero-sales months in the source data are preserved in the cleaned analysis.
- The two-way ANOVA has one aggregated observation per Brand x Quarter cell, so a separate interaction effect cannot be estimated in this design.
- This is a two-year observational comparison and does not by itself establish that COVID-19 caused every observed change; launches, exits, supply constraints and other market factors may also contribute.

## Tools

- R
- Statistical data analysis
- Data cleaning and aggregation
- Pearson chi-square test
- Two-way ANOVA
- Data visualization
