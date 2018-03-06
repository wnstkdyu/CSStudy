/*
 * BubbleSort
 * 앞 인덱스와 뒤의 인덱스의 값을 비교해 정렬하는 방식
 * 하나의 배열을 사용하므로 공간복잡도는 O(1)
 * for문을 두 번 돌며 정렬하므로 시간복잡도는 O(n^2)
*/
public class BubbleSort {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		test();
	}
	
	// BubbleSort를 구현한다.
	public static int[] sort(int[] arr) {
		for (int i = 0; i < arr.length - 1; i++) {
			for (int j = 0; j < arr.length - 1 - i; j++) {
				if (arr[j] > arr[j + 1]) {
					int temp = arr[j + 1];
					
					arr[j + 1] = arr[j];
					arr[j] = temp;
				}
			}
		}
		
		return arr;
	}
	
	public static void test() {
		int[] testArr = {3, 5, 1, 9, 2};
		
		int[] sortedArr = sort(testArr);
		for (int num: sortedArr) {
			System.out.print(num);
		}
	}
}
