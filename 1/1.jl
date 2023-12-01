include("../utils.jl")

t = read_text("data.txt")

function words_to_digits(s::String)
    replacements = Dict("one" => "1", "two" => "2", "three" => "3", "four" => "4",
        "five" => "5", "six" => "6", "seven" => "7", "eight" => "8",
        "nine" => "9")

    digit_str = ""
    start = 1
    for (index, value) in enumerate(s)
        if isdigit(value)
            digit_str *= value
            start = index + 1
        end
        curr_word = s[start:index]
        for (word, digit) in replacements
            replacement_curr_word = replace(curr_word, word => digit)

            if replacement_curr_word != curr_word
                #found a digit
                digit_str *= replacement_curr_word
                start = index + 1
                break
            end
        end
    end

    return digit_str
end



function find_fl_digits(s::String, look_for_words::Bool=false)::Int
    if look_for_words
        s = words_to_digits(s)
    end
    first, last = nothing, nothing
    for i in s
        if isdigit(i)
            last = i
            if first === nothing
                first = last
            end
        end
    end
    concatenated_digits = (first === nothing ? "" : first) * (last === nothing ? "" : last)
    return concatenated_digits == "" ? 0 : parse(Int, concatenated_digits)
end



function sum_digits_in_list(strings::Array{String}, look_for_words::Bool=false)
    total_sum = 0
    for str in strings
        total_sum += find_fl_digits(str, look_for_words)
    end
    return total_sum
end

println("part 1: ", sum_digits_in_list(t))
println("part 2: ", sum_digits_in_list(t, true))
