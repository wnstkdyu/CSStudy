// 삽입 정렬
// 이미 정렬된 앞의 배열에 하나씩 넣어 위치를 잡아 준다.
// 인덱스만 저장해 실제 옮기는 것은 맨 나중에 한다.
func insertionSort(arr: [Int]) -> [Int] {
    var ansArr: [Int] = arr
    
    for i in ansArr.indices {
        guard i > 0 else { continue }
        
        let key = ansArr[i]
        var j = i - 1
        
        while j >= 0 && ansArr[j] > key {
            ansArr[j + 1] = ansArr[j]
            j -= 1
        }
        
        ansArr[j + 1] = key
    }
    
    return ansArr
}