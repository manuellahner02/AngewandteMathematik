# package for plotting functions
using Plots
# use GR
gr()

# 4b)
function c(k)
    # implement the function you received for c_k
    return 0
end

# 4b)
function fourier(x,N)
    # implement fourier according to definition by utilizing your c(k) implementation 
    sum = 0
    for k in -N:N
        sum += 0
    end
    sum
end

# Following section should not be modified

f(x) = mod2pi(x) < pi ? -1.0 : 1.0

X = range(-2*pi, stop=2*pi, length=256)

fourier_k_1( x) = fourier(x,  1)
fourier_k_2( x) = fourier(x,  2)
fourier_k_4( x) = fourier(x,  4)
fourier_k_8( x) = fourier(x,  8)
fourier_k_16(x) = fourier(x, 16)
fourier_k_32(x) = fourier(x, 32)

fourier_1  = fourier_k_1.( X)
fourier_2  = fourier_k_2.( X)
fourier_4  = fourier_k_4.( X)
fourier_8  = fourier_k_8.( X)
fourier_16 = fourier_k_16.(X)
fourier_32 = fourier_k_32.(X)

plt = plot(X, f, color=:red, lw=1, label="squarewave" )
plot!(plt, X, real(fourier_1 ), lw=1, label="complex fourier squarewave N=1" )
plot!(plt, X, real(fourier_2 ), lw=1, label="complex fourier squarewave N=2" )
plot!(plt, X, real(fourier_4 ), lw=1, label="complex fourier squarewave N=4" )
plot!(plt, X, real(fourier_8 ), lw=1, label="complex fourier squarewave N=8" )
plot!(plt, X, real(fourier_16), lw=1, label="complex fourier squarewave N=16" )
plot!(plt, X, real(fourier_32), lw=1, label="complex fourier squarewave N=32" )

#savefig(plot(plt), "complex_fourier.pdf")
display(plot(plt))
