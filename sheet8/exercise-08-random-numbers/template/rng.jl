using Distributions
using Plots

include("urand.jl")

# TODO: 1a)
uniform(N::Int)::Vector{Float64} = [0.0]

# TODO: 1b)
function mid_square(N::Int, seed::Int=34345669)::Vector{Float64}
    [0.0]
end

# TODO: 1c)
function halton(N::Int, base::Int=3)::Vector{Float64}
    [0.0]
end

# 1d)
uniform2D(N::Int)::Vector{Vector{Float64}} = [[0.0], [0.0]]

mid_square2D(N::Int, seed_x::Int=34123169, seed_y::Int=34345669)::Vector{Vector{Float64}} =  [[0.0], [0.0]]

halton2D(N::Int, base_x::Int=3, base_y::Int=5)::Vector{Vector{Float64}} = [[0.0], [0.0]]

urand2D(N::Int)::Vector{Vector{Float64}} = [[0.0], [0.0]]

# display
N = 256

# 1D
sequence_uniform = uniform(N)
sequence_mid_square = mid_square(N)
sequence_halton = halton(N)
sequence_urand = urand(N)

# 2D
sequence_uniform2D = uniform2D(N)
sequence_mid_square2D = mid_square2D(N)
sequence_halton2D = halton2D(N)
sequence_urand2D = urand2D(N)

p = plot(
    scatter(sequence_uniform, title="Julia's Uniform rand() 1D", xlabel="Index", ylabel="Value"),
    histogram(sequence_uniform, title="Distribution", xlabel="Value", ylabel="Occurences"),
    scatter(sequence_uniform2D[1], sequence_uniform2D[2], title="Julia's Uniform rand() 2D", xlabel="X-Value", ylabel="Y-Value"),
    scatter(sequence_mid_square, title="Middle-square 1D", xlabel="Index", ylabel="Value"),
    histogram(sequence_mid_square, title="Distribution", xlabel="Value", ylabel="Occurences"),
    scatter(sequence_mid_square2D[1], sequence_mid_square2D[2], title="Middle-square 2D", xlabel="X-Value", ylabel="Y-Value"),
    scatter(sequence_halton, title="Halton Sequence 1D", xlabel="Index", ylabel="Value"),
    histogram(sequence_halton, title="Distribution", xlabel="Value", ylabel="Occurences"),
    scatter(sequence_halton2D[1], sequence_halton2D[2], title="Halton Sequence 2D", xlabel="X-Value", ylabel="Y-Value"),
    scatter(sequence_urand, title="Urand Sequence 1D", xlabel="Index", ylabel="Value"),
    histogram(sequence_urand, title="Distribution", xlabel="Value", ylabel="Occurences"),
    scatter(sequence_urand2D[1], sequence_urand2D[2], title="Urand Sequence 2D", xlabel="X-Value", ylabel="Y-Value"),
    left_margin=10mm,
    legend = false,
    size = (1200,800), 
    layout = grid(4,3)
)

savefig(p, "rng.pdf")
display(p)