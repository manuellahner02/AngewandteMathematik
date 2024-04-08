using Plots

function plot_results(func, path, axis, label)
    pSurface = surface(axis, axis, func, camera=(45, 45), c = :heat, xlabel = "x", ylabel= "y", title=label, colorbar = false)
    plot!(pSurface, path[:, 1], path[:, 2], func.(path[:, 1], path[:, 2]), color = :blue, linewidth=2, label="search path")
    scatter!(pSurface, [path[1, 1]], [path[1, 2]], [func(path[1, :]...)], markersize=7, color=:blue, label="start")
    scatter!(pSurface, [path[end, 1]], [path[end, 2]], [func(path[end, :]...)], markersize=7, color=:red, label="found minimum")

    pHeatmap = heatmap(axis, axis, func, c = :heat, xlabel = "x", ylabel= "y", legend=false, colorbar=true)
    contour!(pHeatmap, axis, axis, func)
    plot!(pHeatmap, path[:, 1], path[:, 2], linewidth=3, color = :blue)
    scatter!(pHeatmap, [path[1, 1]], [path[1, 2]], markersize=7, color=:blue)
    scatter!(pHeatmap, [path[end, 1]], [path[end, 2]], markersize=7, color=:red)

    combined = plot(pSurface, pHeatmap, layout = (1, 2))
    combined
end;

function gradient_descent(start::Array{Float64, 1}, func_grad, gamma::Float64, iter::Integer)
    path = zeros((iter, 2))

    x = start
    for i = 1:iter
        path[i, :] = x
        x = update_step(x, func_grad, gamma)
    end

    path
end;

# -----------------------[ Exercise 4 ]------------------------------

function update_step(x::Array{Float64, 1}, func_grad, gamma::Float64)::Array{Float64, 1}
    # TODO: Implement the update step of gradient descent (Equation 1) i.e. compute the next point based on the gradient.

    x
end

# TODO: Implement the functions f, g, h and their gradients.
f(x, y) = x + y
f_gradient(x, y) = [1, 1]

g(x, y) =  x + y
g_gradient(x, y) = [1, 1]

h(x, y) =  x + y
h_gradient(x, y) = [1, 1]

# -----------------------[ Exercise 4 ]------------------------------


f_results = gradient_descent([-2.0, 2.0], f_gradient, 0.0025, 200)
g_results = gradient_descent([2.0, -1.0], g_gradient, 0.1, 200)
h_results = gradient_descent([1.0, 0.5], h_gradient, 0.1, 200)

plt = plot(
    plot_results(f, f_results, -2:0.05:2, "f(x, y)"),
    plot_results(g, g_results, -2.5:0.1:2.5, "g(x, y)"),
    plot_results(h, h_results, -3:0.1:3, "h(x, y)"),
    layout = (3, 1), size=(340*3, 350*3))

savefig(plt, "gradient_descent.png")
display(plt)