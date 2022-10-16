import
  ./nodeform_entity

export nodeform_entity

type
  NodeConfig* = object of RootObj
    title*: string
    desc*: string
    arg*: seq[Arg]
    code*: string
    form*: NodeForm

  Node* = object of NodeConfig
    id*: int

  Arg* = object
    key*, value*: string


var count = 0

proc newNode* (title="", desc="", arg: seq[Arg] = @[], code="", form=NodeForm()): Node =
  inc count
  Node(
    id: count,
    title: title,
    desc: desc,
    arg: arg,
    code: code,
    form: form
  )

func `==`* (a, b: Node): bool =
  a.id == b.id

when isMainModule:
  import json
  echo pretty(%newNode())
  echo pretty(%Node(id: 0, code: "echo 999"))
  