import java.util.*;

/*
 * SelectionSort
 * 선택 정렬은 다음과 같은 순서로 이루어진다.
 * 1. 주어진 리스트 중 가장 최솟값을 찾는다.
 * 2. 그 값을 맨 앞에 있는 값과 교체한다.
 * 3. 맨 처음 위치를 뺀 나머지 리스트를 같은 방법으로 교체한다.
 * 
 * 인덱스를 저장하는 식으로 하고 교체하는 것은 맨 나중에 한다.
 * 그러나 비교는 여러 번 하게 된다.
 * 공간복잡도는 O(1).
 * 시간복잡도는 O(n^2).
 */

public class SelectionSort {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		int[] testArr = {3, 5, 1, 9, 2};
		test(testArr);
	}
	
	public static int[] sort(int[] arr) {
		for (int i = 0; i < arr.length - 1; i++) {
			int minIndex = i;
			
			for (int j = i + 1; j < arr.length; j++) {
				if (arr[minIndex] > arr[j]) {
					minIndex = j;
				}
			}
			
			int temp = arr[i];
			arr[i] = arr[minIndex];
			arr[minIndex] = temp;
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
