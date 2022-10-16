import
  std/[json],
  ./canvas,
  ../Domain/[flow_entity, node_entity]

include karax / prelude

var
  flow = Flow(name: "FLOW SAMPLE")
let
  node1 = newNode(title="NODE1")
  node2 = newNode(title="NODE2")

flow.connect(node1, node2)
flow.addGroup(node1, "GROUP1")
flow.addGroup(node2, "GROUP2")

proc main(): VNode =
  buildHtml tdiv:
    flow.canvas()
    br()
    text pretty(%flow)

setRenderer main
