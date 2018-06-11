// 선택 정렬
// 가장 작은 수를 앞으로, 또는 가장 큰 수를 뒤로 보내는 방식으로 정렬한다.
func selectionSort(arr: [Int]) -> [Int] {
    var ansArr: [Int] = arr
    
    for i in ansArr.indices {
        var minIndex: Int = i
        
        for j in ansArr.indices.dropFirst(i + 1) {
            minIndex = ansArr[j] < ansArr[minIndex] ? j : minIndex
        }
        
        ansArr.swapAt(i, minIndex)
    }
    
    return ansArr
}
