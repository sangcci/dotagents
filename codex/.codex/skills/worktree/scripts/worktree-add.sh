#!/usr/bin/env bash
# 사용법: worktree-add.sh <branch> [start-point]
# 현재 디렉터리가 속한 저장소의 메인 루트 아래 .worktrees/<branch>에 worktree를 만든다.
# git 출력은 stderr로 보내고, 마지막 stdout 줄에 worktree 절대 경로를 출력한다.
set -euo pipefail

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  echo "usage: $(basename "$0") <branch> [start-point]" >&2
  exit 2
fi

branch=$1
start=${2:-HEAD}

git check-ref-format --branch "$branch" >/dev/null

# worktree 안에서 실행해도 메인 저장소 루트를 기준으로 삼는다.
common=$(git rev-parse --path-format=absolute --git-common-dir)
root=$(dirname "$common")
path="$root/.worktrees/$branch"

# 이미 같은 경로에 worktree가 있으면 재사용한다.
if git worktree list --porcelain | grep -Fxq "worktree $path"; then
  echo "이미 존재하는 worktree를 사용합니다: $path" >&2
  echo "$path"
  exit 0
fi

if [ -e "$path" ]; then
  echo "경로가 이미 있지만 worktree가 아닙니다: $path" >&2
  exit 1
fi

# .worktrees가 ignore되지 않았다면 추적 파일을 건드리지 않도록 로컬 exclude에 추가한다.
if ! git -C "$root" check-ignore -q ".worktrees/$branch"; then
  mkdir -p "$common/info"
  echo ".worktrees/" >> "$common/info/exclude"
  echo ".git/info/exclude에 .worktrees/를 추가했습니다." >&2
fi

if git show-ref --verify --quiet "refs/heads/$branch"; then
  git worktree add "$path" "$branch" >&2
elif [ $# -lt 2 ] && git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
  git worktree add --track -b "$branch" "$path" "origin/$branch" >&2
else
  git worktree add -b "$branch" "$path" "$start" >&2
fi

echo "$path"
