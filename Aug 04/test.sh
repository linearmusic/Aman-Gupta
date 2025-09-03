#!/bin/sh
Reg=-R68/100/6/50
Pro=-Jm0.5
ps=aman.ps

CPT=aman.cpt
CPT1=oo.cpt
GRD=INDIA.GRD
gmt grdcut $GRD $Reg $Pro -Gtmp1.grd -V
gmt grdmath -25 tmp1.grd MAX=tmp2.grd
gmt grdsample tmp1.grd -Gtmp.grd -I4m -r -nc+c -V
gmt grdgradient tmp.grd -A315 -Ggradient.grd -Nt -V

gmt grdimage $Reg $Pro tmp.grd -C$CPT -K > $ps

gmt pscoast $Reg $Pro -B2g2 -Na -Ia/0.3,blue -O -K >> $ps
