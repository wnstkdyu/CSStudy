# [Pairs](https://www.hackerrank.com/challenges/pairs/problem)

## 생각한 방법
1. 입력을 받을 때 숫자를 있는지 알려주는 HashMap을 작성한다.
2. for 문으로 배열을 돌며 k를 더한 값이 있는지 HashMap을 통해 확인하고 있다면 count를 늘려준다.

## 유의할 점
- 이 문제도 전 문제와 마찬가지로 각 원소가 unique하기 때문에 수월하게 HashMap을 통해 풀 수 있었다.

## 제출 코드
``` java
import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {
    static HashMap<Integer, Integer> indexMap = new HashMap<>();

    static int pairs(int k, int[] arr) {
        int count = 0;
        
        for (int num: arr) {
            int searchNum = num + k;
            
            if (indexMap.get(searchNum) != null) {
                count++;
            }
        }
        
        return count;
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        int k = in.nextInt();
        int[] arr = new int[n];
        for(int arr_i = 0; arr_i < n; arr_i++){
            arr[arr_i] = in.nextInt();
            indexMap.put(arr[arr_i], arr_i);
        }
        int result = pairs(k, arr);
        System.out.println(result);
        in.close();
    }
}
```