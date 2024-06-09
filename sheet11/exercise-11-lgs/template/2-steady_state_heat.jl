using LinearAlgebra
using Plots

include("2-iterative_solvers.jl")

function calculateGridRange(s_pos::Int, e_pos::Int, cell_size::Number)
    s_cell = ceil( cell_size*(s_pos-1) + 1.0 )
    e_cell = floor( cell_size * e_pos )
    range( Int( s_cell ), stop = Int( e_cell ) )
end

#---------------------- Discretization Matrix ----------------------
N = 20

D = Matrix{Float64}(4.0*I, N-2, N-2)
D[diagind(D, 1)] .= -1
D[diagind(D, -1)] .= -1

A = kron(Matrix{Float64}(I, N-2, N-2), D)
A[diagind(A, N-2)] .= -1
A[diagind(A, -(N-2))] .= -1

u = zeros( N, N )

#------------------------- Boundaries -----------------------------
walltemp = 18.0
heatertemp = 30.0
windowtemp = 10.0
doortemp = 20.0

u[:, 1] .= walltemp
u[:, end] .= walltemp
u[1, :] .= walltemp
u[end, :] .= walltemp

_N = (N/10.0)
bWindow_1 = calculateGridRange(3, 8, _N)
bWindow_2 = calculateGridRange(2, 5, _N)
bHeater_1 = calculateGridRange(2, 4, _N)
bHeater_2 = calculateGridRange(4, 7, _N)
bHeater_3 = calculateGridRange(7, 9, _N)
bDoor = calculateGridRange(7, 9, _N)

u[1, bWindow_1] .= windowtemp
u[bWindow_2, end] .= windowtemp
u[bHeater_1, 1] .= heatertemp
u[end, bHeater_2] .= heatertemp
u[bHeater_3, end] .= heatertemp
u[bDoor, 1] .= doortemp

#---------------- solution vector and rhs vector ------------------
x = vec( @view u[2:end-1, 2:end-1] )

# rhs vector (added boundary conditions)
b = zeros( N - 2, N - 2 )
b[:, 1] += u[2:end-1, 1]
b[:, end] += u[2:end-1, end]
b[1, :] += u[1, 2:end-1]
b[end, :] += u[end, 2:end-1]

b = vec(b);

#--------------------------- Solve Laplace Equation -------------------------
#------------------------------ [ Exercise 2 ] ------------------------------
# TODO: Solve the Laplace Equation with jacobi and successiveOverRelaxation

@time x[:, :], r_g = gaußSeidel(A, b, 1000)

plt_conv = plot(r_g, label="Gauß-Seidel", title="Convergence for N="*string(N), aspect_ratio=:equal,
                xlabel="iterations", ylabel="residual norm", width=3,
                yaxis=:log10, xlim=(0, 1000), ylims=(1e-8, 10^3)
            )
# TODO: Extend plt_conv to show convergence of Jacobi and successiveOverRelaxation

plt = plot(
    heatmap(u, c=:thermal, aspect_ratio=:equal, axis=nothing, title="Temperature"),

    surface(1:N, 1:N, u, zlabel="Temperature", camera=(45, 45), fillalpha=0.9, colorbar=false),
    plt_conv,
    layout = (1, 3), size=(480*3, 480)
    )

display(plt)
#------------------------------ [ Exercise 2 ] ------------------------------
