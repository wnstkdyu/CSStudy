# 탐욕 알고리즘 (Greedy Algorithm)

탐욕 알고리즘은 가능한 해들 중에서 가장 좋은 해를 찾는 최적화 알고리즘 기법 중 하나이다. 매 순간마다 최적이라 판단되는 것을 선택하여 최적의 답을 찾아가는 것이 핵심 아이디어이다.

주어진 문제의 전체적인 상황은 고려하지 않기 때문에 항상 최적해를 구한다는 보장이 없다. 그렇지만 구현이 쉽다는 것과 계산 속도가 빨라 신속하게 근사치에 다가갈 수 있다는 장점이 있다. 따라서 최적해를 구하기 위하여 독립적으로 사용되기 보다는, 근사치 추정과 같은 특정한 목적으로 부분적으로 다른 알고리즘과 함께 사용된다.

탐욕 알고리즘을 통해 해결되는 문제는 다음의 조건을 가진다.

- Greedy Choice Property
  - 현재 최적이라고 생각되는 선택을 하고, 이것들이 모여서 최적해를 구할 수 있다.
  - 앞의 선택이 이후의 선택에 영향을 주지 않는다.
  - DP와의 차이점

- Optimal Substructure
  - 부분 문제의 최적해를 통해 전체 문제의 최적해를 구할 수 있다.
  - DP와의 공통점

## 동적 계획법(Dynamic Programming, DP)와의 차이

탐욕 알고리즘

- 하위 문제들이 서로 overlapping 하지 않는다.
- 매 단계에서 하나의 하위 문제만을 처리한다.
- 따라서 시간 복잡도가 더 낮다.

동적 계획법

- 하위 문제들이 서로 overlapping 한다.
- 매 단계에서 여러 개의 하위 문제들을 처리한다.
- 또한 중복되는 하위 문제가 발생할 수 있다. (e.g. 피보나치 수열)
- 따라서 시간 복잡도가 더 높다.

## 분할 정복(Divide and Conquer)과의 차이

분할 정복 방식은 하나의 큰 문제를 작은 단위로 쪼개어 풀어가는 방식이다. 분할 정복 방식에는 전체와 부분이 있다면, 탐욕 알고리즘에는 여러 개의 순간들만 있을 뿐이다. 탐욕 알고리즘은 전체 문제를 쪼갠다기 보다는 순간의 최선의 선택이 최후에도 같기를 기대하는 것이다.

탐욕 알고리즘은 최단 거리를 찾는 문제와 같이 시작점과 종료점이 주어졌을 때 빠른 경로를 찾는 문제에 적합하다. 반면에 분할 정복은 데이터 정렬 문제와 같이 여러 데이터에 규칙을 적용하는 문제에 적합하다.

## 사용 예

탐욕 알고리즘은 다음

- 최소 신장 트리
  - Prim 알고리즘
  - Kruskal 알고리즘
- Dijkstra 알고리즘
- 최소 동전 수 교환 (Minimum Coin Exchange)
- SJF (Shortest Job First): CPU 스케줄링 알고리즘
- 허프만 인코딩 (Huffman Encoding)

## 코드

```swift
public enum MinimumCoinChangeError: Error {
    case noRestPossibleForTheGivenValue
}

public struct MinimumCoinChange {
    internal let sortedCoinSet: [Int]

    public init(coinSet: [Int]) {
        self.sortedCoinSet = coinSet.sorted(by: { $0 > $1})
    }

    //Greedy Algorithm
    public func changeGreedy(_ value: Int) throws -> [Int] {
        guard value > 0 else { return [] }

        var change: [Int] = []
        var newValue = value

        for coin in sortedCoinSet {
            while newValue - coin >= 0 {
                change.append(coin)
                newValue -= coin
            }

            if newValue == 0 {
                break
            }
        }

        if newValue > 0 {
            throw MinimumCoinChangeError.noRestPossibleForTheGivenValue
        }

        return change
    }

    //Dynamic Programming Algorithm
    public func changeDynamic(_ value: Int) throws -> [Int] {
        guard value > 0 else { return [] }

        var cache: [Int : [Int]] = [:]

        func _changeDynamic(_ value: Int) -> [Int] {
            guard value > 0 else { return [] }

            if let cached = cache[value] {
                return cached
            }

            var potentialChangeArray: [[Int]] = []

            for coin in sortedCoinSet {
                if value - coin >= 0 {
                    var potentialChange: [Int] = [coin]
                    potentialChange.append(contentsOf: _changeDynamic(value - coin))

                    if potentialChange.reduce(0, +) == value {
                        potentialChangeArray.append(potentialChange)
                    }
                }
            }

            if potentialChangeArray.count > 0 {
                let sortedPotentialChangeArray = potentialChangeArray.sorted(by: { $0.count < $1.count })
                cache[value] = sortedPotentialChangeArray[0]
                return sortedPotentialChangeArray[0]
            }

            return []
        }

        let change: [Int] = _changeDynamic(value)

        if change.reduce(0, +) != value {
            throw MinimumCoinChangeError.noRestPossibleForTheGivenValue
        }

        return change
    }
}
```

## References

- [그리디 알고리즘과 다이나믹 프로그래밍 비교](http://philoz.me/2017/07/12/%EA%B7%B8%EB%A6%AC%EB%94%94-%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98%EA%B3%BC-%EB%8B%A4%EC%9D%B4%EB%82%98%EB%AF%B9-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D-%EB%B9%84%EA%B5%90/)
- [[알고리즘] Greedy Algorithm(욕심쟁이 알고리즘)](http://ujink.tistory.com/10)
- [Greedy](http://www.incodom.kr/Greedy)
- [Minimum Coin Change - Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club/blob/master/MinimumCoinChange/Sources/MinimumCoinChange.swift)