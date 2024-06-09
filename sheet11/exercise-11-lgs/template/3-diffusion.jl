using LinearAlgebra
using Plots


function initializeXs(border_l::Float64, border_r::Float64, N_grid_points::Int)::Tuple{Float64, Vector}
    # Setup range for space grid
    xs = range(border_l, length=N_grid_points+1, stop=border_r)
    # Get step size for space grid.
    h = step(xs)
    h, xs
end

function initializeTs(start_t::Float64, end_t::Float64, N_time_steps::Int)::Tuple{Float64, Vector}
    # Setup range for time steps
    ts = range(start_t, length=N_time_steps+1, stop=end_t)
    # Get step size for time steps.
    tau = step(ts)
    tau, ts
end

function initializeUs(xs::Vector, f_init::Function, boundary_l::Float64, boundary_r::Float64)::Vector
    # Initialize u values at space grid points for time step 0.
    us_init = f_init.(xs)

    # Set boundary conditions.
    us_init[1] = boundary_l
    us_init[end] = boundary_r
    us_init
end

function plotResult(xs::Vector, ts::Vector, us::Matrix, N_plot_steps::Int, title::String)
    steps2plot = range(start=1, step=ceil(Int, (length(ts) - 1) / (N_plot_steps - 1)), stop=length(ts))

    p_u = plot(xs, us[:, steps2plot], xlabel="x", ylabel="u", color=:red, width=1, label=false)
    plot!(p_u, xs, us[:, 1], color=:blue, width=3, label="initial t="*string(ts[1]))
    plot!(p_u, xs, us[:, end], color=:lightblue, width=3, label="final t="*string(ts[end]))
    p_us = surface(
                   xs, ts[steps2plot], us[:, steps2plot]',
                   xlabel="x", ylabel="time", zlabel="u", camera=(45, 45), fillalpha=0.9, colorbar=false
                  )
    plot(p_u, p_us, layout=(1, 2), size=(480*2, 490), title=title)
end

# -------------------- Explicit Solver Step ------------------------
function explicitStep(us::Vector, h::Float64, tau::Float64, alpha::Float64)::Vector
    grid_size = length(us)
    # Create array for new us at next time step.
    us_new = zeros(Float64, grid_size)
    # Set boundary conditions.
    us_new[1] = us[1]
    us_new[end] = us[end]
    # Update all us using explicit step.
    for i in 2:(grid_size-1)
        us_new[i] = us[i] + tau * alpha / h^2 * (us[i+1] - 2*us[i] + us[i-1])
    end
    us_new
end

# -------------------- Implicit Solver Step -----------------------
#--------------------- [ Exercise 3 ] -----------------------------
function implicitStep(us::Vector, h::Float64, tau::Float64, alpha::Float64)::Vector
    # Create copy of us of previous timestep for new us
    us_new = copy(us)

    # TODO: setup system matrix for implicit Euler
    
    # TODO: update nodes next to boundary to include boundary values in the calculation.

    # TODO: solve for the new values of u (you can use the backslash operator)

    us_new
end
#--------------------- [ Exercise 3 ] -----------------------------

# -------------------- Solver Over Time ---------------------------
function solveOverTime(border_l::Float64, border_r::Float64, N_grid_points::Int, f_init::Function, boundary_l::Float64, boundary_r::Float64, N_time_steps::Int, end_t::Float64, f_solver_step::Function)::Tuple{Vector, Vector, Array}
    # initialize space grid points and time steps
    h, xs = initializeXs(border_l, border_r, N_grid_points)
    tau, ts = initializeTs(0.0, end_t, N_time_steps)

    # Initialize u values on space grid points for time step 0.
    us_init = initializeUs(xs, f_init, boundary_l, boundary_r)

    # Initialize array to store u values over time.
    us_over_time = zeros(Float64, (length(us_init), N_time_steps+1))

    # Add initial us to array.
    us_over_time[:, 1] = us_init

    # Iterate over time steps and perform update steps using f_solver_step function. Store the resulting us in array.
    for t in 1:N_time_steps
        # ts[t+1] = t * tau
        us_over_time[:, t+1] = f_solver_step(us_over_time[:, t], h, tau, alpha)
    end

    # Return x grid points, t grid points and us over time.
    xs, ts, us_over_time
end


#--------------------- Parameters ---------------------------------
u_init(x) = x^2-abs(x)
boundary = 1.0

border_l = -1.0
border_r = 1.0
end_time = 1.0
alpha = 1.0
N_grid_points = 40
N_time_steps = 1000


#-------------------- Solve system over time ----------------------
xs, ts, us_exp = solveOverTime(border_l, border_r, N_grid_points, u_init, boundary, boundary, N_time_steps, end_time, explicitStep)
#--------------------- [ Exercise 3 ] -----------------------------
# TODO: call implicit euler


#--------------------- [ Exercise 3 ] -----------------------------

#------------------------ Plot Results ----------------------------
plt = plotResult(xs, ts, us_exp, 20, "Diffusion - Explicit Euler")

# TODO: use to plot both results in one figure
# plt_impl = plotResult(xs, ts, us_impl, 20, "Diffusion - Implicit Euler")
# plt = plot(plt, plt_impl, layout=(2, 1), size=(490*2, 500*2))

# savefig(plt, "diffusion_result.png")
display(plt)
