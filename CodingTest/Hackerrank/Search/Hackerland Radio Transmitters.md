# [Hackerland Radio Transmitters](https://www.hackerrank.com/challenges/hackerland-radio-transmitters/problem)

## 생각한 방법
그리디 알고리즘이 떠올랐고 처음 집부터 최대한 먼 거리로 나가도록 하는 로직을 생각했다.
1. 배열을 정렬한다.
2. startHouse와 maximumHouse를 유지하는 데, 각각 한 범위의 첫 번째 집, 중간까지 최대한 멀리 간 집을 의미한다.
3. for 문을 돌며 체크하는데 만약 현재 체크하는 집이 maximumHouse + k 보다 크다면 현재 범위에 속하지 않기 때문에 위의 자료구조를 초기화해주고 count를 늘려준다.

## 유의할 점
- 굳이 List를 쓰지 않아도 되는 것은 쓰지 말자. 습관처럼 쓰고 싶어지는데 효율성에서 별로 좋지 않다.

## 제출 코드
``` java
import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {

    static int hackerlandRadioTransmitters(int[] x, int k) {
        Arrays.sort(x);

        int count = 0;
        int startHouse = x[0];
        int maximumHouse = x[0];

        for (int i = 0; i < x.length; i++) {
            int currentHouse = x[i];

            if (i == 0) {
                continue;
            }

            if (currentHouse <= startHouse + k) {
                maximumHouse = currentHouse;
            } else {
                if (currentHouse > maximumHouse + k) {
                    // 새롭게 시작해야 함
                    startHouse = currentHouse;
                    maximumHouse = currentHouse;
                    count++;
                }
            }
        }

        return count + 1;
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        int k = in.nextInt();
        int[] x = new int[n];
        for(int x_i = 0; x_i < n; x_i++){
            x[x_i] = in.nextInt();
        }
        int result = hackerlandRadioTransmitters(x, k);
        System.out.println(result);
        in.close();
    }
}

```