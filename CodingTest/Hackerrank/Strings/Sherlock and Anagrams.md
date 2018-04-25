# [Sherlock and Anagrams](https://www.hackerrank.com/challenges/sherlock-and-anagrams/problem)
문자열이 주어졌을 때 그 속에서 모든 아나그램을 찾는 문제. 부분 문자열에서도 아나그램을 찾아야 한다.

## 생각한 방법
1. n 길이의 가능한 부분 문자열을 만든다.
2. 각각의 쌍을 만들어 isAnagram() 메서드를 돌린다.
3. true면 카운트를 올린다.
4. 이 과정을 n이 1일 때부터 (문자열 길이 - 1) 까지 돌린다.

## 유의할 점

### List to Array
리스트에서 배열로 할 때는 이 방법을 쓰도록 하자.
``` java
String[] subStringArray = subStringList.toArray(new String[subStringList.size()]);
```

### 객체 간 내용 비교
자바에서 문자열 비교할 때는 `eqauls()`를 사용한다. 이 메서드를 사용하면 객체 안에 있는 내용을 비교한다.

``` Java
sortedStr1.equals(sortedStr2)
```

### charArray to String
`toString()` 메서드를 사용하며 원하는 대로 이루어지지 않았다. 대신 새로운 문자열을 만드는 방법을 쓰자.
``` java
String sortedStr1 = new String(str1CharArr);
```

## 제출 코드
``` Java
import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {

    static int sherlockAndAnagrams(String s){
        // Complete this function
        int anagramCount = 0;

        for (int n = 1; n < s.length(); n++) {
            String[] subStringArr = makeSubStringArray(s, n);
            for (int i = 0; i < subStringArr.length - 1; i++) {
                for (int j = i + 1; j < subStringArr.length; j++) {
                    if (isAnagram(subStringArr[i], subStringArr[j])) {
                        anagramCount++;
                    }
                }
            }
        }

        return anagramCount;
    }

    static String[] makeSubStringArray(String s, int length) {
        List<String> subStringList = new ArrayList<>();
        for (int i = 0; i <= s.length() - length; i++) {
            String subString = s.substring(i, i + length);
            subStringList.add(subString);
        }

        String[] subStringArray = subStringList.toArray(new String[subStringList.size()]);

        return subStringArray;
    }

    static boolean isAnagram(String str1, String str2) {
        // 문제에서 소문자만 주어지기 때문에 바로 알파벳 순서대로 정렬한다.
        char[] str1CharArr = str1.toCharArray();
        Arrays.sort(str1CharArr);
        String sortedStr1 = new String(str1CharArr);

        char[] str2CharArr = str2.toCharArray();
        Arrays.sort(str2CharArr);
        String sortedStr2 = new String(str2CharArr);

        // 정렬된 문자열이 같은지 확인한다.
        if (sortedStr1.equals(sortedStr2)) {
            return true;
        } else {
            return false;
        }
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int q = in.nextInt();
        for(int a0 = 0; a0 < q; a0++){
            String s = in.next();
            int result = sherlockAndAnagrams(s);
            System.out.println(result);
        }
    }
}
```