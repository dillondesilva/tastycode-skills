# Tastycode Skills Scaffold

Reusable AI skill pack with a simple installer.

## Structure

- `skills/` - Source skills in `<skill-name>/SKILL.md` format
- `scripts/install-skills.sh` - Install skills globally or into a project

## Quick start

Install all skills into current project (local clone):

```bash
bash scripts/install-skills.sh --project .
```

Install all skills into current project (`curl`):

```bash
curl -fsSL https://raw.githubusercontent.com/dillondesilva/tastycode-skills/main/scripts/install-skills.sh | bash -s -- --project .
```

Install specific skills globally (local clone):

```bash
bash scripts/install-skills.sh --global concept-chain debug-the-explanation
```

Install specific skills globally (`curl`):

```bash
curl -fsSL https://raw.githubusercontent.com/dillondesilva/tastycode-skills/main/scripts/install-skills.sh | bash -s -- --global concept-chain debug-the-explanation
```

List available skills (local clone):

```bash
bash scripts/install-skills.sh --list
```

List available skills (`curl`):

```bash
curl -fsSL https://raw.githubusercontent.com/dillondesilva/tastycode-skills/main/scripts/install-skills.sh | bash -s -- --list
```
