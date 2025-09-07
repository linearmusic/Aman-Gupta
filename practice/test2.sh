#!/bin/sh
Reg=-R113/160/-38/-12
Pro=-Jm0.5
GRD=topo30.grd
CPT=aman.cpt
ps=australia.ps
gmt grdcut $GRD $Reg -Gtmp1.grd -V
gmt grdsample tmp1.grd -Gtmp.grd -I4m -r -V
gmt grdgradient tmp.grd -A315 -Ggradient.grd -Nt -V
gmt pscoast $Reg $Pro -B2g2 -Slightblue -K > $ps
gmt grdimage tmp.grd $Reg $Pro -C$CPT -Igradient.grd -O -K >> $ps
gmt pscoast $Reg $Pro -W0.25p,black -Ia/0.3p,blue -Ib/0.2p,blue -O >> $ps
echo "showpage" >> $ps
okular $ps