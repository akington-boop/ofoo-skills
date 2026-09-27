#!/usr/bin/env bash
# Symlinks ofoo-skills/skills/* into ~/.claude/skills/*. No downloads, no
# network calls, no sudo. Only touches SKILLS_DEST below; --prune only
# removes symlinks that resolve back into SKILLS_SRC (see loop at bottom).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_SRC="$ROOT/skills"          # this repo's skills/ dir (source of truth)
SKILLS_DEST="$HOME/.claude/skills" # where Claude Code looks for skills

dry_run=0
prune=0

usage() {
    cat <<'EOF'
Usage: install.sh [--dry-run] [--prune] [--help]

Symlinks ofoo-skills into ~/.claude/skills:
  - ~/.claude/skills/<name> -> ofoo-skills/skills/<name> (one symlink per skill,
    only for subfolders of ofoo-skills/skills/ containing a SKILL.md at their root)

~/.claude/skills/ also holds skills from other sources (plugins, dotclaude, manual
installs) that ofoo-skills does not own. Those are left untouched.

  --dry-run   Report actions without touching the filesystem.
  --prune     Remove skill symlinks in the destination that point back into
              ofoo-skills/ but no longer have a matching source folder.
              Never touches a dest entry that isn't an ofoo-skills-owned symlink.
  --help      Show this message.

Output lines: installed: <name> | skipped: <name> (<reason>) | replaced: <name> (was a real directory)
              orphan: <name> | pruned: <name>
Exit codes:   0 success | 1 runtime error | 2 bad usage
EOF
}

while [ $# -gt 0 ]; do
    case "$1" in
        --dry-run) dry_run=1 ;;
        --prune)   prune=1 ;;
        --help|-h) usage; exit 0 ;;
        *) echo "error: unknown argument '$1'" >&2; usage >&2; exit 2 ;;
    esac
    shift
done

[ -d "$SKILLS_SRC" ] || { echo "error: source not found: $SKILLS_SRC" >&2; exit 1; }

[ "$dry_run" -eq 1 ] || mkdir -p "$SKILLS_DEST"

installed=0
skipped=0
orphaned=0
pruned=0

link() {
    # rm -rf here only ever targets $SKILLS_DEST/<name> (never $src) —
    # replaces whatever is at dest (broken symlink, old symlink, or real dir).
    local src="$1" dest="$2"
    if [ "$dry_run" -eq 0 ]; then
        rm -rf "$dest"
        ln -sfn "$src" "$dest"
    fi
}

for src in "$SKILLS_SRC"/*/; do
    [ -d "$src" ] || continue
    name="$(basename "$src")"
    if [ ! -f "$src/SKILL.md" ]; then
        echo "skipped: $name (no SKILL.md)"
        skipped=$((skipped + 1))
        continue
    fi
    dest="$SKILLS_DEST/$name"
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "${src%/}" ]; then
        echo "installed: $name (already linked)"
    elif [ -e "$dest" ] && [ ! -L "$dest" ]; then
        link "${src%/}" "$dest"
        echo "replaced: $name (was a real directory)"
    else
        link "${src%/}" "$dest"
        echo "installed: $name"
    fi
    installed=$((installed + 1))
done

if [ -d "$SKILLS_DEST" ]; then
    for dest in "$SKILLS_DEST"/*; do
        [ -e "$dest" ] || [ -L "$dest" ] || continue
        name="$(basename "$dest")"
        [ -d "$SKILLS_SRC/$name" ] && continue

        # Only ever act on entries that are symlinks pointing back into
        # ofoo-skills/skills/ — never a real directory or a symlink to
        # somewhere else (that's someone else's skill, not ours to remove).
        if [ -L "$dest" ] && [[ "$(readlink "$dest")" == "$SKILLS_SRC"/* ]]; then
            if [ "$prune" -eq 1 ]; then
                [ "$dry_run" -eq 0 ] && rm -f "$dest"
                echo "pruned: $name"
                pruned=$((pruned + 1))
            else
                echo "orphan: $name"
                orphaned=$((orphaned + 1))
            fi
        fi
    done
fi

suffix=""
if [ "$dry_run" -eq 1 ]; then
    suffix=" (dry-run)"
fi

echo "summary: installed=$installed skipped=$skipped orphan=$orphaned pruned=$pruned$suffix"
