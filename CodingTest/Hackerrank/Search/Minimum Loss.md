# [Minimum Loss](https://www.hackerrank.com/challenges/minimum-loss/problem)

## 생각한 방법
구매 가격의 인덱스가 판매 가격의 인덱스보다 적어야 하기 때문에 정렬을 해도 그 인덱스를 알아야 한다. 그래서 처음 생각한 것은 Tuple 클래스를 직접 만드는 것이었다. 그러나 RunTime 에러가 났고 HashMap을 써보기로 하였다.

1. 입력을 받아들일 때 값을 key로, 인덱스를 value로 하는 HashMap을 만들어 나간다.
2. 배열을 정렬한다.
3. 차이를 저장하는 배열을 만들고 for 문을 돌며 차이를 저장하는 배열을 채워나간다.
    1. 채워나갈 때 최소 차이를 유지하고 이것을 갱신해 나간다. 이 때 중요한 것은 **인덱스 비교를 통해 구매 가격의 인덱스가 판매 가격의 인덱스보다 낮을 때만 갱신하는 것**이다.

## 유의할 점
- 모든 값이 distinct하다고 했으므로 HashMap을 사용하면 된다. 굳이 Tuple을 만들어서 효율성을 떨어뜨리지 말자.

## 제출 코드
``` java
import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {

    static HashMap<Long, Integer> indexMap = new HashMap<>();    
    static int minimumLoss(long[] price) {
        Arrays.sort(price);

        long[] differArr = new long[price.length - 1];
        long minDiffer = price[price.length - 1];
        for (int i = 0; i < price.length - 1; i++) {
            differArr[i] = price[i + 1] - price[i];
            
            if (indexMap.get(price[i + 1]) < indexMap.get(price[i])) {
                minDiffer = Math.min(minDiffer, differArr[i]);
            }
        }

        return Math.toIntExact(minDiffer);
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        long[] price = new long[n];
        for (int price_i = 0; price_i < n; price_i++) {
            price[price_i] = in.nextLong();
            indexMap.put(price[price_i], price_i);
        }
        int result = minimumLoss(price);
        System.out.println(result);
        in.close();
    }
}
```