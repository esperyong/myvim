# myvim

Personal vim config. Uses [pathogen](https://github.com/tpope/vim-pathogen) for plugin management. The 3 pre-checked-in plugins (`html`/sparkup, `majutsushi-tagbar`, `snipMate`) live in the repo; the other 16 are cloned from upstream by the install script.

## Quick install (Linux / macOS)

```bash
git clone <your-fork-url> ~/myvim
cd ~/myvim
./install.sh
```

The script will:

1. Symlink `~/.vimrc` → `~/myvim/.vimrc` and `~/.vim` → `~/myvim/.vim` (backs up existing files to `*.bak`).
2. Clone the 16 missing plugins into `.vim/bundle/` (parallel `git clone --depth 1`).
3. Install the `ack` binary (required by `ack.vim`) via `apt`/`brew` if missing.

## Manual install

If you'd rather run the steps by hand:

```bash
# 1. Symlinks
ln -sfn ~/myvim/.vimrc ~/.vimrc
ln -sfn ~/myvim/.vim ~/.vim

# 2. The bundle/ dir contains empty placeholder folders for 16 plugins;
#    remove them so git clone can recreate them.
cd ~/myvim/.vim/bundle
rmdir ack.vim ctrlp.vim es.next.syntax.vim javascript-libraries-syntax.vim \
      nerdtree vim-endwise vim-es6 vim-fugitive vim-haml vim-javascript \
      vim-jsx vim-rails vim-react-snippets vim-ruby vim-slim yajs.vim

# 3. Clone upstream repos
git clone --depth 1 https://github.com/mileszs/ack.vim.git                          ack.vim
git clone --depth 1 https://github.com/ctrlpvim/ctrlp.vim.git                       ctrlp.vim
git clone --depth 1 https://github.com/othree/es.next.syntax.vim.git                es.next.syntax.vim
git clone --depth 1 https://github.com/othree/javascript-libraries-syntax.vim.git   javascript-libraries-syntax.vim
git clone --depth 1 https://github.com/preservim/nerdtree.git                       nerdtree
git clone --depth 1 https://github.com/tpope/vim-endwise.git                        vim-endwise
git clone --depth 1 https://github.com/isRuslan/vim-es6.git                         vim-es6
git clone --depth 1 https://github.com/tpope/vim-fugitive.git                       vim-fugitive
git clone --depth 1 https://github.com/tpope/vim-haml.git                           vim-haml
git clone --depth 1 https://github.com/pangloss/vim-javascript.git                  vim-javascript
git clone --depth 1 https://github.com/mxw/vim-jsx.git                              vim-jsx
git clone --depth 1 https://github.com/tpope/vim-rails.git                          vim-rails
git clone --depth 1 https://github.com/justinj/vim-react-snippets.git               vim-react-snippets
git clone --depth 1 https://github.com/vim-ruby/vim-ruby.git                        vim-ruby
git clone --depth 1 https://github.com/slim-template/vim-slim.git                   vim-slim
git clone --depth 1 https://github.com/othree/yajs.vim.git                          yajs.vim
git clone --depth 1 https://github.com/airblade/vim-gitgutter.git                   vim-gitgutter
git clone --depth 1 https://github.com/tmux-plugins/vim-tmux-focus-events.git       vim-tmux-focus-events

# 4. Ack binary (needed by :Ack)
# Linux:
sudo apt-get install -y ack
# macOS:
brew install ack
```

## Plugin map

| bundle dir                          | source                                           | purpose                    |
|-------------------------------------|--------------------------------------------------|----------------------------|
| ack.vim                             | mileszs/ack.vim                                  | `:Ack` search (needs `ack` binary) |
| ctrlp.vim                           | ctrlpvim/ctrlp.vim                               | fuzzy file open            |
| es.next.syntax.vim                  | othree/es.next.syntax.vim                        | ES.next syntax             |
| html *(checked in)*                 | sparkup                                          | html abbrev expansion      |
| javascript-libraries-syntax.vim     | othree/javascript-libraries-syntax.vim           | jQuery/React/etc. highlight |
| majutsushi-tagbar *(checked in)*    | majutsushi/tagbar                                | tag side panel             |
| nerdtree                            | preservim/nerdtree                               | file tree                  |
| snipMate *(checked in)*             | msanders/snipmate.vim                            | snippets                   |
| vim-endwise                         | tpope/vim-endwise                                | auto `end` for ruby/sh     |
| vim-es6                             | isRuslan/vim-es6                                 | ES6 snippets               |
| vim-fugitive                        | tpope/vim-fugitive                               | git wrapper                |
| vim-haml                            | tpope/vim-haml                                   | haml syntax                |
| vim-javascript                      | pangloss/vim-javascript                          | JS syntax/indent           |
| vim-jsx                             | mxw/vim-jsx                                      | JSX syntax                 |
| vim-rails                           | tpope/vim-rails                                  | rails helpers              |
| vim-react-snippets                  | justinj/vim-react-snippets                       | react snippets             |
| vim-ruby                            | vim-ruby/vim-ruby                                | ruby syntax/indent         |
| vim-slim                            | slim-template/vim-slim                           | slim syntax                |
| yajs.vim                            | othree/yajs.vim                                  | yet another JS syntax      |
| vim-gitgutter                       | airblade/vim-gitgutter                           | diff signs in gutter (used for the Claude Code workflow) |
| vim-tmux-focus-events               | tmux-plugins/vim-tmux-focus-events               | makes `FocusGained`/`FocusLost` fire inside tmux |

## Key bindings

Leader = `,`

| keys       | action              |
|------------|---------------------|
| `,o`       | open NERDTree       |
| `,t`       | CtrlP fuzzy open    |
| `,a`       | `:Ack` prompt       |
| `,i`       | TagbarToggle        |
| `F8`       | TagbarToggle        |
| `,r`       | run current file (py/rb/js/pl) |
| `jj`       | exit insert mode    |

## Requirements

- vim 8+ (tested on 9.1)
- git
- `ack` binary (for `:Ack` — `ack.vim` silently disables itself if not found)

## Notes

- The `bundle/` tree contains empty directories for the 16 external plugins so pathogen's intended layout is visible in the repo. The install script removes them before cloning; if you don't, `git clone` will fail with "destination path already exists".
- `html` bundle is actually sparkup (not html5.vim), checked in directly.
- `snipMate` is the original msanders/snipmate (not the maintained garbas/vim-snipmate fork) — no external deps.

## Pairing with Claude Code

This config is set up so you can run [Claude Code](https://claude.com/claude-code) in one tmux pane and vim in another, and vim will **auto-reload files within ~1 s** whenever Claude edits them. No plugin-side glue, no `vim --remote` (this vim is compiled `-clientserver`); it's just `autoread` + a 1 s `:checktime` timer in `.vimrc`, plus `vim-gitgutter` to visualize Claude's changes in the sign column.

### One-time tmux setup

Append to `~/.tmux.conf` (create the file if it doesn't exist):

```
set -g focus-events on
```

Then start a fresh tmux session (`tmux kill-server` first if you had an old one running) so the setting takes effect.

### Daily workflow

```bash
# 1. start a tmux session
tmux new -s code

# 2. in the first pane, enter your project and open vim
cd ~/your-project
vim .

# 3. split the window — Ctrl-b "  (horizontal) or Ctrl-b %  (vertical)
#    focus jumps to the new pane automatically

# 4. in the new pane, start claude
claude
```

Now talk to Claude in its pane. When Claude edits a file you have open, vim's buffer refreshes within ~1 s with no action from you, and the gitgutter signs in column 1 (`+` / `~` / `-`) show what changed vs `HEAD`. For a full side-by-side diff, `:Gdiff` (vim-fugitive, already installed).

### Useful tmux keys

| action | keys |
|---|---|
| switch pane | `Ctrl-b` + arrow (or `Ctrl-b o` to cycle) |
| zoom current pane to full window / restore | `Ctrl-b z` |
| resize pane | `Ctrl-b` + hold arrow |
| detach (claude keeps running) | `Ctrl-b d` |
| reattach later | `tmux attach -t code` |

### Conflict handling

If you are editing a file in vim AND Claude writes to the same file, vim does **not** silently overwrite your unsaved buffer. The buffer stays modified; on your next `:w` vim shows `W11: file has changed since reading`. Resolve with:

- `:e!` — discard your in-vim edits and reload Claude's version
- `:w!` — force-write your version over Claude's (you lose Claude's edits)
- `:diffsplit %` or `:Gdiff` — compare before deciding

### How it works (short version)

- `.vimrc` sets `autoread` + `updatetime=1000` and runs `:checktime` on a 1 s `timer_start` loop, plus on `FocusGained`/`BufEnter`/`CursorHold`. The timer skips cmdline and `:terminal` job modes so it never nags you mid-prompt.
- The old `au FocusLost * :wa` has been replaced with `silent! checktime | silent! wall` so that tabbing away to Claude doesn't blow up when both sides have touched the same file.
- `vim-tmux-focus-events` makes the focus autocmds actually fire inside tmux (terminal vim otherwise doesn't get those events).
- `vim-gitgutter` watches buffers + the git index and repaints its signs on every reload, giving you a live view of Claude's diff.
