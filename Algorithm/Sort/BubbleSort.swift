// 버블 정렬
// 앞, 뒤 인덱스를 비교해 계속해서 바꿔준다.
func bubbleSort(arr: [Int]) -> [Int] {
    var ansArr: [Int] = arr
    
    for i in ansArr.indices {
        for j in ansArr.indices.dropLast(i + 1) {
            guard ansArr[j] > ansArr[j + 1] else { continue }
            ansArr.swapAt(j, j + 1)
        }
    }
    
    return ansArr
}