# https://adventofcode.com/2021/day/4
using AdventOfCode

input = read("2021/data/day_4.txt", String)

function parse_input(input)
    chunks = split(chomp(input), "\n\n")
    draws = parse.(Int, split(first(chunks), ','))
    boards = parse_board.(chunks[2:end])
    return draws, boards
end

parse_board(chunk) = reshape(parse.(Int, split(strip(chunk), r"\s+")), 5, 5)

function score_board!(board, call)
    idx = findfirst(==(call), board)
    idx === nothing && return -1
    board[idx] = 0
    if all(iszero, view(board, idx[1], :)) || all(iszero, view(board, :, idx[2]))
        return sum(board) * call
    else
        return -1
    end
end

function part_1(input)
    draws, boards = parse_input(input)

    for call in draws
        for board in boards
            score = score_board!(board, call)
            score >= 0 && return score
        end
    end
    
end
@info part_1(input)

function part_2(input)
    draws, boards = parse_input(input)
    scores = Int[]

    for call in draws
        idx = 1
        while idx <= length(boards)
            board = boards[idx]
            score = score_board!(board, call)
            if score >= 0
                push!(scores, score)
                deleteat!(boards, idx)
            else
                idx += 1
            end
        end
    end

    return scores[end]
end
@info part_2(input)
