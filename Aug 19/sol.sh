#!/bin/bash
set -euo pipefail

# Define the region for the Indian subcontinent.
REGION="70/90/5/35"

# Polar stereographic projection (classic mode).
PROJECTION="s0/90/4.5i/60"

# Output PostScript file
OUTPUT="ans.ps"
rm -f "$OUTPUT"

# 1. Plot the country boundaries and coastlines in black.
gmt pscoast -R$REGION -J$PROJECTION -Di -Bafg \
  -N1/0.5p,black -N2/0.5p,black -A2000 -p180 -K > "$OUTPUT"

# 2. Plot all river levels in neon green.
gmt pscoast -R$REGION -J$PROJECTION -I1/0.5p,0/255/0 -O -K -p180 >> "$OUTPUT"
gmt pscoast -R$REGION -J$PROJECTION -I2/0.25p,0/255/0 -O -K -p180 >> "$OUTPUT"
gmt pscoast -R$REGION -J$PROJECTION -I3/0.25p,0/255/0 -O -K -p180 >> "$OUTPUT"

# 3. Plot the major cities and labels.
cat << EOF > cities.tmp
77.21 28.61 Delhi
80.94 26.84 Lucknow
88.36 22.57 Kolkata
75.81 26.91 Jaipur
72.58 23.02 Ahmedabad
72.87 19.07 Mumbai
73.85 18.52 Pune
78.48 17.38 Hyderabad
77.59 12.97 Bangalore
80.27 13.08 Chennai
EOF

gmt psxy -R$REGION -J$PROJECTION cities.tmp -Sc0.1c -Gred -O -K -p180 >> "$OUTPUT"
gmt pstext -R$REGION -J$PROJECTION cities.tmp -F+f8p,Helvetica-Bold,black+jTL -O -p180 >> "$OUTPUT"

# Clean up
rm -f cities.tmp

echo "Map created as $OUTPUT. Opening in Okular..."
okular "$OUTPUT" >/dev/null 2>&1 &
