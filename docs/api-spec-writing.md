# API Specification Writing Guide

## 배경

API 스펙을 일관된 구조로 작성하기 위한 문서 형식과 표현 기준을 정의한다. 근거, 상태와 공통 문체는 [공통 문서 작성 가이드](<../../Projects/finditem/DOCS/guide/공통 문서 작성 가이드.md>)를 따른다. HTTP 상태, 공통 응답, 인증, 데이터 표현과 목록 응답의 사용 기준은 [공통 API 스펙](<../../Projects/finditem/DOCS/00-프로젝트/찾아줘! - 운영 (2차 MVP)/API 스펙/공통 API 스펙.md>)에서 관리한다.

```text
// as-is
API는 성공하면 200과 COMMON200을 반환합니다.

// to-be
성공 응답에는 HTTP 상태, 응답 필드와 JSON 예시를 작성한다. HTTP 상태와 응답 코드의 선택 기준은 공통 API 스펙을 따른다.
```

## 문서 역할

API 스펙에는 클라이언트가 요청을 만들고 응답을 처리하는 데 필요한 계약을 작성한다. 업무 판단 기준이나 저장 구조는 중복하지 않고 해당 문서를 참조한다.

```text
// as-is
팝업 스토어는 마지막 영업이 끝나면 종료 상태가 되고 목록에서 제외됩니다.

// to-be
운영 종료에 따라 노출 대상에서 제외된 팝업 스토어는 장소 목록 응답에 포함하지 않는다.
상태 판단 기준은 성수 콘텐츠 정책서의 ‘노출 기준’을 따른다.
```

## 문서 구조

### 제목과 목차

제목에는 개발 범위와 업무 영역을 표시한다. 제목 바로 아래에는 모든 API와 공통 모델을 찾을 수 있도록 목차를 작성한다.

```markdown
<!-- as-is -->
# 장소 API

## 장소 등록
## 장소 조회

<!-- to-be -->
# 2차 스프린트 성수 콘텐츠 API 스펙

## 목차

- [문서 범위](#문서-범위)
- [공통 모델](#공통-모델)
- [운영진 장소 API](#운영진-장소-api)
  - [장소 등록](#장소-등록)
- [장소 탐색 API](#장소-탐색-api)
  - [장소 목록 조회](#장소-목록-조회)
```

### 문서 범위

목차 다음에는 문서가 관리하는 API 범위와 관련 정책서, 테이블 설계 및 화면 정의서를 링크한다.

```markdown
<!-- as-is -->
성수 콘텐츠와 관련된 내용을 정리합니다.

<!-- to-be -->
## 문서 범위

이 문서는 성수 콘텐츠의 API 요청과 응답을 정의한다.

- 운영 상태와 노출 기준: [성수 콘텐츠 정책서](<../정책서/성수 콘텐츠 정책서.md>)
- 공통 응답과 인증: [공통 API 스펙](<./공통 API 스펙.md>)
```

### API 목록

문서 앞부분에는 전체 API 목록을 작성한다. 목록에는 기능, Method, Path와 인증 조건만 표시하고 상세 규칙은 개별 API에서 관리한다.

```markdown
<!-- as-is -->
- 장소를 등록하는 API가 있다.
- 장소 목록을 조회하는 API가 있다.

<!-- to-be -->
| 기능 | Method | Path | 인증 |
| --- | --- | --- | --- |
| 장소 등록 | `POST` | `/admin/places` | `ROLE_ADMIN` |
| 장소 목록 조회 | `GET` | `/places` | 선택 인증 |
```

### 업무 영역별 분류

개별 API는 Controller나 화면이 아니라 같은 자원과 목적을 공유하는 업무 영역별로 묶는다.

```text
// as-is
AdminPlaceController API
MainPlaceController API

// to-be
운영진 장소 API
장소 탐색 API
장소 좋아요 API
```

### 참조형 구성과 공통 모델

각 API는 다른 API의 본문을 읽지 않아도 이해할 수 있게 작성한다. 두 개 이상의 API가 같은 모델을 사용하면 공통 모델로 분리하고 개별 API에는 링크와 추가 조건만 작성한다.

```text
// as-is
응답은 앞에서 설명한 장소 목록과 같습니다.

// to-be
응답의 places는 PlaceSummary 배열이다. 로그인하지 않은 요청에서는 isFavorite=false를 반환한다.
```

## API 작성 형식

### 작성 순서

개별 API는 API 이름, Method와 Path, 인증, 설명, 요청, 성공 응답, 오류, 처리 규칙 순서로 작성한다. 사용하지 않는 항목은 생략할 수 있지만 순서는 바꾸지 않는다.

```text
// as-is
처리 규칙 → 오류 → 경로 → 성공 응답

// to-be
API 이름 → Method와 Path → 인증 → 설명 → 요청 → 성공 응답 → 오류 → 처리 규칙
```

### Method와 Path

Method와 Path는 API 이름 바로 아래에 인라인 코드로 함께 작성한다. Path에는 실제 경로만 표시하고 Query Parameter는 요청 필드 표에서 정의한다.

```text
// as-is
GET /places?type={type}&cursor={cursor}

// to-be
GET /places
```

### 인증

인증 조건은 별도 소제목에 공통 API 스펙에서 정의한 표현으로 작성한다. 로그인 여부에 따라 응답이 달라지면 차이를 함께 작성한다.

```markdown
<!-- as-is -->
로그인하지 않아도 조회할 수 있습니다.

<!-- to-be -->
#### 인증

선택 인증

- 로그인한 요청: 사용자의 저장 여부를 `isFavorite`에 반환한다.
- 로그인하지 않은 요청: `isFavorite=false`를 반환한다.
```

### 설명

설명에는 API를 호출하는 목적과 결과를 한두 문장으로 작성한다. 요청 필드, 내부 구현과 정책의 상세 조건은 반복하지 않는다.

```text
// as-is
PlaceService가 Repository에서 활성 장소를 조회하고 DTO로 변환합니다.

// to-be
지도 카테고리를 선택하지 않은 홈 화면에 노출할 장소를 조회한다.
```

## 요청 작성

### 요청 위치와 필드

요청은 Path Parameter, Query Parameter, Header, Body, Part 순서로 작성한다. 필드 표에는 이름, 타입, 필수 여부, 기본값과 규칙을 작성한다.

```markdown
<!-- as-is -->
type을 전달할 수 있고 size는 기본 20입니다.

<!-- to-be -->
| Query Parameter | 타입 | 필수 | 기본값 | 규칙 |
| --- | --- | --- | --- | --- |
| `type` | Enum | 선택 | 전체 | `CAFE`, `RESTAURANT`, `POPUP` 중 하나 |
| `size` | Integer | 선택 | `20` | 1 이상 20 이하 |
```

### 필수 여부

필수 여부에는 `필수`, `선택`, `조건부`를 사용한다. 조건부 필드는 포함해야 하는 조건을 규칙에 함께 작성한다.

```text
// as-is
lastDistance와 lastPostId는 경우에 따라 필요합니다.

// to-be
lastDistance: 다음 페이지 요청 시 lastPostId와 함께 전달하는 조건부 필드
lastPostId: 다음 페이지 요청 시 lastDistance와 함께 전달하는 조건부 필드
```

### multipart 요청

`multipart/form-data` 요청은 Part별 Content-Type과 필수 여부를 먼저 정의한다. JSON Part의 필드는 별도의 요청 모델에서 정의한다.

```markdown
<!-- as-is -->
request와 이미지를 multipart로 전달합니다.

<!-- to-be -->
| Part | Content-Type | 필수 | 규칙 |
| --- | --- | --- | --- |
| `request` | `application/json` | 필수 | PlaceUpsertRequest |
| `thumbnail` | `image/*` | 선택 | 생략하면 기존 썸네일 유지 |
```

## 응답 작성

### 성공 응답

성공 응답에는 HTTP 상태, 응답 필드와 JSON 예시를 작성한다. HTTP 상태와 공통 응답 값은 공통 API 스펙을 참조한다.

```markdown
<!-- as-is -->
성공하면 장소 정보를 반환합니다.

<!-- to-be -->
#### 성공 응답

HTTP `200 OK`

| 필드 | 타입 | nullable | 포함 조건 | 설명 |
| --- | --- | --- | --- | --- |
| `placeId` | Long | 아니요 | 항상 | 장소 식별자 |
| `isFavorite` | Boolean | 아니요 | 항상 | 사용자의 저장 여부 |
```

### nullable과 포함 조건

응답 필드가 항상 존재하는지와 값이 `null`일 수 있는지를 구분한다. 필드 생략, `null`, 빈 문자열과 빈 배열을 같은 의미로 사용하지 않는다.

```text
// as-is
운영 기간은 팝업일 때만 있고 영업시간이 없을 수도 있습니다.

// to-be
operationPeriod: type=POPUP일 때만 포함하며 null이 아님
todayBusinessHours: 항상 포함하며 정기 휴무일에는 null
```

### 오류

문서 마지막에는 도메인의 전체 오류 코드를 작성한다. 개별 API에는 실제 발생할 수 있는 오류만 쓰고, 조건은 내부 예외가 아니라 클라이언트가 오류를 받는 상황으로 설명한다.

```markdown
<!-- as-is -->
GeneralException이 발생하면 PLACE404를 반환합니다.

<!-- to-be -->
| HTTP | 코드 | 조건 |
| --- | --- | --- |
| 404 | `PLACE404-NOT_FOUND` | 장소가 없거나 현재 노출할 수 없는 상태임 |
```

## 데이터 표현

### 타입과 형식

타입은 특정 언어의 클래스보다 JSON과 OpenAPI에서 이해할 수 있는 표현을 사용한다. 단위, 형식과 허용 범위는 필드 설명에 작성한다.

```text
// as-is
latitude: Double
createdAt: LocalDateTime

// to-be
latitude: Number, -90 이상 90 이하
createdAt: String, ISO 8601 형식의 등록 일시
```

### Enum

Enum 필드는 허용하는 모든 값을 작성한다. 값의 의미가 이름만으로 분명하지 않으면 설명표를 추가한다.

```text
// as-is
type: PlaceType

// to-be
type: CAFE, RESTAURANT, POPUP 중 하나
```

### 필수 여부와 nullable

필수 여부는 필드의 존재 조건을, nullable은 존재하는 응답 필드가 `null`일 수 있는지를 나타낸다. 두 개념을 대신해서 사용하지 않는다.

```text
// as-is
operationPeriod: 선택

// to-be
요청: type=POPUP이면 필수이며 다른 유형이면 전달하지 않음
응답: type=POPUP일 때 포함하며 값은 null이 아님
```

## 처리 규칙

요청과 응답 표만으로 설명하기 어려운 멱등성, 연관 작업과 외부 동작을 작성한다. 내부 클래스, 메서드와 Repository 호출 순서는 작성하지 않는다.

```text
// as-is
PlaceFavoriteStateRepository에서 ON DUPLICATE KEY UPDATE를 실행합니다.

// to-be
이미 저장한 장소를 다시 요청해도 성공으로 응답하고 저장 상태를 유지한다.
```

## 예시 작성

### 요청과 응답 예시

JSON 예시는 필드 표의 타입, 필수 여부와 포함 조건을 모두 만족해야 한다. 전체 구조를 확인할 수 있도록 생략 기호를 사용하지 않는다.

````markdown
<!-- as-is -->
```json
{
  "weeklySchedules": [ ... ]
}
```

<!-- to-be -->
```json
{
  "placeId": 31,
  "type": "CAFE",
  "isFavorite": false
}
```
````

### 예시 데이터

예시에는 실제 개인정보, 운영 토큰과 내부 주소를 사용하지 않는다. 식별자와 날짜는 필드 사이의 관계가 맞도록 작성한다.

```text
// as-is
Authorization: Bearer 실제운영토큰
email: 실제사용자@example.com

// to-be
Authorization: Bearer {accessToken}
email: user@example.com
```

## 정보 배치

### 스펙 상태

논의 중인 요청이나 응답 구조를 확정된 계약처럼 작성하지 않는다. 확정되지 않은 내용은 해당 API 바로 아래에 [공통 문서 작성 가이드](<../../Projects/finditem/DOCS/guide/공통 문서 작성 가이드.md>)에서 정한 상태와 근거를 표시한다.

```text
// as-is
성공 응답은 추후 결정할 예정입니다.

// to-be
> 논의 필요
>
> 저장 취소 성공 응답에 저장 상태를 반환할지 결정해야 한다.
> 출처: 성수 콘텐츠 API 논의, 2026-09-10
```

## 완료 전 확인 목록

체크 항목은 API 정책을 결정하는 목록이 아니라 필요한 계약을 빠짐없이 작성했는지 확인하는 용도로 사용한다.

```text
// as-is
- [ ] REST 규칙에 맞는 HTTP 상태를 선택했는가?

// to-be
- [ ] HTTP 상태와 응답 구조가 공통 API 스펙과 일치하는가?
```

- [ ] 목차와 API 목록이 실제 섹션과 일치하는가?
- [ ] 개별 API가 정한 순서로 작성됐는가?
- [ ] 요청 필드의 위치, 타입, 필수 여부, 기본값과 제약이 적혀 있는가?
- [ ] 응답 필드의 타입, nullable 여부, 포함 조건과 설명이 적혀 있는가?
- [ ] HTTP 상태와 응답 구조가 공통 API 스펙과 일치하는가?
- [ ] 빈 결과, 마지막 페이지와 nullable 필드의 응답이 명확한가?
- [ ] JSON 예시가 필드 표와 일치하는가?
- [ ] 정책서와 테이블 설계의 내용을 불필요하게 중복하지 않았는가?
- [ ] 확정되지 않은 내용에 알맞은 상태를 표시했는가?
