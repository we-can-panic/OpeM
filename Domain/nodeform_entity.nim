import json, colors


type
  NodeForm* = object
    kind*: NodeFormKind
    frontCon, backCon*: int
    color*: Color
    icon*: NodeIcon

  NodeFormKind* = enum
    nf菱, nf四角, nf丸

  NodeIcon* = enum
    x, y, z


func `%`* (c: Color): JsonNode = %(int(c))


when isMainModule:
  import json
  echo pretty(%NodeForm())

