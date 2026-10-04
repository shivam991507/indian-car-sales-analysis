# Data quality and reconstruction notes

This file records the checks performed while rebuilding the portfolio version from the original academic report and the supplied Kaggle CSV.

## Confirmed reconstruction

The quarterly dataset was regenerated directly from the monthly source data by summing Jan-Mar, Apr-Jun, Jul-Sep and Oct-Dec for each brand and year. Therefore, the deleted quarterly spreadsheet is no longer required.

## Differences found in the original report

The academic report contains several small manual/transcription changes relative to the supplied raw CSV. Examples include:

- Some genuine zero values were written as `1` for Kia and MG in 2019 and for Ford in late 2021.
- Ford's 2021 annual total appears as 33,481 in the report, while the raw CSV sums to 33,480.
- Kia's 2019 annual total appears as 45,497 in the report, while the raw CSV sums to 45,494.
- MG's 2019 annual total appears as 15,932 in the report, while the raw CSV sums to 15,930.
- One 2019 ANOVA table row shows Ford quarter values copied incorrectly, even though its displayed row mean corresponds to the correct Ford quarterly values.
- The 2019 grand mean used in the report omits exactly 10,935 units, which equals Jeep's 2019 annual total, producing incorrect ANOVA sums of squares.
- The annual Brand x Year chi-square statistic in the report does not match the statistic obtained from the supplied raw data.

The portfolio version therefore treats the supplied Kaggle CSV as the data source of truth and regenerates all derived tables and statistics programmatically.
