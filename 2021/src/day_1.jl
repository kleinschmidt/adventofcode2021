# https://adventofcode.com/2021/day/1
using AdventOfCode

input = parse.(Int, readlines("2021/data/day_1.txt"))

function part_1(input)
    comparisons = @views input[1:end-1] .< input[2:end]
    return sum(comparisons)
end

@info part_1(input)

function part_2(input)
    @views part_1(input[1:end-2] .+ input[2:end-1] .+ input[3:end])
end

@info part_2(input)
