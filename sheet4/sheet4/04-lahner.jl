using Plots

function position(t)
    if t <= 50
        return 0.6 * t^2
    elseif t <= 200
        return 60 * t - 1500
    end
    return -140 * t + t^2 - (t^3 / 600) + 11833
end

function velocity(t)
    if t <= 50
        return 1.2 * t
    elseif t <= 200
        return 60
    end
    return 2*t - (t^2 / 200) - 140
end

function acceleration(t)
    if t <= 50
        return 1.2
    elseif t <= 200
        return 0
    end
    return -(t / 100) + 2
end


step = 5  #b)1 c=5  
time = 0:step:300   

acc = acceleration.(time)
vel = velocity.(time)
pos = position.(time)

vel_app = cumsum(acc * step)
pos_app = cumsum(vel_app * step)

# Plotten
p1 = plot(time, acc, xlabel="Zeit (s)", ylabel="Beschleunigung (m/s²)", label="Beschleunigung", legend=:topleft)
p2 = plot(time, vel, xlabel="Zeit (s)", ylabel="Geschwindigkeit (m/s)", label="Geschwindigkeit", legend=:topleft)
plot!(p2, time, vel_app, label="Approximierte Geschwindigkeit")
p3 = plot(time, pos, xlabel="Zeit (s)", ylabel="Position (m)", label="Position", legend=:topleft)
plot!(p3, time, pos_app, label="Approximierte Position")
p4 = plot(time, abs.(vel - vel_app), xlabel="Zeit (s)", ylabel="Fehler in der Geschwindigkeit (m/s)", label="Fehler in der Geschwindigkeit", legend=:topleft)
p5 = plot(time, abs.(pos - pos_app), xlabel="Zeit (s)", ylabel="Fehler in der Position (m)", label="Fehler in der Position", legend=:topleft)

# Anordnung der Plots in einem Raster
plot(p1, p2, p3, p4, p5, layout=(3, 2), size=(800, 800))
