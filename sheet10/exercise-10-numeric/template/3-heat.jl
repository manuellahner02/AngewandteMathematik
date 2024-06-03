using Plots

module HeatEquationSolver

function initializeXs(border_l::Float64, border_r::Float64, N_grid_points::Int)::Tuple{Float64, Vector}
    # Setup range for space grid
    xs = range(border_l, length=N_grid_points+1, stop=border_r)
    # Get step size for space grid.
    h = step(xs)
    h, xs
end

function initializeUs(xs::Vector, f_init::Function, boundary_l::Float64, boundary_r::Float64)::Vector
    # Initialize u values at space grid points for time step 0.
    us_init = f_init.(xs)

    # Set boundary conditions.
    us_init[1] = boundary_l
    us_init[end] = boundary_r
    us_init
end

function explicitStep(us::Vector, h::Float64, tau::Float64)::Vector
    #TODO 3b) Implement update step of explicit numerical method derived in exercise 4a.
    # Function should return new values for all us at next time step.
    # Hint: Make sure to consider the boundaries at us[1] and us[end].
    us
end

function solveOverTime(border_l::Float64, border_r::Float64, N_grid_points::Int, f_init::Function, boundary_l::Float64, boundary_r::Float64, N_time_steps::Int, tau::Float64)::Tuple{Vector, Vector, Array}
    # Initialize space grid points
    h, xs = initializeXs(border_l, border_r, N_grid_points)

    # Initialize time grid points
    ts = range(0.0, length=N_time_steps+1, step=tau)

    # Initialize u values on space grid points for time step 0.
    us_init = initializeUs(xs, f_init, boundary_l, boundary_r)

    # Initialize array to store u values over time.
    us_over_time = zeros(Float64, (length(us_init), N_time_steps+1))

    # Add initial us to array.
    us_over_time[:, 1] = us_init

    # Iterate over time steps and perform explicit update steps. Store the resulting us in array.
    for t in 1:N_time_steps
        us_over_time[:, t+1] = explicitStep(us_over_time[:, t], h, tau)
    end

    # Return x grid points, t grid points and us over time.
    xs, ts, us_over_time
end
end

function plotOverTime(border_l::Float64, border_r::Float64, N_grid_points::Int, f_init::Function, boundary_l::Float64, boundary_r::Float64, N_time_steps::Int, tau::Float64)
    xs, ts, us_over_time = HeatEquationSolver.solveOverTime(border_l, border_r, N_grid_points, f_init, boundary_l, boundary_r, N_time_steps, tau)
    plt_1D = plot(xs, us_over_time[:, 1], legend=true, xlabel="x", ylabel="u(x, t)", linewidth=3, color=:blue, label="t=" * string(ts[1]))

    for t in 2:10:(N_time_steps+1)
        plot!(plt_1D, xs, us_over_time[:, t], color=:red, label="")
    end
    plot!(plt_1D, xs, us_over_time[:, end], linewidth=3, label="t=" * string(ts[end]))

    plt_2D = heatmap(ts, xs, us_over_time, xlabel="t", ylabel="x", colorbar_title="u(x, t)")
    plot(plt_1D, plt_2D, size=(1000, 900), layout=(2, 1))
end

u_init(x) = x^2-abs(x)

border_l = -1.0
border_r = 1.0
N_grid_points = 40
boundary = 1.0
tau = 0.001
N_time_steps = 1000
plt = plotOverTime(border_l, border_r, N_grid_points, u_init, boundary, boundary, N_time_steps, tau)
display(plt)
