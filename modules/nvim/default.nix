{
    pkgs,
    ...
}:
let
  focus = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-focus";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-focus";
      repo = "focus.nvim";
      rev = "31f41d91b6b331faa07f0a513adcbc37087d028d";
      sha256 = "sha256-IOMhyplEyLEPJ/oXFjOfs7uXY52AcVrSZuHV7t4NeUE=";
    };
  };
  inlayhints = pkgs.vimUtils.buildVimPlugin {
    name = "lsp-inlayhints";
    src = pkgs.fetchFromGitHub {
      owner = "lvimuser";
      repo = "lsp-inlayhints.nvim";
      rev = "d981f65c9ae0b6062176f0accb9c151daeda6f16";
      sha256 = "sha256-06CiJ+xeMO4+OJkckcslqwloJyt2gwg514JuxV6KOfQ=";
    };
  };
in {
    programs.nixvim = {
        enable = true;

        globals = {
            mapleader = " ";
        };

        colorschemes = {
          tokyonight = {
            enable = true;
            transparent = true;
            styles = {
              sidebars = "transparent";
              floats = "transparent";
            };
            onColors = "
            function(colors)
              colors.border = colors.purple
            end
            ";
          };
        };

        plugins = {
            telescope = {
                enable = true;
            };

            noice = {
                enable = true;
            };

            mini = {
              enable = true;
              modules = {
                bufremove = { };
                surround = { };
              };
            };

            cmp-nvim-lsp.enable = true;
            gitsigns.enable = true;
            nvim-cmp.enable = true;
            oil.enable = true;
            treesitter = {
                enable = true;
                ensureInstalled = [
                    "bash"
                    "go"
                    "nix"
                    "javascript"
                    "typescript"
                    "rust"
                ];
            };

            lualine = {
              enable = true;
              globalstatus = true;
              theme = "tokyonight";
              winbar = {
                lualine_c = [
                  "filename"
                  "diagnostics"
                ];
              };
              inactiveWinbar = {
                lualine_c = [
                  "filename"
                  "diagnostics"
                ];
              };
            };
        };

        options = {
            shiftwidth = 4;
            tabstop = 4;
            expandtab = true;
            relativenumber = true;
            number = true;
            wrap = false;
        };

        keymaps = [
            { mode = "n"; key = "<leader>e"; action = ":Oil<cr>"; }
            { mode = "n"; key = "<leader>|"; action = ":vsplit<cr>"; }
            { mode = "n"; key = "<leader>-"; action = ":split<cr>"; }
            { mode = "n"; key = "<leader>fb"; action = ":Telescope buffers<cr>"; }
            { mode = "n"; key = "<leader>fd"; action = ":Telescope diagnostics<cr>"; }
            { mode = "n"; key = "<leader>ff"; action = ":Telescope find_files<cr>"; }
            { mode = "n"; key = "<leader>fg"; action = ":Telescope live_grep<cr>"; }
            { mode = "n"; key = "<leader>fr"; action = ":Telescope lsp_references<cr>"; }
            { mode = "n"; key = "<leader>fs"; action = ":Telescope find_string<cr>"; }
            { mode = "n"; key = "<leader>ca"; action = ":lua vim.lsp.buf.actions()<cr>"; }
            { mode = "n"; key = "<leader>cd"; action = ":lua vim.diagnostic.open_float()<cr>"; }
            { mode = "n"; key = "<leader>cr"; action = ":lua vim.lsp.buf.rename()<cr>"; }
            { mode = "n"; key = "<C-h>"; action = ":wincmd h<cr>"; }
            { mode = "n"; key = "<C-j>"; action = ":wincmd j<cr>"; }
            { mode = "n"; key = "<C-k>"; action = ":wincmd k<cr>"; }
            { mode = "n"; key = "<C-l>"; action = ":wincmd l<cr>"; }
            { mode = "n"; key = "<C-Left>"; action = ":wincmd h<cr>"; }
            { mode = "n"; key = "<C-Down>"; action = ":wincmd j<cr>"; }
            { mode = "n"; key = "<C-Up>"; action = ":wincmd k<cr>"; }
            { mode = "n"; key = "<C-Right>"; action = ":wincmd l<cr>"; }
            { mode = "n"; key = "H"; action = ":bnext<cr>"; }
            { mode = "n"; key = "L"; action = ":bprev<cr>"; }

            { mode = "n"; key = "<leader>gb"; action = ":Gitsigns blame_line<cr>"; }
            { mode = "n"; key = "<leader>gl"; action = ":Gitsigns prev_hunk<cr>"; }
            { mode = "n"; key = "<leader>gn"; action = ":Gitsigns next_hunk<cr>"; }
            { mode = "n"; key = "<leader>gp"; action = ":Gitsigns preview_hunk_inline<cr>"; }
            { mode = "n"; key = "<leader>gP"; action = ":Gitsigns preview_hunk<cr>"; }
            { mode = "n"; key = "<leader>gr"; action = ":Gitsigns reset_hunk<cr>"; }

            { mode = "n"; key = "<leader>bd"; action = ":lua require('mini.bufremove').delete<cr>"; }
            { mode = "n"; key = "<leader>wd"; action = "<C-W>c"; }
            { mode = "n"; key = "<leader>w|"; action = "<C-W>s"; }
            { mode = "n"; key = "<leader>|"; action = "<C-W>s"; }
            { mode = "n"; key = "<leader>w-"; action = "<C-W>v"; }
            { mode = "n"; key = "<leader>-"; action = "<C-W>v"; }
        ];

        extraPlugins = with pkgs.vimPlugins; [
            vim-nix
            nvim-lspconfig
            nui-nvim
            focus
            inlayhints
        ];

        extraConfigLua = ''
require("focus").setup({})

local cmp = require("cmp")

cmp.setup({
    sources = {
        { name = "nvim_lsp" }
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
    capabilities = capabilities,

    settings = {
        ["rust-analyzer"] = {
            cargo = {
                target = os.getenv("LSP_CARGO_TARGET") or nil,
            },
        },
    },
})

require("lsp-inlayhints").setup({})
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("lsp-inlayhints").on_attach(client, bufnr, true)
  end
})

vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "YankHighlight",
  desc = "Highlight yanked text",
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank()",
})

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
'';
    };
}
