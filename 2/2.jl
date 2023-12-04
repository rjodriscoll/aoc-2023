include("../utils.jl")
using  Base: match
t = read_text("data.txt")

game_pattern = r"Game (\d+)"
red_pattern = r"(\d+) red"
green_pattern = r"(\d+) green"
blue_pattern = r"(\d+) blue"


total_power = 0 
game_sum = 0
for s in t
    game_id = parse(Int, match(game_pattern, s)[1])
    red_max = find_max(red_pattern, s)
    green_max = find_max(green_pattern, s)
    blue_max = find_max(blue_pattern, s)
    game_power = red_max * green_max * blue_max
    total_power += game_power
    if red_max <= 12 && green_max <= 13 && blue_max <= 14
        game_sum += game_id
    end
end

println("part 1", game_sum)
println("part 2", total_power)
