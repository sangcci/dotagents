# dotskills

개인 agent skill과 가벼운 agent 설정을 dotfiles처럼 관리하는 저장소입니다.

Claude Code에 묶인 설정을 source of truth로 두지 않고, Codex, pi, 그 외 `~/.agents`를 읽을 수 있는 agent들이 함께 사용할 수 있는 공용 레이어를 목표로 합니다.

## 구조

- `agents/.agents/skills`: 개인 공용 skill의 기준 위치입니다.
- `agents/.agents/plugins/marketplace.json`: Codex 로컬 plugin marketplace 메타데이터입니다.
- `plugins/`: 이 저장소와 함께 관리할 로컬 Codex plugin bundle을 둡니다.
- `vendor/skills/`: 다른 사람이 만든 skill이나 외부 저장소에서 가져온 skill을 보관합니다.

세션, 캐시, 인증 파일, 히스토리, telemetry 같은 런타임 상태는 관리하지 않습니다.

## 설치

```sh
cd ~/dotskills
stow -t ~ agents
```

설치 후 `~/.agents`는 `~/dotskills/agents/.agents`를 가리킵니다.

## Skill 네이밍

공용 skill은 용도에 따라 namespace를 붙입니다.

- `git:*`: 로컬 Git 작업
  - 예: `git:commit`, `git:branch`
- `github:*`: GitHub와 `gh` CLI에 의존하는 작업
  - 예: `github:issue`, `github:pr`

디렉터리 이름은 호환성을 위해 하이픈을 사용합니다.

```text
agents/.agents/skills/git-commit/SKILL.md      # name: git:commit
agents/.agents/skills/git-branch/SKILL.md      # name: git:branch
agents/.agents/skills/github-issue/SKILL.md    # name: github:issue
agents/.agents/skills/github-pr/SKILL.md       # name: github:pr
```

skill 내부에서 다른 skill의 파일을 참조할 때는 `~/.agents/skills/...`를 기준으로 씁니다.

## 외부 Skill 관리

다른 사람이 만든 plain skill은 바로 `~/.agents/skills`에 섞기보다 먼저 `vendor/skills`에 보관합니다.

추천 흐름:

1. 원본을 `vendor/skills/<source-name>` 아래에 둡니다.
2. 실제로 사용할 skill만 `agents/.agents/skills/<namespace-skill>`로 복사하거나 수정합니다.
3. 로컬 환경에만 존재하는 캐시 경로나 특정 도구 전용 경로는 제거합니다.
4. 프로젝트 컨벤션은 가능하면 `AGENTS.md`를 우선합니다.

외부 skill을 그대로 따라가지 않고 한 번 복사해서 쓰는 이유는, 개인 workflow에 맞게 이름과 경로를 안정적으로 통제하기 위해서입니다.

## Codex Plugin 관리

Codex plugin은 `plugins/<plugin-name>` 아래에 둡니다.

각 plugin은 최소한 다음 파일을 가져야 합니다.

```text
plugins/<plugin-name>/.codex-plugin/plugin.json
```

필요하면 plugin 안에 다음 요소를 추가할 수 있습니다.

```text
plugins/<plugin-name>/skills/
plugins/<plugin-name>/hooks/
plugins/<plugin-name>/scripts/
plugins/<plugin-name>/assets/
plugins/<plugin-name>/.mcp.json
plugins/<plugin-name>/.app.json
```

Codex에서 로컬 plugin marketplace로 노출하려면 `agents/.agents/plugins/marketplace.json`에 등록합니다.

```json
{
  "name": "plugin-name",
  "source": {
    "source": "local",
    "path": "./plugins/plugin-name"
  },
  "policy": {
    "installation": "AVAILABLE",
    "authentication": "ON_INSTALL"
  },
  "category": "Productivity"
}
```

## 원칙

- 재사용 가능한 개인 skill은 `~/.agents/skills`를 기준으로 관리합니다.
- 프로젝트별 agent 규칙은 `AGENTS.md`를 우선합니다.
- 공유 skill 안에는 `~/.claude/skills`, `~/.codex/skills` 같은 도구 전용 경로를 넣지 않습니다.
- 런타임 상태, 인증 정보, 캐시, 세션 파일은 이 저장소에 넣지 않습니다.
