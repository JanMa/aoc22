import strutils, sequtils, sets

proc parseInput(path: string): seq[string] =
  result = readFile(path).strip.splitLines

proc checkRucksack(items: string): HashSet[char] =
  var
    l = items.len
    c1 = toHashSet(items[0 .. (l div 2) - 1])
    c2 = toHashSet(items[(l div 2) .. ^1])
  result = c1 * c2

proc priority(dup: HashSet[char]): int =
  for i in dup.items:
    var p = ord(i)
    result += (
      if p < 91:
        p - 64 + 26
      else:
        p - 96
    )

proc sumPriorities(rucksacks: seq[string]): int =
  result = rucksacks.mapIt(it.checkRucksack.priority).foldl(a+b)

proc checkGroup(group: seq[string]): HashSet[char] =
  result = group.mapIt(it.toHashSet).foldl(a * b)

proc sumBadges(rucksacks: seq[string]): int =
  var i = 0
  while i < (len(rucksacks)-2):
    result += checkGroup(rucksacks[i .. i+2]).priority
    i += 3

var
  input = parseInput("input/day03.txt")
  sample = parseInput("sample/day03.txt")

assert sumPriorities(sample) == 157

echo "Part one:"
echo sumPriorities(input)

assert sumBadges(sample) == 70

echo "Part two:"
echo sumBadges(input)
