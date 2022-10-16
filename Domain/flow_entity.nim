import
  std/[sequtils, colors],
  ./node_entity


type
  Flow* = object
    name* : string
    nodeList* : seq[Node]
    cons* : seq[Con]
    groups* : seq[Group]

  Con* = object
    c1*, c2* : int

  Group* = object
    name* : string
    color* : Color
    nodeIds* : seq[int]

# --

proc contains* (f: var Flow, c: Con): bool
proc contains* (f: var Flow, n: Node): bool
proc add* (f: var Flow, c: Con)
proc add* (f: var Flow, n: Node)
proc getNode* (f: Flow, id: int): Node
proc findGroup* (f: Flow, name: string): int
proc addGroup* (f: var Flow, name: string, n: Node)
proc addGroup* (f: var Flow, n: Node, name: string)
proc removeGroup* (f: var Flow, name: string, n: Node)
proc removeGroup* (f: var Flow, n: Node, name: string)
func `==`* (a, b: Con): bool
proc pop* (f: var Flow, n: Node)
proc pop* (f: var Flow, c: Con)
proc connect* (f: var Flow, a, b: Node)

# --

proc contains* (f: var Flow, c: Con): bool =
  f.cons.contains(c)

proc contains* (f: var Flow, n: Node): bool =
  f.nodeList.contains(n)

proc add* (f: var Flow, c: Con) =
  f.cons.add(c)

proc add* (f: var Flow, n: Node) =
  f.nodeList.add(n)

proc getNode* (f: Flow, id: int): Node =
  for n in f.nodeList:
    if n.id == id:
      return n
  return Node(id: -1)

proc findGroup* (f: Flow, name: string): int =
  for i, g in f.groups:
    if g.name == name:
      return i
  return -1

proc addGroup* (f: var Flow, name: string, n: Node) =
  if not f.contains(n): f.add(n)
  let idx = f.findGroup(name)
  if idx == -1:
    f.groups.add(Group(name: name, color: colAqua, nodeIds: @[n.id]))
  else:
    f.groups[idx].nodeIds.add(n.id)

proc addGroup* (f: var Flow, n: Node, name: string) =
  addGroup(f, name, n)

proc removeGroup* (f: var Flow, name: string, n: Node) =
  if not f.contains(n): return
  let idx = f.findGroup(name)
  if idx == -1:
    return
  else:
    let nodeidx = f.groups[idx].nodeIds.find(n.id)
    if nodeidx == -1:
      return
    else:
      f.groups[idx].nodeIds.delete(nodeidx)


proc removeGroup* (f: var Flow, n: Node, name: string) =
  removeGroup(f, name, n)

func `==`* (a, b: Con): bool =
  (a.c1 == b.c1 and a.c2 == b.c2) or (a.c1 == b.c2 and a.c2 == b.c1)

proc pop* (f: var Flow, n: Node) =
  f.nodeList.keepItIf(it!=n)

proc pop* (f: var Flow, c: Con) =
  f.cons.keepItIf(it!=c)

proc connect* (f: var Flow, a, b: Node) =
  if not f.contains(a): f.add(a)
  if not f.contains(b): f.add(b)
  f.add(Con(c1: a.id, c2: b.id))

