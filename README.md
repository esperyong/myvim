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
