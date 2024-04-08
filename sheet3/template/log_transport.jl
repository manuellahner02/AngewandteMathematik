using Plots

# parameters of extremum problem
river_length = 500
boat_speed = 18
land_speed = 13
inland_up = 200
inland_down = 100

# -----------------------[ Exercise 2 ]------------------------------
# TODO: Implement the functions for computing the transportation time

f(x) = (500-x)/18 + sqrt(x^2 +200^2)/13
f(x, y) = (500-x-y)/18 + sqrt(x^2 +200^2)/13 + sqrt(y^2 +100^2)/13

# -----------------------[ Exercise 2 ]------------------------------

x = 0:1:river_length

plot_1d = plot(x, f, xlabel = "x", ylabel= "hours", label="")

plot_2d = heatmap(x, x, f, c = :heat, xlabel = "x", ylabel= "y", zlabel="hours")
contour!(plot_2d, x, x, f)

plt = plot(plot_1d, plot_2d, title="Transportation time"; size=(1200, 480))

savefig(plt, "log_transport.png")
display(plt)