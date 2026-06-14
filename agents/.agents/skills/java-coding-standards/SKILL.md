---
name: java-coding-standards
description: Use when writing or reviewing Java code and you need pure Java coding standards, not project-specific conventions. Covers naming, method design, immutability, Optional, Stream usage, null handling, collections, enums, exceptions, logging, and readability.
---

# Java Coding Standards

이 스킬은 프로젝트별 구조 규칙이 아니라, **순수 자바 코드 자체를 어떻게 읽기 쉽게 쓸지**에 집중한다.

우선순위는 아래와 같다.

1. 프로젝트 자체 컨벤션
2. 로컬 코드베이스 패턴
3. 이 스킬의 자바 코딩 기준

즉, 이 스킬은 프로젝트 문서를 덮어쓰는 용도가 아니다. 프로젝트 문서에 없는 자바 표현 규칙을 채우는 기본 기준이다.

## 언제 쓰는가

- Java 코드 작성
- Java 코드 리뷰
- 메서드/클래스 구조 다듬기
- Stream, Optional, null handling, logging 같은 표현 방식 판단
- 프로젝트 컨벤션과 무관한 순수 자바 스타일 정리

## 1. Naming

- 클래스, 인터페이스, enum, record는 PascalCase
- 메서드와 필드는 camelCase
- 상수는 UPPER_SNAKE_CASE
- boolean 이름은 `is`, `has`, `can`, `should`를 우선한다.

예시

```java
public class PaymentService {}
private static final int MAX_RETRY_COUNT = 3;
private boolean isClosed;
public boolean hasPermission() {}
```

하지 않음

```java
public class paymentService {}
private int max_retry_count;
private boolean closed;
```

## 2. Method Design

- 메서드는 한 가지 일에 집중한다.
- 메서드가 길어지면 줄 수보다 책임 수를 먼저 본다.
- 조건 분기가 깊어지면 early return이나 guard clause를 먼저 검토한다.
- 파라미터가 많아지면 의미 있는 객체로 묶을 수 있는지 본다.

예시

```java
public void validate(Member member) {
    if (member == null) {
        throw new IllegalArgumentException("member must not be null");
    }

    if (!member.isActive()) {
        throw new IllegalStateException("member is inactive");
    }
}
```

지양

```java
public void validate(Member member) {
    if (member != null) {
        if (member.isActive()) {
            // ...
        }
    }
}
```

## 3. Immutability

- 가능한 `final`을 우선한다.
- 변경 가능한 shared state를 줄인다.
- 객체를 수정하는 것보다, 필요하면 새 객체를 만드는 쪽이 더 읽기 쉬운지 먼저 본다.
- 불변이 자연스러운 값은 record나 value object를 검토한다.

예시

```java
public record Money(BigDecimal amount, Currency currency) {}
```

## 4. Optional

- `Optional`은 주로 반환값에서 사용한다.
- 필드나 파라미터에 `Optional`을 남용하지 않는다.
- `get()` 직접 호출보다 `map`, `flatMap`, `orElseThrow`를 우선한다.

예시

```java
return memberRepository.findById(memberId)
        .orElseThrow(() -> new IllegalArgumentException("member not found"));
```

지양

```java
Optional<Member> member = memberRepository.findById(memberId);
return member.get();
```

## 5. Stream

- Stream은 변환, 필터링, 집계처럼 흐름이 분명할 때 쓴다.
- pipeline이 길어지거나 분기가 많아지면 for문이 더 읽기 쉬울 수 있다.
- stream 내부에서 외부 상태를 바꾸는 코드는 지양한다.

예시

```java
List<String> names = members.stream()
        .filter(Member::isActive)
        .map(Member::getName)
        .toList();
```

지양

```java
members.stream().forEach(member -> names.add(member.getName()));
```

## 6. Null Handling

- null 허용 여부를 애매하게 두지 않는다.
- null 대신 빈 컬렉션이나 `Optional`로 표현할 수 있는지 먼저 본다.
- null 체크가 연쇄되기 시작하면 구조를 다시 보는 편이 낫다.

예시

```java
return Collections.emptyList();
```

## 7. Collections

- 가능하면 `List`, `Set`, `Map` 같은 interface 타입으로 받는다.
- null 대신 빈 컬렉션을 반환한다.
- mutable collection을 그대로 외부에 노출하지 않는다.

예시

```java
public List<Member> findActiveMembers() {
    return members.isEmpty() ? List.of() : members;
}
```

## 8. Enum and Value Object

- 의미가 정해진 문자열 집합은 enum을 우선 검토한다.
- 함께 움직이는 값은 value object로 묶을 수 있는지 본다.
- 문자열 하드코딩이 반복되면 enum 또는 상수로 올린다.

## 9. Exceptions

- 예외는 의미가 드러나게 던진다.
- broad catch는 정말 필요한 경우만 사용한다.
- 예외 메시지는 무엇이 왜 잘못됐는지 보이게 적는다.
- 복구하지 못할 예외를 조용히 삼키지 않는다.

예시

```java
throw new IllegalStateException("payment is already closed");
```

지양

```java
throw new RuntimeException("error");
```

## 10. Logging

- 로그는 개념과 식별자가 같이 보이게 남긴다.
- 성공 로그를 무조건 남기지 않는다.
- 예외 로그는 맥락 정보와 함께 남긴다.

예시

```java
log.info("close_rent rentId={} memberId={}", rentId, memberId);
log.error("failed_close_rent rentId={} memberId={}", rentId, memberId, ex);
```

## 11. Magic Numbers and Constants

- 의미 있는 숫자는 상수로 뺀다.
- 한 번만 나와도 의미 해석이 필요한 숫자라면 이름을 준다.

예시

```java
private static final int MAX_PAGE_SIZE = 100;
```

## 12. Readability First

- 짧다고 무조건 좋은 코드가 아니다.
- 영리한 코드보다 바로 읽히는 코드를 우선한다.
- 한 줄로 줄일 수 있어도, 두 줄이 더 분명하면 두 줄을 택한다.
- 프로젝트 formatter가 있다면 사람 취향보다 formatter 결과를 따른다.

## 13. 리뷰할 때 보는 포인트

- 이름만 보고 역할이 보이는가?
- 메서드가 한 가지 일만 하는가?
- 분기 깊이가 과하지 않은가?
- Optional, Stream을 억지로 쓰고 있지 않은가?
- null, collection, 예외 처리가 읽기 쉽게 드러나는가?
- 코드가 짧은데도 오히려 이해하기 어려운 상태는 아닌가?

## 14. 금지 사항

- `doThing`, `processData`, `handleIt` 같은 뭉툭한 이름 남발
- `Optional.get()` 습관적 사용
- stream 안에서 외부 상태 변경
- null 반환 남발
- broad catch 후 무시
- 의미 없는 매직 넘버 반복
- 한 메서드에서 너무 많은 책임 처리
