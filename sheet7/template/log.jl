# package for ploting functions
using Plots

X = range(0.001, stop=2.3, length=256)

### <-- Aufgabe 4(b): Funktion eingeben.
# 1/sqrt(x) approximation using Taylor series
function inverseSquareRootApprox(x, n)
    result = 0     
    for k in 1:n
        result +=  binomial(-0.5, k) * (x - 1)^k  
        
    end
    return result
end

### <-- Aufgabe 4(c): Errorfunktion implementieren.
function error(x, n)
	return abs(inverseSquareRootApprox(x, n) - 1/sqrt(x))
end


# plot real 1/sqrt(x)
plt1 = plot(X, x -> 1/sqrt(x), color=:blue, lw = 3, label="1/sqrt(x)" );




# plot taylor series for n=2
plot!(plt1, X, inverseSquareRootApprox.(X, 2), color=:orange, lw = 3, label="n=2");
# plot taylor series for n=5
plot!(plt1, X, inverseSquareRootApprox.(X, 5), color=:red, lw = 3, label="n=5");
# plot taylor series for n=20
plot!(plt1, X, inverseSquareRootApprox.(X, 20), color=:violet, lw = 3, label="n=20");



# plot error
plt2 = plot(X, error.(X, 2), color=:orange, label="error n=2");
plot!(plt2, X, error.(X, 5), color=:red, label="error n=5");
plot!(plt2, X, error.(X, 20), color=:violet, label="error n=20");

### <-- EXERCISE 4(b,c): Bereiten Sie hier die Plots vor

# show plots
display( plot( plt1, plt2, layout = (1, 2)))

t1 = time();
# Code block to measure execution time
for i in range(0.2, stop=1.8, length=10000)
	x = 1/sqrt(i)
end
elapsed_time = time() - t1;
println("Zeit genaue Variante  : ", elapsed_time, " s");

t1 = time();
# Code block to measure execution time
for i in range(0.2, stop=1.8, length=10000)
	x = inverseSquareRootApprox(i,2)
end
elapsed_time = time() - t1;
println("Zeit Taylorreihe n=2  : ", elapsed_time, " s");

t1 = time();
# Code block to measure execution time
for i in range(0.2, stop=1.8, length=10000)
	x = inverseSquareRootApprox(i,5)
end
elapsed_time = time() - t1;
println("Zeit Taylorreihe n=5  : ", elapsed_time, " s");

t1 = time();
# Code block to measure execution time
for i in range(0.2, stop=1.8, length=10000)
	x = inverseSquareRootApprox(i,20)
end
elapsed_time = time() - t1;
println("Zeit Taylorreihe n=20 : ", elapsed_time, " s");