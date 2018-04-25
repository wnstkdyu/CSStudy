# [Common Child](https://www.hackerrank.com/challenges/common-child/problem)
최장 공통 부분 수열을 구하는 문제로 Dynamic Programming 기법을 사용한다. 이차원 배열을 완성해 나가는 식으로 진행하며 만약 문자열을 구하고 싶으면 배열의 뒷부분부터 대각선으로 증가하는 부분을 캐치해서 문자열을 완성해나가면 된다.

## 생각한 방법
최장 공통 부분 수열을 구하자.

## 유의할 점
**동적 계획법을 공부하자!**

## 제출 코드
``` java
import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {

    static int commonChild(String s1, String s2){
        // 부분 계산 값들을 저장하는 배열. 길이를 +1씩 해준 것은 문자열이 비었을 경우를 고려.
        int[][] memoization = new int[s1.length() + 1][s2.length() + 1];

        // 규칙을 따라 memoization을 채워나간다.
        for (int i = 0; i < memoization.length; i++) {
            for (int j = 0; j < memoization[i].length; j++) {
                // 한 문자열이 빈 문자열일 경우
                if (i == 0 || j == 0) {
                    memoization[i][j] = 0;
                // 마지막 문자열이 같은 경우
                } else if (s1.charAt(i - 1) == s2.charAt(j - 1)) {
                    memoization[i][j] = memoization[i - 1][j - 1] + 1;
                // 마지막 문자열이 다른 경우
                } else {
                    memoization[i][j] = Math.max(memoization[i][j - 1], memoization[i - 1][j]);
                }
            }
        }

        return memoization[s1.length()][s2.length()];
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        String s1 = in.next();
        String s2 = in.next();
        int result = commonChild(s1, s2);
        System.out.println(result);
    }
}
```