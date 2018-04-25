# [Fraudulent Activity Notifications](https://www.hackerrank.com/challenges/fraudulent-activity-notifications/problem)
n일 중 한 날의 소비가 d일 만큼의 과거 기록의 median 값의 두 배가 넘는 날의 갯수를 찾는 문제.

## 생각한 방법
처음에 생각한 방법은 가장 단순하게 d일씩 잘라서 정렬 후 median 값을 구하는 것이었다. 그러나 이것은 매우 비효율적인 방법이라 시간 검사에서 바로 탈락했다. 검색 결과 알게된 것이 작은 수들의 집합을 정렬할 때 *Counting Sort*를 사용하면 효율적이라는 것.
1. countArr와 intList를 통해 d일 동안의 과거 기록을 계속 유지한다. countArr는 countingSort에 사용될 배열이고 intList는 정렬한 수들의 리스트이다.
    - 이 때 countArr를 유지하는 것은 countingSort를 좀 더 효율적으로 하기 위해서이다.   
2. for 문을 돌며 expenditure 배열의 d 인덱스부터 검사한다.
3. countArr와 intList로부터 정렬된 배열을 얻고 median을 구해 검사한다.

이러한 방법을 생각해서 적용했지만 인덱스 에러가 나 풀지를 못했다.

## 유의할 점

### 가능한 수의 집합이 작은 정렬일 경우 'Counting Sort'가 효율적이다.
Counting sort는 다음과 같이 동작한다.
1. 배열을 돌며 각 수의 갯수를 새로운 배열에 저장한다.
2. 새로운 배열에서 수의 누적합을 저장할 배열을 만든다.
3. 누적 합 배열의 각 항목은 각 수들의 인덱스가 된다. 예를 들어 0 인덱스의 값이 2라면 0은 정렬될 배열의 0, 1 인덱스를 차지한다.


## 제출 코드
``` java
import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {

    static int activityNotifications(int[] expenditure, int d) {
        // Complete this function
        int count = 0;
        ArrayList<Integer> intList = new ArrayList<>();
        for (int i = 0; i < d; i++) {
            intList.add(expenditure[i]);
        }

        // 이것을 게속 유지하기
        int[] countArr = new int[201];
        for (int num: intList) {
            countArr[num]++;
        }
        for (int i = d; i < expenditure.length; i++) {
            if (i != d) {
                countArr[expenditure[intList.get(0)]]--;
                countArr[expenditure[i - 1]]++;

                intList.remove(0);
                intList.add(expenditure[i - 1]);
            }

            double median = getMedian(countingSort(countArr, intList));
            if (expenditure[i] >= 2 * median) {
                count++;
            }
        }

        return count;
    }

    static double getMedian(int[] arr) {
        if (arr.length % 2 != 0) {
            return arr[arr.length / 2];
        } else {
            return ((double)arr[arr.length / 2 - 1] + (double)arr[arr.length / 2]) / 2;
        }
    }

    static int[] countingSort(int[] countArr, ArrayList<Integer> intList) {
        // 누적 합 구하기
        int[] sumArr = new int[201];
        int sum = 0;
        for (int i = 0; i < countArr.length; i++) {
            sum += countArr[i];
            sumArr[i] += sum;
        }

        int[] result = new int[intList.size()];
        for (int num: intList) {
            result[sumArr[num] - 1] = num;
            sumArr[num]--;
        }

        return result;
    }
    
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        int d = in.nextInt();
        int[] expenditure = new int[n];
        for(int expenditure_i = 0; expenditure_i < n; expenditure_i++){
            expenditure[expenditure_i] = in.nextInt();
        }
        int result = activityNotifications(expenditure, d);
        System.out.println(result);
        in.close();
    }
}

```