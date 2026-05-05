# Output (JPEG format)
set terminal jpeg enhanced font "Arial,36" size 2200,1200
set output "pressure_profiles.jpg"

# General styling
set border linewidth 2
set tics font "Arial,36"

# Legend (key)
set key font "Arial,36"
set key top right box linewidth 1.5
set key spacing 1.3
set key samplen 3

# Axis labels
set xlabel "x (mm)" font "Arial,36"
set ylabel "Pressure (kPa)" font "Arial,36" offset 1,0

# Grid
set grid lw 1.5 dt 2

# Line styles (reusing exact blue from previous figure)
set style line 1 lc rgb "black" lw 5 dt 2          # dashed (0 ms)
set style line 2 lc rgb "blue"  lw 5 pt 7 ps 2   # EXACT same blue as before
set style line 3 lc rgb "#2a6fdb" lw 5 pt 5 ps 2 # darker blue
set style line 4 lc rgb "#4fa3ff" lw 5 pt 9 ps 2 # lighter blue

# Plot (reduced marker density)
plot \
    "results/line_0000.txt" using 1:(0.001*$6) with lines ls 1 title "0 ms", \
    "results/line_0010.txt" using 1:(0.001*$6) with linespoints ls 2 pi 20 title "0.4 ms", \
    "results/line_0025.txt" using 1:(0.001*$6) with linespoints ls 3 pi 20 title "1.0 ms", \
    "results/line_0075.txt" using 1:(0.001*$6) with linespoints ls 4 pi 20 title "3.0 ms"

unset output
