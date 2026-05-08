# Plugins

`dotskills`에서 함께 관리할 로컬 Codex plugin을 두는 위치입니다.

각 plugin은 `plugins/<plugin-name>` 아래에 두고, 최소한 `.codex-plugin/plugin.json`을 포함해야 합니다.

Codex에서 설치 가능하거나 사용 가능한 plugin으로 노출하려면 `agents/.agents/plugins/marketplace.json`에 등록합니다.

등록할 때는 저장소 루트 기준 상대 경로를 사용합니다.

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
