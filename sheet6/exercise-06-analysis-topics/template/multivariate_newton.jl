"Newton's method generalized to multiple variables."
function multivariate_newton(func::Function, jacobian::Function, x_0::Vector, iter_max::Int=16)::Vector
    x_1 = x_0
    iter = 0
    converged = false

    while !converged && iter < iter_max
        # your update rule here
        iter += 1
    end
    return x_1
end


"Jacobian of function f."
function jacobian_f(x)
    return # your code here
end


"Jacobian of function g."
function jacobian_g(x)
    return # your code here
end


"Jacobian of function h."
function jacobian_h(x)
    return # your code here
end
