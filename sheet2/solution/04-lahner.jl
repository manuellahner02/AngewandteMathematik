using Plots, Base

function plot_function(fct, x_min, x_max, step_size)
    plot(x_min:step_size:x_max, map(fct, x_min:step_size:x_max))
end

fct_1(x) = 3x^2 - x - 7
fct_1_str = "f(x) = 3x^2 - x - 7"
fig_1 = plot_function(fct_1, -5.0, 5.0, 0.01)

fct_2(x) = (7 / 5)^x - 0.5 * x^3
fct_2_str = "f(x) = (7/5)^x-0.5*x^3"
fig_2 = plot_function(fct_2, -2.0, 2.0, 0.01)

fct_3(x) = 3 * sin(x) + cos(10 * x) * (1 / 3) * sin(x)
fct_3_str = "f(x) = 3sin(x)+cos(10x)*(1/3)*sin(x)"
fig_3 = plot_function(fct_3, -6.0, 6.0, 0.01)

fct_4(x) = abs(abs(abs(abs(x) - 1) - 1) - 1)
fct_4_str = "f(x) = abs(abs(abs(abs(x) - 1) - 1) - 1)"
fig_4 = plot_function(fct_4, -10.0, 10.0, 0.01)

fct_5(x) = 1 / x
fct_5_str = "f(x) = 1 / x"
fig_5 = plot_function(fct_5, -2.0, 2.0, 0.01)

fct_6(x) = log(abs(x - 1))
fct_6_str = "f(x) = log(abs(x - 1))"
fig_6 = plot_function(fct_6, -10.0, 12.0, 0.01)

plot(fig_1, fig_2, fig_3, fig_4, fig_5, fig_6, layout=6, title=[fct_1_str fct_2_str fct_3_str fct_4_str fct_5_str fct_6_str],
    titlefont=font(8), legend=false)
