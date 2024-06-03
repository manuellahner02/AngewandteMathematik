# load plotting library
using Plots
using Plots.Measures

# evaluate a function on 2D uniform grid
function evaluateFunction(N::Int, fun::Function)::Matrix{Float64}
    X = zeros(N, N);
    for i = 1:N
        for j = 1:N
            x = Float64(i)/N - 0.5
            y = Float64(j)/N - 0.5
            X[i,j] = fun(x, y)
        end
    end
    X;
end

function measureTime(runs::Int, N::Int, fun::Function)::Float64
    time = Float64(0.0);
    for i = 1:runs
        time = @elapsed evaluateFunction(N, fun);
    end
    time /= runs;
end

# original polynomial
function f(x::Float64, y::Float64)::Float64
    3*x^9 + 4*x^7*y^7 + 2*y^7 - 4*x^6*y^3 + 7*x^3*y^3 - x*y^2 + 11*y - 21
end

# polynomial after applying Horner's scheme
function h(x::Float64, y::Float64)::Float64
    #TODO bonus c) Implement horner scheme for above polynomial.
    0.0
end

N = 1024
number_runs = 3

avg_runtime_f = measureTime(number_runs, N, f)
println("Original polynomial: Average runtime over ", number_runs, " runs = ", avg_runtime_f)
avg_runtime_h = measureTime(number_runs, N, h)
println("Horner polynomial: Average runtime over ", number_runs, " runs = ", avg_runtime_h)

#TODO bonus c) Implement calculation of speedup
avg_speedup = 0.0
println("Average speedup of function transformed with horner scheme = ", avg_speedup)


# execute function, store result in X and store elapsed time
Xf = evaluateFunction( N, f )
Xh = evaluateFunction( N, h )

# create heat map
plt1 = heatmap( Xf, show_axis=true, title="Result original polynomial")
plt2 = heatmap( Xh, show_axis=true, title="Result horner polynomial")

# compute absolute difference
abs_diff = abs.(Xh .- Xf)
abs_max = maximum(abs_diff)
println("Maximum absolute difference between solutions = ", abs_max)

# create absolute difference plot
plt3 = heatmap(abs_diff, title="Difference between solutions")

plt = plot(plt1, plt2, plt3, size=(1200, 900), layout=(3,1), right_margin=4mm)

# show
display(plt)
