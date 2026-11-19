---
name: worktree
description: 저장소 루트의 .worktrees 아래에 브랜치 이름과 같은 경로로 git worktree를 만들고 그 안에서 작업한다.
---

# Worktree

현재 작업 디렉터리가 속한 Git 저장소의 메인 루트 아래 `.worktrees/<브랜치 이름>`에 worktree를 만듭니다. 브랜치 이름과 디렉터리 이름은 같게 둡니다.

## 만들기

1. 브랜치 이름을 정합니다. 사용자가 지정한 이름을 그대로 쓰고, 지정하지 않았다면 작업 내용에 맞는 이름을 제안해 확인받습니다.
2. 이 스킬 폴더의 `scripts/worktree-add.sh`를 대상 저장소 안에서 실행합니다.

   ```sh
   <skill-dir>/scripts/worktree-add.sh <branch> [start-point]
   ```

   - 로컬 브랜치가 있으면 그 브랜치를 체크아웃합니다.
   - 로컬에 없고 `origin/<branch>`가 있으면 추적 브랜치로 만듭니다.
   - 둘 다 없으면 `start-point`(기본값 현재 HEAD)에서 새 브랜치를 만듭니다.
   - 이미 같은 경로에 worktree가 있으면 새로 만들지 않고 그 경로를 출력합니다.
   - `.worktrees/`가 ignore되지 않은 저장소에서는 `.git/info/exclude`에 추가합니다. 추적 중인 `.gitignore`는 수정하지 않습니다.
3. stdout 마지막 줄이 worktree 절대 경로입니다. 이후 명령, 파일 읽기와 수정은 모두 이 경로를 기준으로 합니다. 셸의 작업 디렉터리가 유지되지 않는 도구라면 명령마다 작업 디렉터리를 지정합니다.
4. 사용자에게 worktree 경로와 브랜치 이름을 알립니다.

`.env`처럼 Git이 추적하지 않는 파일은 worktree에 복사되지 않습니다. 작업에 필요하면 사용자에게 확인한 뒤 복사합니다.

## 정리하기

사용자가 요청할 때만 정리합니다. 커밋하지 않은 변경이 있으면 먼저 알리고 확인받습니다.

```sh
git worktree remove <worktree-path>
```

브랜치 삭제는 사용자가 따로 요청한 경우에만 합니다.
