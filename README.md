# dotagents

개인 Codex 지침, 스킬과 문서 작성 가이드를 관리합니다.

```text
dotagents/
├── codex/.codex/
│   ├── AGENTS.md
│   └── skills/
├── claude/.claude/
│   ├── CLAUDE.md   -> codex/.codex/AGENTS.md
│   └── skills/*    -> codex/.codex/skills/*
└── docs/
```

## 설치와 사용

Git과 GNU Stow가 필요합니다. macOS: `brew install stow`

```sh
git clone https://github.com/sangcci/dotagents.git ~/dotagents
cd ~/dotagents
stow -t ~ codex
stow -t ~ claude   # Claude Code
```

`~/.codex`에 링크를 만듭니다. 기존 파일과 충돌하면 백업 후 정리합니다.
수정은 이 저장소에서 하고, 새 파일이나 스킬을 추가하면 Stow를 다시 실행합니다.
연결 해제: `stow -D -t ~ codex` 또는 `stow -D -t ~ claude`

`claude` 패키지는 `codex` 쪽 원본을 상대 심볼릭 링크로 가리킵니다. 지침과 스킬은 `codex/.codex`에서만 수정합니다.

다른 도구에서는 필요한 스킬 폴더 전체를 해당 도구의 스킬 경로에 연결합니다.
지침 파일명과 경로는 도구에 맞게 조정하며, 플러그인 배포에는 별도 패키징이 필요합니다.

## 문서 가이드

- [문서 작성](docs/documentation.md)
- [API 스펙 작성](docs/api-spec-writing.md)
- [용어집 작성](docs/glossary-writing.md)
- [에이전트와 개발하는 방식](docs/agent-workflow.md)
- [스킬 목록](docs/skills.md): 스킬별 역할, 호출 방식, 출처
