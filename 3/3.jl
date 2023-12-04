include("../utils.jl")
data = read_text("data.txt")
  
function findnums(line)
    "get the value, position and length of the values in a line"
    map(eachmatch(r"(\d+)", line)) do m        
        (parse.(Int, m.match), m.offset, length(m.match)) # value, position, length
    end
end

function get_adjacent_area(start_col, num_length, row, matrix)
    num_rows, num_cols = size(matrix)
    col_range = max(start_col - 1, 1):min(start_col + num_length, num_cols)
    row_range = max(row - 1, 1):min(row + 1, num_rows)
    matrix[col_range, row_range]
end



function get_padded_adjacent_area(start_col, num_length, row, matrix)
    padded_matrix = fill('.', size(matrix) .+ (2, 2))
    padded_matrix[2:end-1, 2:end-1] = matrix
    get_adjacent_area(start_col + 1, num_length, row + 1, padded_matrix)
end


function special(char)
    return !isnumeric(char) && char != '.'
end

function star(char)
    return char == '*'
end

function larray(lines)
    return reduce(hcat, collect.(lines))
end

function solve(lines)
    array = larray(lines)
    total_part1 = 0
    dict_part2 = Dict()

    for (i, line) in enumerate(lines)
        for (val, pos, len) in findnums(line)
            if any(special, get_adjacent_area(pos, len, i, array))
                total_part1 += val
            end

            for xy in findall(star, get_padded_adjacent_area(pos, len, i, array))
                adjusted_xy = Tuple(xy) .+ (pos, i)
                dict_part2[adjusted_xy] = push!(get(dict_part2, adjusted_xy, []), val)
            end
        end
    end

    total_part2 = 0
    for nums in values(dict_part2)
        if length(nums) == 2
            total_part2 += prod(nums)
        end
    end


    return total_part1, total_part2
end


a = solve(data)
println("Part 1: ", a[1], "\nPart 2: ", a[2])
