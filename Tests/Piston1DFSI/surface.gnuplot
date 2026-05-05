# Output (JPEG format)
set terminal jpeg enhanced font "Arial,36" size 1800,1200
set output "disp_pressure_plot.jpg"

# General styling
set border linewidth 2
set tics font "Arial,36"
set key font "Arial,36"
set key top right box linewidth 1.0

# Slightly larger legend (key)
set key font "Arial,32"
set key spacing 1.5
set key samplen 2.5
set key top right box linewidth 1.2


# Axis labels
set xlabel "Time (ms)" font "Arial,36"
set ylabel "Displacement (mm)" font "Arial,36" offset 1,0
set y2label "Force (mN)" font "Arial,36" offset -1,0

# Enable secondary y-axis
set y2tics
set ytics nomirror

# Line styles with markers
set style line 1 lc rgb "black" lw 5 pt 7 ps 2   # displacement (circle)
set style line 2 lc rgb "blue"  lw 5 pt 5 ps 2   # pressure (square)

# Grid
set grid lw 2 dt 2

# Plot with reduced marker density
plot \
    "results/disp.0"  using (1000*$1):2               with linespoints ls 1 pi 20 title "Displacement", \
    "results/force.0" using (1000*$1):(3.0/1000.0*$2) axes x1y2 \
                                      with linespoints ls 2 pi 20 title "Force"

unset output
