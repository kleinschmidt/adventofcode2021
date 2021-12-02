# https://adventofcode.com/2021/day/2
using AdventOfCode

input = readlines("2021/data/day_2.txt")

function parse_instruction(line)
    dir, n = split(line, ' ')
    n = parse(Int, n)
    if dir == "forward"
        return (n, 0)
    else
        return (0, dir == "down" ? n : -n)
    end
end

function part_1(input)
    h, v = mapreduce(parse_instruction, (a,b) -> a .+ b, input; init=(0, 0))
    return h * v
end
@info part_1(input)

function update_h_v_aim((h, v, aim), (Δh, Δaim))
    aim += Δaim
    return (h + Δh, v + Δh*aim, aim)
end

test_input = split("""forward 5
down 5
forward 8
up 3
down 8
forward 2""", '\n')

function part_2(input)
    h, v, aim = mapfoldl(parse_instruction, update_h_v_aim, input; init=(0, 0, 0))
    return h * v
end
@info part_2(input)
