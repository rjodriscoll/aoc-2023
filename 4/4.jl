
include("../utils.jl")

t = read_text("data.txt")


function double_one_n_times(n)
    return n > 0 ? 2^n : 1
end

function parse_card_line(card_line)
    parts = split(split(card_line, ":")[2], "|")
    ours = [parse(Int, num) for num in split(strip(parts[1]))]
    winners = [parse(Int, num) for num in split(strip(parts[2]))]
    return ours, winners
end

get_n_match(ours, winners) = length(intersect(ours, winners))

function part_1(cards)
    total_points = sum(cards) do card
        ours, winners = parse_card_line(card)
        points = get_n_match(ours, winners)
        points >= 1 ? double_one_n_times(points - 1) : 0
    end
    return total_points
end

function part_2(cards)
    card_copies = [(matches = get_n_match(parse_card_line(card)...), copies = 1) for card in cards]

    for i in 1:length(card_copies)
        matches = card_copies[i].matches
        for offset in 1:matches
            next_index = i + offset
            if next_index <= length(cards)
                card_copies[next_index] = (matches = card_copies[next_index].matches, copies = card_copies[next_index].copies + card_copies[i].copies)
            end
        end
    end

    total_copies = sum(card -> card.copies, card_copies)
    return total_copies
end


println("Part 1: ", part_1(t))
println("Part 2: ", part_2(t))