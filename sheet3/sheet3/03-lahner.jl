using Plots
using Base.MathConstants
e = Base.MathConstants.e

function plot_results(func, x, start, root, label)
    pLine = plot(x, func, xlabel="x", ylabel="y", label="", legend=:bottomright, title=label)
    plot!(pLine, [0], seriestype="hline", label="")
    scatter!(pLine, [start], [func(start)], color=:blue, label="start")
    scatter!(pLine, [root], [func(root)], color=:red, label="root")
end;


# -----------------------[ Exercise 3 ]------------------------------

function newton_method(func, func_prime, start::Float64, iter::Integer)::Float64
    x = start

    for i in 1:iter
        x = x - func(x)/func_prime(x)
    end

    x
end;

# TODO: Implement the functions f, g, h and their derivatives

f = (x) -> x^3/3 -x +6
f_prime = (x) -> x^2 -1

g = (x) -> (0.7*e^x-0.5)/(e^x+1)
g_prime = (x) -> (0.7*e^x*(e^x+1)-(0.7*e^x-0.5)*e^x)/(e^x+1)^2

h = (x) -> (3*x^2-sin(x))*e^(1-x^2)+0.1
h_prime = (x) -> e^(1-x^2)*(6*x-6*x^3-cos(x)-2*x*sin(x))

# -----------------------[ Exercise 3 ]------------------------------


f_root = newton_method(f, f_prime, 3.0, 10)
g1_root = newton_method(g, g_prime, 2.5, 10)
g2_root = newton_method(g, g_prime, 1.0, 10)
h_root = newton_method(h, h_prime, 1/2, 10)

plt = plot(
        plot_results(f, -5:0.1:5, 3.0, f_root, "f(x)"),
        plot_results(g, -5:0.1:5, 2.5, g1_root, "g(x)"),
        plot_results(g, -5:0.1:5, 1.0, g2_root, "g(x)"),
        plot_results(h, -5:0.1:5, 1/2, h_root, "h(x)"),
        layout = (4, 1), size=(600, 300*3)
        )

savefig(plt, "newton.png")
display(plt)