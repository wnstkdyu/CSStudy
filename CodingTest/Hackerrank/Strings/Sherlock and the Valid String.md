# [Sherlock and the Valid String](https://www.hackerrank.com/challenges/sherlock-and-valid-string/problem)
문자열 s가 주어지고 s 안의 알파벳의 갯수가 모두 같으면 valid, 아니면 invalid하다. 이 때 하나의 알파벳을 지울 수 있는데, 이 때 검사를 해도 결과가 나오도록 한다.

예를 들어 abcd는 valid, abcdd도 valid이다.

## 생각한 방법
1. for 문을 돌며 Character 별로 갯수를 저장하는 HashMap을 만든다.
2. HashMap의 values를 정렬된 Array로 받아 놓는다.
3. isSame() 메서드를 통해 Array 안의 원소들이 같은지 확인한다.  
    - 만약 같지 않다면 첫째 자리 원소, 마지막 원소에서 1을 뺀 결과를 다시 isSame()을 돌려 확인한다.
4. 여기까지 걸러지지 않는다면 "NO"를 반환한다.
  
## 유의할 점

### 자바에서는 참조가 기본!
배열에서 배열을 만들 때 주의하자. `Arrays.copyOf`를 사용해야 복사가 되고 새 인스턴스가 만들어진다.
``` java
Integer[] firstValuesArray = Arrays.copyOf(valuesArray, valuesArray.length);
```

### Integer의 대수 비교는 intValue()를 사용하자.
``` java
arr[i + 1].intValue() != arr[i].intValue()
```

## 제출 코드

``` java
import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {

    static String isValid(String s){
        if (s.length() == 0 || s.length() == 1) {
            return "YES";
        }

        // Complete this function
        Map<Character, Integer> characterMap = new HashMap<>();

        for (char c: s.toCharArray()) {
            if (characterMap.containsKey(c)) {
                Integer existedValue = characterMap.get(c);
                characterMap.put(c, existedValue + 1);
            } else {
                characterMap.put(c, 1);
            }
        }

        Integer[] valuesArray = characterMap.values().toArray(new Integer[characterMap.size()]);
        Arrays.sort(valuesArray);

        if (isSame(valuesArray)) {
            return "YES";
        } else {
            // 첫 번째에서 1을 뺀 뒤 같은지 보기.
            Integer[] firstValuesArray = Arrays.copyOf(valuesArray, valuesArray.length);
            firstValuesArray[0]--;

            if (isSame(firstValuesArray)) {
                return "YES";
            }

            // 마지막에서 1을 뺀 뒤 같은지 보기.
            Integer[] lastValuesArray = Arrays.copyOf(valuesArray, valuesArray.length);
            lastValuesArray[lastValuesArray.length - 1]--;

            if (isSame(lastValuesArray)) {
                return "YES";
            }
        }

        return "NO";
    }

    static boolean isSame(Integer[] arr) {
        for (int i = 0; i < arr.length - 1; i++) {
            if (arr[i + 1].intValue() != arr[i].intValue()) {
                if (arr[i + 1] != 0 && arr[i] != 0) {
                    return false;
                }
            }
        }

        return true;
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        String s = in.next();
        String result = isValid(s);
        System.out.println(result);
    }
}
```