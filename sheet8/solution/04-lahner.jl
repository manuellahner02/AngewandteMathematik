using Distributions
using Plots

N = 4096*2 

U(a,b) = rand(Uniform(a,b), N)

module Example
    a=0
    b=1
    f="sin(x)/2"
    pdf(x) = sin(x)/2
    cdf(x) = (-cos(x)+1)/2
    inverse(x) = acos(1-2*x)
end
# TODO:
module A
    a = 0
    b = 1 
    f = "1/(3x^(2/3))"
    pdf(x) = 1/(3*(x^(2/3)))
    cdf(x) = x^(1/3)
    inverse(x) = x^3
end

# TODO:
module B 
    a = 0
    b = 1 
    f = "(pi*e^(-x))/4 + pi*e^(x))/4"
    pdf(x) = (pi*exp(-x) + pi*exp(x))/4 
    cdf(x) = (-pi*exp(-x) + pi*exp(x))/4
    inverse(x) = log((4x+sqrt(16x^2+4*pi^2))/2pi)
end

# plot helper
function plot_transformation(a,b,pdf,cdf,inverse,title)
    dist = U(a,b)
    i = inverse.(dist)
    x = minimum(i):10^-3:maximum(i)
    plot(
        plot(x, pdf.(x), title=title, framestyle=:origin),
        plot(x, cdf.(x), title="f_CDF(x)", framestyle=:origin),
        histogram(i, title="transformation", framestyle=:origin),
        histogram(cdf.(i), title="re-transformation", framestyle=:origin), # TODO: retrieve uniform distribution
        legend = false,
        layout = grid(1,4),
        size = (1200,300),
    )
end

modules = [ Example, A, B ]
plots = [plot_transformation(m.a,m.b,m.pdf,m.cdf,m.inverse,m.f) for m = modules]

# display distribution
nPlots = length(modules)
p = plot(plots..., layout = grid(nPlots,1), size = (1200, nPlots*300))
savefig(p,"its.pdf")
display(p)
