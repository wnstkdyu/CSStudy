# [Lily's Homework](https://www.hackerrank.com/challenges/lilys-homework/problem)

## 생각한 방법
1. 배열의 값을 키, 그 값의 인덱스의 ArrayList를 밸류로 하는 HashMap을 만든다. 참조로 인해 두 개씩 만든다.
2. 정렬된 배열, 그리고 역정렬된 배열을 만들어 map과 arr와 함께 `check()` 메서드에 집어넣는다.
3. 인자로 받은 배열의 값을 키로 갖는 리스트를 배열 리스트, 정렬된 배열의 값을 키로 갖는 리스트를 정렬 리스트라 하자. check() 메서드는 정렬된 배열과 비교해 같으면 인자로 받은 map에서 인덱스를 지워준다. 그런데 만약 다르다면 swap 과정을 거쳐야 한다. 구체적으로는 현재 배열의 값을 키로 갖는 배열 리스트에서 현재 인덱스를 지워주고 현재 인덱스의 정렬 배열의 값을 키로 갖는 정렬 리스트의 첫번째 값을 배열 리스트에 넣어준다. 그리고 정렬 리스트의 첫번째 값은 지워주고 마지막으로 배열을 swap한 형태로 바꿔준다.

## 유의할 점

### HashMap을 잘 사용하고 key, value에 익숙해지자

### Java에서 참조를 항상 주의하자
함수에 넘겨줄 때 참조 타입(거의 다 쓰임...)은 계속 참조를 하기 때문에 새 인자를 만들어서 넣자!
예를 들어 배열은 `Arrays.copyOf(arr, arr.length)`를 사용하자.

``` java
int sortedSwap = check(map1, Arrays.copyOf(arr, arr.length), sortedArr);
int reversedSwap = check(map2, Arrays.copyOf(arr, arr.length), reversedArr);
```

## 제출 코드
``` java
import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {

    static int lilysHomework(int[] arr) {
        HashMap<Integer, ArrayList<Integer>> map1 = new HashMap<>();
        HashMap<Integer, ArrayList<Integer>> map2 = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            if (map1.containsKey(arr[i])) {
                map1.get(arr[i]).add(i);
                map2.get(arr[i]).add(i);
            } else {
                ArrayList<Integer> newList1 = new ArrayList<>();
                newList1.add(i);
                ArrayList<Integer> newList2 = new ArrayList<>();
                newList2.add(i);

                map1.put(arr[i], newList1);
                map2.put(arr[i], newList2);
            }
        }

        int[] sortedArr = Arrays.copyOf(arr, arr.length);
        Arrays.sort(sortedArr);
        int[] reversedArr = new int[arr.length];
        for (int i = 0; i < sortedArr.length; i++) {
            reversedArr[i] = sortedArr[sortedArr.length - 1 - i];
        }

        int sortedSwap = check(map1, Arrays.copyOf(arr, arr.length), sortedArr);
        int reversedSwap = check(map2, Arrays.copyOf(arr, arr.length), reversedArr);

        return Math.min(sortedSwap, reversedSwap);
    }

    static int check(HashMap<Integer, ArrayList<Integer>> map, int[] arr, int[] sortedArr) {
        int swapCount = 0;
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == sortedArr[i]) {
                ArrayList<Integer> indexList = map.get(arr[i]);
                indexList.remove((Integer)i);
            } else {
                // arr[i]에 해당하는 리스트를 찾아 i를 지워준다.
                ArrayList<Integer> changedList = map.get(arr[i]);
                changedList.remove((Integer)i);

                ArrayList<Integer> removedList = map.get(sortedArr[i]);
                changedList.add(removedList.get(0));
                arr[removedList.get(0)] = arr[i];
                removedList.remove(0);

                arr[i] = sortedArr[i];

                swapCount++;
            }
        }

        return swapCount;
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        int[] arr = new int[n];
        for(int arr_i = 0; arr_i < n; arr_i++){
            arr[arr_i] = in.nextInt();
        }
        int result = lilysHomework(arr);
        System.out.println(result);
        in.close();
    }
}

```