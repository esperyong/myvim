#!/usr/bin/env bash
# Installs this vim config on Linux or macOS.
# Idempotent: safe to re-run.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUNDLE_DIR="$REPO_DIR/.vim/bundle"

echo "==> Symlinking ~/.vimrc and ~/.vim"
for pair in ".vimrc:$HOME/.vimrc" ".vim:$HOME/.vim"; do
  src="$REPO_DIR/${pair%%:*}"
  dst="${pair##*:}"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    echo "   backing up existing $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  ln -sfn "$src" "$dst"
done

echo "==> Cloning missing plugins into $BUNDLE_DIR"
declare -a plugins=(
  "ack.vim                          mileszs/ack.vim"
  "ctrlp.vim                        ctrlpvim/ctrlp.vim"
  "es.next.syntax.vim               othree/es.next.syntax.vim"
  "javascript-libraries-syntax.vim  othree/javascript-libraries-syntax.vim"
  "nerdtree                         preservim/nerdtree"
  "vim-endwise                      tpope/vim-endwise"
  "vim-es6                          isRuslan/vim-es6"
  "vim-fugitive                     tpope/vim-fugitive"
  "vim-haml                         tpope/vim-haml"
  "vim-javascript                   pangloss/vim-javascript"
  "vim-jsx                          mxw/vim-jsx"
  "vim-rails                        tpope/vim-rails"
  "vim-react-snippets               justinj/vim-react-snippets"
  "vim-ruby                         vim-ruby/vim-ruby"
  "vim-slim                         slim-template/vim-slim"
  "yajs.vim                         othree/yajs.vim"
)

pids=()
for line in "${plugins[@]}"; do
  dir="${line%% *}"
  repo="${line##* }"
  target="$BUNDLE_DIR/$dir"

  # Empty placeholder dir from the repo — remove so git clone can run.
  if [[ -d "$target" && -z "$(ls -A "$target" 2>/dev/null)" ]]; then
    rmdir "$target"
  fi

  if [[ -d "$target/.git" ]]; then
    echo "   [skip] $dir already cloned"
    continue
  fi

  (
    if git clone --depth 1 --quiet "https://github.com/$repo.git" "$target" 2>/tmp/myvim_clone_$$_$dir.log; then
      echo "   [ok]   $dir"
    else
      echo "   [FAIL] $dir — see /tmp/myvim_clone_$$_$dir.log"
    fi
  ) &
  pids+=($!)
done
for p in "${pids[@]}"; do wait "$p" || true; done

echo "==> Ensuring 'ack' binary is installed"
if command -v ack >/dev/null 2>&1; then
  echo "   [skip] ack already installed ($(ack --version | head -1))"
else
  case "$(uname -s)" in
    Linux)
      if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update -qq && sudo apt-get install -y ack
      elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y ack
      elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm ack
      else
        echo "   [warn] unknown Linux package manager — install 'ack' manually"
      fi
      ;;
    Darwin)
      if command -v brew >/dev/null 2>&1; then
        brew install ack
      else
        echo "   [warn] Homebrew not found — install from https://brew.sh then run: brew install ack"
      fi
      ;;
    *)
      echo "   [warn] unknown OS $(uname -s) — install 'ack' manually"
      ;;
  esac
fi

echo "==> Done. Launch vim to verify."
