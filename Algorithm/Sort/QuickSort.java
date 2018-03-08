/*
 * QuickSort
 * Divide&Conquer의 방식의 정렬로 재귀를 사용한다.
 * Pivot을 두어 그것을 기준으로 
 * 왼쪽은 피벗의 값보다 작은 배열,
 * 오른쪽은 피벗의 값보다 큰 배열로 나누어 다시 정렬을 한다.
 * 이 때 주의할 것은 피벗은 이미 정렬된 상태이기 때문에 재귀를 할 때 제외한다.
 * 
 * 최악의 경우(이미 정렬된 경우) O(n^2)의 시간복잡도를 보이지만,
 * 평균, 최상의 경우 O(nlogn)의 시간복잡도를 보인다.
 * 그리고 보통의 경우에 빠른 정렬 방법이다.
 */
public class QuickSort {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int[] testArr = {3, 5, 1, 9, 2};
		int[] sortedArr = quick_sort(testArr, 0, testArr.length - 1);
		
		for (int num: sortedArr) {
			System.out.print(num);
		}
	}
	
	public static int[] quick_sort(int[] arr, int p, int r) {
		if (p < r) {
			int q = partition(arr, p, r);
			quick_sort(arr, p, q - 1);
			quick_sort(arr, q + 1, r);
		}
		
		return arr;
	}
	
	public static int partition(int[] arr, int p, int r) {
		// 배열 arr[p...r]의 원소들을 arr[r], 즉 pivot을 기준으로 양쪽으로 재배치하고
		// A[r]이 위치한 자리를 반환한다.
		int pivot = arr[r];
		int lastLowerIndex = p - 1;
		
		for (int currentCheckIndex = p; currentCheckIndex < r; currentCheckIndex++) {
			if (arr[currentCheckIndex] < pivot) {
				lastLowerIndex++;
				
				// arr[lastLowerIndex]와 arr[currentCheckIndex]를 바꿔준다.
				int temp = arr[lastLowerIndex];
				arr[lastLowerIndex] = arr[currentCheckIndex];
				arr[currentCheckIndex] = temp;
			}
		}
		// pivot의 위치를 잡아준다.
		int temp = arr[lastLowerIndex + 1];
		arr[lastLowerIndex + 1] = pivot;
		arr[r] = temp;
		
		return lastLowerIndex + 1;
	}
}
