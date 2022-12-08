import strutils, sequtils

proc parseInput(path: string): seq[seq[string]] =
  result = readFile(path).split("\n\n").mapIt(it.splitLines)

proc buildCargo(input: seq[string]): seq[seq[char]] =
  var rows = input[^1].strip.splitWhitespace.len
  result = newSeqWith(rows, newSeq[char](0))
  for i in countup(0, rows-1):
    for j in countdown(input.len-2, 0):
      var offset = (i+1) + (i)*3
      if input[j].len > offset:
        var it = input[j][offset]
        if it != ' ':
          result[i].add(it)

proc buildMoves(input: seq[string]): seq[seq[int]] =
  result = input.mapIt(it.splitWhitespace.filterIt(it != "move" and it != "from" and it != "to").mapIt(it.parseInt)).filterIt(it.len > 0)

proc applyMove(input: seq[seq[char]], move: seq[int]): seq[seq[char]] =
  result = input
  for i in countup(1,move[0]):
    result[move[2]-1].add(result[move[1]-1].pop)

proc moves(input: seq[seq[char]], moves: seq[seq[int]]): seq[seq[char]] =
  result = input
  for move in moves:
    result = applyMove(result, move)

proc topCrates(input: seq[seq[char]]): string =
  result = input.mapIt(it[^1]).join("")

proc partOne(input: seq[seq[string]]): string =
  result = moves(input[0].buildCargo, input[1].buildMoves).topCrates

proc applyMoveTwo(input: seq[seq[char]], move: seq[int]): seq[seq[char]] =
  result = input
  result[move[2]-1].add(result[move[1]-1][^move[0]..^1])
  result[move[1]-1].setLen(len(result[move[1]-1])-move[0])

proc movesTwo(input: seq[seq[char]], moves: seq[seq[int]]): seq[seq[char]] =
  result = input
  for move in moves:
    result = applyMoveTwo(result, move)

proc partTwo(input: seq[seq[string]]): string =
  result = movesTwo(input[0].buildCargo, input[1].buildMoves).topCrates

var
  sample = parseInput("sample/day05.txt")
  input = parseInput("input/day05.txt")

assert partOne(sample) == "CMZ"

echo "Part one: ", partOne(input)

assert partTwo(sample) == "MCD"

echo "Part two: ", partTwo(input)
