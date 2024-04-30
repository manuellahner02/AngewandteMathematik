# package for ploting functions
using Plots

X = range(0.001, stop=2.3, length=256)

### <-- Aufgabe 4(b): Funktion eingeben.
# 1/sqrt(x) approximation using Taylor series
function inverseSquareRootApprox(x, n)
	return 0;
end

### <-- Aufgabe 4(c): Errorfunktion implementieren.
function error(x, n)
	return 0;
end


# plot real 1/sqrt(x)
plt1 = plot(X, x -> 1/sqrt(x), color=:blue, lw = 3, label="1/sqrt(x)" );

n = 2;
# plot taylor series for n=2
plot!(plt1, X, inverseSquareRootApprox.(X, n), color=:orange, lw = 3, label="n=2");
# plot error
plt2 = plot(X, error.(X, n), color=:orange, label="error n=2");

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