# package for ploting functions
using Plots
# use GR
gr()

# range to plot unit circle
t = range(0, stop = 1, length = 200)
theta = (6*pi) .* t
x = cos.(theta)
y = sin.(theta)

# define a = 0.5 + 0.7i
a = ( 0.5, 0.7 );
# define b = 1.5 + 1i
b = ( 1.5, 1.0 );

function conjugate(z)
    return (0,0) ###... <-- EXERCISE 3(c): implement the conjugate of z
end

function reciprocal(z)
    return (0,0) ###... <-- EXERCISE 3(c): implement the reciprocal of z 
end

# calculate conjugates and add them to the array
conj_a = conjugate(a);
conj_b = conjugate(b);

# calculate reciprocals and add them to the array
recip_a = reciprocal(a);
recip_b = reciprocal(b);

# Plot a
plt1 = plot([0, a[1]], [0, a[2]], color=:red, xlim = (0, 2.5),  ylim = (-1.5, 1.5), label="a",  marker =:circle, arrow=true, arrowsize=0.5);
plot!( plt1, [0, conj_a[1]], [0, conj_a[2]], color=:blue, label="conj(a)" ,  marker =:circle, arrow=true, arrowsize=0.5);
plot!( plt1, [0, recip_a[1]], [0, recip_a[2]], color=:green, label="1/a" ,  marker =:circle, arrow=true, arrowsize=0.5);
plot!( plt1, x, y, linewidth = 0.5, color=:black, label = "unit circle")

# Plot b
plt2 = plot( [0, b[1]], [0, b[2]], color=:red, xlim = (0, 2.5),  ylim = (-1.5, 1.5), label="b",  marker =:circle, arrow=true, arrowsize=0.5);
plot!( plt2, [0, conj_b[1]], [0, conj_b[2]], color=:blue, label="conj(b)" ,  marker =:circle, arrow=true, arrowsize=0.5);
plot!( plt2, [0, recip_b[1]], [0, recip_b[2]], color=:green, label="1/b" ,  marker =:circle, arrow=true, arrowsize=0.5);
plot!( plt2, x, y, linewidth = 0.5, color=:black, label = "unit circle")

# arrange and display
display( plot(plt1, plt2, size=(560, 300)));

