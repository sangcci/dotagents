---
name: issue
description: GitHub 이슈를 생성하고 연결된 worktree/branch를 만드는 스킬. `/issue`로 새 이슈 생성 후 branch까지 한 번에 처리. 이슈 번호(#12 형식)를 인자로 주면 이슈 생성을 건너뛰고 branch만 생성. 새 기능, 버그 수정, 개선 작업을 시작할 때 항상 이 스킬을 사용할 것.
invocation: explicit
---

# issue

## 사용법

```
/issue [#number | type] [convention]
```

- `#number`: 기존 이슈 번호 (예: `#12`) — 이슈 생성 건너뛰고 branch만 생성
- `type`: 브랜치 타입 — `feat` | `fix` | `hotfix` | `chore` | `refactor` | `test` | `docs` (생략 시 이슈 label 기반 자동 선택)
- `convention`: 브랜치 컨벤션 파일명 (생략 시 `default`)

**예시:**
- `/issue` → 이슈 생성부터 branch까지
- `/issue feat` → feat 타입으로 이슈 생성 + branch
- `/issue #42` → 이슈 #42로 branch만 생성
- `/issue #42 fix` → 이슈 #42 기반으로 fix 타입 branch 생성

---

## 동작 순서

### A. 이슈 번호가 인자로 주어진 경우 (`#<number>`)

1. `gh issue view {number} --json number,title,labels` 로 이슈 존재 확인
   - 없으면 오류 출력 후 중단
2. 이슈 제목과 labels 확인 → **C단계(branch 생성)**로 이동

---

### B. 이슈 번호가 없는 경우 — 이슈 생성

**1. 템플릿 탐색** (우선순위 순):

a. 현재 프로젝트 루트의 `.github/ISSUE_TEMPLATE/` 탐색
   ```bash
   PROJECT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
   ls "$PROJECT_ROOT/.github/ISSUE_TEMPLATE/" 2>/dev/null
   ```
   - `.yml` / `.yaml` / `.md` 파일 목록 수집

b. 없으면 `~/.agents/skills/issue/templates/` 의 기본 템플릿 사용
   - `feature_request.md` (기능 추가)
   - `bug_report.md` (버그 리포트)

**2. 템플릿 선택**:
- 탐색된 템플릿 목록을 번호와 함께 보여주고 선택 요청
- 프로젝트 템플릿: YAML front matter의 `name` 필드로 표시
- 스킬 기본 템플릿: frontmatter의 `name` 필드로 표시

**3. 이슈 내용 수집**:

선택한 템플릿의 각 필드를 **순서대로** 수집한다.

- 각 필드 프롬프트 형식:
  ```
  ### {label}
  {description}
  {placeholder가 있으면 예시로 표시}
  {default value가 있으면 기본값으로 표시}
  (required: false인 경우 "건너뛰려면 엔터" 안내)
  ```
- 수집된 내용으로 GitHub issue body markdown 구성:
  ```markdown
  ## {label}

  {입력값}
  ```
- 이슈 제목은 `summary` 또는 첫 번째 `input` 타입 필드 값 사용

**4. 이슈 제목 결정**:

우선순위:
1. 프로젝트 루트 `AGENTS.md` 내 Issue 컨벤션 섹션 탐색 (`## Issue` 또는 `## Issues` 헤더)
   - 있으면 해당 섹션의 형식을 따름
2. 없으면 default 형식 적용:
   - 버그: 버그 현상을 간결하게 (예: `로그인 시 500 에러 발생`)
   - 기능: 무엇을 추가/변경하는지 서술 (예: `소셜 로그인 기능 추가`)
   - issue number나 label prefix 없음 — 제목만

**5. 이슈 작성 스타일**:

- 어투: "입니다/합니다" 체 사용 (음슴체 "~함", "~됨" 금지)
- 자연스러운 한국어 개발자 어투 사용 (영어 직역 금지)
  - O: "파일이 없으면 실패합니다"
  - X: "파일이 없을 경우 실패하게 됨"

**6. 이슈 생성**:
```bash
gh issue create \
  --title "{제목}" \
  --body "{구성된 body}" \
  --label "{labels}"
```

- 생성된 이슈 URL과 번호 출력
- 실패 시 오류 출력 후 중단

> **프로젝트 템플릿 파싱 시**: YAML front matter에서 `name`, `labels`, `title` 추출.
> `body` 배열의 각 항목에서 `type`, `id`, `attributes.label`, `attributes.description`,
> `attributes.placeholder`, `attributes.value`, `validations.required` 파싱.

---

### C. Branch/Worktree 생성

**7. 컨벤션 로드**: `~/.agents/skills/branch/conventions/{convention}.md` 읽기
- 파일이 없으면 사용 가능한 컨벤션 목록 출력 후 중단

**8. 브랜치 타입 결정**:
- 인자로 type이 주어진 경우 그대로 사용
- 아닌 경우 이슈 labels에서 자동 추론:
  - `feat` 포함 → `feat`
  - `bug` 포함 → `fix`
  - `chore` 포함 → `chore`
  - `docs` 포함 → `docs`
  - `refactor` 포함 → `refactor`
  - 추론 불가 시 사용자에게 입력 요청

**9. 브랜치명 생성**:
- 이슈 제목을 slug로 변환:
  - 소문자 영문 + 숫자만 허용
  - 단어 구분: `-`
  - 특수문자, 한글, 공백: 제거 또는 영문 변환
  - 최대 40자 (초과 시 잘라내기)
- 패턴: `{type}/#{issue-number}-{slug}`

예시: `feat/#42-add-postgresql-advisory-lock`

**10. Worktree 생성** (권장):
```bash
git fetch origin {base-branch}
git worktree add -b {branch-name} ../{branch-name} origin/{base-branch}
```
- worktree 경로: 프로젝트 루트의 **상위 디렉토리**에 `{branch-name}` 폴더 생성
- 실패 시 일반 branch로 fallback:
  ```bash
  git checkout -b {branch-name} origin/{base-branch}
  ```
- 동명 브랜치가 이미 존재하면 경고 후 사용자 확인을 받아 진행

**11. 결과 출력**:
```
✅ 이슈: #{number} — {title}
   URL: {issue-url}

🌿 브랜치: {branch-name}
   Base:    {base-branch}
   Worktree: {worktree-path}   (worktree 생성 시)
```
