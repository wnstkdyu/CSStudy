# 이진 탐색 트리 (Binary Search Tree) Part 2

## 구현

### 열거형으로 구현

클래스 대신 열거형으로도 이진 탐색 트리를 구현할 수 있다. 둘의 차이은 레퍼런스 시맨틱스와 값 시맨틱스의 차이이다. 클래스 기반의 트리는 메모리 상의 같은 인스턴스에 변화를 주지만, 열거형 기반의 트리는 불변적이기 때문에 삽입이나 삭제가 발생하면 완전히 새로운 복사본이 만들어진다. 둘 중 절대적으로 좋은 것은 없으므로 필요에 따라 선택하면 된다. 열거형 기반의 트리 코드는 다음과 같다.

```swift
public enum BinarySearchTree<T: Comparable> {
  case Empty
  case Leaf(T)
  indirect case Node(BinarySearchTree, T, BinarySearchTree)
}
```

이 열거형에는 세 가지 케이스가 있다.

- `Empty`: 가지의 끝, 클래스 기반의 트리에서는 `nil`로 표시하였다.
- `Leaf`: 리프 노드, 즉 자식이 없는 노드
- `Node`: 자식이 하나 또는 둘 있는 노드. `indirect`를 표시함으로써 이 열거형이 `BinarySearchTree`를 값으로 가질 수 있도록 만들었다. `indirect` 예약어 없이는 재귀적인 선언형을 만들 수 없다.

> 열거형을 기반으로 한 노드에는 부모 노드로의 레퍼런스가 존재하지 않는다. 이것이 큰 문제는 되지 않지만 특정 연산을 할 때 조금 까다로운 제약이 될 수 있다.

#### 노드의 개수와 트리의 높이

다음은 트리의 전체 노드 개수와 높이를 구하는 코드이다. 이것은 재귀적으로 구현되어 있고 열거형 케이스 별로 각각 다르게 처리된다.

```swift
public var count: Int {
  switch self {
  case .Empty: return 0
  case .Leaf: return 1
  case let .Node(left, _, right): return left.count + 1 + right.count
  }
}

public var height: Int {
  switch self {
  case .Empty: return 0
  case .Leaf: return 1
  case let .Node(left, _, right): return 1 + max(left.height, right.height)
  }
}
```

#### 노드 삽입

노드를 삽입하는 메서드는 다음과 같다.

```swift
public func insert(newValue: T) -> BinarySearchTree {
  switch self {
  case .Empty:
    return .Leaf(newValue)

  case .Leaf(let value):
    if newValue < value {
      return .Node(.Leaf(newValue), value, .Empty)
    } else {
      return .Node(.Empty, value, .Leaf(newValue))
    }

  case .Node(let left, let value, let right):
    if newValue < value {
      return .Node(left.insert(newValue), value, right)
    } else {
      return .Node(left, value, right.insert(newValue))
    }
  }
}
```

위 메서드를 사용하여 다음과 같이 트리를 구성할 수 있다. 여기서 주의해야 할 점은 삽입이 일어날 때 마다 다른 메모리 공간에 새로운 객체가 만들어지기 때문에, 결과값을 변수에 매번 반환받아야 한다는 것이다.

```swift
var tree = BinarySearchTree.Leaf(7)
tree = tree.insert(2)
tree = tree.insert(5)
tree = tree.insert(10)
tree = tree.insert(9)
tree = tree.insert(1)
```

#### 노드 탐색

특정 값을 지닌 노드를 탐색하는 메서드는 다음과 같다.

```swift
public func search(x: T) -> BinarySearchTree? {
  switch self {
  case .Empty:
    return nil
  case .Leaf(let y):
    return (x == y) ? self : nil
  case let .Node(left, y, right):
    if x < y {
      return left.search(x)
    } else if y < x {
      return right.search(x)
    } else {
      return self
    }
  }
}
```

## 이진 탐색 트리의 불균형

이진 탐색 트리의 좌우 서브 트리가 같은 수의 노드를 가지고 있을 때 이것을 균형 잡힌 트리라고 말한다. 이 때 n개의 노드로 구성된 트리의 높이는 log(n)이다. 그리고 이 상태가 가장 이상적이다.

어느 한 쪽의 가지가 다른 한 쪽에 비해 심각하게 길어진다면 탐색 속도는 매우 느려진다. 필요 이상의 노드를 탐색할 수 밖에 없기 때문이다. 게다가 트리의 높이가 n인 경우도 있을 수 있다. 이 경우에는 트리가 마치 연결 리스트와 같이 생겼다고 볼 수 있으며, 성능은 O(n)까지 떨어질 수 있다. 좋지 않다.

이진 탐색 트리를 균형 있게 유지하기 위한 한 가지 방법으로는, 노드를 삽입할 때 완전히 무작위 순으로 삽입하는 것이다. 이 방법은 평균적으로 균형 잡힌 트리를 만들 것으로 기대되기는 하지만, 보장되지 않은 방법이며 그다지 실용적이지도 않다. 다른 방법으로는 이진 트리가 스스로 균형을 잡도록 만드는 것이다. 이런 종류의 자료 구조를 사용하면 노드의 삽입이나 삭제 이후에 트리가 스스로 조정하여 균형을 잡을 것이다. 자세한 내용은 AVL 트리와 레드-블랙 트리를 확인해보자.

## References

- [Binary Search Tree - Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search%20Tree)
