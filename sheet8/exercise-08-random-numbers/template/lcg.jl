using LinearAlgebra
using Plots

function prime_divisors(n)
    divisors = Int[]
    while n % 2 == 0
        push!(divisors, 2)
        n = n ÷ 2
    end
    for i in 3:2:isqrt(n)
        while n % i == 0
            push!(divisors, i)
            n = n ÷ i
        end
    end
    if n > 2
        push!(divisors, n)
    end
    return divisors
end

function find_period(sequence::Vector{Float64})
    n = length(sequence)
    for period in 1:n÷2
        is_period = true
        for i in 1:n-period
            if sequence[i] ≠ sequence[i+period]
                is_period = false
                break
            end
        end
        if is_period
            return period
        end
    end
    return false
end

# a)
function lcg(a::Int, c::Int, m::Int, seed::Int, n::Int)
    # initialize an array to store generated random numbers
    random_numbers = ones(n) 
    
    # generate random numbers
    return random_numbers
end

# b)
function marsaglia(U::Vector{Float64})
    # make tuples out of sequence

    # create appropriate plot using tuples
end

# c)
function knuth(a::Int, c::Int, m::Int, seed::Int, n::Int)

    # check if c,m are coprime

    # check if every p also divides a-1

    # check if 4 divides a-1 when 4 divides m 

    return false
end

# Test parameters that meet Knuth's conditions:
a=41
c=23
m=32
seed=0
n=64

U = lcg(a, c, m, seed, n)
knuth(a, c, m, seed, n)
marsaglia(U)