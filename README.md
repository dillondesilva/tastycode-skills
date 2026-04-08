# Tastycode Skills Scaffold

Reusable AI skill pack with a simple installer.

The installer supports both local repo usage and `curl | bash` usage.
When run outside the repo, it clones this repository to a temporary directory,
installs selected skills, and then removes the temporary clone.

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

## Installer behavior

- Uses local `skills/` when running from this repo.
- Falls back to cloning `tastycode-skills` into a temporary directory when needed.
- Installs into:
  - `--project <path>` -> `<path>/.cursor/skills`
  - `--global` -> `~/.cursor/skills`
- Optional skill names install only those skills; no names installs all.
- Set `TC_SKILLS_REPO_URL` to override the clone source repository.
