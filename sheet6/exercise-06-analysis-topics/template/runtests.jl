using Test


include("multivariate_newton.jl")

function f(x)
    return [x[1]^2 - x[1] + x[2]^2 - x[2]]
end

function g(x)
    return [x[1]^4; log(x[2])]
end


function h(x)
    return [x[1]^3*x[2]^3 - 2*x[2] + x[1] + 4; (1/2) * x[1]^3 + x[1]*x[2]^3 - 5]
end


@testset "Newton's method for roots" begin
    @testset "searching in two dimensions" begin
        @test isapprox(multivariate_newton(f, jacobian_f, [2, 2]), [1, 1]; atol=1e-3)
        @test isapprox(multivariate_newton(g, jacobian_g, [2, 0.5]), [0.020045191515237093, 1.0]; atol=1e-3)
        @test isapprox(multivariate_newton(h, jacobian_h, [3, 3]), [0.3375971095998547, 2.4526317652409433]; atol=1e-3)
    end
end
