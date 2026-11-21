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

## 스킬 출처

| 스킬 | 출처 |
| --- | --- |
| cv-writing | 개인 이력서 개정 과정에서 정리한 [작성 가이드](codex/.codex/skills/cv-writing/references/cv-style-guide.md) |
| humanize-korean | [epoko77-ai/im-not-ai](https://github.com/epoko77-ai/im-not-ai/tree/14aeb52d13e737beb4e999cb7cb92275d0969689), [MIT](codex/.codex/skills/humanize-korean/LICENSE) |
| korean-expression | Billit의 [한국어 표현 가이드](https://github.com/JECT-Study/Billit-5th-Docs/blob/main/guide/한국어%20표현%20가이드.md)를 바탕으로 작성, 원 출처는 [snflkd/fluent-korean](https://github.com/snflkd/fluent-korean). ASD-STE100, EARS, ISO/IEC/IEEE 29148과 [토스 테크니컬 라이팅 가이드](https://technical-writing.dev/sentence/index.html) 참고 |
| my-voice, my-voice-formal | 기존 개인 스킬, 외부 출처 기록 없음 |
| toss-technical-writing | [토스 라이팅 가이드](https://technical-writing.dev/overview.html), [토스 테크 1](https://toss.tech/article/technical-writing-1), [토스 테크 5](https://toss.tech/article/technical-writing-5) 참고 |
| worktree | 직접 작성, `.worktrees/<브랜치>` 규칙과 생성 스크립트 |
| verification-before-completion | [obra/superpowers](https://github.com/obra/superpowers/blob/main/skills/verification-before-completion/SKILL.md)를 수정, [MIT](codex/.codex/skills/verification-before-completion/LICENSE) |
