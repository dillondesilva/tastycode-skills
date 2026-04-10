# Tastycode Skills

This is a quick collection of some AI skills that I'm writing to try to:

1. Provide safe guardrails that enable understanding of codebases without full offloading to AI (i.e. mitigating the risk of long-term cognitive decline).

2. Enable learning of a given codebase via microlearning style exercises.

3. Keep the process of reading, writing and understanding code engaging whilst still making use of the latest and greatest tools.

## Quick install

Clone, install, and clean up in one shot:

```bash
git clone https://github.com/dillondesilva/tastycode-skills.git /tmp/tastycode-skills \
  && bash /tmp/tastycode-skills/scripts/install-skills.sh --global \
  && rm -rf /tmp/tastycode-skills
```

Replace `--global` with any target flag below to change where skills land.

## Install targets

| Flag | Installs to |
|------|-------------|
| `--project <path>` | `<path>/.cursor/skills/` |
| `--global` | `~/.cursor/skills/` |
| `--claude-project <path>` | `<path>/.claude/skills/` |
| `--claude-global` | `~/.claude/skills/` |

Append skill names to install only specific ones (omit to install all):

```bash
git clone https://github.com/dillondesilva/tastycode-skills.git /tmp/tastycode-skills \
  && bash /tmp/tastycode-skills/scripts/install-skills.sh --global concept-chain feynman \
  && rm -rf /tmp/tastycode-skills
```

## List available skills

```bash
git clone https://github.com/dillondesilva/tastycode-skills.git /tmp/tastycode-skills \
  && bash /tmp/tastycode-skills/scripts/install-skills.sh --list \
  && rm -rf /tmp/tastycode-skills
```

## Structure

- `skills/` — source skills in `<skill-name>/SKILL.md` format
- `scripts/install-skills.sh` — installer script

## Notes

- Set `TC_SKILLS_REPO_URL` to override the clone source repository.
- Requires `bash` and `git`.
