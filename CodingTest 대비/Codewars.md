# Codewars 문제 모음

## [CodeWars Digital Root 문제](https://www.codewars.com/kata/541c8630095125aba6000c00/solutions/java/all/best_practice)

각 자리 수의 합을 구하는 문제로 일의 자리가 나올 때까지 반복. 모범 답안은 각 자리의 수를 더했을 때 9로 나누어 떨어지 않으면 나머지가 문제의 답이 된다.
```java
public class DRoot {
  public static int digital_root(int n) {
    return (n != 0 && n%9 == 0) ? 9 : n % 9;
  }
}
```
