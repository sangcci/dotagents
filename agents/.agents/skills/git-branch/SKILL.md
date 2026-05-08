---
name: "git:branch"
description: 이슈 번호와 컨벤션을 받아 최신 base 브랜치에서 네이밍 규칙에 맞는 브랜치를 생성합니다.
invocation: explicit
---

# git:branch

## 사용법

```
/git:branch <issue-number> [type] [convention]
```

- `issue-number`: GitHub 이슈 번호 (필수)
- `type`: 브랜치 타입 — `feat` | `fix` | `hotfix` | `chore` | `refactor` (생략 시 `feat`)
- `convention`: 프로젝트 컨벤션 파일명 (생략 시 `default`)
- 예: `/git:branch 42`, `/git:branch 42 fix`, `/git:branch 42 feat myproject`

## 동작 순서

1. **컨벤션 로드**: `~/.agents/skills/git-branch/conventions/{convention}.md` 읽기
   - 파일이 없으면 사용 가능한 컨벤션 목록을 출력하고 중단.
2. **이슈 정보 조회**: `gh issue view {issue-number}` 로 제목 가져오기
   - gh CLI 미설치 또는 이슈 조회 실패 시, 사용자에게 브랜치 설명(slug)을 직접 입력받기.
3. **브랜치명 생성**: 컨벤션 규칙 + 이슈 번호 + 제목 slug 조합
   - slug 규칙: 소문자 영문/숫자, 단어 구분은 `-`, 특수문자 제거, 최대 40자
   - 최종 형태: `{type}/#{issue-number}-{slug}` (컨벤션에서 재정의 가능)
4. **최신 base fetch**: `git fetch origin {base-branch}`
   - 실패 시 오류 출력 후 중단.
5. **브랜치 생성 및 체크아웃**: `git checkout -b {branch-name} origin/{base-branch}`
   - 동명 브랜치가 이미 존재하면 경고 후 사용자 확인을 받아 진행.
6. **결과 출력**: 생성된 브랜치명, base 브랜치, 연결된 이슈 번호 요약 출력.

## 브랜치 네이밍 예시

| 이슈 | 타입 | 결과 브랜치명 |
|------|------|--------------|
| #42 "Add login page" | feat | `feat/#42-add-login-page` |
| #7 "Fix NPE in UserService" | fix | `fix/#7-fix-npe-in-userservice` |
| #100 "Update dependencies" | chore | `chore/#100-update-dependencies` |

## 컨벤션 목록

`~/.agents/skills/git-branch/conventions/` 에 위치:

| 파일 | 용도 |
|------|------|
| `default.md` | 범용 기본 컨벤션 (base: `develop`) |
| `java.md` | Java/Spring 백엔드 프로젝트 |
| `main.md` | base가 `main`인 프로젝트 |
