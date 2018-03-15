# KaKao 블라인드 채용

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
