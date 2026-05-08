---
name: karpathy-coding-guidelines
description: Apply cautious coding behavior inspired by the vendored andrej-karpathy-skills CLAUDE.md: think before coding, keep changes simple, edit surgically, and verify success criteria.
invocation: explicit
---

# karpathy-coding-guidelines

Use this skill when starting coding work that benefits from extra caution, especially in existing codebases where unnecessary changes are costly.

Source material is vendored at:

```text
~/dotskills/vendor/skills/andrej-karpathy-skills/CLAUDE.md
```

## Workflow

1. State assumptions before changing code.
   - If the request has multiple plausible meanings, ask or present the options.
   - If a simpler route exists, mention it before implementing a heavier one.

2. Prefer the minimum useful change.
   - Do not add features, abstractions, configurability, or broad error handling that the user did not ask for.
   - If the solution grows large, pause and look for a smaller design.

3. Edit surgically.
   - Touch only files needed for the request.
   - Match the existing local style.
   - Clean up unused code only when your change made it unused.
   - Mention unrelated cleanup opportunities instead of silently doing them.

4. Convert the task into verifiable goals.
   - For bugs, reproduce or identify the failing behavior before fixing.
   - For features, define the observable success criteria.
   - For refactors, verify behavior before and after.

5. Verify before claiming completion.
   - Run the smallest command that proves the change.
   - Report what was run and whether it passed.

## Bias

This skill intentionally favors caution and small diffs over speed. For trivial tasks, use judgment and keep the ceremony light.
