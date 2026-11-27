# 스킬 목록

## 구성

스킬의 규칙은 각 `SKILL.md`에 있고, 이 문서에는 스킬을 고르는 데 필요한 정보만 적는다. 스킬 하나가 표의 행 하나에 대응한다.

- **호출**: `자동`은 에이전트가 설명의 트리거를 보고 고른다. `직접`은 사용자가 `/이름`으로 호출할 때만 쓴다.
- **연결**: `SKILL.md`가 직접 참조하거나 워크플로에서 함께 쓰는 스킬이다.
- 스킬을 추가하거나 삭제하면 이 문서의 행도 함께 갱신한다.

## 개발 워크플로

흐름은 [에이전트와 개발하는 방식](agent-workflow.md)을 따른다.

| 스킬 | 역할 | 호출 | 연결 | 출처 |
| --- | --- | --- | --- | --- |
| [grilling](../codex/.codex/skills/grilling/SKILL.md) | 계획과 결정을 사용자가 이해할 때까지 라운드 단위로 질문해 검증한다 | 자동 | grill-me | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/productivity/grilling)를 한국어로 옮김, [MIT](../codex/.codex/skills/grilling/LICENSE) |
| [grill-me](../codex/.codex/skills/grill-me/SKILL.md) | `grilling`을 직접 호출하는 별칭 | 직접 | grilling | grilling과 같음 |
| [codebase-design](../codex/.codex/skills/codebase-design/SKILL.md) | 깊은 모듈, seam, 인터페이스 어휘로 모듈의 모양을 설계한다 | 자동 | tdd | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/codebase-design)를 한국어로 옮김, [MIT](../codex/.codex/skills/codebase-design/LICENSE) |
| [tdd](../codex/.codex/skills/tdd/SKILL.md) | 합의한 seam에서 red와 green 슬라이스를 하나씩 반복한다 | 자동 | codebase-design, diff-review | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/tdd)를 한국어로 옮김, [MIT](../codex/.codex/skills/tdd/LICENSE) |
| [diff-review](../codex/.codex/skills/diff-review/SKILL.md) | 기준점 이후의 변경을 Standards와 Spec 두 축으로 나눠 리뷰한다 | 자동 | verification-before-completion | [mattpocock/skills의 code-review](https://github.com/mattpocock/skills/tree/main/skills/engineering/code-review)를 한국어로 옮기고, 내장 `code-review`와 겹치지 않도록 이름을 바꿈, [MIT](../codex/.codex/skills/diff-review/LICENSE) |
| [verification-before-completion](../codex/.codex/skills/verification-before-completion/SKILL.md) | 완료를 보고하기 전에 테스트와 빌드 같은 검증 근거를 확인한다 | 자동 | diff-review | [obra/superpowers](https://github.com/obra/superpowers/blob/main/skills/verification-before-completion/SKILL.md)를 수정, [MIT](../codex/.codex/skills/verification-before-completion/LICENSE) |
| [pr](../codex/.codex/skills/pr/SKILL.md) | PR 본문에 요약, before와 after 증거, 머지 위험(one-way 또는 two-way door)을 적는다 | 자동 | diff-review | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/pr)를 한국어로 옮김. 원 출처는 Dex Horthy의 [show-me](https://github.com/humanlayer/skills/blob/main/plugins/show-me/skills/show-me/SKILL.md), [MIT](../codex/.codex/skills/pr/LICENSE) |
| [diagnosing-bugs](../codex/.codex/skills/diagnosing-bugs/SKILL.md) | 빨간불이 켜지는 피드백 루프를 먼저 만들고 가설, 계측, 수정, 회귀 테스트로 진행한다 | 자동 | tdd, retro | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/diagnosing-bugs)를 한국어로 옮김, [MIT](../codex/.codex/skills/diagnosing-bugs/LICENSE) |
| [retro](../codex/.codex/skills/retro/SKILL.md) | 세션을 돌아보고 에이전트 환경(검사, 규약, 지침 파일, 도구)의 개선점을 심각도 순으로 제안한다 | 직접 | diff-review, diagnosing-bugs | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/retro)를 한국어로 옮기고 `writing-for-agents` 단계를 뺌, [MIT](../codex/.codex/skills/retro/LICENSE) |
| [worktree](../codex/.codex/skills/worktree/SKILL.md) | 저장소 루트의 `.worktrees/<브랜치>`에 git worktree를 만들고 그 안에서 작업한다 | 자동 | - | 직접 작성, `.worktrees/<브랜치>` 규칙과 생성 스크립트 |

## 학습

| 스킬 | 역할 | 호출 | 연결 | 출처 |
| --- | --- | --- | --- | --- |
| [teach](../codex/.codex/skills/teach/SKILL.md) | 여러 세션에 걸쳐 개념을 배우도록 `~/teach/<주제>/` 워크스페이스에서 가르친다 | 직접 | korean-expression, grilling | [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/productivity/teach)를 한국어로 옮기고, 원리 사슬과 자료 조사 기준을 더함, [MIT](../codex/.codex/skills/teach/LICENSE) |

## 한국어 글쓰기

| 스킬 | 역할 | 호출 | 연결 | 출처 |
| --- | --- | --- | --- | --- |
| [korean-expression](../codex/.codex/skills/korean-expression/SKILL.md) | 의미가 분명하고 자연스러운 한국어로 답변과 문서를 쓴다. 한국어 답변의 기본 기준이다 | 자동 | toss-technical-writing, humanize-korean | Billit의 [한국어 표현 가이드](https://github.com/JECT-Study/Billit-5th-Docs/blob/main/guide/한국어%20표현%20가이드.md)를 바탕으로 작성, 원 출처는 [snflkd/fluent-korean](https://github.com/snflkd/fluent-korean). ASD-STE100, EARS, ISO/IEC/IEEE 29148과 [토스 테크니컬 라이팅 가이드](https://technical-writing.dev/sentence/index.html) 참고 |
| [toss-technical-writing](../codex/.codex/skills/toss-technical-writing/SKILL.md) | 독자 가치와 핵심 메시지 중심으로 문서와 이력서 문장을 쓴다 | 자동 | korean-expression, cv-writing | [토스 라이팅 가이드](https://technical-writing.dev/overview.html), [토스 테크 1](https://toss.tech/article/technical-writing-1), [토스 테크 5](https://toss.tech/article/technical-writing-5) 참고 |
| [humanize-korean](../codex/.codex/skills/humanize-korean/SKILL.md) | AI가 쓴 한국어 글의 번역투와 기계적 표현을 내용 변경 없이 윤문한다 | 자동 | korean-expression | [epoko77-ai/im-not-ai](https://github.com/epoko77-ai/im-not-ai/tree/14aeb52d13e737beb4e999cb7cb92275d0969689), [MIT](../codex/.codex/skills/humanize-korean/LICENSE) |
| [my-voice](../codex/.codex/skills/my-voice/SKILL.md) | 사용자의 말투와 사고 흐름을 살려 사람이 쓴 듯한 글을 쓴다 | 자동 | my-voice-formal | 기존 개인 스킬, 외부 출처 기록 없음 |
| [my-voice-formal](../codex/.codex/skills/my-voice-formal/SKILL.md) | 자기소개서와 지원서처럼 공식 문서에서 사용자의 말투를 살려 쓴다 | 자동 | my-voice, cv-writing | 기존 개인 스킬, 외부 출처 기록 없음 |
| [cv-writing](../codex/.codex/skills/cv-writing/SKILL.md) | 개발자 이력서, 경력기술서, 포트폴리오의 경험 선별과 성과 표현을 다듬는다 | 자동 | toss-technical-writing, my-voice-formal | 개인 이력서 개정 과정에서 정리한 [작성 가이드](../codex/.codex/skills/cv-writing/references/cv-style-guide.md) |
