# Vendored Skills

Use this directory for upstream skills copied from other people or mirrored from external repositories.

Recommended flow:

1. Keep the upstream source under `vendor/skills/<source-name>`.
2. Copy or adapt selected skills into `agents/.agents/skills/<namespace-skill>`.
3. Keep local edits explicit in the copied skill instead of depending on runtime cache paths.

For GitHub-specific skills, prefer the `github-*` directory prefix and `github:*` skill name. For local Git workflows, prefer `git-*` and `git:*`.
