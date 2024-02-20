{ pkgs
, ...
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

  octo = pkgs.vimUtils.buildVimPlugin {
    name = "octo";
    src = pkgs.fetchFromGitHub {
      owner = "pwntester";
      repo = "octo.nvim";
      rev = "0d0abffed42b0e77aff286279fb7c958f1f79ce6";
      sha256 = "sha256-HoY9VGK+tPPjvbJ/W4wIKPewPCeJHO82LFcmUxzx5Fw=";
    };
  };
in
{
  programs.nixvim = {
    enable = true;

    clipboard.register = "unnamedplus";

    globals = {
      mapleader = " ";
    };

    colorschemes = {
      catppuccin = {
        enable = true;
        flavour = "mocha";
        transparentBackground = true;
      };
      tokyonight = {
        enable = false;
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
      cmp-buffer.enable = true;
      cmp-clippy.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      comment-nvim.enable = true;
      crates-nvim.enable = true;
      gitsigns.enable = true;
      illuminate.enable = true;
      indent-blankline.enable = true;
      luasnip.enable = true;
      nix.enable = true;
      nvim-cmp.enable = true;
      oil.enable = true;
      todo-comments.enable = true;
      treesitter-textobjects.enable = true;

      navbuddy = {
        enable = true;
        lsp.autoAttach = true;
      };

      navic = {
        enable = true;
        lsp.autoAttach = true;
      };

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

      treesitter = {
        enable = true;
        ensureInstalled = [
          "bash"
          "cpp"
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
        winbar = {
          lualine_c = [
            {
              name = "filename";
              extraConfig = {
                "path" = 1;
              };
            }
            "diagnostics"
            "navic"
          ];
        };
        inactiveWinbar = {
          lualine_c = [
            {
              name = "filename";
              extraConfig = {
                "path" = 1;
              };
            }
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
      smartcase = true;
      spell = true;
      splitbelow = true;
      splitright = true;
      list = true;
      number = true;
      wrap = false;
      ignorecase = true;
    };

    keymaps = [
      { mode = "n"; key = "<C-S>"; action = ":w<cr>"; options.silent = true; }
      { mode = "i"; key = "<C-S>"; action = "<esc>:w<cr>"; options.silent = true; }

      { mode = "n"; key = "<leader>e"; action = ":Oil<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>|"; action = ":vsplit<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>-"; action = ":split<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>fb"; action = ":Telescope buffers<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>fd"; action = ":Telescope diagnostics<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>ff"; action = ":Telescope find_files<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>fr"; action = ":Telescope lsp_references<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>fs"; action = ":Telescope lsp_document_symbols<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>fS"; action = ":Telescope lsp_dynamic_workspace_symbols<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>fw"; action = ":Telescope grep_string<cr>"; options.silent = true; }

      { mode = "n"; key = "gd"; action = ":lua vim.lsp.buf.definition()<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>ca"; action = ":lua vim.lsp.buf.actions()<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>cd"; action = ":lua vim.diagnostic.open_float()<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>cn"; action = ":Navbuddy<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>cr"; action = ":lua vim.lsp.buf.rename()<cr>"; options.silent = true; }

      { mode = "n"; key = "<C-h>"; action = ":wincmd h<cr>"; options.silent = true; }
      { mode = "n"; key = "<C-j>"; action = ":wincmd j<cr>"; options.silent = true; }
      { mode = "n"; key = "<C-k>"; action = ":wincmd k<cr>"; options.silent = true; }
      { mode = "n"; key = "<C-l>"; action = ":wincmd l<cr>"; options.silent = true; }
      { mode = "n"; key = "<C-Left>"; action = ":wincmd h<cr>"; options.silent = true; }
      { mode = "n"; key = "<C-Down>"; action = ":wincmd j<cr>"; options.silent = true; }
      { mode = "n"; key = "<C-Up>"; action = ":wincmd k<cr>"; options.silent = true; }
      { mode = "n"; key = "<C-Right>"; action = ":wincmd l<cr>"; options.silent = true; }
      { mode = "n"; key = "H"; action = ":bnext<cr>"; options.silent = true; }
      { mode = "n"; key = "L"; action = ":bprev<cr>"; options.silent = true; }

      { mode = "n"; key = "<leader>gb"; action = ":Gitsigns blame_line<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>gl"; action = ":Gitsigns prev_hunk<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>gn"; action = ":Gitsigns next_hunk<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>gp"; action = ":Gitsigns preview_hunk_inline<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>gP"; action = ":Gitsigns preview_hunk<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>gr"; action = ":Gitsigns reset_hunk<cr>"; options.silent = true; }

      { mode = "n"; key = "<leader>bd"; action = ":lua require('mini.bufremove').delete()<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>wd"; action = "<C-W>c"; }
      { mode = "n"; key = "<leader>w|"; action = "<C-W>v"; }
      { mode = "n"; key = "<leader>|"; action = "<C-W>v"; }
      { mode = "n"; key = "<leader>w-"; action = "<C-W>s"; }
      { mode = "n"; key = "<leader>-"; action = "<C-W>s"; }

      { mode = "n"; key = "<leader>ss"; action = ":Telescope spell_suggest<cr>"; options.silent = true; }

      { mode = "n"; key = "<esc>"; action = "<esc>:noh<cr>"; options.silent = true; }
      { mode = "i"; key = "<esc>"; action = "<esc>:noh<cr>"; options.silent = true; }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-lspconfig
      nui-nvim
      focus
      inlayhints
      octo
    ];

    extraConfigLua = ''
      require("focus").setup({})
      require("octo").setup({})

      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" }
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
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              target = os.getenv("LSP_CARGO_TARGET") or nil,
            },
            diagnostics = {
              enable = true,
              disabled = {
                "inactive-code",
                "unlinked-file",
              },
            },
          },
        },
      })

      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })

      lspconfig.marksman.setup({
        capabilities = capabilities,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.nil_ls.setup({
        capabilities = capabilities,
        settings = {
          ["nil"] = {
            formatting = {
              command = { "nixpkgs-fmt" },
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
