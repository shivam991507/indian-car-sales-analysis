# Reproducible visualizations using base R.

quarterly <- read.csv(file.path("data", "processed", "quarterly_sales_2019_2021.csv"))
yearly <- read.csv(file.path("data", "processed", "yearly_sales_2019_2021.csv"))

if (!dir.exists("figures")) dir.create("figures")

brand_order <- unique(yearly$Company[yearly$Year == 2019])
mat <- sapply(c(2019, 2021), function(yr) {
  x <- yearly[yearly$Year == yr, ]
  x$Annual_Sales[match(brand_order, x$Company)]
})
colnames(mat) <- c("2019", "2021")
rownames(mat) <- brand_order

png(file.path("figures", "annual_sales_by_brand_r.png"), width = 1600, height = 850, res = 140)
par(mar = c(9, 5, 4, 2) + 0.1)
barplot(t(mat), beside = TRUE, names.arg = brand_order, las = 2,
        ylab = "Units sold", main = "Annual car sales by brand: 2019 vs 2021")
legend("topright", legend = c("2019", "2021"), fill = c("gray30", "gray70"), bty = "n")
dev.off()

market_q <- aggregate(cbind(Q1, Q2, Q3, Q4) ~ Year, quarterly, sum)
qmat <- t(as.matrix(market_q[c("Q1", "Q2", "Q3", "Q4")]))
colnames(qmat) <- market_q$Year

png(file.path("figures", "quarterly_market_sales_r.png"), width = 1200, height = 700, res = 140)
matplot(1:4, qmat, type = "o", pch = 19, lty = 1,
        xaxt = "n", xlab = "Quarter", ylab = "Units sold",
        main = "Total market sales by quarter")
axis(1, at = 1:4, labels = c("Q1", "Q2", "Q3", "Q4"))
legend("topright", legend = colnames(qmat), lty = 1, pch = 19, bty = "n")
dev.off()
