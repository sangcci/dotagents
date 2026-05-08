---
name: git-commit
description: git diff와 git log를 분석해 컨벤션에 맞는 커밋 메시지를 생성합니다. 변경이 여러 단위면 커밋을 나눠서 제안합니다. 인자로 프로젝트별 컨벤션을 선택합니다.
invocation: explicit
---

# git-commit

## 사용법

```
/git-commit [convention]
```

- `convention` 생략 시 `default` 사용
- 예: `/git-commit`, `/git-commit java`, `/git-commit obsidian`

## 동작 순서

1. **컨벤션 로드**: `~/.agents/skills/git-commit/conventions/{convention}.md` 읽기
   - 파일이 없으면 오류 메시지 출력 후 중단. 사용 가능한 컨벤션 목록 안내.

2. **변경사항 수집**:
   ```bash
   git status
   git diff HEAD
   git log --oneline -10
   ```
   - staged/unstaged 변경 파일 파악
   - diff 내용으로 실제 변경점 직접 파악
   - 최근 커밋 로그로 컨벤션 준수 여부 참고

3. **커밋 분리 판단**:
   - 변경 단위가 논리적으로 다르면 커밋을 나눠서 제안
   - 예: 기능 추가 + 별개 버그 수정 → 2개 커밋으로 분리
   - 하나의 맥락이면 1개로 통합

4. **커밋 메시지 초안 작성**:
   - diff 내용을 직접 읽고 변경점 정리 (LOG.md 불필요)
   - 컨벤션 규칙 적용 (type, scope, message, body, footer)
   - 커밋이 여럿이면 순서와 함께 나열

5. **사용자 확인**: 초안을 출력하고 진행 여부를 묻는다.
   - 승인(y/엔터): 다음 단계로
   - 거부(n): 중단
   - 수정 요청: 재작성 후 재확인

6. **커밋 실행**:
   - 커밋이 1개면: `git add -A && git commit -m "<메시지>"`
   - 커밋이 여럿이면: 각 커밋마다 해당 파일만 stage 후 순서대로 실행
     ```bash
     git add {해당 파일들} && git commit -m "<메시지1>"
     git add {해당 파일들} && git commit -m "<메시지2>"
     ```

## 컨벤션 목록

`~/.agents/skills/git-commit/conventions/` 에 위치:

| 파일 | 용도 |
|------|------|
| `default.md` | 기본 컨벤션 (type: subject + body + footer) |
