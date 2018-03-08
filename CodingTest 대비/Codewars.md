# Codewars 문제 모음

## [Digital Root](https://www.codewars.com/kata/541c8630095125aba6000c00/solutions/java/all/best_practice)

각 자리 수의 합을 구하는 문제로 일의 자리가 나올 때까지 반복. 모범 답안은 각 자리의 수를 더했을 때 9로 나누어 떨어지 않으면 나머지가 문제의 답이 된다.
```java
public class DRoot {
  public static int digital_root(int n) {
    return (n != 0 && n%9 == 0) ? 9 : n % 9;
  }
}
```

## [Your order, please](https://www.codewars.com/kata/your-order-please/java)
"is2 Thi1s T4est 3a" 같은 문자열이 주어지면 그것을 숫자 순서대로 다시 배열해 문자열을 반환하는 문제.

```java
public class Order {
  public static String order(String words) {
    return Arrays.stream(words.split(" "))
      .sorted(Comparator.comparing(s -> Integer.valueOf(s.replaceAll("\\D", ""))))
      .reduce((a, b) -> a + " " + b).get();
  }
}
```
배열에 대한 스트림을 만들어 정규식을 이용해 정렬한 뒤에 reduce로 합치는 코드.
- 자주 쓸 것 같은 정규식 모음
  - \s - 공백 문자
  - \S - 공백 문자가 아닌 나머지 문자
  - \w - 알파벳이나 숫자
  - \W - 알파벳이나 숫자를 제외한 문자
  - \d - 숫자 [0-9]와 동일
  - \D - 숫자를 제외한 모든 문자
- 예제

  1) 숫자만 : ^[0-9]*$

  2) 영문자만 : ^[a-zA-Z]*$

  3) 한글만 : ^[가-힣]*$

  4) 영어 & 숫자만 : ^[a-zA-Z0-9]*$

  5) E-Mail : ^[a-zA-Z0-9]+@[a-zA-Z0-9]+$

  6) 휴대폰 : ^01(?:0|1|[6-9]) - (?:\d{3}|\d{4}) - \d{4}$

  7) 일반전화 : ^\d{2.3} - \d{3,4} - \d{4}$

  8) 주민등록번호 : \d{6} \- [1-4]\d{6}

  9) IP 주소 : ([0-9]{1,3}) \. ([0-9]{1,3}) \. ([0-9]{1,3}) \. ([0-9]{1,3})

  출처: http://highcode.tistory.com/6
