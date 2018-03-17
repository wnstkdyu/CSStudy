# 큐 최적화 (Queue Optimization)

기존 큐에서 dequeue 메서드의 비효율 문제가 있었다. Dequeue를 효율적으로 하기 위하여 배열 앞쪽에 여분의 빈 공간을 둘 필요가 있다. 이 방법은 Swift 언어가 자체로 지원하는 것이 아니기 때문에 직접 작성해야 한다.

큐 최적화의 핵심 아이디어는 dequeue가 발생하고 즉각적으로 자리를 옮기는 것이 아니라, 빈 자리에 일단 표시만 해두는 것이다.

```
[ "Ada", "Steve", "Tim", "Grace", xxx, xxx ]
```

위 상태에서 "Ada"와 "Steve"를 순서대로 dequeue하면 아래처럼 된다. 앞에 빈 자리 두 개가 생겼는데 자리를 땡겨 맞추지 않고 일단 둔다.

```
[ xxx, xxx, "Tim", "Grace", xxx, xxx ]
```

그리고 미리 정해둔 일정한 주기를 따라 자리를 이동하는 작업을 수행한다. 이것을 trimming이라 한다.

```
[ "Tim", "Grace", xxx, xxx, xxx, xxx ]
```

Trimming은 O(n)의 시간 복잡도를 가진다. 그렇지만 이것은 드물게 발생하기 때문에 평균적으로 O(1)의 시간 복잡도라 볼 수 있다.

## 최적화된 큐 구현

```swift
public struct Queue<T> {
  fileprivate var array = [T?]()
  fileprivate var head = 0

  public var isEmpty: Bool {
    return count == 0
  }

  public var count: Int {
    return array.count - head
  }

  public mutating func enqueue(_ element: T) {
    array.append(element)
  }

  public mutating func dequeue() -> T? {
    guard head < array.count, let element = array[head] else { return nil }

    array[head] = nil
    head += 1

    let percentage = Double(head)/Double(array.count)
    if array.count > 50 && percentage > 0.25 {
      array.removeFirst(head)
      head = 0
    }

    return element
  }

  public var front: T? {
    if isEmpty {
      return nil
    } else {
      return array[head]
    }
  }
}
```

배열의 빈 원소에 표시를 하기 위하여 배열은 이제부터 T 대신 T?로 둔다. 그리고 `head`라는 변수를 추가하여 채워져 있고 가장 앞에 있는 원소의 인덱스를 가지게 한다. `dequeue()` 메서드의 가장 큰 변화는 우선 head에 위치한 원소를 nil로 바꾸어 빈 자리로 표시하고, head를 다음 자리로 이동시킨다는 것이다. 마트의 계산대를 head로, 손님 열을 배열로 비유하면 이해하기 쉽다. 이것은 매번 `removeFirst()`했던 기존 방식과 크게 다르다. `removeFirst()`는 O(n)의 시간 복잡도를 가진다.

`dequeue()` 메서드 내부의 그 다음 코드는 앞쪽에 비어있는 자리를 주기적으로 trim해주기 위한 코드이다. 이 예시 코드에서는 두 가지 조건을 두었는데, 하나는 비어있는 길이가 전체 길이의 25% 이상이어야 한다는 것이고, 다른 하나는 전체 길이가 적어도 50은 되어야 한다는 것이다. 이것은 임의의 숫자로 필요에 따라 적절히 조정할 수 있다.

이렇게 `dequeue()` 메서드를 최적화함으로써 빈 공간를 차지하고 있던 `nil`을 제거해 낭비되는 공간을 줄이는 효과를 얻을 수 있다. 그리고 `dequeue()` 메서드는 O(1)의 시간 복잡도를 달성하게 된다.

## References

- [Queue - Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club/blob/master/Queue/README.markdown)
