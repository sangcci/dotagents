# Vendored Skills

다른 사람이 만든 skill이나 외부 저장소에서 가져온 원본을 보관하는 위치입니다.

여기 있는 파일은 바로 실행용이라기보다, 출처가 있는 원재료로 봅니다. 실제로 사용할 skill은 `agents/.agents/skills` 아래에 복사하거나 우리 workflow에 맞게 수정해서 둡니다.

추천 흐름:

1. 원본을 `vendor/skills/<source-name>` 아래에 보관합니다.
2. 실제로 쓸 내용만 `agents/.agents/skills/<skill-name>`로 복사하거나 변환합니다.
3. 복사한 skill에는 로컬 수정 사항을 명시적으로 반영합니다.
4. 런타임 캐시 경로나 특정 도구 전용 경로에 의존하지 않게 정리합니다.

이름 규칙:

- GitHub 작업은 `github-*` 접두사를 사용합니다.
- 로컬 Git 작업은 `git-*` 접두사를 사용합니다.
- skill 이름과 디렉터리 이름 모두 하이픈을 사용합니다.
