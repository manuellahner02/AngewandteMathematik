using QuadGK

#a)

f_prime(x) = 2x
arc_length_a(x) = sqrt(1 + f_prime(x)^2)


#c)
x_prime(x) = (cos(x)^2 - sin(x)^2)
y_prime(x) = 2 * cos(x) * sin(x)
z_prime(x) = -sin(x)
arc_length_c(x) = sqrt(x_prime(x)^2 + y_prime(x)^2 + z_prime(x)^2)



L_a, err_a = quadgk(arc_length_a, -1, 2)
L_c, err_c = quadgk(arc_length_c, 0, 2*pi)

# Ausgabe des Ergebnisses
println("a) Die Bogenlänge beträgt: ", L_a)
println("c) Die Bogenlänge beträgt: ", L_c)