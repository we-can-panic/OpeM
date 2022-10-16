import
  std/[sequtils, strutils],
  ../Domain/[flow_entity, node_entity]

include karax / prelude
import karax/vstyles

# --

proc canvas* (f: Flow): VNode

# --

proc canvas* (f: Flow): VNode =
  buildHtml tdiv:
    label: text "name is " & f.name
    br()

    label: text "nodes are [" & f.nodeList.mapIt(it.title).join(", ") & "]"
    br()

    label: text "connection is:"
    br()
    for con in f.cons:
      label: text "- " & f.getNode(con.c1).title & " to " & f.getNode(con.c2).title
      br()

    label: text "group is:"
    br()
    for group in f.groups:
      label: text "- " & group.name & ":"
      br()
      for nodeId in group.nodeIds:
        label: text "-- " & f.getNode(nodeId).title
        br()
