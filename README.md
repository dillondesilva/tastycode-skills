# Tastycode Skills Scaffold

Reusable AI skill pack with a simple installer.

## Structure

- `skills/` - Source skills in `<skill-name>/SKILL.md` format
- `scripts/install-skills.sh` - Install skills globally or into a project

## Quick start

Install all skills into current project:

```bash
bash scripts/install-skills.sh --project .
```

Install specific skills globally:

```bash
bash scripts/install-skills.sh --global concept-chain debug-the-explanation
```

List available skills:

```bash
bash scripts/install-skills.sh --list
```
