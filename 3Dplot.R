library(plot3D)
library(raster)
library(rgl)
library(plotly)
library(haven)

setwd("D:/DOCUMENTOS/UNIVERSIDAD_DE_LIMA/IDIC/2021/humanitariaLogistics/googleEarthAPI/ira3Dplot")
data <- read_sav("data.sav")

airquality -> data

#basic plot
scatter3D(x=data$Month, y=data$Ozone, z=data$Solar.R, bty = "g",   pch = 20, cex = 2, ticktype = "detailed")

#put label
scatter3D(x=data$Month, y=data$Ozone, z=data$Solar.R, bty = "g",   pch = 20, cex = 2, ticktype = "detailed", clab="Solar rad.", xlab="Month",ylab= "Ozone", zlab="solar rad")

#change theme
scatter3D(x=data$Month, y=data$Ozone, z=data$Solar.R, bty = "b2",   pch = 20, cex = 2, ticktype = "detailed", clab="Solar rad.", xlab="Month",ylab= "Ozone", zlab="solar rad")

#change perspective
scatter3D(x=data$Month, y=data$Ozone, z=data$Solar.R, bty = "b2",   pch = 20, cex = 2, ticktype = "detailed", clab="Solar rad.", xlab="Month",ylab= "Ozone", zlab="solar rad", phi = 0)

scatter3D(x=data$Month, y=data$Ozone, z=data$Solar.R, bty = "b2",   pch = 20, cex = 2, ticktype = "detailed", clab="Solar rad.", xlab="Month",ylab= "Ozone", zlab="solar rad", phi = 0, theta=30)

#using other variables
scatter3D(x=data$Temp, y=data$Ozone, z=data$Month, bty = "b2",   pch = 20, cex = 2, ticktype = "detailed", clab="Month", xlab="Month",ylab= "Ozone", zlab="solar rad", phi = 0, theta=30)

#create custom color for the legend and customise it,
scatter3D(x=data$Temp, y=data$Ozone, z=data$Month, bty = "b2",   pch = 20, cex = 2, ticktype = "detailed", clab="Month", xlab="Month",ylab= "Ozone", zlab="solar rad", phi = 0, theta=30,  col.var = data$Month,  col = c("blue", "green", "yellow", "orange", "red"))

scatter3D(x=data$Temp, y=data$Ozone, z=data$Month, bty = "b2",   pch = 20, cex = 2, ticktype = "detailed", clab="Month", xlab="Month",ylab= "Ozone", zlab="solar rad", phi = 0, theta=30,  col.var = data$Month,  col = c("blue", "green", "yellow", "orange", "red"), colvar = data$Month, colkey = list(at=c(5,6,7,8,9), labels=c("May", "jun", "jul", "Aug", "Sep"), side=1))


#Another example used rgl
x= data$Temp
y=data$Ozone
z=data$Solar.R



#an example using dem data
read.csv("xyz_mrp") -> r
x <- r$x
y <- r$y
z <- r$mrpUTM1_Resample1

#using rgl
plot3d(x = x, y = y, z = z)

#create custom color for rgl plot
myColorRamp <- function(colors, values) {
  v <- (values - min(values))/diff(range(values))
  x <- colorRamp(colors)(v)
  rgb(x[,1], x[,2], x[,3], maxColorValue = 255)
}
# z as the fourth variable 
col <- myColorRamp(c("blue", "green","yellow", "orange", "red"), z)
plot3d(x = x, y = y, z = z, col=col)


#another example using plotly
as.matrix(rasterFromXYZ(r)) -> dem
dim(dem)
fig <- plot_ly(z = ~dem)
fig <- fig %>% add_surface()
fig
