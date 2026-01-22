---
name: push-pr
description: Push to staging and auto-create PR to main
version: 1.0.0
---

# Push with Auto-PR

Push local commits to staging and automatically create/update a PR to main.

## Usage

```
/push-pr
```

## Instructions

When the user invokes `/push`:

### 1. Execute the push

**Default push** (no arguments):
```bash
git push
```

**With arguments** (pass through to git):
```bash
git push $ARGS
```

### 2. Report the result

Show which branch was pushed and to where.

### 3. Auto-create PR (for staging branch)

If pushing to `staging` and the push succeeded:

1. **Check for existing PR** from staging to main:
   ```bash
   gh pr list --base main --head staging --json number --jq 'length'
   ```

2. **If no PR exists**, create one:
   ```bash
   gh pr create --base main --head staging \
     --title "$(git log -1 --format='%s')" \
     --body "$(cat <<'BODY'
   ## Changes
   $(git log origin/main..origin/staging --oneline)

   ---
   *Auto-created by /push*

   🤖 Generated with [Claude Code](https://claude.com/claude-code)
   BODY
   )"
   ```

3. **If PR already exists**, report its URL:
   ```bash
   gh pr view --json url --jq '.url'
   ```

## Safety

- Never use `--force` on main/master unless the user explicitly requests it
- Warn if pushing to a protected branch with force
- Show the commit range being pushed before executing
