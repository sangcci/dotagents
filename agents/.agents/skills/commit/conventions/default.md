# Commit Convention: default

## 메시지 형식

```
{type}({scope}): {message}

{body}
```

## 타입

| 타입 | 용도 |
|------|------|
| `feat` | 새 기능 |
| `fix` | 버그 수정 |
| `hotfix` | 프로덕션 긴급 수정 |
| `chore` | 빌드, 의존성, 설정 변경 |
| `refactor` | 기능 변경 없는 코드 개선 |
| `test` | 테스트 코드 추가/수정 |
| `docs` | 문서/주석 수정 |
| `style` | 코드 포맷, 세미콜론 등 (로직 무관) |
| `perf` | 성능 개선 |

## 규칙

- message: **한글**, 명령형, 마침표 없음, 50자 이내 (type+scope 포함)
- scope: 핵심 변경 파일명 (확장자 제외), 예: `UserService`, `LoginController`
- body: 변경 이유와 맥락을 **한글**로 서술, 72자 줄바꿈 (선택)
- footer 미사용: 스쿼시 머지로 커밋이 날아가므로 `Closes #N`, `Refs #N`은 PR 본문에 작성
- Co-authored-by 미사용

## 문체 가이드

커밋 메시지는 사람이 직접 쓴 것처럼 짧고 직관적으로 작성한다.

**금지 표현 (AI 티 나는 문구):**
- "~를 통해 ~를 개선" → "~개선"
- "~을 위한 ~추가" → "~추가"
- "전반적인", "효율적인", "최적화된"
- "~를 구현하였습니다", "~를 수행합니다"
- body에서 "이를 통해", "해당 변경사항은"

**좋은 예:**
```
fix(UserService): 탈퇴 후 토큰 만료 안 되는 버그 수정
refactor(OrderController): 주문 검증 로직 분리
chore(build): Gradle 8.7로 업그레이드
```

**나쁜 예:**
```
fix(UserService): 사용자 탈퇴 후 토큰이 만료되지 않는 문제를 해결하여 보안을 강화
refactor(OrderController): 주문 검증 로직을 별도 클래스로 분리하여 가독성을 개선
```

## 예시

```
feat(JwtProvider): 리프레시 토큰 로테이션 추가

재사용 방지 목적. 매 요청마다 토큰 교체.
```
