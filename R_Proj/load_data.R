## Scrit for loading necessary datafor this lab

#DEM Data
DEM <- raster("rawData/Shale_hills_DEM.tif")

# Loadin the watershed boundary shapefile
#watershed <- st_read("rawData/Watershed_Boundary/wshd_nad83_edit.shp")
ws <- vect("rawData/Watershed_Boundary/wshd_nad83_edit.shp") # This uses terra 

sm <- read.csv("rawData/SM_10cm_2010.csv") # Soil moist

# Removing SID col from sm
sm <- sm %>% select(-SID)

# Converting sm to spatial points data frame
coordinates(sm) <- ~X+Y

