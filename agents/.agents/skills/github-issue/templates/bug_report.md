---
name: 버그 리포트
labels: ["🐛 bug"]
title: "{title}"
---

## Fields

### summary
- label: 버그 요약
- description: 어떤 문제가 발생했는지 한 줄로 설명해주세요.
- placeholder: ex) 차 대절 예약 시 passengerCount가 감소하지 않음
- required: true
- type: input

### steps
- label: 재현 방법
- description: 버그를 재현할 수 있는 단계를 순서대로 작성해주세요.
- default: |
    1.
    2.
    3.
- required: true
- type: textarea

### expected
- label: 기대 동작
- description: 정상적으로 동작할 경우 어떤 결과가 나와야 하나요?
- required: true
- type: textarea

### actual
- label: 실제 동작
- description: 실제로 어떤 결과가 나왔나요?
- required: true
- type: textarea

### environment
- label: 환경
- description: Java, Spring Boot 버전 등 관련 환경을 작성해주세요.
- placeholder: |
    - Java: 17
    - Spring Boot: 3.3.5
    - DB: PostgreSQL
- required: false
- type: textarea

### logs
- label: 관련 로그 / 스택트레이스
- description: 관련 로그나 에러 메시지가 있다면 붙여넣어주세요.
- required: false
- type: textarea
