# Big Sorting
기본적인 정렬 문제이다. 매우 큰 숫자가 주어지기 때문에 시간을 유의해야 한다.

## 생각한 방법
처음에는 문자를 다시 숫자로, 숫자를 다시 문자로 바꾸는 방법을 생각했었다. 그러나 `parseInt()` 메서드에서 에러가 일어나고 시간 복잡도 상 문제가 있었다. 그래서 문자를 숫자로 바꾸지 말고 해보자고 생각했다.
1. `Arrays.sort()`를 통해 정렬을 한다.
2. 정렬할 때는 먼저 길이 비교를 해서 긴 것을 뒤로 하고 만약 길이가 같을 경우 문자 하나하나를 숫자로 형 변환해서 비교하자.

두 번째 방법에서 좀 더 찾아보니 `compareTo()`를 사용하면 되어서 바꾸었다. 

**그러나 Test Case #6에서 시간 초과가 일어나는 것을 해결하지 못했다**.
## 유의할 점

### Comparator 오버라이드
새 비교 연산을 적용하고 싶을 때 사용한다. int를 반환하며 **오름차순을 기준으로 -1이면 크고, 1이면 작고, 0이면 같다**.
``` java
Arrays.sort(unsorted, new Comparator<String>() {
    @Override
    public int compare(String o1, String o2) {
        if (o1.length() == o2.length()) {
            return o1.compareTo(o2);
        }

        return o1.length() - o2.length();
    }
});
```

## 제출 코드
``` java
import java.io.*;
import java.math.*;
import java.text.*;
import java.util.*;
import java.util.regex.*;

public class Solution {
    static String[] bigSorting(String[] unsorted) {
        Arrays.sort(unsorted, new Comparator<String>() {
            @Override
            public int compare(String o1, String o2) {
                if (o1.length() == o2.length()) {
                    return o1.compareTo(o2);
                }

                return o1.length() - o2.length();
            }
        });

        return unsorted;
    }

    private static final Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) throws IOException {
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(System.getenv("OUTPUT_PATH")));

        int n = scanner.nextInt();
        scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])*");

        String[] unsorted = new String[n];

        for (int unsortedItr = 0; unsortedItr < n; unsortedItr++) {
            String unsortedItem = scanner.nextLine();
            scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])*");
            unsorted[unsortedItr] = unsortedItem;
        }
        scanner.close();
        
        String[] result = bigSorting(unsorted);

        for (int resultItr = 0; resultItr < result.length; resultItr++) {
            bufferedWriter.write(result[resultItr]);

            if (resultItr != result.length - 1) {
                bufferedWriter.write("\n");
            }
        }

        bufferedWriter.newLine();

        bufferedWriter.close();

        scanner.close();
    }
}
```