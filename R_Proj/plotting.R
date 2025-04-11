#plotting sm 
plot(DEM) # base
plot(sm, add = T, pch = 16) # points

# ad(sm, add = T, pch = 16, col = "red") to the plot
par(xpd = FALSE)
legend("topright", legend = "Soil Moisture Station", pch = 16)

# intervals for colors
## adding bins for cols 
nbins <- 7
col.pal <- brewer.pal(nbins, "GnBu")
## Adding global data range to animate with constant cols
global_range <- range(sm@data, na.rm = TRUE)
intervals <- quantile(global_range, probs = seq(0, 1, length.out = 8), na.rm = TRUE) ## these are fixed now. Fixed in terms of staying the same not mended

## reading in precip data for barplot
ppt <- read.csv("rawData/SHCZO_ppt_2010.csv")

## loop to cycle plots
ani.options(interval = 0.3)


for (i in 1:ncol(sm@data)) {
  par(mfrow = c(2, 1), mar = c(4, 4, 3, 1)) 
  idx.col <- cut(sm@data[, i], breaks = intervals, include.lowest = TRUE, labels = FALSE)
  plot(DEM, col = brewer.pal(9, 'Greys'), 
       xlab = 'Easting [m]', ylab = 'Northing [m]',
       main = paste('Shale Hills Elevation -', gsub("X", "", colnames(sm@data)[i])))
  plot(sm, pch = 16, col = col.pal[idx.col], add = TRUE)
  plot(ws, add = TRUE)
  leg <- paste0(round(intervals[-8], 2), '-', round(intervals[-1], 2))
  legend('bottomright', legend = leg, pch = 16, col = col.pal, title = 'Soil Moisture [%]', cex = 0.6)
  
  
  ## Homework part barplot sect
  
  barplot(height = ppt$Total_Precip_mm,
          names.arg = ppt$TmStamp,
          las = 2, cex.names = 0.5,
          main = "Daily Precipitation (mm)")
  
  idx.v <- which(ppt$TmStamp == gsub("X", "", colnames(sm@data)[i]))
  if (length(idx.v) > 0) abline(v = idx.v, col = 'red', lwd = 2)
  
  ani.pause()
}

