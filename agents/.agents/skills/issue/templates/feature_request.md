---
name: 기능 추가
labels: ["✨ feat"]
title: "{title}"
---

## Fields

### summary
- label: 기능 요약
- description: 추가하려는 기능을 한 줄로 설명해주세요.
- placeholder: ex) 차 대절 예약 시 PostgreSQL Advisory Lock으로 동시성 제어
- required: true
- type: input

### background
- label: 배경 및 목적
- description: 왜 이 기능이 필요한가요? 해결하려는 문제나 달성하려는 목표를 설명해주세요.
- required: true
- type: textarea

### tasks
- label: 구현 방향
- description: 어떻게 구현할지 체크리스트로 작성해주세요.
- default: |
    - [ ]
    - [ ]
    - [ ]
- required: true
- type: textarea

### references
- label: 참고 자료
- description: 관련 문서, 링크, PR 등이 있다면 작성해주세요.
- required: false
- type: textarea
