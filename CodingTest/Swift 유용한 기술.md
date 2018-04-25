# Swift 유용한 기술

## String 입력 받기
``` Swift
let inputString = readLine()
```
readLine() 함수로 입력을 받을 수 있으며 `String?`을 리턴하므로 `옵셔널 언래핑`을 해줘야 한다.

### 추가적 기술
``` Swift
// http://qiita.com/y_mazun/items/dc2a0cad8da1c0e88a40
extension String: Collection {} // to enable String.split()

func readInput() -> Int {
    return readLine().flatMap { Int($0) }!
}

func readInput() -> [Int] {
    return readLine().flatMap { $0.split(separator: " ").flatMap { Int($0)} }!
}

func readInput() -> (Int, Int) {
    let inputs = readInput() as [Int]
    return (inputs[0], inputs[1])
}

func readInput() -> Double {
    return readLine().flatMap { Double($0) }!
}

func readInput() -> [Double] {
    return readLine().flatMap { $0.split(separator: " ").flatMap { Double($0)} }!
}

func readInput() -> (Double, Double) {
    let inputs = readInput() as [Double]
    return (inputs[0], inputs[1])
}

func readInput() -> String {
    return readLine()!
}

func readInput() -> [String] {
    return readLine().flatMap { $0.split(separator: " ") }!
}
```

## String 쪼개기
입력 받은 String을 쪼개는 방법이다.

**1. components(seperatedBy:" ")**

**String의 배열**을 리턴하는 함수이다.

하나의 문자열을 기준으로 나눌 수도 있고,

``` Swift
let str = "alpaca hi!"
let arr = str.components(separatedBy: " ")
// ["alpaca", "hi!"]
```

여러 개의 인자를 받아 나눌 수도 있다.
``` Swift
let str2 = "5+4-2/3"
let arr2 = str.components(separatedBy: ["+", "-", "/"])
// ["5", "4", "2", "3"]
```

**2. split(separator: " ")**

**Substring의 배열**을 반환하는 함수이다.

``` Swift
let str = "alpaca hi!"
let arr = str.split(separator: " ")
// ["alpaca", "hi!"]
```

**3. indices**

Swift에서는 String이 콜렉션 타입이기 때문에 인덱스로 접근이 가능하다.

``` Swift
let str = "alpaca hi!"

for s in str {
    print(s)
}
```

## String에서 문자만 남기기

`Character`의 대소 관계를 이용해 filter를 사용해 얻는다. 
```Swift
let str = str.filter { $0 >= "a" && $0 <= "z"}
```
