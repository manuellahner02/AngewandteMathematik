using Distributions
using Plots

# Helper
scale(sequence::Vector{Float64}, a::Float64=0.0, b::Float64=1.0)::Vector{Float64} = map(x -> x*(b-a)+a, sequence)

# Parameters
f(x) = exp(-(x^2))
a = 0.0 
b = 1.0

# TASKS

# 2a)
function mc_integration(a::Float64, b::Float64, N::Int, sequence::Vector{Float64})::Float64
    # HINT: halton::Vector{::Float64} -> 4096 pairs of x values
    y = map(x -> f(x), sequence[1:N])
    s = sum(y)
    return (b-a)/float(N)*s
end

# 2b)
function mc_integration_rs(a::Float64, b::Float64, N::Int, sequence2D)::Float64
    y_values = f.(sequence2D[1][1:N])
    
    inCount = 0
    
    for i in 1:N
        if sequence2D[2][i] <= y_values[i]
            inCount += 1
        end
    end
    
    return (b-a)/float(N)*inCount
end

# RESULTS
module Uniform
    name = "rand()"
    distribution = include("integration_uniform_1.jl")
    distribution2D = include("integration_uniform_2.jl")
end

module MiddleSquare
    name = "MiddleSquare"
    distribution = include("integration_mid_square_1.jl")
    distribution2D = include("integration_mid_square_2.jl")
end

module Halton
    name = "Halton"
    distribution = include("integration_halton_1.jl")
    distribution2D = include("integration_halton_2.jl")
end

module Urand
    name = "urand"
    distribution = include("integration_urand_1.jl")
    distribution2D = include("integration_urand_2.jl")
end

x = collect(a-1:(b+1)/256:b+1)
y = f.(x)
wolframalpha = 0.746824 


modules = [Uniform, MiddleSquare, Halton, Urand]
plot_list = [ ] 
for m = modules
    solution_mc_integration = mc_integration(a, b, 256, scale(m.distribution, a, b))
    m.distribution2D[1] = scale(m.distribution2D[1], a, b)
    solution_mc_integration_rs = mc_integration_rs(a, b, 256, m.distribution2D)

    println(m.name, "-----------------------------------------------")
    println("Wolframalpha Solution: \t\t\t", wolframalpha)
    println("MC Integration Solution: \t\t", solution_mc_integration)
    println("MC Integration Rejection Sampling Solution: \t", solution_mc_integration_rs)

    # PLOTTING
    p1 = plot(x, y, label="f(x)", title=m.name)
    scatter!(m.distribution[1:32], f.(m.distribution[1:32]), label="f(x_i)")

    # 3c) intuitive extension for above solution_mc_integration... 

    p2 = plot(x, y, label="f(x)", title=m.name)
    scatter!(m.distribution2D[1][1:128], m.distribution2D[2][1:128], label="p")

    # 3c) intuitive extension for above solution_mc_integration_rs... 

    append!(plot_list, [p1,p2])
end

p = plot(plot_list..., layout = grid(4,2), size = (1200,800))
savefig(p, "integration.pdf")
display(p)