# https://adventofcode.com/2021/day/3
using AdventOfCode

input = readlines("2021/data/day_3.txt")

split_digits(line) = parse.(Int, collect(line))

binary_from_digits(digits) = foldl((a,b) -> a*2 + b, digits; init=0)

function part_1(input)
    counts = mapreduce(split_digits, +, input)
    half = length(input) ÷ 2
    digits = counts .> half
    @show join(Int.(digits))
    γ = binary_from_digits(digits)
    ϵ = binary_from_digits(.!(digits))
    return γ * ϵ
end
@info part_1(input)

function bisect(input, pos)
    idx = searchsortedfirst(view(input, pos, :), '1')
    return @views input[:, 1:idx-1], input[:, idx:end]
end

function majority(input)
    pos = 1
    while size(input, 2) > 1
        zero, one = bisect(input, pos)
        input = size(zero, 2) > size(one, 2) ? zero : one
        pos += 1
    end
    return input
end

function minority(input)
    pos = 1
    while size(input, 2) > 1
        zero, one = bisect(input, pos)
        input = length(zero) <= length(one) ? zero : one
        pos += 1
    end
    return input
end

function part_2(input)
    input = reduce(hcat, collect.(sort(input)))
    bisect(input, 1)
    o2 = majority(input)
    co2 = minority(input)
    return binary_from_digits(parse.(Int, o2)) * binary_from_digits(parse.(Int, co2))
end
@info part_2(input)
