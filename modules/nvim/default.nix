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
          };
        };

        plugins = {
            telescope = {
                enable = true;
            };

            noice = {
                enable = true;
            };

            nvim-cmp.enable = true;
            cmp-nvim-lsp.enable = true;
            oil.enable = true;
            treesitter = {
                enable = true;
                ensureInstalled = [
                    "rust"
                ];
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
            { mode = "n"; key = "<leader>ff"; action = ":Telescope find_files<cr>"; }
            { mode = "n"; key = "<leader>fr"; action = ":Telescope lsp_references<cr>"; }
            { mode = "n"; key = "<leader>cr"; action = ":lua vim.lsp.buf.rename()<cr>"; }
        ];

        extraPlugins = with pkgs.vimPlugins; [
            vim-nix
            nvim-lspconfig
            nui-nvim
            focus
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

                },
            },
        })
        '';
    };
}
