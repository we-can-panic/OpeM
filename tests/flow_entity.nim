discard """
  exitcode: 0
"""
include ../Domain/flow_entity
from unittest import check

import json
block:
  var flow = Flow()
  discard %flow
  
block:
  var flow = Flow()
  let
    node1 = newNode(title="XXX")
    node2 = newNode(title="YYY")

  flow.add(node1)
  flow.add(node2)

  check node1 in flow.nodeList
  check node2 in flow.nodeList

block:
  var flow = Flow()
  let
    node1 = newNode(title="XXX")
    node2 = newNode(title="YYY")

  flow.connect(node1, node2)

  check node1 in flow.nodeList
  check node2 in flow.nodeList
  check Con(c1: node1.id, c2: node2.id) in flow.cons

block:
  var flow = Flow()
  let
    node1 = newNode(title="XXX")
    node2 = newNode(title="YYY")

  flow.connect(node1, node2)
  flow.addGroup(node1, "X")
  flow.addGroup(node2, "Y")

  block:
    let grouplist = flow.groups.mapIt(it.name)

    check "X" in grouplist
    check "Y" in grouplist
    check node1.id in flow.groups[flow.findGroup("X")].nodeIds
    check node2.id in flow.groups[flow.findGroup("Y")].nodeIds

