# 스택 (Stack)

스택은 배열과 같지만 기능이 제한적인 자료구조이다. 새로운 원소를 스택의 최상단에 추가하기 위해 push하거나, 최상단에 있는 원소를 가져오기 위해 remove를 하거나, 최상단 원소를 pop하지 않고 살짝 들여다보기 위해 peek을 할 수 있다.

왜 이런 것들이 필요할까? 많은 알고리즘들에서 특정 시점에 객체들을 배열에 임시적으로 저장해두고, 나중에 언젠가 이 객체들을 다시 끄집어내어 사용해야 할 상황이 발생한다. 그리고 이런 때에는 객체를 추가하거나 제거하는 순서가 중요하다.

스택은 LIFO, 즉 후입선출의 순서를 제공한다. 마지막으로 push했던 원소가 반드시 다음 번 pop을 통해 반환되는 것이다. 유사한 자료구조인 큐는 FIFO, 즉 선입선출 순서이다.

## 스택 구현

```swift
public struct Stack<T> {
  fileprivate var array = [T]()

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

  public mutating func push(_ element: T) {
    array.append(element)
  }

  public mutating func pop() -> T? {
    return array.popLast()
  }

  public var top: T? {
    return array.last
  }
}
```
## 스택의 시간 복잡도

주목할 만한 것은 push를 통해 추가되는 원소는 위치는 배열의 시작이 아닌 끝이라는 점이다. 맨 앞에 새로운 원소를 추가하는 것은 비용이 많이 드는 작업이다. 기존에 존재하던 원소들의 위치를 전부 메모리에서 이동시켜주어야 하기 때문에 O(n) 연산이 든다. 반면에 맨 뒤에 원소를 추가하는 것은 O(1) 연산이다. 배열의 크기와 무관하게 일정한 상수시간이 소요된다.

## Stack Overflow와 Underflow

스택은 우리가 흔히 말하는 stack overflow와 관련이 깊다. 함수가 호출될 때마다 CPU는 반환 주소를 스택에 저장한다. 함수가 종료되면 CPU는 이 반환 주소를 이용하여 호출부로 다시 돌아오는 것이다. 만약 재귀적인 호출과 같이 너무 많은 수의 함수가 호출되면 stack overflow가 발생할 수 있다. CPU 스택에 공간이 모자라서 발생하는 문제이다.

반대로 pop을 하려는데 스택에 원소가 존재하지 않는다면 stack underflow가 발생할 수 있다. 이러한 경우에는 `nil`을 반환하여 스택이 비어있어서 pop이 유효하지 않다는 것을 호출부에 알려야 한다. `popLast()`는 배열이 비어있는 경우 `nil`을 반환한다.


## References

- [Stack - Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club/blob/master/Stack/README.markdown)
- [popLast() - Apple Developer Documentation](https://developer.apple.com/documentation/swift/array/1539777-poplast)
