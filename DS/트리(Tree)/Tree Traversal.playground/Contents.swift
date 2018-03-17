//: Playground - noun: a place where people can play

import Foundation

class Node {
    var value: Int
    var left: Node?
    var right: Node?
    
    init(value: Int) {
        self.value = value
    }
}

//      0
//  1       2
//3   4   5
let rootNode = Node(value: 0)
let firstNode = Node(value: 1)
let secondNode = Node(value: 2)
let thirdNode = Node(value: 3)
let forthNode = Node(value: 4)
let fifthNode = Node(value: 5)

rootNode.left = firstNode
rootNode.right = secondNode

firstNode.left = thirdNode
firstNode.right = forthNode

secondNode.left = fifthNode

// 노드 방문
func visit(node: Node) {
    print(node.value)
}

// 전위 순회: 루트 먼저! (바로바로 방문)
func preorderTraversal(rootNode: Node?) {
    guard let rootNode = rootNode else { return }
    
    visit(node: rootNode)
    preorderTraversal(rootNode: rootNode.left)
    preorderTraversal(rootNode: rootNode.right)
}
print("전휘 순회")
preorderTraversal(rootNode: rootNode)
// 0 1 3 4 2 5

// 중위 순회: 루트가 중간에 오도록! (먼저 왼쪽 방문)
func inorderTraversal(rootNode: Node?) {
    guard let rootNode = rootNode else { return }
    
    inorderTraversal(rootNode: rootNode.left)
    visit(node: rootNode)
    inorderTraversal(rootNode: rootNode.right)
}
print("중위 순회")
inorderTraversal(rootNode: rootNode)
// 3 1 4 0 5 2

// 후위 순회: 루트를 가장 나중에! (먼저 왼쪽, 오른쪽 방문)
func postOrderTraversal(rootNode: Node?) {
    guard let rootNode = rootNode else { return }
    
    postOrderTraversal(rootNode: rootNode.left)
    postOrderTraversal(rootNode: rootNode.right)
    visit(node: rootNode)
}
print("후위 순회")
postOrderTraversal(rootNode: rootNode)
// 3 4 1 5 2 0

// 레벨 순회: 같은 레벨 먼저
func levelorderTraversal(rootNode: Node?) {
    guard let rootNode = rootNode else { return }
    var queue: [Node] = []
    queue.append(rootNode)
    
    while !queue.isEmpty {
        let node = queue.removeFirst()
        visit(node: node)
        
        if let leftNode = node.left {
            queue.append(leftNode)
        }
        if let rightNode = node.right {
            queue.append(rightNode)
        }
    }
}
print("레벨 순회")
levelorderTraversal(rootNode: rootNode)
