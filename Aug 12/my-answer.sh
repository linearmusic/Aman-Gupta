#!/bin/sh

# Set the GMT parameters for Times-Roman font
gmt gmtset FONT_ANNOT_PRIMARY Times-Roman
gmt gmtset FONT_LABEL Times-Roman

# Region of South America
# Corrected the format for the whole world
Reg=-R83/90/25/30

# Projection (mercator) with a new, smaller scale to fit the page
Pro=-Jm3

# Input grid and color palettes
GRD=~/Desktop/topo30.grd
CPT=relief.cpt

# Output file
ps=answer.ps

# Step 1: Cut the region from the global topo grid
gmt grdcut $GRD $Reg -Gtmp1.grd -V

# Step 2: Resample to 4 arc-minute resolution
gmt grdsample tmp1.grd -Gtmp.grd -I0.5m -r -nc+c -V

# Step 3: Compute gradient for shading
gmt grdgradient tmp.grd -A315 -Ggradient.grd -Nt -V

# Step 4: Create the fancy base map frame and start the PostScript file
gmt pscoast $Reg $Pro -Bf2g2 -Slightblue -K > $ps

# Step 5: Plot the gridded image on top of the base map
gmt grdimage tmp.grd $Reg $Pro -C$CPT -Igradient.grd -O -K >> $ps

# Step 6: Add coastlines and rivers on top of the image
# This command plots both permanent major (-Ia) and minor (-Ib) rivers.
gmt pscoast $Reg $Pro -Q -W0.25p,black -Ia/0.5,blue -O -K >> $ps
# Step 7: Plot the station (27.34 85.99) as a filled red inverted triangle
echo "85.99 27.34" | gmt psxy $Reg $Pro -Si0.5i -Gred -W3p,red -O -K >> $ps

# Step 8: Plot the locations from location.dat as filled blue circles
awk '{print $2, $1}' location.dat | gmt psxy $Reg $Pro -Sx0.5i -Gblue -W3,purple -O >> $ps
# Step 8: Label the cities
# gmt pstext cities.dat $Reg $Pro -F+f10p,Times-Roman+jRT -D0.1i/0.1i -O -K >> $ps

okular answer.ps

# Step 9: Finalize the PostScript file
# gmt gmtshow $ps

# The commented out showpage command is replaced with a gmtshow command to display the generated file. You could also just remove it if you don't want to show the file.
