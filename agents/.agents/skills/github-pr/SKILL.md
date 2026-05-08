---
name: github-pr
description: GitHub PR을 생성하는 스킬. 현재 브랜치의 커밋과 diff를 분석해 제목·본문·label을 자동 구성. 프로젝트 AGENTS.md에 PR 컨벤션이 있으면 그것을 우선 적용. 새 기능, 버그 수정, 리팩토링 작업을 PR로 올릴 때 사용.
invocation: explicit
---

# github-pr

## 사용법

```
/github-pr [convention]
```

- `convention`: 컨벤션 파일명 (생략 시 `default`, AGENTS.md 우선)
- 예: `/github-pr`, `/github-pr java`

---

## 동작 순서

### 1. 컨벤션 로드

우선순위:
1. 프로젝트 루트 `AGENTS.md` 내 PR 컨벤션 섹션 탐색
   - `## PR` 또는 `## Pull Request` 헤더 포함 여부 확인
   - 있으면 해당 섹션을 컨벤션으로 사용
2. 없으면 `~/.agents/skills/github-pr/conventions/{convention}.md` 로드

### 2. 브랜치 정보 수집

```bash
git branch --show-current          # 현재 브랜치명
git merge-base HEAD origin/{base}  # base 분기점
git log {merge-base}..HEAD --oneline  # 이 브랜치의 커밋 목록
git diff {merge-base}..HEAD --stat    # 변경 파일 요약
git diff {merge-base}..HEAD           # 전체 diff (body 작성용)
```

- 브랜치명에서 타입과 이슈 번호 파싱: `{type}/#{issue-number}-{slug}`
- base 브랜치: 컨벤션의 base 브랜치 값 사용 (기본 `develop`)

### 3. 이슈 정보 조회

```bash
gh issue view {issue-number} --json title,labels,body
```

- 실패해도 중단하지 않고 브랜치·커밋 정보만으로 진행

### 4. PR 제목 생성

우선순위:
1. 프로젝트 루트 `AGENTS.md` 내 PR 컨벤션 섹션 (`## PR` 또는 `## Pull Request`)에 제목 형식이 명시된 경우 그것을 따름
2. 없으면 default 형식 적용:

```
[#{issue-number}] {제목}
```

- 제목: 어떤 작업을 메인으로 했는지 간결하게 (이슈 제목 그대로가 아닌 PR 작업 관점으로)
- 문체 가이드의 금지 표현 적용

### 5. PR Body 작성

diff와 커밋 로그를 분석해 body 구성. **문체 가이드를 반드시 준수**.

**작성 원칙:**
- `작업 내용`: 왜 바꿨는지 + 어떤 문제였는지. 2~3문장 이내.
- `구현`: 실제 코드 변경 항목을 구체적으로 (클래스명, 메서드명 포함 가능)
- `테스트`: 검증 방법. 없으면 `N/A`
- `Closes #{number}` 는 항상 포함

**AI 티 나는 표현 금지.** 동료에게 슬랙으로 설명하듯 짧고 직관적으로.

### 6. Label 결정

브랜치 타입 → label 매핑 (default 컨벤션):

| 브랜치 타입 | Label |
|------------|-------|
| `feat` | `✨ feat` |
| `fix` | `🐛 bug` |
| `hotfix` | `🚨 hotfix` |
| `chore` | `🔧 chore` |
| `refactor` | `♻️ refactor` |
| `test` | `✅ test` |
| `docs` | `📝 docs` |

프로젝트 AGENTS.md에 label 매핑이 있으면 해당 값 우선.

### 7. 사용자 확인

생성된 PR 제목과 body를 출력하고 진행 여부 확인.
- 승인(y/엔터): 다음 단계로
- 거부(n): 중단
- 수정 요청: 재작성 후 재확인

### 8. PR 생성

```bash
gh pr create \
  --title "{제목}" \
  --body "{body}" \
  --base {base-branch} \
  --label "{label}"
```

- 생성된 PR URL 출력

---

## 컨벤션 목록

`~/.agents/skills/github-pr/conventions/` 에 위치:

| 파일 | 용도 |
|------|------|
| `default.md` | 기본 컨벤션 (`[TYPE] #issue 제목`) |
