---
name: korean-expression
description: 의미가 분명하고 자연스러운 한국어로 답변과 결과물을 작성한다. 한국어로 답변하거나 정책서, 기획서, 설계서, 튜토리얼, How-to, 설명 문서, Figma 화면 설명, Issue, PR, 코멘트, Slack과 Discord 메시지 같은 한국어 결과물을 쓰고 고칠 때 사용한다. 요청받은 외국어 번역이나 코드 관례를 바꾸는 데는 사용하지 않는다.
---

# 한국어 표현 가이드

## 목적과 적용 범위

이 가이드는 의미가 분명하고 자연스러운 한국어를 쓰기 위한 기준이다. 모든 규칙은 확정된 기준이며, 작성자가 상황에 따라 적용 여부를 판단하지 않는다.

한국어 설명문에 적용한다. 코드, 코드 주석, 변수명, 로그 문자열과 커밋 메시지의 관례를 바꾸는 기준으로 사용하지 않는다. 인용문과 실제 화면 문구는 원문을 유지한다. 외국어 표기나 원문 유지가 필요한 내용은 임의로 번역하지 않는다.

저장소의 지침이나 템플릿이 구조를 정하면 그 구조를 따른다. 이때도 문장, 어미와 어휘는 이 가이드를 따른다.

## 작업 순서

1. 결과물의 사용처를 정하고 다음 표에서 사용처에 맞는 파일을 읽는다.
2. [어미 체계](references/endings.md)에서 사용처의 기본 어미와 명사형 종결 위치를 정한다.
3. 초안을 쓴다.
4. [한국어 통제 규칙](references/controlled-korean.md)의 검사 항목으로 문장과 어휘를 고친다.
5. [표현 검토](#표현-검토) 항목을 확인한다.

| 사용처 | 함께 읽는 파일 |
| --- | --- |
| 모든 한국어 결과물 | [어미 체계](references/endings.md), [한국어 통제 규칙](references/controlled-korean.md) |
| 정책서, 기획서, API 스펙, 규칙 가이드, README | [문서](references/usage/document.md), [요구사항 문장](references/requirements.md), [예시 블록](references/example-blocks.md) |
| 설계서 | [문서](references/usage/document.md), [설계서](references/usage/design.md), [요구사항 문장](references/requirements.md), [예시 블록](references/example-blocks.md) |
| 튜토리얼 | [문서](references/usage/document.md), [튜토리얼](references/usage/tutorial.md), [예시 블록](references/example-blocks.md) |
| How-to, 트러블슈팅 | [문서](references/usage/document.md), [How-to](references/usage/how-to.md), [예시 블록](references/example-blocks.md) |
| 배경, 개념, 전환 설계를 설명하는 문서 | [문서](references/usage/document.md), [설명 문서](references/usage/article.md), [예시 블록](references/example-blocks.md) |
| Figma 화면 설명, 다른 문서에서 화면 가리키기 | [화면 설명](references/usage/screen.md), [예시 블록](references/example-blocks.md) |
| GitHub Issue | [Issue](references/usage/issue.md), [요구사항 문장](references/requirements.md), [예시 블록](references/example-blocks.md) |
| Pull Request | [PR](references/usage/pr.md), [예시 블록](references/example-blocks.md) |
| Issue와 PR의 코멘트, 코드 리뷰 | [코멘트](references/usage/comment.md) |
| Slack, Discord 같은 팀 메신저 | [메신저](references/usage/messenger.md) |
| 에이전트가 사용자에게 보내는 대화 답변 | 추가 파일 없음 |

## 주체와 대상이 분명한 문장

- 사용자 행동은 사용자를, 시스템 동작은 시스템을 주체로 쓴다. 같은 주체가 이어지면 두 번째 문장부터 주체를 생략한다.
- 뜻을 이해하는 데 필요한 주어, 목적어와 맥락을 생략하지 않는다. 짧게 쓰더라도 누가 무엇을 하고 어떤 결과가 생기는지 드러나게 쓴다.
- 수식어가 어느 대상에 붙는지 분명하게 쓴다. 여러 조건이 겹치면 조건과 동작을 나누어 쓴다.

## 완결된 문장과 자연스러운 연결

- 문장과 명사형 종결의 위치는 [어미 체계](references/endings.md)를 따른다.
- 조사와 어미를 과도하게 생략하지 않는다. 문장 성분 사이의 관계가 드러나도록 쓴다.
- 조건과 결과, 원인과 영향을 연결할 때는 관계를 명시한다. 접속사를 붙이는 것만으로 논리적 연결을 대신하지 않는다.
- 모든 문장을 같은 길이나 구조로 맞추지 않는다. 함께 읽어야 의미가 분명한 내용은 연결하고, 독립된 판단은 나눈다.

## 행동과 상황을 설명하는 표현

`책임 분리`, `기준 정리`, `흐름 개선`, `일관성 확보` 같은 추상적인 표현만으로 설명을 끝내지 않는다. 무엇을 나누고 어떤 기준을 적용하며 무엇이 달라지는지 쓴다.

조건이나 결과를 알 수 없는 표현은 근거를 확인해 구체화한다. 금지 표현과 대체 표현은 [한국어 통제 규칙](references/controlled-korean.md#통제-어휘)에서 관리한다. 원문에 없는 조건이나 효과를 덧붙여 구체적으로 보이게 만들지 않는다.

명사에 여러 관계를 압축하지 않고 행동과 상황을 문장으로 푼다. 이미 뜻이 명확한 명사, 정확한 기술 용어와 제목은 풀어 쓰지 않는다.

다음 예시는 표현을 비교하기 위한 것이며 새로운 정책을 정의하지 않는다.

| 피하는 표현 | 권장 표현 |
| --- | --- |
| 개인 환율 변경에 따른 기존 지출 영향 없음. | 개인 환율을 변경해도 기존 지출의 환율은 바뀌지 않는다. |
| 멱등성 보장을 통한 중복 저장 방지. | 서버는 같은 고유키의 재요청으로 지출을 다시 저장하지 않는다. |
| 응답 수신 실패 시 재시도 수행. | 앱이 응답을 받지 못하면 같은 고유키로 저장을 재시도한다. |

## 번역투와 과장된 표현

- 한국어 대체어가 있는 영어 표현은 한국어로 쓴다. 고유명사와 기술 용어는 [통제 어휘](references/controlled-korean.md#통제-어휘)의 기준을 따른다.
- 한자어나 추상적인 명사를 겹쳐 뜻을 압축하지 않는다.
- 낯선 비유나 과장된 은유로 일반적인 동작을 설명하지 않는다. 중요성과 효과는 확인한 근거의 범위에서 쓴다.
- 대화의 축약어와 말투를 결과물에 옮기지 않는다.
- 작성 과정의 대화를 가리키는 표현을 쓰지 않는다. `앞서 말씀하신`, `요청하신 대로`, `논의한 것처럼`처럼 대화에 참여한 사람만 이해하는 지시어 대신 근거 자료를 링크한다.

## 표현 검토

초안을 쓴 뒤에는 문법만 보지 않고, 독자가 실제 의미를 이해하는지 확인한다.

- 사용처의 기본 어미를 지켰고, 명사형 종결이 정해진 위치에만 있는가?
- 주체와 대상, 수식어의 관계가 분명한가?
- 추상적인 명사 나열을 실제 행동과 결과로 설명했는가?
- 원인과 결과의 관계가 분명하며, 근거 없는 영향을 덧붙이지 않았는가?
- [한국어 통제 규칙](references/controlled-korean.md#검사-항목)의 검사 항목을 통과했는가?
- 고치는 과정에서 조건, 의무 수준과 확정 여부가 달라지지 않았는가?

## 참고

Billit의 [한국어 표현 가이드](https://github.com/JECT-Study/Billit-5th-Docs/blob/main/guide/한국어%20표현%20가이드.md)를 바탕으로 썼다. 원 출처는 [snflkd/fluent-korean](https://github.com/snflkd/fluent-korean)이다. 통제 규칙은 ASD-STE100의 구성을, 문장 규칙 일부는 [토스 테크니컬 라이팅 가이드](https://technical-writing.dev/sentence/index.html)를 참고했다.
