//: Playground - noun: a place where people can play

import Foundation

// LinkedList
// Array의 삽입, 삭제 시 나머지 원소들의 인덱스 변화 문제점을 해결하기 위해 나온 자료구조
// 삽입, 삭제만 놓고 보았을 때 다음 노드만 변경하면 되어 O(1) 시간! 그러나...
// Search에도 O(n)이 걸리기 때문에 결과적으로 원하는 위치에 삽입, 삭제할 경우 O(n)이 걸린다.
// Tree 구조의 근간이 되는 자료구조

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

