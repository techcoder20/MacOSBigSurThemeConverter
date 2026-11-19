#!/usr/bin/env bash
# Experimental Debian 13 / labwc appearance support; does not alter system display or network settings.
set -euo pipefail

usage() {
  cat <<'HELP'
Usage: theme.sh install | light | dark | restore | status
  install   Fetch WhiteSur GTK and icon sources for review (does not execute installers)
  light     Select installed WhiteSur light GTK/icons (save original settings once)
  dark      Select installed WhiteSur dark GTK/icons (save original settings once)
  restore   Restore GTK and icon preferences from before the first switch
  status    Show active theme and original values
Theme changes require a functioning user D-Bus session.
HELP
}

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/macosbigsur-cardputer"
SRC_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/macosbigsur-cardputer/sources"
GTK_SCHEMA=org.gnome.desktop.interface

get_setting() { gsettings get "$GTK_SCHEMA" "$1"; }
set_setting() { gsettings set "$GTK_SCHEMA" "$1" "$2"; }

ensure_deps() {
  for cmd in git gsettings; do
    command -v "$cmd" >/dev/null || { echo "Missing dependency: $cmd" >&2; exit 1; }
  done
}

check_target() {
  [ "$(uname -m)" = aarch64 ] || { echo 'Expected ARM64 (aarch64)' >&2; exit 1; }
  . /etc/os-release
  [ "${VERSION_CODENAME:-}" = trixie ] || { echo 'Expected Debian 13 trixie' >&2; exit 1; }
  command -v labwc >/dev/null || { echo 'labwc not found' >&2; exit 1; }
}

backup_once() {
  mkdir -p "$STATE_DIR"
  if [ ! -e "$STATE_DIR/original-gtk" ]; then
    get_setting gtk-theme > "$STATE_DIR/original-gtk"
    get_setting icon-theme > "$STATE_DIR/original-icons"
  fi
}

# WhiteSur theme names can vary by upstream installer version.
find_gtk() {
  local wanted="$1" d name
  for d in "$HOME/.themes"/* /usr/share/themes/*; do
    [ -d "$d/gtk-3.0" ] || continue
    name="${d##*/}"
    case "$wanted:$name" in
      dark:WhiteSur*dark*|dark:WhiteSur*Dark*|light:WhiteSur*light*|light:WhiteSur*Light*) printf '%s\n' "$name"; return 0;;
    esac
  done
  return 1
}

find_icons() {
  local d name
  for d in "$HOME/.local/share/icons"/* "$HOME/.icons"/*; do
    [ -f "$d/index.theme" ] || continue
    name="${d##*/}"
    case "$name" in WhiteSur*) printf '%s\n' "$name"; return 0;; esac
  done
  return 1
}

install_assets() {
  check_target
  command -v sassc >/dev/null || {
    echo 'Install dependency first: sudo apt install sassc libglib2.0-dev-bin libxml2-utils' >&2
    exit 1
  }
  mkdir -p "$SRC_DIR"
  for repo in WhiteSur-gtk-theme WhiteSur-icon-theme; do
    if [ -e "$SRC_DIR/$repo" ]; then
      echo "Source already exists: $SRC_DIR/$repo; inspect/update manually before reinstalling" >&2
    else
      git clone --depth 1 "https://github.com/vinceliuice/$repo.git" "$SRC_DIR/$repo"
    fi
  done
  echo 'Review the upstream installers before continuing:'
  echo "  $SRC_DIR/WhiteSur-gtk-theme/install.sh"
  echo "  $SRC_DIR/WhiteSur-icon-theme/install.sh"
  echo 'Install assets with:'
  echo "  (cd '$SRC_DIR/WhiteSur-gtk-theme' && ./install.sh -c light -c dark)"
  echo "  (cd '$SRC_DIR/WhiteSur-icon-theme' && ./install.sh)"
  echo 'No downloaded scripts have been executed.'
}

apply_theme() {
  local mode="$1" gtk icons
  gtk="$(find_gtk "$mode")" || { echo "WhiteSur $mode GTK theme not installed" >&2; exit 1; }
  icons="$(find_icons)" || { echo 'WhiteSur icons not installed' >&2; exit 1; }
  backup_once
  set_setting gtk-theme "$gtk"
  set_setting icon-theme "$icons"
  echo "Selected GTK=$gtk icons=$icons"
}

restore_theme() {
  if [ ! -f "$STATE_DIR/original-gtk" ] || [ ! -f "$STATE_DIR/original-icons" ]; then
    echo 'No original theme settings saved; nothing to restore.' >&2
    exit 1
  fi
  set_setting gtk-theme "$(cat "$STATE_DIR/original-gtk")"
  set_setting icon-theme "$(cat "$STATE_DIR/original-icons")"
  echo 'Original theme preferences restored. Installed theme assets were not deleted.'
}

main() {
  ensure_deps
  case "${1:-}" in
    install) install_assets;;
    light|dark) check_target; apply_theme "$1";;
    restore) restore_theme;;
    status)
      printf 'GTK: %s\nIcons: %s\n' "$(get_setting gtk-theme)" "$(get_setting icon-theme)"
      if [ -f "$STATE_DIR/original-gtk" ]; then
        printf 'Original GTK: %s\nOriginal icons: %s\n' "$(cat "$STATE_DIR/original-gtk")" "$(cat "$STATE_DIR/original-icons")"
      fi
      ;;
    *) usage; [ "$#" -eq 0 ] && exit 0 || exit 2;;
  esac
}
main "$@"
