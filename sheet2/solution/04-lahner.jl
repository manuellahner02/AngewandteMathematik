using Plots, Base

function plot_function(fct, x_min, x_max, step_size)
    plot(x_min:step_size:x_max, map(fct, x_min:step_size:x_max))
end

f1(x) = 3x^2 - x - 7
f1d = "f(x) = 3x^2 - x - 7"
f1p = plot_function(f1, -5.0, 5.0, 0.01)

f2(x) = (7 / 5)^x - 0.5 * x^3
f2d = "f(x) = (7/5)^x-0.5*x^3"
f2p = plot_function(f2, -2.0, 2.0, 0.01)

f3(x) = 3 * sin(x) + cos(10 * x) * (1 / 3) * sin(x)
f3d = "f(x) = 3sin(x)+cos(10x)*(1/3)*sin(x)"
f3p = plot_function(f3, -6.0, 6.0, 0.01)

f4(x) = abs(abs(abs(abs(x) - 1) - 1) - 1)
f4d = "f(x) = abs(abs(abs(abs(x) - 1) - 1) - 1)"
f4p = plot_function(f4, -10.0, 10.0, 0.01)

f5(x) = 1 / x
f5d = "f(x) = 1 / x"
f5p = plot_function(f5, -2.0, 2.0, 0.01)

f6(x) = log(abs(x - 1))
f6d = "f(x) = log(abs(x - 1))"
f6p = plot_function(f6, -10.0, 12.0, 0.01)

plot(f1p, f2p, f3p, f4p, f5p, f6p, layout=6, title=[f1d f2d f3d f4d f5d f6d],
    titlefont=font(8), legend=false)
