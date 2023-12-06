include("../utils.jl")

t = read_text("data.txt")

as_il(t) = parse.(Int, t)
as_il_concat(t) = parse(Int, join(t))

get_distance(button_hold, race_duration) = button_hold * (race_duration - button_hold)

function get_n_ways(t, d)
    total = 0
    for i in 1:t
        traveled = get_distance(i, t)
        if traveled > d
            total += 1
        elseif traveled + (t - i) <= d
            break  # Early exit if further distance cannot exceed record distance
        end
    end
    return total
end

times = as_il(split(t[1])[2:end])
distances = as_il(split(t[2])[2:end])

times2 = as_il_concat(split(t[1])[2:end])
distances2 = as_il_concat(split(t[2])[2:end])

part1_result = prod(get_n_ways.(times, distances))
part2_result = get_n_ways(times2, distances2)

println("Part 1: ", part1_result)
println("Part 2: ", part2_result)
