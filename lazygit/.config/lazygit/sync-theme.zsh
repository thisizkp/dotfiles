#!/bin/zsh
set -euo pipefail

config_file="${LG_CONFIG_FILE:-$HOME/.config/lazygit/config.yml}"
target_file="$config_file"

if [[ -L "$config_file" ]]; then
  target_file="$(readlink "$config_file")"
  [[ "$target_file" != /* ]] && target_file="${config_file:h}/$target_file"
  target_file="${target_file:A}"
fi

detect_terminal_theme() {
  [[ -r /dev/tty && -w /dev/tty ]] || return 1

  local old_stty response char red green blue
  old_stty="$(stty -g < /dev/tty 2>/dev/null)" || return 1

  stty raw -echo min 0 time 2 < /dev/tty 2>/dev/null || return 1
  printf '\033]11;?\033\\' > /dev/tty

  response=""
  while IFS= read -r -s -k 1 -t 0.02 char < /dev/tty; do
    response+="$char"
    [[ "$response" == *$'\a' || "$response" == *$'\033\\' ]] && break
  done

  stty "$old_stty" < /dev/tty 2>/dev/null || true

  [[ "$response" =~ 'rgb:([0-9a-fA-F]+)/([0-9a-fA-F]+)/([0-9a-fA-F]+)' ]] || return 1
  red=$((16#${match[1][1,2]}))
  green=$((16#${match[2][1,2]}))
  blue=$((16#${match[3][1,2]}))

  if (( red * 299 + green * 587 + blue * 114 < 128000 )); then
    print -r dark
  else
    print -r light
  fi
}

detect_system_theme() {
  if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null || true)" == "Dark" ]]; then
    print -r dark
  else
    print -r light
  fi
}

theme="${LAZYGIT_THEME:-}"
if [[ "$theme" != "dark" && "$theme" != "light" ]]; then
  theme="$(detect_terminal_theme 2>/dev/null || detect_system_theme)"
fi

if [[ "$theme" == "dark" ]]; then
  selected_bg="#3C3836"
  pager='delta --dark --paging=never --syntax-theme=ansi --line-numbers --minus-style='\''syntax "#442E2D"'\'' --minus-emph-style='\''syntax "#5A3835"'\'' --minus-empty-line-marker-style='\''normal "#442E2D"'\'' --plus-style='\''syntax "#34381B"'\'' --plus-emph-style='\''syntax "#3F4724"'\'' --plus-empty-line-marker-style='\''normal "#34381B"'\'' --hyperlinks --hyperlinks-file-link-format="lazygit-edit://{path}:{line}"'
else
  selected_bg="#F2E5BC"
  pager='delta --light --paging=never --syntax-theme=ansi --line-numbers --minus-style='\''syntax "#F0C6B6"'\'' --minus-emph-style='\''syntax "#E9A992"'\'' --minus-empty-line-marker-style='\''normal "#F0C6B6"'\'' --plus-style='\''syntax "#DDE5A2"'\'' --plus-emph-style='\''syntax "#CBD577"'\'' --plus-empty-line-marker-style='\''normal "#DDE5A2"'\'' --hyperlinks --hyperlinks-file-link-format="lazygit-edit://{path}:{line}"'
fi

mkdir -p "${target_file:h}"
tmp_file="${target_file}.tmp.$$"

cat > "$tmp_file" <<EOF
gui:
  theme:
    activeBorderColor:
      - cyan
      - bold
    inactiveBorderColor:
      - default
    searchingActiveBorderColor:
      - yellow
      - bold
    optionsTextColor:
      - blue
    selectedLineBgColor:
      - "$selected_bg"
    selectedRangeBgColor:
      - "$selected_bg"
    inactiveViewSelectedLineBgColor:
      - default
    cherryPickedCommitFgColor:
      - blue
    cherryPickedCommitBgColor:
      - cyan
    markedBaseCommitFgColor:
      - blue
    markedBaseCommitBgColor:
      - yellow
    unstagedChangesColor:
      - red
    defaultFgColor:
      - default

git:
  pagers:
    - colorArg: always
      pager: >-
        $pager
EOF

mv "$tmp_file" "$target_file"
