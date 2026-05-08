# dotskills

Agent skills and lightweight agent configuration managed as dotfiles.

## Layout

- `agents/.agents/skills`: canonical personal skills shared by Codex, pi, and other agents that read `~/.agents`.
- Tool-specific runtime state such as sessions, caches, auth files, histories, and telemetry is intentionally excluded.

## Install

```sh
cd ~/dotskills
stow -t ~ agents
```

## Policy

- Keep reusable skills in `~/.agents/skills`.
- Prefer `AGENTS.md` for project-level agent conventions.
- Avoid Claude-specific paths such as `~/.claude/skills` and tool-specific paths such as `~/.codex/skills` inside shared skills.
