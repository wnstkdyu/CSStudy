# 큐 (Queue)

큐는 새로운 원소가 뒤로 들어가고 앞에서부터 빠져나오는 자료구조이다. 최초에 넣었던 원소가 최초로 빠져나오는 원소인 것이다. 이것은 FIFO, 선입선출이다.

스택과 마찬가지 이유로 배열에 넣고 빼는 순서가 중요한 알고리즘에서 자주 사용된다. 스택과 비교하자면 스택은 넣고 빼는 위치가 한 곳으로 동일하지만, 큐는 서로 다른 위치에서 넣는(enqueue) 위치와 빼는(dequeue) 위치가 정반대이다.

## 큐 구현

```swift
public struct Queue<T> {
  fileprivate var array = [T]()

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

  public mutating func enqueue(_ element: T) {
    array.append(element)
  }

  public mutating func dequeue() -> T? {
    if isEmpty {
      return nil
    } else {
      return array.removeFirst()
    }
  }

  public var front: T? {
    return array.first
  }
}
```

## 큐의 시간 복잡도

### Enqueue

Enqueue 메서드는 O(1)의 시간 복잡도를 가진다. 배열의 길이와 무관하게 맨 끝에 새로운 원소가 추가되기 때문이다. 어째서 맨 끝에 추가하는 경우에는 O(1)의 시간 복잡도를 가지는지 궁금해할 수 있다. Swift에서 배열의 끄트머리에는 사실 몇 개의 빈 공간이 할당되어 있기 때문이다.

```swift
var queue = Queue<String>()
queue.enqueue("Ada")
queue.enqueue("Steve")
queue.enqueue("Tim")
```

위 코드의 결과로 변수 `queue`는 실제로는 다음과 같을 수 있다.

```
[ "Ada", "Steve", "Tim", xxx, xxx, xxx ]
```

xxx는 예약되었지만 채워져 있지 않은 메모리 공간을 뜻한다. 만약 하나의 데이터를 추가로 enqueue한다면 해당 데이터의 메모리를 xxx에 복사하기만 하면 되기 때문에 상수 시간만 소요되는 것이다.

그렇지만 빈 공간의 개수도 한정적이다. 빈 공간이 다 채워지게 되면 공간을 더 만들기 위하여 배열을 리사이징해야 한다. 리사이징은 새로운 메모리를 할당하고 기존 데이터를 새로운 배열에 복사하는 과정이다. 이것은 O(n)의 복잡도를 가지기 때문에 느리다고 볼 수 있다. 하지만 리사이징은 드물게 일어나고 한 번 리사이징을 하면 오랫동안 O(1) 복잡도를 유지하며 O(n)을 분할 상환할 수 있기 때문에 평균적으로 O(1)라 볼 수 있다.

### Dequeue

Dequeue는 이야기가 좀 다르다. 아래와 같이 "Ada"를 큐의 맨 앞에서 제거하고 나면 나머지 원소들이 전부 한 칸씩 이동하는 작업이 필수적이기에, O(n)의 복잡도가 발생한다.

참고적으로 `dequeue()` 메서드에서, 빈 배열에 대하여 `removeFirst()` 메서드를 호출하면 컴파일 에러가 발생한다. 따라서 우선 비어있는지 확인하고 비어있다면 `nil`을 반환한다.

```
before   [ "Ada", "Steve", "Tim", "Grace", xxx, xxx ]
                   /       /      /
                  /       /      /
                 /       /      /
                /       /      /
after   [ "Steve", "Tim", "Grace", xxx, xxx, xxx ]
```

## 큐를 이용한 추천 예제

- 큐로 Heap 구현하기

## References

- [Queue - Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club/blob/master/Queue/README.markdown)
- [removeFirst() - Apple Developer Documentation](https://developer.apple.com/documentation/swift/array/2884646-removefirst)
