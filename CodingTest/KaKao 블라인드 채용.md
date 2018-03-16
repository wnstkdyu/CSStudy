# KaKao 블라인드 채용 1라운드
http://tech.kakao.com/2017/09/27/kakao-blind-recruitment-round-1/

## 1. 비밀 지도(난이도: 하)

2진수로 변환하는 작업을 배열로 반환하는 방법을 사용했는데 더 효율적인 방법은 없는지 고민해봐야겠다.
``` Swift
let n: Int = 5
let arr1: [Int] = [9, 20, 28, 18, 11]
let arr2: [Int] = [30, 1, 21, 17, 28]

// 2진수로 변환하는 작업
let twoArr1 = arr1.map { (num) -> [Int] in
    var ansArr: [Int] = Array(repeating: 0, count: n)
    var num = num
    for i in ansArr.indices {
        ansArr[ansArr.count - 1 - i] = num % 2
        num = num / 2
    }

    return ansArr
}

let twoArr2 = arr2.map { (num) -> [Int] in
    var ansArr: [Int] = Array(repeating: 0, count: n)
    var num = num
    for i in ansArr.indices {
        ansArr[ansArr.count - 1 - i] = num % 2
        num = num / 2
    }

    return ansArr
}

var ansArr: [String] = []
for i in twoArr1.indices {
    var ansString = ""
    for j in twoArr1[i].indices {
        if twoArr1[i][j] == 1 || twoArr2[i][j] == 1 {
            ansString.append("#")
        } else {
            ansString.append(" ")
        }
    }
    ansArr.append(ansString)
}

for s in ansArr {
    print(s)
}
```

## 2. 다트 게임(난이도: 하)

``` Swift
let inputString = readLine()!

var numArr: [Int] = []
var optionArr: [Int: Int?] = [0: nil, 1: nil, 2: nil]

for char in inputString {
    if let num = Int(String(char)) {
        // 방금 들어간 숫자가 1이고 지금 들어온 애가 0이라면 붙여줘야함.
        if let lastNum = numArr.last, lastNum == 1, num == 0 {
            numArr.removeLast()
            numArr.append(Int("\(lastNum)" + "\(num)")!)
        } else {
            numArr.append(num)
        }

        continue
    }

    switch char {
    case "S":
        numArr[numArr.endIndex - 1] = numArr[numArr.endIndex - 1]
    case "D":
        let num = numArr[numArr.endIndex - 1]
        numArr[numArr.endIndex - 1] = num * num
    case "T":
        let num = numArr[numArr.endIndex - 1]
        numArr[numArr.endIndex - 1] = num * num * num
    case "*":
        if numArr.count == 3 {
            // 1, 2 인덱스 값 업데이트
            if let option = optionArr[2], let option2 = option {
                optionArr.updateValue(option2 * 2, forKey: 2)
            } else {
                optionArr.updateValue(2, forKey: 2)
            }

            if let option = optionArr[1], let option2 = option {
                optionArr.updateValue(option2 * 2, forKey: 1)
            } else {
                optionArr.updateValue(2, forKey: 1)
            }
        } else {
            // 0, 1 인덱스 값 업데이트
            if let option = optionArr[numArr.count - 1], let option2 = option {
                optionArr.updateValue(option2 * 2, forKey: numArr.count - 1)
            } else {
                optionArr.updateValue(2, forKey: numArr.count - 1)
            }

            if let option = optionArr[numArr.count - 2], let option2 = option {
                optionArr.updateValue(option2 * 2, forKey: numArr.count - 2)
            } else {
                optionArr.updateValue(2, forKey: numArr.count - 2)
            }
        }
    case "#":
        if let option = optionArr[numArr.endIndex - 1], let option2 = option {
            optionArr.updateValue(option2 * -1, forKey: numArr.endIndex - 1)
        } else {
            optionArr.updateValue(-1, forKey: numArr.endIndex - 1)
        }
    default:
        continue
    }
}

var ans: Int = 0
for i in numArr.indices {
    if let option = optionArr[i], let option2 = option {
        ans += numArr[i] * option2
    } else {
        ans += numArr[i]
    }
}
```

## 3. 캐시(난이도: 하)

LRU를 사용하는 문제라 스택을 사용해서 풀었다.

``` Swift
func solve() -> Int {
    guard cacheSize > 0 else {
        return cities.count * 5
    }

    var cacheStack: [String] = []
    var time: Int = 0

    for city in cities {
        if cacheStack.contains(city) {
            time += 1

            // 최근에 썼던 것을 스택의 맨 밑으로 보내야 함.
            cacheStack = cacheStack.filter { $0 == city }
            cacheStack.insert(city, at: 0)
        } else {
            time += 5

            if cacheStack.count == cacheSize {
                // 맨 위에 있던 것을 빼고
                cacheStack.popLast()
            } else {
                cacheStack = cacheStack.filter { $0 == city }
            }

            // 맨 아래에 최근 것을 넣기
            cacheStack.insert(city, at: 0)
        }
    }

    return time
}
```

## 4. 셔틀버스(난이도: 중)

입력으로 들어오는 시간 형태의 문재열 배열을 잘 `파싱`하는 것이 중요하고 분을 더하거나 뺄 때 `나머지 연산`을 통해 값을 구하는 것이 포인트이다.

많은 경우의 수가 있어 고려해야 할 것을 놓치는 어려운 문제 같다.

``` Swift
struct Time {
    var hour: Int
    var minute: Int

    init(str: String) {
        let strArr = str.components(separatedBy: ":")

        hour = Int(strArr.first!)!
        minute = Int(strArr.last!)!
    }

    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }

    func afterMinute(t: Int) -> Time {
        var newTime = self

        if newTime.minute + t >= 60 {
            newTime.hour += (newTime.minute + t) / 60
        }

        newTime.minute = (newTime.minute + t) % 60

        return newTime
    }

    func beforeMinute(t: Int) -> Time {
        var newTime = self

        if newTime.minute - t < 0 {
            newTime.hour -= 1
        }

        newTime.minute = (newTime.minute - t + 60) % 60

        return newTime
    }

    func description() -> String {
        let hourString: String
        if hour < 10 {
            hourString = "0\(hour)"
        } else {
            hourString = "\(hour)"
        }

        let minuteString: String
        if minute < 10 {
            minuteString = "0\(minute)"
        } else {
            minuteString = "\(minute)"
        }

        return "\(hourString):\(minuteString)"
    }
}

func solve(n: Int, t: Int, m: Int, timeTable: [String]) -> String {
    // 1. time을 내가 쓸 수 있게 변경
    var personTimeTable = timeTable.map { Time(str: $0) }.sorted { (time1, time2) -> Bool in
        if time1.hour > time2.hour {
            return false
        } else if time1.hour == time2.hour && time1.minute > time2.minute {
            return false
        }

        return true
    }

    // 2. 버스의 도착시간 TimeTable을 만든다.
    let busTimeTable: [Time] = {
        var busTimeTable: [Time] = []

        for i in 0..<n {
            busTimeTable.append(Time(hour: 9, minute: 0).afterMinute(t: t * i))
        }

        return busTimeTable
    }()

    // 3. [버스 도착 시간: [사람]]을 만든다. 이 때 사람 배열은 m을 초과할 수 없게 한다.
    // 초과될 경우에는 다음 버스에 넣는다.
    let tupleArray: [(Time, [Time])] = {
        var tupleArray: [(Time, [Time])] = []

        for busTime in busTimeTable {
            var personArr: [Time] = []

            for personTime in personTimeTable {
                guard personArr.count != m else {
                    // 정원 초과
                    break
                }

                if personTime.hour < busTime.hour {
                    personArr.append(personTime)
                } else if personTime.hour == busTime.hour && personTime.minute <= busTime.minute {
                    personArr.append(personTime)
                }
            }

            // 넣어진 사람은 제거해주기
            if !personArr.isEmpty {
                personTimeTable.removeSubrange(0...personArr.count - 1)
            }

            tupleArray.append((busTime, personArr))
        }

        return tupleArray
    }()

    // 4. tupleArray를 바탕으로 가장 마지막에 가능한 수를 찾자
    guard let lastTime = tupleArray.last else { return "" }

    if lastTime.1.count == m {
        return Time(hour: lastTime.1.last!.hour ,minute: lastTime.1.last!.minute)
            .beforeMinute(t: 1)
            .description()
    } else {
        return lastTime.0.description()
    }
}
```

## 5. 뉴스 클러스터링(난이도: 중)

`Set`를 이용해서 교집합, 합집합을 구하는 것이 포인트인 것 같다. 특수문자, 공백, 숫자를 제거하는 법도 알아두면 두고두고 쓰일 것이다.

``` Swift
func solution(str1: String, str2: String) -> Int {
    // 1,2. 다중 집합을 만든 후 정렬한다.
    let str1Arr = makeMultipleArray(str: str1.lowercased()).sorted { $0 < $1 }
    let str2Arr = makeMultipleArray(str: str2.lowercased()).sorted { $0 < $1 }

    // 3. 교집합을 구한다.
    //  1) 세트로 일단 만든다.
    let str1Set = Set(str1Arr)
    let str2Set = Set(str2Arr)
    //  2) 교집합을 구한다.
    let intersectionSet = str1Set.intersection(str2Set)
    //  3) 교집합의 원소들의 각 집합의 갯수를 구한 뒤 최솟값을 더해준다.
    var intersectionCount: Double = 0
    for element in intersectionSet {
        let str1Count = str1Arr.filter { $0 == element }.count
        let str2Count = str2Arr.filter { $0 == element }.count
        let finalCount = min(str1Count, str2Count)

        intersectionCount += Double(finalCount)
    }

    // 4. 합집합을 구한다.
    //  1&2) 세트로 만들고 세트의 합집합을 구한다.
    let unionSet = str1Set.union(str2Set)
    //  3) 합집합의 원소들의 각 집합의 갯수를 구한 뒤 최댓값을 더해준다.
    var unionCount: Double = 0
    for element in unionSet {
        let str1Count = str1Arr.filter { $0 == element }.count
        let str2Count = str2Arr.filter { $0 == element }.count
        let finalCount = max(str1Count, str2Count)

        unionCount += Double(finalCount)
    }

    // 공집합인 경우 체크
    guard unionCount != 0 else { return 1 * 65536 }

    let ans: Double = intersectionCount / unionCount

    return Int(ans * 65536)
}

// 다중 집합 만들기 함수
func makeMultipleArray(str: String) -> [String] {
    var ansArray: [String] = []
    for i in str.indices {
        guard i != str.index(before: str.endIndex) else { break }
        ansArray.append(String(str[i...str.index(after: i)]))
    }

    // 특수문자, 숫자, 공백이 들어가 있는 문자들을 제거한다.
    ansArray = ansArray.filter { $0 == $0.filter{ $0 >= "a" && $0 <= "z" }}

    return ansArray
}
```

## 6. 프렌즈4블록(난이도: 상)

2중 배열로 주변의 것들까지 검색해야 하기 때문에 얼마나 빠르게 구현하는지가 관건일 것 같다.

``` Swift
func solution(m: Int, n: Int, board: [String]) -> Int {
    // 1. 블록들을 각각의 자리에 배치
    var blockArr: [[String]] = {
        var blockArr: [[String]] = Array(repeating: [], count: m)

        for i in board.indices {
            for str in board[i] {
                blockArr[i].append(String(str))
            }
        }

        return blockArr
    }()

    var count = 0
    // 2. 배열을 순회하며 체크한다.
    while checkArr(arr: blockArr).1 != 0 {
        let result = checkArr(arr: blockArr)

        blockArr = result.0
        count += result.1
    }

    return count
}

func checkArr(arr: [[String]]) -> ([[String]] ,Int) {
    var set: [(Int, Int)] = []

    for i in 0..<arr.count {
        let floor = arr[i]
        for j in 0..<floor.count {
            let block = floor[j]

            // 위에서부터 밑에 부분만 계속 체크해 나가기
            guard i + 1 < arr.count && j + 1 < floor.count else {
                break
            }

            guard block != "" else { continue }

            let rightBlock = arr[i][j + 1]
            let underBlock = arr[i + 1][j]
            let rightUnderBlock = arr[i + 1][j + 1]

            guard block == rightBlock && block == underBlock && block == rightUnderBlock else {
                continue
            }

            // 기존 set에 인덱스가 없다면 담기
            if !set.contains(where: { $0.0 == i && $0.1 == j }) {
                set.append((i, j))
            }
            if !set.contains(where: { $0.0 == i && $0.1 == j + 1 }) {
                set.append((i, j + 1))
            }
            if !set.contains(where: { $0.0 == i + 1 && $0.1 == j }) {
                set.append((i + 1, j))
            }
            if !set.contains(where: { $0.0 == i + 1 && $0.1 == j + 1 }) {
                set.append((i + 1, j + 1))
            }
        }
    }

    var arr = arr
    // 원래 배열에서 블록들을 제거한다.
    for i in 0..<arr.count {
        let floor = arr[i]

        for j in 0..<floor.count {
            // (i, j)가 set에 들었으면 string을 ""로 바꿔준다.
            guard set.contains(where: { $0.0 == i && $0.1 == j }) else {
                continue
            }

            arr[i][j] = ""
        }
    }

    // 제거된 배열에서 존재하는 빈 공간을 없앤다.
    for i in 0..<arr.count {
        let floor = arr[i]

        for j in 0..<floor.count {
            // 빈 공간을 체크한다.
            guard floor[j] == "" else { continue }

            // 빈 공간이면 위에 존재하는 것을 체크해 있으면 바로 넣어준다.
            for k in 0..<i {
                let checkIndex = i - 1 - k
                if arr[checkIndex][j] != "" {
                    arr[i][j] = arr[checkIndex][j]
                    arr[checkIndex][j] = ""
                }
            }
        }
    }

    return (arr, set.count)
}
```
