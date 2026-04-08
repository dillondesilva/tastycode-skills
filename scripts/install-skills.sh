#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR=""
if [[ -n "${BASH_SOURCE[0]:-}" && -f "${BASH_SOURCE[0]}" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
  SOURCE_DIR="${ROOT_DIR}/skills"
fi
REPO_URL="${TC_SKILLS_REPO_URL:-https://github.com/dillondesilva/tastycode-skills.git}"

TMP_CLONE=""

cleanup() {
  if [[ -n "${TMP_CLONE}" && -d "${TMP_CLONE}" ]]; then
    rm -rf "${TMP_CLONE}"
  fi
}
trap cleanup EXIT

usage() {
  cat <<'EOF'
Usage:
  install-skills.sh --list
  install-skills.sh --project <path> [skill-name ...]
  install-skills.sh --global [skill-name ...]

Examples:
  install-skills.sh --project .
  install-skills.sh --project ~/work/my-app code-review
  install-skills.sh --global code-review release-notes
EOF
}

list_skills() {
  for dir in "${SOURCE_DIR}"/*; do
    [[ -d "${dir}" ]] || continue
    basename "${dir}"
  done
}

ensure_source_dir() {
  if [[ -d "${SOURCE_DIR}" ]]; then
    return
  fi

  TMP_CLONE="$(mktemp -d)"
  if ! git clone --depth 1 "${REPO_URL}" "${TMP_CLONE}"; then
    echo "Failed to clone skills repo: ${REPO_URL}" >&2
    exit 1
  fi
  SOURCE_DIR="${TMP_CLONE}/skills"

  if [[ ! -d "${SOURCE_DIR}" ]]; then
    echo "Could not find skills directory after clone: ${SOURCE_DIR}" >&2
    exit 1
  fi
}

copy_skill() {
  local skill="$1"
  local target="$2"
  local from="${SOURCE_DIR}/${skill}"
  local to="${target}/${skill}"

  if [[ ! -d "${from}" ]]; then
    echo "Skill not found: ${skill}" >&2
    exit 1
  fi

  rm -rf "${to}"
  mkdir -p "${target}"
  cp -R "${from}" "${to}"
  echo "Installed: ${skill} -> ${to}"
}

main() {
  if [[ $# -eq 0 ]]; then
    usage
    exit 1
  fi

  ensure_source_dir

  local mode=""
  local target=""

  case "${1}" in
    --list)
      list_skills
      exit 0
      ;;
    --project)
      mode="project"
      shift
      target="${1:-}"
      [[ -n "${target}" ]] || { usage; exit 1; }
      shift
      target="${target}/.cursor/skills"
      ;;
    --global)
      mode="global"
      shift
      target="${HOME}/.cursor/skills"
      ;;
    *)
      usage
      exit 1
      ;;
  esac

  local skills=("$@")
  if [[ ${#skills[@]} -eq 0 ]]; then
    skills=()
    while IFS= read -r skill; do
      skills+=("${skill}")
    done < <(list_skills)
  fi

  for skill in "${skills[@]}"; do
    copy_skill "${skill}" "${target}"
  done

  echo "Done (${mode}): ${target}"
}

main "$@"
