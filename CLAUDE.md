# CLAUDE.md — instructions for installing this vim config

You are being asked to install the `myvim` vim config on the current machine (Linux or macOS). Execute the steps below. **Do not ask for confirmation on individual steps — run them unless a step fails.**

## Preconditions to check

1. `vim --version | head -1` → need vim 8+ (9.x preferred).
2. `git --version` → must exist.
3. Network to `github.com` (you'll clone 18 repos).
4. The repo is at `~/myvim` (or ask the user where it is, then use that path as `$REPO`).

## Install steps

### 1. Symlinks

```bash
REPO=~/myvim   # or wherever the user cloned it
[ -e ~/.vimrc ] && [ ! -L ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak
[ -e ~/.vim   ] && [ ! -L ~/.vim   ] && mv ~/.vim   ~/.vim.bak
ln -sfn "$REPO/.vimrc" ~/.vimrc
ln -sfn "$REPO/.vim"   ~/.vim
```

### 2. Remove empty placeholder dirs under bundle/

The repo checks in **empty** directories for 18 external plugins (so pathogen's intended layout is visible). `git clone` will refuse if the directory already exists, so remove empties first.

```bash
cd "$REPO/.vim/bundle"
for d in ack.vim ctrlp.vim es.next.syntax.vim javascript-libraries-syntax.vim \
         nerdtree vim-endwise vim-es6 vim-fugitive vim-haml vim-javascript \
         vim-jsx vim-rails vim-react-snippets vim-ruby vim-slim yajs.vim \
         vim-gitgutter vim-tmux-focus-events; do
  [ -d "$d" ] && [ -z "$(ls -A "$d" 2>/dev/null)" ] && rmdir "$d"
done
```

**Do not remove** `html`, `majutsushi-tagbar`, or `snipMate` — those are checked in with real content.

### 3. Clone the 18 upstream repos (in parallel)

Run these in parallel (background + `wait`) — serial is slow. Use `--depth 1`.

| target dir                          | repo                                             |
|-------------------------------------|--------------------------------------------------|
| `ack.vim`                           | `mileszs/ack.vim`                                |
| `ctrlp.vim`                         | `ctrlpvim/ctrlp.vim`                             |
| `es.next.syntax.vim`                | `othree/es.next.syntax.vim`                      |
| `javascript-libraries-syntax.vim`   | `othree/javascript-libraries-syntax.vim`         |
| `nerdtree`                          | `preservim/nerdtree`                             |
| `vim-endwise`                       | `tpope/vim-endwise`                              |
| `vim-es6`                           | `isRuslan/vim-es6`                               |
| `vim-fugitive`                      | `tpope/vim-fugitive`                             |
| `vim-haml`                          | `tpope/vim-haml`                                 |
| `vim-javascript`                    | `pangloss/vim-javascript`                        |
| `vim-jsx`                           | `mxw/vim-jsx`                                    |
| `vim-rails`                         | `tpope/vim-rails`                                |
| `vim-react-snippets`                | `justinj/vim-react-snippets`                     |
| `vim-ruby`                          | `vim-ruby/vim-ruby`                              |
| `vim-slim`                          | `slim-template/vim-slim`                         |
| `yajs.vim`                          | `othree/yajs.vim`                                |
| `vim-gitgutter`                     | `airblade/vim-gitgutter`                         |
| `vim-tmux-focus-events`             | `tmux-plugins/vim-tmux-focus-events`             |

Simplest path: run `bash $REPO/install.sh` which does steps 1–4 in one shot and is idempotent.

### 4. Install `ack` binary

`ack.vim` silently calls `finish` if the `ack` binary isn't on PATH, so `:Ack` won't be registered. Always install it.

- **Linux (apt)**: `sudo apt-get install -y ack`
- **Linux (dnf)**: `sudo dnf install -y ack`
- **Linux (pacman)**: `sudo pacman -S --noconfirm ack`
- **macOS**: `brew install ack`

## Verification

```bash
# 1. Headless startup — exit code 0, no stderr.
vim -N -u ~/.vimrc -e -s -c 'qa!'

# 2. Key commands are registered.
vim -N -u ~/.vimrc -c 'redir! > /tmp/v.log' \
    -c 'silent! command NERDTree' \
    -c 'silent! command CtrlP' \
    -c 'silent! command TagbarToggle' \
    -c 'silent! command Ack' \
    -c 'redir END' -c 'qa!' </dev/null >/dev/null 2>&1
cat /tmp/v.log   # all four commands should appear
```

Report to the user: "vim config installed; `,o` opens NERDTree, `,t` opens CtrlP, `,i`/F8 opens tagbar, `,a` runs Ack."

## Common pitfalls — things that already tripped us up

- **Empty bundle dirs → `:NERDTree` → `E492: Not an editor command`.** Root cause: repo checks in empty placeholder dirs. `git clone` into a non-empty target fails silently if you ignore its exit code, and pathogen has nothing to load. Always `rmdir` the empties first.
- **`:Ack` missing after install.** Root cause: `ack` binary not on PATH. Install the package.
- **Ambiguous bundle names.** Best-guess mappings (change if the user corrects you):
  - `html` → sparkup (**already checked in** — do not re-clone)
  - `snipMate` → msanders/snipmate.vim (**already checked in**; the casing matches that repo, not the garbas fork)
  - `vim-react-snippets` → `justinj/vim-react-snippets`
  - `majutsushi-tagbar` → majutsushi/tagbar (**already checked in**; the plugin has since moved to `preservim/tagbar`)
- **Don't assume taglist.** The vimrc has no taglist plugin; `,i` is bound to `:TagbarToggle`.
