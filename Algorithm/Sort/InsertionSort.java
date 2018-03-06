import java.util.*;

/*
 * InsertionSort
 * 이미 정렬된 앞의 배열에 자신이 들어갈 자리를 찾아 정렬하는 방법.
 * 즉 n째 원소를 정렬할 때, 0..n-1 인덱스까지는 정렬이 되어 있다.
 * i번째 원소와 i-1부터 0까지 비교하며 비교대상보다 크면 뒤로 미루고
 * 작거나 같으면 그 위치 다음 부분에 비교 대상을 넣어준다.
 * 공간복잡도는 O(1).
 * 시간복잡도는 O(n^2).
 */

public class InsertionSort {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int[] testArr = {3, 5, 1, 9, 2};
		test(testArr);
	}
	
	public static int[] sort(int[] arr) {
		for (int i = 1; i < arr.length; i++) {
			int key = arr[i];
			int j = i - 1;
			
			while (j >= 0 && arr[j] > key) {
				arr[j + 1] = arr[j];
				j--;
			}
			
			arr[j + 1] = key;
		}
		
		return arr;
	}
	
	public static void test(int[] testArr) {
		int[] sortedArr = sort(testArr);
		
		for (int num: sortedArr) {
			System.out.print(num);
		}
	}
}
