import sequtils, strutils

proc parseInput(path: string): seq[string] =
  result = readFile(path).strip.splitLines

proc playOne(round: string): int =
  case round
  of "A X":
    result = 4
  of "A Y":
    result = 8
  of "A Z":
    result = 3
  of "B X":
    result = 1
  of "B Y":
    result = 5
  of "B Z":
    result = 9
  of "C X":
    result = 7
  of "C Y":
    result = 2
  of "C Z":
    result = 6
  else:
    result = 0

proc gameOne(rounds: seq[string]): int =
  rounds.mapIt(it.playOne).foldl(a+b)

var
  sample = parseInput("sample/day02.txt")
  input = parseInput("input/day02.txt")

assert sample.gameOne == 15

echo "Part one:"
echo input.gameOne

proc playTwo(round: string): int =
  case round
  of "A X":
    result = 3
  of "A Y":
    result = 4
  of "A Z":
    result = 8
  of "B X":
    result = 1
  of "B Y":
    result = 5
  of "B Z":
    result = 9
  of "C X":
    result = 2
  of "C Y":
    result = 6
  of "C Z":
    result = 7
  else:
    result = 0

proc gameTwo(rounds: seq[string]): int =
  rounds.mapIt(it.playTwo).foldl(a+b)

assert sample.gameTwo == 12

echo "Part two:"
echo input.gameTwo
