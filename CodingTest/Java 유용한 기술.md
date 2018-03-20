# Java 유용한 기술

## 입력 받기
`java.util.Scanner`를 import하여 Scanner클래스를 사용한다.

``` java
Scanner scanner = new Scanner(System.in);

String inputString = scanner.nextLine();
int inputNum = scanner.nextInt();
double inputDouble = scanner.nextDouble();
```

## 문자열이 숫자인지 판별하는 방법

```java
public static boolean isNumeric(String s) {
  try {
      Double.parseDouble(s);
      return true;
  } catch(NumberFormatException e) {
      return false;
  }
}
```
이 메소드를 선언해 숫자를 판별한다.

## 문자열 마지막을 자르는 방법
```java
if (str.length() > 0) {
			str = str.substring(0, str.length() - 1);
		}
```
문자열이 비어 있는지 먼저 체크해준 뒤, 마지막을 자른다.

## 문자열을 뒤집어 정렬하는 방법
`StringBuilder` 클래스의 인스턴스 메서드 `reverse()`를사용한다.

``` Java
String reversedStr = new StringBuilder(str).reverse().toString();
```

## String을 int로, int를 String으로

``` java
String numStr = "54";
int numInt = Integer.parseInt(numStr);
String numStr2 = String.valueOf(numInt);
```
