
include("../utils.jl")

t = read_text("data.txt")

function parse_mappings(strings)
    mappings = Dict()
    current_map = nothing  
    for line in strings
        if endswith(line, "map:")
            current_map = replace(line, " map:" => "")
            mappings[current_map] = []
        elseif line != "" && current_map != nothing
            push!(mappings[current_map], parse_mapping_line(line))
        end
    end

    return mappings
end


function parse_mapping_line(line)
    nums = split(line)
    return (dest_start=parse(Int, nums[1]), src_start=parse(Int, nums[2]), length=parse(Int, nums[3]))
end

function apply_sequential_mappings(number, mapping_dict)
    categories = ["seed-to-soil", "soil-to-fertilizer", "fertilizer-to-water", "water-to-light", "light-to-temperature", "temperature-to-humidity", "humidity-to-location"]
    
    for category in categories
        for (dest_start, src_start, length) in mapping_dict[category]
            if number >= src_start && number <= src_start + length - 1
                number = dest_start + (number - src_start)
                break   
            end
        end
    end

    return number
end

function part_1(t)
    mappings = parse_mappings(t)
    seeds = map(s -> parse(Int, s), split(t[1], ' ')[2:end])
    lowest = Inf 

    for s in seeds
        location = apply_sequential_mappings(s,  mappings)
        if location < lowest
            lowest = location
        end
    end
    println("lowest location: $lowest" )
end

function part_2(t)
    mappings = parse_mappings(t)
    seed_pairs = split(t[1], ' ')[2:end]
    lowest = Inf
    println("starting part 2")

    for i in 1:2:length(seed_pairs)
        
        start_seed = parse(Int, seed_pairs[i])
        range_length = parse(Int, seed_pairs[i+1])
        println("start seed: $start_seed, range length: $range_length")
        for seed in start_seed:(start_seed + range_length - 1)
            location = apply_sequential_mappings(seed, mappings)
            if location < lowest
                lowest = location
            end
        end
    end

    println("Lowest location: $lowest")
end


part_1(t)

part_2(t)
