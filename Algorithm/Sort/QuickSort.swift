// 퀵 정렬
// 분할 정복이지만 병합 과정이 없음. 분할 과정에서 이미 넣어지기 때문.
// 멋진 코드여서 가져와서 수정했다.
// 출처: http://minsone.github.io/programming/quick-sort-in-swift
func quickSort(array: [Int]) -> [Int] {
    guard !array.isEmpty else { return [] }
    
    let pivot = array[0]
    
    return quickSort(array: varArray.filter{$0 <= pivot}) + [pivot] + quickSort(array: varArray.filter{$0 > pivot})
}

func quickSort<T: Comparable>(array: [T]) -> [T] {
    guard !array.isEmpty else { return [] }
    
    let pivot = array[0]
    
    return quickSort(array: array.filter { $0 <= pivot }) + [pivot] + quickSort(array: array.filter { $0 > pivot })
}