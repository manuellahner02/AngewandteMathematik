"Newton's method generalized to multiple variables."
function multivariate_newton(func::Function, jacobian::Function, x_0::Vector, iter_max::Int=16)::Vector
   
    x_1 = x_0
    iter = 0
    converged = false

    while !converged && iter < iter_max
        x_new = x_1 - (jacobian(x_1) \ func(x_1))
        x_1 = x_new
        iter += 1
    end
    return x_1
end


"Jacobian of function f."
function jacobian_f(x)
    return [2*x[1]-1 2*x[2]-1]
end


"Jacobian of function g."
function jacobian_g(x)
    return [4*(x[1]^3) 0; 0 1/x[2]]
end


"Jacobian of function h."
function jacobian_h(x)
    return [3(x[1]^2)*(x[2]^3)+1 3(x[1]^3)*(x[2]^2)-2; 3/2*(x[1]^2)+(x[2]^3) 3*(x[1])*(x[2]^2)]
end
