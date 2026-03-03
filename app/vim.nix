{ pkgs, ... }: {
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [ nixfmt git ];

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    # vimdiffAlias = true; # TODO

    defaultEditor = true;

    configure = {
      packages.myVimPackage = with pkgs.vimPlugins; {
        # Loaded on launch.
        start = [
          vim-nix
          vim-scala
          lean-nvim
          vim-nixhash
          vim-yaml
          vim-toml
          vim-airline
          ctrlp-vim
          vim-ocaml
          vim-devicons
          vim-bsv
          rust-vim
          typst-vim
          idris2-vim
          # verilog_systemverilog-vim
          zig-vim
          semshi
          haskell-vim
          coc-rust-analyzer
          coc-nvim
          vim-markdown
          coq_nvim
          #nvim-treesitter
          Coqtail
          verilog_systemverilog-vim
          telescope-nvim
          tokyonight-nvim
          semshi

          # vim-stylish-haskell
          # nvim-hs
          # coc-isabelle
          # isabelle.vim
        ];
        # Manually loadable by calling `:packadd $plugin-name`.
        opt = [ ];
      };

      customRC = ''
          syntax on
        " This has to be defined at the top of the file
          " let maplocalleader = "\<Space>\<Space>"
          let mapleader = ";"
          let maplocalleader = ","

          set scrolloff=4

        " noswapfile
        " nobackup
        " undodir=~/.vim/undodir
        " undofile
        " spell
        " signcolumn=yes

        au BufRead,BufNewFile *.bs set filetype=haskell

        " Search case sensitivity
          set smartcase
          set ignorecase

        " Keep lines short
          set textwidth=100
          set colorcolumn=100
          hi ColorColumn ctermbg=DarkYellow

        " No error bells
          set noerrorbells

          colorscheme tokyonight-night
          " colorscheme vim
          " set notermguicolors

        " Flex
          nnoremap <C-s> gg0<C-v>G$y<C-v>G$r Go<esc>0"_Dp$pgg$p

        " Correct my typos
          command W :w
          command Wq :wq
          command WQ :wq

        " Move text arround
          vnoremap J :m '>+1<CR>gv=gv
          vnoremap K :m '<-2<CR>gv=gv
          inoremap <C-j> <esc>:m .+1<CR>==i
          inoremap <C-k> <esc>:m .-2<CR>==i
          nnoremap <leader>j :m .+1<CR>==
          nnoremap <leader>k :m .-2<CR>==

        " Completion
          set wildmenu
          set completeopt=longest,menuone

        " Completion in command bar
          set wmnu
          set wildmode=list:longest,list:full
          set wildignore=*.o

        " Command bar
          set history=2000


        " Search
          set incsearch
          set nohlsearch

        " No mouse
          set mouse=a

        " Encoding
          set encoding=utf-8
          set fileencoding=utf-8

        " Make neovim more powerfull
          set nocompatible

        " Allow backspace in insert mode
          set backspace=indent,eol,start

        " Highlight the current line
          set cursorline
          hi CursorLine term=bold cterm=bold ctermbg=darkgrey

        " Line numbers
          set number
          set relativenumber

        " Tabs vs spaces
          set tabstop=2
          set softtabstop=2
          set shiftwidth=2
          set expandtab

        " Auto indent
          " set smartindent
          set autoindent

        " Ctrl-T for new tab
          nnoremap <C-t> :tabnew<cr>

        " Delete tralling whitespace on save
          autocmd BufWritePre * %s/\s\+$//e

        " Spell-check
          map <F6> :setlocal spell! spelllang=en_us<CR>
          map <F7> :setlocal spell! spelllang=fr<CR>

        " Line and word count
          map <F3> :!wc <C-R>%<CR>

        " Find files using Telescope command-line sugar.
          nnoremap <leader>ff <cmd>Telescope find_files<cr>
          nnoremap <leader>fg <cmd>Telescope live_grep<cr>
          nnoremap <leader>fb <cmd>Telescope buffers<cr>
          nnoremap <leader>fh <cmd>Telescope help_tags<cr>

        " Lean
        "  lua<<EOF
        "  require 'nvim-treesitter.configs'.setup({
        "        highlight = {
        "            enable = true,
        "            additional_vim_regex_highlighting = true,
        "        },
        "    })

        "    local parsers = require 'nvim-treesitter.parsers'.get_parser_configs()
        "    parsers.lean = {
        "        install_info = {
        "            url = "https://github.com/Julian/tree-sitter-lean",
        "            files = { "src/parser.c", "src/scanner.cc" },
        "            branch = "main",
        "            requires_generate_from_grammar = false,
        "        },
        "        filetype = "lean"
        "    }

          lua<<EOF
          local on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            -- Enable completion triggered by <c-x><c-o>
            buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            local opts = { noremap=true, silent=true }

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
            buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
            buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
            buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
            buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

          end
          require('lean').setup{
            lsp = { on_attach = on_attach },
            lsp3 = { on_attach = on_attach },
            mappings = true,
            -- Abbreviation support
            abbreviations = {
              enable = true,
              builtin = true, -- built-in expander
              compe = false, -- nvim-compe source
              snippets = false, -- snippets.nvim source
              leader = '\\',
            },

            -- Infoview support
            infoview = {
              autoopen = true,
              width = 50,
              height = 20,
              horizontal_position = "bottom",
            },

            -- Progress bar support
            progress_bars = {
              enable = true,
              -- Use a different priority for the signs
              priority = 10,
            },

            -- Redirect Lean's stderr messages somewhere (to a buffer by default)
            stderr = {
              enable = true,
              -- a callback which will be called with (multi-line) stderr output
              -- e.g., use:
              --   on_lines = function(lines) vim.notify(lines) end
              -- if you want to redirect stderr to `vim.notify`.
              -- The default implementation will redirect to a dedicated stderr
              -- window.
              on_lines = nil,
            },
          }
        EOF
      '';
    };
  };
}

