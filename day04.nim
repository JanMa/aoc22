import strutils, sequtils, sets, sugar

proc sequence(lo: int, hi: int): seq[int] =
  result = collect(newSeq):
    for i in countup(lo, hi):
      i

proc parseInput(path: string): seq[seq[HashSet[int]]] =
  result = readFile(path).strip.splitLines.mapIt(
    it.split(',').mapIt(it.split('-')).mapIt(
      sequence(it[0].parseInt, it[1].parseInt)).mapIt(it.toHashSet))

proc fullyContains(first, second: HashSet[int]): int =
  result = if first <= second or second <= first:
             1
           else:
             0

proc overlap(first, second: HashSet[int]): int =
  result = if len(first * second) > 0:
             1
           else:
             0

proc sumContained(input: seq[seq[HashSet[int]]]): int =
  result = input.mapIt(fullyContains(it[0], it[1])).foldl(a+b)

proc sumOverlap(input: seq[seq[HashSet[int]]]): int =
  result = input.mapIt(overlap(it[0], it[1])).foldl(a+b)

var
  sample = parseInput("sample/day04.txt")
  input = parseInput("input/day04.txt")

assert sumContained(sample) == 2

echo "Part one:"
echo sumContained(input)

assert sumOverlap(sample) == 4

echo "Part two:"
echo sumOverlap(input)
