# dotagents

## 구조

```text
dotagents/
├── README.md
└── codex/.codex/
    ├── AGENTS.md
    └── skills/
        ├── attention-kind/
        ├── fluent-korean/
        ├── humanize-korean/
        ├── my-voice/
        ├── my-voice-formal/
        ├── toss-technical-writing/
        └── verification-before-completion/
```

## 설치 및 사용

Git과 GNU Stow를 설치한 뒤 실행합니다. macOS에서는 `brew install stow`로 Stow를 설치할 수 있습니다.

```sh
git clone https://github.com/sangcci/dotagents.git ~/dotagents
cd ~/dotagents
stow --simulate -t ~ codex
stow -t ~ codex
```

이미 clone했다면 설치 명령만 실행합니다. 같은 위치에 일반 파일이 있으면 먼저 백업하고 원본과 비교해 정리합니다. Stow는 충돌하는 파일을 덮어쓰지 않습니다.

- 전역 지침: `codex/.codex/AGENTS.md`를 수정합니다.
- 스킬: `codex/.codex/skills/<skill-name>/`를 수정하거나 추가합니다.
- 파일이나 스킬을 추가한 뒤에는 `stow -t ~ codex`를 다시 실행합니다.
- Codex에서 새 대화를 열어 지침과 스킬을 확인합니다. 스킬은 이름을 요청에 명시해 사용할 수 있습니다.
- 연결 해제는 저장소에서 `stow -D -t ~ codex`로 실행합니다. 원본 파일은 유지됩니다.

Codex의 전역 지침은 `~/.codex/AGENTS.md`로 연결됩니다. `config.toml`, 인증 정보, 시스템 스킬과 캐시는 관리 대상에서 제외합니다.

참고: [AGENTS.md 공식 문서](https://learn.chatgpt.com/docs/agent-configuration/agents-md), [스킬 공식 문서](https://learn.chatgpt.com/docs/build-skills).

## 다른 에이전트나 플러그인에서 사용

이 저장소는 Codex용 Stow 패키지를 제공하며, 플러그인 설치 패키지는 아닙니다. 다른 도구에서는 해당 도구가 지원하는 스킬 경로에 필요한 스킬 디렉터리를 연결합니다. 예를 들어 `~/.agents/skills`를 읽는 도구라면 다음처럼 연결할 수 있습니다.

```sh
mkdir -p ~/.agents/skills
ln -s ~/dotagents/codex/.codex/skills/fluent-korean ~/.agents/skills/fluent-korean
```

예제는 대상 경로가 비어 있을 때 사용합니다. 스킬의 참고 파일도 필요하므로 `SKILL.md` 파일 하나가 아닌 디렉터리 전체를 연결합니다. 심볼릭 링크를 지원하지 않는 환경에서는 디렉터리를 복사하되, 수정은 dotagents에서 하고 다시 배포합니다.

전역 지침 파일명과 스킬 지원 여부는 도구마다 다릅니다. `AGENTS.md`의 내용을 해당 도구의 지침 형식에 맞게 적용하고, 상대 경로인 `skills/...`도 실제 설치 위치에 맞춥니다. `agents/openai.yaml`은 Codex용 메타데이터이므로 다른 도구에서 동일하게 적용된다고 가정하지 않습니다.

플러그인으로 배포하려면 해당 플랫폼의 manifest와 스킬 등록 규칙에 맞게 별도로 패키징해야 합니다.

## 스킬 출처

| 스킬 | 출처 | 적용 방식 |
| --- | --- | --- |
| attention-kind | [alexgreensh/attention-span](https://github.com/alexgreensh/attention-span) | 결론 우선, 필수 정보 보존 원칙을 참고해 한국어 응답용으로 새로 작성했습니다. |
| fluent-korean | [snflkd/fluent-korean](https://github.com/snflkd/fluent-korean) | 원본 output-style을 Codex 스킬 형식에 맞게 적용했습니다. |
| toss-technical-writing | 비바리퍼블리카 [테크니컬 라이팅 가이드](https://technical-writing.dev/overview.html), 토스 테크 [Technical Writer, 사라질 결심](https://toss.tech/article/technical-writing-5), [세상에 없던 직무를 만들어가기](https://toss.tech/article/technical-writing-1) | 공개 자료의 원칙과 사례를 한국어 문서 작성과 편집에 적용했습니다. |
| verification-before-completion | [obra/superpowers](https://github.com/obra/superpowers/blob/main/skills/verification-before-completion/SKILL.md) | 한국어로 재구성하고 검증과 로그 처리 지침을 조정했습니다. 원본 MIT 라이선스와 저작권 고지는 [LICENSE](codex/.codex/skills/verification-before-completion/LICENSE)에 보존합니다. |
| my-voice, my-voice-formal | 기존 dotskills 저장소의 개인 스킬 | Git HEAD의 원본과 참고 자료를 복원했습니다. 외부 출처는 기록되어 있지 않습니다. |
| humanize-korean | [epoko77-ai/im-not-ai](https://github.com/epoko77-ai/im-not-ai/tree/14aeb52d13e737beb4e999cb7cb92275d0969689) | Codex용 스킬과 참고 자료를 가져왔습니다. 외부 상대 링크는 실제 파일로 포함하고 [MIT 라이선스](codex/.codex/skills/humanize-korean/LICENSE)를 보존했습니다. |

