import java.util.*;

/*
 * MergeSort
 * Divide & Conquer 전략을 이용해 정렬하는 방법으로 재귀적 방법을 사용한다.
 * 이전의 기본 정렬과 다르게 O(nlogn)의 빠른 시간 복잡도를 보인다.
 * 이는 평균적으로나 최악이나 같아 안정적이라 할 수 있다.
 * 대신 임의의 빈 배열을 만들어 사용하여 O(n)의 공간 복잡도를 보인다.
 * 그러나 연결 리스트에서는 O(1)만 필요해 연결 리스트의 정렬에 적합하다.
 */

public class MergeSort {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int[] testArr = {3, 5, 1, 9, 2};
		int[] sortedArr = merge_sort(testArr, 0, testArr.length - 1);
		
		for (int num: sortedArr) {
			System.out.print(num);
		}
	}
	
	public static int[] merge_sort(int[] arr, int p, int r) {
		if (p < r) {
			int q = (p + r) / 2;
			
			merge_sort(arr, p, q);
			merge_sort(arr, q + 1, r);
			merge(arr, p, q, r);
		}
		
		return arr;
	}
	
	public static void merge(int[] arr, int p, int q, int r) {
		// 정렬된 arr[p...q]와 arr[q+1...r]을 합쳐
		// 정렬된 arr[p...r]을 만든다.
		int i = p;
		int j = q + 1;
		
		int[] tempArr = new int[arr.length];
		
		int k = p;
		
		while (i <= q && j <= r) {
			if (arr[i] <= arr[j]) {
				tempArr[k] = arr[i];
				i++;
			} else {
				tempArr[k] = arr[j];
				j++;
			}
			
			k++;
		}
		
		// 남아 있는 것 처리
		// 1) 왼쪽이 남아 있으면 
		while (i <= q) {
			tempArr[k] = arr[i];
			i++;
			k++;
		} 
		// 2) 오른쪽이 남아 있으면 
		while (j <= r) {
			tempArr[k] = arr[j];
			j++;
			k++;
		}
		
		for (int h = p; h <= r; h++) {
			arr[h] = tempArr[h];
		}
	}
}
