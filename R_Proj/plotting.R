#plotting sm 
plot(DEM) # base
plot(sm, add = T, pch = 16) # points

# ad(sm, add = T, pch = 16, col = "red") to the plot
par(xpd = FALSE)
legend("topright", legend = "Soil Moisture Station", pch = 16)

# intervals for colors
col.pal <- brewer.pal(3, "GnBu")
intervals <- seq(min(sm@data[,1]), max(sm@data[,1], length = 8))
intervals
idx.col <- cut(sm@data[,1], intervals, include.lowest = T)
idx.col

# define color palette
col.pal[idx.col]

## plotting the stuff

plot(DEM, col = brewer.pal(9, "Greys"),
     xlab = "Easting (m)", ylab = "Northing (m)", main = "Shale Hills Elevation (m)")
plot(sm, pch = 16, col = col.pal[idx.col], add = T)
plot(ws, add = T)
par(xpd = FALSE)

## Adding legend
leg <- paste0(round(intervals[-8], digits = 2), "-",
              round(intervals[-1], digits = 2))

legend("topleft", legend = leg, pch = 16, col = col.pal, title = "Soil Moist (%)")
