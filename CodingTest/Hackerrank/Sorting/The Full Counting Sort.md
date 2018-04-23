# The Full Counting Sort
입력값으로 정수, 그리고 처음 입력 받은 갯수 만큼 (정수, 문자열)이 들어온다. 이 중 반은 문자열이 "-"로 대체되고 그 다음 튜플의 정수부분이 인덱스가 되어 정렬이 된다. 이 때 들어온 순서는 지켜져야 한다. 정렬된 것들을 출력한다.

## 생각한 방법
1. 일단 int의 배열, String의 배열에 입력값들을 차곡차곡 넣는다.
    - 이 때 정수 값의 최댓값을 기록해 나중에 ArrayList의 갯수로 사용한다.
2. 문자열의 배열 첫 번째 반을 "-"로 바꿔준다.
3. 문제의 예시처럼 ArrayList<String>의 ArrayList를 만들어 입력값들의 정수를 index로 하여 넣어준다.
4. 차례대로 출력한다. 이 때 띄어쓰기를 유의한다.

단순히 반복하는 문제로 생각하고 풀었더니 Test Case #5에서 시간 초과가 난다. 그래서 검색 결과 입력 값이 많을 경우 `Scanner`를 통한 입출력보다 `BufferedReader`와 `BufferedWriter`를 사용하는 것이 더 빠르다는 것을 알게 되었고 이것을 적용하였다.

## 유의할 점

### 입력값이 많을 때는 BufferedReader와 BufferedWriter를 사용하자.
공통적으로 try-catch 구문을 통해 에러 처리를 해줘야 한다.

#### BufferedReader 생성하고 한 문장 읽기
`readLine()`을 하면 문자열이 반환된다. 마지막에는 `close()`를 해주자.
``` java
BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
int n = 0;
try {
    n = Integer.parseInt(reader.readLine());
} catch (IOException e){}
...
// 마지막에는 close()를 해주자.
try {
    reader.close();
} catch (IOException e) {}
```
#### StringTokenizer를 이용해 쪼개서 읽기
띄어쓰기를 기준으로 읽을 수 있다.
``` java
try {
    StringTokenizer tokenizer = new StringTokenizer(reader.readLine());
    x = Integer.parseInt(tokenizer.nextToken());
    s = tokenizer.nextToken();
} catch (IOException e) {}
```

#### BufferedWriter를 이용한 출력
마찬가지로 생성 후 `write()` 메서드를 통해 출력한다. 최종적으로 `close()`를 하는데 그 전에 계속 출력하고 싶다면 `flush()`를 사용한다.
``` java
BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(System.out));
for (ArrayList<String> arrayList: sortedList) {
    for (String str: arrayList) {
        try {
            writer.write(str + " ");
            writer.flush();
        } catch (IOException e) {}
    }
}

try {
    writer.close();
} catch (IOException e) {}
```

## 제출 코드
``` java
import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {
    public static void main(String[] args) {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int n = 0;
        try {
            n = Integer.parseInt(reader.readLine());
        } catch (IOException e){}

        int[] intArr = new int[n];
        String[] strArr = new String[n];
        int max = 0;
        for(int a0 = 0; a0 < n; a0++){
            int x = 0;
            String s = "";
            try {
                StringTokenizer tokenizer = new StringTokenizer(reader.readLine());
                x = Integer.parseInt(tokenizer.nextToken());
                s = tokenizer.nextToken();
            } catch (IOException e) {}
            if (max < x) {
                max = x;
            }

            intArr[a0] = x;
            if (a0 < n / 2) {
                strArr[a0] = "-";
            } else {
                strArr[a0] = s;
            }
        }
        try {
            reader.close();
        } catch (IOException e) {}

        write(max, intArr, strArr);
    }
    
    static void write(int max, int[] intArr, String[] strArr) {
        List<ArrayList<String>> sortedList = new ArrayList<>();
        for (int i = 0; i <= max; i++) {
            sortedList.add(new ArrayList<>());
        }

        for (int i = 0; i < intArr.length; i++) {
            ArrayList<String> list = sortedList.get(intArr[i]);
            list.add(strArr[i]);
        }

        BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(System.out));
        for (ArrayList<String> arrayList: sortedList) {
            for (String str: arrayList) {
                try {
                    writer.write(str + " ");
                    writer.flush();
                } catch (IOException e) {}
            }
        }

        try {
            writer.close();
        } catch (IOException e) {}
    }
}

```