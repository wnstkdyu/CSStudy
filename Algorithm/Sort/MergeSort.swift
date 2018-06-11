// 합병 정렬
// 분할 정복!
func mergeSort(arr: [Int]) -> [Int] {
    let startIndex: Int = 0
    guard let lastIndex: Int = arr.indices.last else { return [] }
    
    guard startIndex < lastIndex else { return arr }
    
    let middleIndex: Int = (startIndex + lastIndex) / 2
    let firstArr = mergeSort(arr: Array(arr[startIndex...middleIndex]))
    let secondArr = mergeSort(arr: Array(arr[middleIndex + 1...lastIndex]))
    
    return merge(firstArr: firstArr, secondArr: secondArr)
}

func merge(firstArr: [Int], secondArr: [Int]) -> [Int] {
    var ansArr: [Int] = []
    
    var firstArrIndex = 0
    var secondArrIndex = 0
    
    while firstArrIndex <= firstArr.count - 1 && secondArrIndex <= secondArr.count - 1 {
        if firstArr[firstArrIndex] < secondArr[secondArrIndex] {
            ansArr.append(firstArr[firstArrIndex])
            firstArrIndex += 1
        } else {
            ansArr.append(secondArr[secondArrIndex])
            secondArrIndex += 1
        }
    }
    
    // 남은 것 처리
    while firstArrIndex <= firstArr.count - 1 {
        ansArr.append(firstArr[firstArrIndex])
        firstArrIndex += 1
    }
    while secondArrIndex <= secondArr.count - 1 {
        ansArr.append(secondArr[secondArrIndex])
        secondArrIndex += 1
    }
    
    return ansArr
}