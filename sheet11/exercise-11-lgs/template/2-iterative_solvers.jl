using LinearAlgebra

function stepJacobi!(x_next::Vector, A::Matrix, b::Vector, x::Vector)
    # 2b TODO: implement the Jacobi iteration
end

#------------------------------ [ Exercise 2 ] ------------------------------
function stepGaußSeidel!(x::Vector, A::Matrix, b::Vector)
    for i in eachindex(x)
        @views x[i] = (1.0 / A[i, i]) * (b[i] - dot(A[i, :], x) + A[i, i]*x[i])
    end
end

function stepSOR!(x::Vector, A::Matrix, b::Vector, omega)
    # 2b TODO: implement the Successive Over-Relaxation iteration
end

function errorNorm(A::Matrix, b::Vector, x::Vector)
     # 2c TODO: implement the euclidean norm of the residual (you are allowed to use functions from LinearAlgebra)
    1e4
end
#------------------------------ [ Exercise 2 ] ------------------------------


# -------------------------- Iterative Solver ------------------------------
mutable struct SolverData{MatType, VecType}
    A::MatType
    b::VecType
    x::VecType
    x_next::VecType
end

function solveIterative!(solver!::Function, data::SolverData, maxiter, epsilon)
    r = zeros(maxiter)

    iter = 2
    r[1] = errorNorm(data.A, data.b, data.x)

    while iter <= maxiter && r[iter-1] > epsilon

        solver!(data.x_next, data.A, data.b, data.x)
        data.x_next, data.x = data.x, data.x_next

        r[iter] = errorNorm(data.A, data.b, data.x)
        iter += 1
    end

    data.x, r[1:iter-1]
end

# -------------------------- Solver Definitions --------------------------
function jacobi(A::Matrix, b::Vector, maxiter = 100, epsilon = 1e-8)
    x = zeros(length(b))
    solveIterative!(stepJacobi!, SolverData(A, b, x, similar(x)), maxiter, epsilon)
end

function gaußSeidel(A::Matrix, b::Vector, maxiter = 100, epsilon = 1e-8)
    x = zeros(length(b))
    solveIterative!((x_, A, b, x) -> stepGaußSeidel!(x_, A, b), SolverData(A, b, x, x), maxiter, epsilon)
end

function successiveOverRelaxation(A::Matrix, b::Vector, maxiter = 100, epsilon = 1e-8)
    x = zeros(length(b))
    
    # compute optimal relaxation parameter (based on spectral radius)
    M = inv( Diagonal(A) ) * ( A - Diagonal(A) )
    sradius = maximum(eigvals(M))
    omega = 1.0 + sradius^2 / (1 + sqrt(1 - sradius^2))^2

    solveIterative!((x_, A, b, x) -> stepSOR!(x_, A, b, omega), SolverData(A, b, x, x), maxiter, epsilon)
end

# -------------------------- Tests ------------------------------
begin
    A = [ 4.0 -1 -1 0; -1 4 0 -1; -1 0 4 -1; 0 -1 -1 4 ]
    b = [ 0.0; 3; 3; 0 ]

    @assert isapprox( jacobi(A, b)[1], A \ b)
    @assert isapprox( gaußSeidel(A, b)[1], A \ b )
    @assert isapprox( successiveOverRelaxation(A, b)[1], A \ b)
end
# -------------------------- Tests ------------------------------
