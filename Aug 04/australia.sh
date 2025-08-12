#!/bin/sh

# Region of Australia
Reg=-R113/160/-38/-12

# Projection (mercator)
Pro=-Jm0.5

# Input grid and color palettes
GRD=topo30.grd
CPT=aman.cpt

# Output
ps=australia.ps

# Step 1: Cut the region from the global topo grid
gmt grdcut $GRD $Reg -Gtmp1.grd -V

# Step 2: Resample to 4 arc-minute resolution
gmt grdsample tmp1.grd -Gtmp.grd -I4m -r -nc+c -V

# Step 3: Compute gradient for shading
gmt grdgradient tmp.grd -A315 -Ggradient.grd -Nt -V

# Step 4: Create the base map frame with an ocean fill and start the PostScript file
gmt pscoast $Reg $Pro -B2g2 -Slightblue -K > $ps

# Step 5: Plot the gridded image on top of the base map
gmt grdimage tmp.grd -C$CPT -Igradient.grd -O -K >> $ps

# Step 6: Add coastlines and rivers on top of the image and close the file
gmt pscoast $Reg $Pro -Q -W0.25p,black -Ia/0.3p,blue -O >> $ps
