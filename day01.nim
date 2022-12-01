import strutils
import sequtils
import algorithm

proc parseInput(path: string): seq[int] =
    result = readFile(path).strip().split("\n\n").mapIt(it.splitLines().mapIt(it.parseInt).foldl(a+b))


var
  sample = parseInput("sample/day01.txt")
  input = parseInput("input/day01.txt")

assert sample.max == 24000

echo "Part one:"
echo input.max

sample.sort()
input.sort()

assert sample[^3 .. ^1].foldl(a+b) == 45000

echo "Part two:"
echo input[^3 .. ^1].foldl(a+b)
