//: Playground - noun: a place where people can play

import Foundation

class Node {
    let data: Int
    var next: Node?
    
    init(data: Int) {
        self.data = data
    }
}

func insert(head: Node?, data: Int!) -> Node? {
    // head가 nil이면 바로 insert한 노드가 head가 됨.
    // nil이 아니면 head의 다음 노드를 계속 확인하여 nil인 곳에 박아 넣으면 됨.
    guard head != nil else { return Node(data: data) }
    
    var currentNode = head
    while currentNode?.next != nil {
        currentNode = currentNode?.next
    }
    currentNode?.next = Node(data: data)
    
    return head
}

func display(head: Node?) {
    var current = head
    
    while current != nil {
        print(current!.data, terminator: " ")
        current = current!.next
    }
}

var head: Node?
let n = [2, 3, 4, 1]

n.forEach {
    head = insert(head: head, data: $0)
}

display(head: head)

