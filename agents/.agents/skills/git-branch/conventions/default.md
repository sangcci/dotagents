# Branch Convention: default

## Base 브랜치

```
develop
```

## 브랜치 네이밍 패턴

```
{type}/#{issue-number}-{slug}
```

## 허용 타입

| 타입 | 용도 |
|------|------|
| `feat` | 새 기능 |
| `fix` | 버그 수정 |
| `hotfix` | 프로덕션 긴급 수정 (main에서 분기) |
| `chore` | 빌드, 의존성, 설정 변경 |
| `refactor` | 기능 변경 없는 코드 개선 |
| `test` | 테스트 코드 추가/수정 |
| `docs` | 문서 수정 |

## Slug 규칙

- 소문자 영문 + 숫자만 허용
- 단어 구분: `-`
- 특수문자/한글: 제거 또는 영문 변환
- 최대 40자 (초과 시 잘라내기)

## hotfix 특이사항

`hotfix` 타입 선택 시 base 브랜치를 `develop` 대신 `main`으로 자동 변경하여 분기.
