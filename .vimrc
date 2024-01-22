call plug#begin('~/.vim/plugged')

" Plugins
Plug 'slim-template/vim-slim'
" Plug 'evanleck/vim-svelte'
" Plug 'mxw/vim-jsx'
" Plug 'othree/html5.vim'
" Plug 'pangloss/vim-javascript'
Plug 'ryanoasis/vim-devicons'
Plug 'AndrewRadev/splitjoin.vim'

Plug 'activebridge/rails-snippets'
Plug 'honza/vim-snippets'
Plug 'p0deje/vim-ruby-interpolation'
Plug 'terryma/vim-multiple-cursors'
Plug 'RRethy/nvim-treesitter-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'vim-scripts/surround.vim'
Plug 'mhinz/vim-startify'
Plug 'navarasu/onedark.nvim'


" Nvim/Neovide configs
Plug 'nvim-lua/plenary.nvim'
" Plug 'kevinhwang91/nvim-hlslens'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
" Plug 'petertriho/nvim-scrollbar'
" Plug 'dstein64/nvim-scrollview'
Plug 'lewis6991/satellite.nvim'
Plug 'm4xshen/autoclose.nvim'
" Plug 'mhartington/formatter.nvim'
Plug 'NvChad/nvim-colorizer.lua'
Plug 'numToStr/Comment.nvim'
Plug 'dcampos/nvim-snippy'
Plug 'nvim-lualine/lualine.nvim'
Plug 'prichrd/netrw.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'dcampos/cmp-snippy'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-emoji'
" Plug 'hrsh7th/cmp-cmdline'
Plug 'sbdchd/neoformat'
Plug 'onsails/lspkind.nvim'
Plug 'justinhj/battery.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'mateuszwieloch/automkdir.nvim'

if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction
  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'
endif

call plug#end()

if exists('g:neovide')
  let g:neovide_input_use_logo=v:true
  " copy
  vnoremap <D-c> "+y

  " paste
  nnoremap <D-v> "+p
  inoremap <D-v> <Esc>"+pa
  cnoremap <D-v> <c-r>+

  " undo
  nnoremap <D-z> u
  inoremap <D-z> <Esc>ua
  let g:neovide_transparency = 0.8
  " let g:transparency = 0.8
  " let g:neovide_background_color = '#000000'.printf('%x', float2nr(255 * g:transparency))
  let g:neovide_floating_blur_amount_x = 2.0
  let g:neovide_floating_blur_amount_y = 2.0
  let g:neovide_scroll_animation_length = 0.2
  let g:neovide_cursor_vfx_mode = "pixiedust"
  let g:neovide_cursor_animation_length = 0.05
  let g:neovide_cursor_trail_size = 0.1
  let g:neovide_touch_deadzone = 6.0
  let g:neovide_touch_drag_timeout = 1
  let g:neovide_underline_automatic_scaling = v:false
  let g:neovide_refresh_rate = 120
  let g:neovide_refresh_rate_idle = 5
  let g:neovide_fullscreen = v:false
  let g:neovide_remember_window_size = v:true
  let g:neovide_cursor_animate_in_insert_mode = v:true
  let g:neovide_cursor_animate_command_line = v:true
  let g:neovide_floating_shadow = v:true
  let g:neovide_floating_z_height = 10
  let g:neovide_light_angle_degrees = 45
  let g:neovide_light_radius = 5
  let g:neovide_scroll_animation_far_lines = 1
  let g:neovide_theme = 'auto'
  let g:neovide_unlink_border_highlights = v:true
  let g:neovide_input_macos_alt_is_meta = v:true
endif

lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "html", "css", "javascript", "svelte", "ruby", "yaml" },
    sync_install = false,
    auto_install = true,
    endwise = {
        enable = true,
    },
    highlight = {
      enable = true,
      disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
              return true
          end
      end,
      additional_vim_regex_highlighting = false,
    },
  }
  local actions = require("telescope.actions")
  local builtin = require('telescope.builtin')
  local lga_actions = require("telescope-live-grep-args.actions")

  require("mason").setup()
  require("mason-lspconfig").setup{
    ensure_installed = { "lua_ls", "rubocop", "eslint", "html", "cssls", "jsonls", "remark_ls", "ruby_ls", "yamlls", "svelte" },
  }
  require("telescope").setup{
    defaults = {
      layout_config = { prompt_position="top" },
      sorting_strategy = 'ascending',
      cursor_strategy = 'follow',
      selection_caret=  ' ',
      results_title = '💬',
      multi_icon = '📌',
      prompt_title = '🔍',
      winblend = 40,
      mappings = {
        i = {
        },
      },
    },
  extensions = {
    live_grep_args = {
      auto_quoting = false, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    }
  }
  }

  require("autoclose").setup({
    options = {
      disabled_filetypes = { "text" },
      disable_when_touch = true,
      touch_regex = "[%w(%[{]",
      pair_spaces = false,
      auto_indent = true,
      disable_command_mode = true,
    },
  })

  require'colorizer'.setup {
    -- filetypes = {'css', 'html', 'scss', 'sass', 'slim', 'haml', 'javascript', 'svelte', 'xml', 'json', 'svg' },
    user_default_options = { mode = 'background', css = true, lowercase = true }
  }
  require('Comment').setup()

  require('onedark').setup  {
    transparent = true,
    lualine = {
      transparent = true,
    },
    diagnostics = {
      background=false,
    }
  }

  local function fileProgress()
    local chars = { '󰝦', '󰪞', '󰪞', '󰪟', '󰪠', '󰪡', '󰪢', '󰪣', '󰪤', '󰪤', '󰪥', }
    -- local chars = { '󱩎', '󱩏', '󱩐', '󱩑', '󱩒', '󱩓', '󱩔', '󱩕', '󱩕', '󰛨', '󰛨', }
    local current_line = vim.fn.line('.')
    local total_lines = vim.fn.line('$')
    if total_lines < 20 then return '' end
    local i = math.floor(current_line / total_lines * 10)
    return chars[i + 1]..' '
  end

  local function spacer()
    return [[ ]]
  end

  local function iconScroll()
    -- local chars = { '󱖗', '󱖔', '󱖘', '󱖕', '󱖙', '󱖖', '󱖚', '󱖓', }
    local chars = { '🌘', '🌑', '🌒', '🌓', '🌔', '🌕', '🌖', '🌗', '🌘', }
    local l = vim.fn.line('.')
    return chars[(l % 8) + 1]
  end

  local function iconMode()
    local icons = { n = ' 󰰓 󰌌', c = ' 󰯲 ', v = ' 󰰫 󰩬', V = ' 󰰫 󰫙', ["^V"] = ' 󰰫 󱊁', i = ' 󰰄 󰗧', b = ' 󰯯 ', t = ' 󰰥 ', nt = ' 󰰥 ', }
    return icons[vim.api.nvim_get_mode().mode] or ' 󰰫 󱊁'
  end

  local function modeColor()
    local colors = { n = '#98c279', c = '#e5c07b', v = '#c678dd', V = '#c678dd', ["^V"] = '#c678dd', i = '#61afef' }
    return colors[vim.api.nvim_get_mode().mode] or '#98c279'
  end

  local function iconTime()
    local now = os.date("*t")
    local hours = { '󱑊', '󱐿', '󱑀', '󱑁', '󱑂', '󱑃', '󱑄', '󱑅', '󱑆', '󱑇', '󱑈', '󱑉', '󱑊', '󱐿', '󱑀', '󱑁', '󱑂', '󱑃', '󱑄', '󱑅', '󱑆', '󱑇', '󱑈', '󱑉', }
    local m = string.format('%02d', now.min):gsub('1', '󰎤'):gsub('2', '󰎧'):gsub('3', '󰎪'):gsub('4', '󰎭'):gsub('5', '󰎱'):gsub('6', '󰎳'):gsub('7', '󰎶'):gsub('8', '󰎹'):gsub('9', '󰎼'):gsub('0', '󰎡')
    local h = string.format('%02d', now.hour):gsub('10', '󰎤󰎡'):gsub('20', '󰎧󰎡'):gsub('0', '󰎡'):gsub('1', '󰎤'):gsub('2', '󰎧'):gsub('3', '󰎪'):gsub('4', '󰎭'):gsub('5', '󰎱'):gsub('6', '󰎳'):gsub('7', '󰎶'):gsub('8', '󰎹'):gsub('9', '󰎼')
    -- return string.format('%s %s󰧌%s', hours[now.hour + 1], h, m)
    return string.format('%s󰧌%s', h, m)
  end

  local function iconLine()
    local numbers = {
      ['1'] = '󰬺',
      ['2'] = '󰲢',
      ['3'] = '󰬼',
      ['4'] = '󰲧',
      ['5'] = '󰬾',
      ['6'] = '󰲪',
      ['7'] = '󰭀',
      ['8'] = '󰲮',
      ['9'] = '󰭂',
      ['0'] = '󰎡',
    }
    local t = vim.fn.line('$')
    local total = tostring(vim.fn.line('$')):gsub('1', '󰎤'):gsub('2', '󰎧'):gsub('3', '󰎪'):gsub('4', '󰎭'):gsub('5', '󰎱'):gsub('6', '󰎳'):gsub('7', '󰎶'):gsub('8', '󰎹'):gsub('9', '󰎼'):gsub('0', '󰎡')
    local current = tostring(vim.fn.line('.')):gsub('1', '󰲠'):gsub('2', '󰲢'):gsub('3', '󰲤'):gsub('4', '󰲦'):gsub('5', '󰲨'):gsub('6', '󰲪'):gsub('7', '󰲬'):gsub('8', '󰲮'):gsub('9', '󰲰'):gsub('0', '󰎡')
    local cur = string.format(('%'..string.len(tostring(t)))..'s', current)
    local r,c = unpack(vim.api.nvim_win_get_cursor(0))
    local col = tostring(c + 1):gsub('1', '󰬺'):gsub('2', '󰬻'):gsub('3', '󰬼'):gsub('4', '󰬽'):gsub('5', '󰬾'):gsub('6', '󰬿'):gsub('7', '󰭀'):gsub('8', '󰭁'):gsub('9', '󰭂'):gsub('0', '󰬹')
    local x = string.format(("%"..string.len(tostring(t))).."d", r)
    local y = string.format("%3d", c + 1)
    x = x:gsub('1', '󰬺'):gsub('2', '󰬻'):gsub('3', '󰬼'):gsub('4', '󰬽'):gsub('5', '󰬾'):gsub('6', '󰬿'):gsub('7', '󰭀'):gsub('8', '󰭁'):gsub('9', '󰭂'):gsub('0', '󰬹')
    y = y:gsub('1', '󰬺'):gsub('2', '󰬻'):gsub('3', '󰬼'):gsub('4', '󰬽'):gsub('5', '󰬾'):gsub('6', '󰬿'):gsub('7', '󰭀'):gsub('8', '󰭁'):gsub('9', '󰭂'):gsub('0', '󰬹')
    -- return string.format('%s%s󰖳%s󱐕', y, x, total)
    return string.format('%s%s%s', y, x, total)
  end

  require'battery'.setup({
    update_rate_seconds = 10,           -- Number of seconds between checking battery status
    show_status_when_no_battery = false, -- Don't show any icon or text when no battery found (desktop for example)
    show_plugged_icon = true,           -- If true show a cable icon alongside the battery icon when plugged in
    show_unplugged_icon = false,         -- When true show a diconnected cable icon when not plugged in
    show_percent = false,                -- Whether or not to show the percent charge remaining in digits
    vertical_icons = true,              -- When true icons are vertical, otherwise shows horizontal battery icon
  })
  local nvimbattery = function()
    return require("battery").get_status_line()
  end

  require('lualine').setup {
    options = {
      globalstatus = true,
      disabled_file_types = {'netrw'},
      -- component_separators = { left = '', right = ''},
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      -- section_separators = { left = ' ', right = ''},
      -- section_separators = { left = '', right = ''},
    },
    sections = {
      lualine_a = {
        { iconMode,
          padding = 0,
          color = function(section)
             return { fg = modeColor(), bg = '#000000' }
          end,
          separator = { left = '', right = ' ' },
        },
         -- { 'mode' },
      },
      lualine_b = {
        {
          'branch',
          -- color = { bg = '#333333', gui='italic,bold', fg='#e5c07b' },
          color = function(section)
             return { fg = modeColor(), gui='italic,bold', bg = '#000000' }
          end,
          icon = '',
          -- separator = { left = ' ', right = ''},
          on_click = function(count, btn, keys)
            builtin.git_branches({
              prompt_title = '🔭',
              preview_title = '📖',
              prompt_prefix = ' ',
              git_icons = {
                added = "󰐗",
                changed = "󰆗",
                copied = "",
                deleted = "󰅙",
                renamed = "",
                unmerged = "󰀩",
                untracked = "󰎔",
              }
            })
          end
        }
      },
      lualine_c = {
        { 'filetype',
          icon_only = true,
          -- padding = 0,
          separator = '',
        },
        { 'filename',
          path = 1,
          padding = 0,
          symbols = {
            modified = '',  -- Text to show when the file is modified.
            readonly = '',  -- Text to show when the file is non-modifiable or readonly.
            unnamed = '',    -- Text to show for unnamed buffers.
            newfile = ' ',  -- Text to show for newly created file before first write
          }
        },
      },
      lualine_x = {
        { 'diagnostics',
          padding = 0,
          -- separator = { left = '', right = ''},
          color = { bg = '#000000', gui='italic' },
          symbols = { error = '', warn = '', info = '', hint = '' },
        },
        { spacer, padding = 0 },
        {
          'diff',
          colored = true,
          icon = '',
          padding = 1,
          separator = { left = ' ', right = ' '},
          color = { bg = '#000000', gui='italic,bold' },
          symbols = { added = '󰐗 ', modified = '󰆗 ', removed = '󰅙 ' },
          on_click = function(count, btn, keys)
            builtin.git_status({
              prompt_title = '🔭',
              preview_title = '📖',
              prompt_prefix = ' ',
              git_icons = {
                added = "󰐗",
                changed = "󰆗",
                copied = "",
                deleted = "󰅙",
                renamed = "",
                unmerged = "󰀩",
                untracked = "󰎔",
              }
            })
          end
        },
        -- { iconScroll, padding=0, color = { bg=none, } },
      },
      lualine_y = {
        { 'fileformat', color = { bg='#000000', padding=0 } },
        -- { 'location', color = { bg='#333333' }, padding = 0 },
        { iconLine,
          padding=1,
          color = function(section)
             return { fg = modeColor(), bg = '#000000' }
          end,
        },
        { fileProgress, padding=0, color = { bg='#000000' } },
        -- { spacer, padding = 0, color = { bg='none' } },
      },
      lualine_z = {
        -- { spacer, padding = 0 },
        {
          nvimbattery,
          padding=0,
          color = function(section)
             return { fg = modeColor(), bg = '#000000' }
          end,
        },
        {
          iconTime,
          -- color = {
          --   gui ='italic',
          --   fg = '#ffffff'
          -- },
          color = function(section)
             return { fg = modeColor(), bg = '#000000' }
          end,
        },
      }
    },
    -- tabline = {
    --   lualine_a = {'      '},
    --   lualine_b = {},
    --   lualine_c = {{
    --     'buffers',
    --     padding = 10,
    --     use_mode_colors = true,
    --     symbols = {
    --       modified = '',      -- Text to show when the buffer is modified
    --       alternate_file = '', -- Text to show to identify the alternate file
    --       directory =  '',     -- Text to show when the buffer is a directory
    --     },
    --   }},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {}
    -- },
  }
    -- winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = {'filename'},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {}
    -- },
    --
    -- inactive_winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = {'filename'},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {}
    -- }

  require('satellite').setup {
  current_only = false,
  winblend = 30,
  zindex = 40,
  excluded_filetypes = {
    "cmp_docs",
    "cmp_menu",
    "noice",
    "prompt",
    "TelescopePrompt",
  },
  width = 2,
  handlers = {
    cursor = {
      enable = false,
      -- Supports any number of symbols
      symbols = { '⎺', '⎻', '⎼', '⎽' }
      -- symbols = { '⎻', '⎼' }
      -- Highlights:
      -- - SatelliteCursor (default links to NonText
    },
    search = {
      enable = true,
      -- Highlights:
      -- - SatelliteSearch (default links to Search)
      -- - SatelliteSearchCurrent (default links to SearchCurrent)
    },
    diagnostic = {
      enable = false,
      signs = {'-', '=', '≡'},
      min_severity = vim.diagnostic.severity.HINT,
      -- Highlights:
      -- - SatelliteDiagnosticError (default links to DiagnosticError)
      -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
      -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
      -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
    },
    gitsigns = {
      enable = false,
      signs = { -- can only be a single character (multibyte is okay)
        add = "│",
        change = "│",
        delete = "-",
      },
      -- Highlights:
      -- SatelliteGitSignsAdd (default links to GitSignsAdd)
      -- SatelliteGitSignsChange (default links to GitSignsChange)
      -- SatelliteGitSignsDelete (default links to GitSignsDelete)
    },
    marks = {
      enable = false,
      show_builtins = false, -- shows the builtin marks like [ ] < >
      key = 'm'
      -- Highlights:
      -- SatelliteMark (default links to Normal)
    },
    quickfix = {
      signs = { '-', '=', '≡' },
      -- Highlights:
      -- SatelliteQuickfix (default links to WarningMsg)
    }
  },
}

  require('gitsigns').setup {
    signs = {
      add          = { text = '│' },
      change       = { text = '┆' },
      delete       = { text = '┝' },
      topdelete    = { text = '┝' },
      changedelete = { text = '┝' },
      untracked    = { text = '' },
    },
  }
  require'netrw'.setup {}
  local bufferline = require('bufferline')
  bufferline.setup({
      options = {
          diagnostics = "nvim_lsp",
          mode = 'tabs',
          show_tab_indicators = false,
          modified_icon = '',
          indicator = {
              icon = '📌', -- this should be omitted if indicator style is not 'icon'
              style = 'none', -- icon | underline
          },
          style_preset = {
            bufferline.style_preset.no_italic,
          },
          numbers = 'none',
          show_close_icon = false,
          -- show_buffer_close_icons = false,
          max_name_length = 25,
          -- buffer_close_icon = '󰅙',
          separator_style = { '', '' },
          offsets = {
            filetype = "netrw",
            text = "File Explorer",
            text_align = "left",
            separator = true
          },
          hover = {
              enabled = true,
              delay = 200,
              reveal = {'close'}
          },
          highlights = {
          },
          custom_areas = {
            left = function()
              local result = {}
              table.insert(result, {text = "        󱌮  ", fg = "#f4468f"})
              return result
            end,
          }
        }
  })

  local wilder = require('wilder')

  local gradient = {
    '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
    '#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
    '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
    '#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
  }

  for i, fg in ipairs(gradient) do
    gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', {{a = 1}, {a = 1}, {foreground = fg}})
  end
  wilder.setup({
    modes = {':', '/', '?'},
  })
  wilder.set_option('renderer', wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
      highlights = {
        border = 'Normal', -- highlight to use for the border
        pumblend = 0,
        gradient = gradient,
      },
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
      border = 'rounded',
      pumblend = 0,
      highlighter = wilder.highlighter_with_gradient({
        wilder.basic_highlighter(), -- or wilder.lua_fzy_highlighter(),
      }),
      left = {' ', wilder.popupmenu_devicons()},
      right = {' ', wilder.popupmenu_scrollbar({ thumb_char = '│' })},
  })
))


local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

-- require'lspconfig'.syntax_tree.setup{}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.tsserver.setup { capabilities = capabilities }
require'lspconfig'.cssls.setup { capabilities = capabilities }
require'lspconfig'.tailwindcss.setup { capabilities = capabilities }
require'lspconfig'.eslint.setup { capabilities = capabilities }
require'lspconfig'.svelte.setup { capabilities = capabilities }
require'lspconfig'.html.setup { capabilities = capabilities }
require'lspconfig'.ruby_ls.setup { capabilities = capabilities }
require'lspconfig'.rubocop.setup { capabilities = capabilities }

local nvim_lsp = require('lspconfig')
function PrintDiagnostics(opts, bufnr, line_nr, client_id)
  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  opts = opts or {['lnum'] = line_nr}

  local line_diagnostics = vim.diagnostic.get(bufnr, opts)
  if vim.tbl_isempty(line_diagnostics) then return end

  local diagnostic_message = ""
  for i, diagnostic in ipairs(line_diagnostics) do
    diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
    print(diagnostic_message)
    if i > 0 then return end
    if i ~= #line_diagnostics then
      diagnostic_message = diagnostic_message .. "\n"
    end
  end
  vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
end

function showDiagnostic()
  vim.diagnostic.open_float(nil, {
    focus=false,
    scope="cursor",
    border="rounded",
    header=false,
    soruce=false,
    prefix='',
    suffix='',
    style='minimal',
  })
  PrintDiagnostics()
end

local border = {
      {"x", "FloatBorder"},
      {"o", "FloatBorder"},
      {"🭾", "FloatBorder"},
      {"▕", "FloatBorder"},
      {"🭿", "FloatBorder"},
      {"▁", "FloatBorder"},
      {"🭼", "FloatBorder"},
      {"▏", "FloatBorder"},
}

vim.opt.signcolumn = "yes"
vim.diagnostic.config({
  -- virtual_text = {
    -- prefix = 'x',
  -- },
  virtual_text = false,
  -- float = true,
  float = {
    border = "rounded",
    format = function(diagnostic)
    return string.format(
    "%s (%s)",
    diagnostic.message,
    diagnostic.source
    )
    end,
  },
})
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

vim.cmd [[autocmd! CursorHold,CursorHoldI * lua showDiagnostic()]]
vim.cmd [[autocmd! ColorScheme * highlight DiagnosticFloatingWarn guifg='#ffa222' guibg='#000000']]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg='#777777' guibg='#000000' ]]

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  vim.fn.sign_define("Lsp" .. hl, { text = icon, texthl = hl, numhl = hl })
end

  local cmp = require'cmp'


  local lspkind = require('lspkind')
  vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#000000" })
  cmp.setup({
    formatting = {
      fields = { "abbr", "kind" },
      format = lspkind.cmp_format({
        mode = 'symbol', -- show only symbol annotations
        maxwidth = 30, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = '…', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function (entry, vim_item)
          vim_item.abbr = string.sub(vim_item.abbr, 1, 30)
          vim_item.menu = ""
          return vim_item
        end
      })
    },
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('snippy').expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    window = {
      completion = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        winhighlight = 'Normal:CmpNormal',

        scrolloff = 0,
        col_offset = 0,
        side_padding = 0,
        scrollbar = '│',
      },
      documentation = {
        -- max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
        -- max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        winhighlight = 'Normal:CmpNormal',
        scrollbar = '│',
      },
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.config.disable
    }),
    sources = cmp.config.sources({
      {
        name ='buffer',
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end
        }
      },
      { name = 'nvim_lsp' },
      { name = 'snippy' }, -- For snippy users.
      { name = 'emoji' },
    }, {
      { name = 'buffer' },
    })
  })

EOF

let g:neovide_padding_top=10
let g:neovide_padding_left=0
let g:neovide_padding_right=0
let g:neovide_padding_bottom=0

let g:startify_change_to_dir = 0
let g:netrw_banner = 0
let g:netrw_winsize = 25
" let g:netrw_browse_split = 4
hi! link netrwMarkFile Search
function! NetrwRemoveRecursive()
  if &filetype ==# 'netrw'
    cnoremap <buffer> <CR> rm -r<CR>
    normal mu
    normal mf

    try
      normal mx
    catch
      echo "Canceled"
    endtry

    cunmap <buffer> <CR>
  endif
endfunction

" Vim
set pumblend=15
set guifont=Menlo:h15
colo onedark                      " Theme
" set fullscreen                  " Start Maximazed
" set lines=999 columns=9999
set expandtab ts=2 sw=2 ai        " Two spaces insted tab
set showtabline=2                 " Always shows tabs on top
set backspace=indent,eol,start    " Intuitive backspacing.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set scrolloff=3                   " Show 3 lines of context around the cursor.
set noeb vb t_vb=                 " No beeping
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " Disable swp files
set shortmess=filmnrxtTI          " Disble intro message
set nohidden                      " Remove the buffer after tab close
set list
set listchars=trail:•             " Show spaces in end of line
set autoread                      " Update open files when changed externally
set number relativenumber         " Set relative line numbers
" set iskeyword-=_                " Underscore brakes the word
set re=1
set ttyfast
set lazyredraw
set nocursorcolumn
set cursorline
set cursorlineopt=number
syntax sync minlines=256
set synmaxcol=300
" set clipboard=unnamed             " Use global copy/paste buffer
filetype plugin on                " Turn on file type detection.
filetype indent on                " Turn on file indent detection.
set tags=tmp/
set mousescroll=ver:1,hor:0
set splitbelow
set updatetime=1000
" set laststatus=0


" autocmd ColorScheme * highlight BufferLineFill guibg=#FFFFFF
hi Pmenu guibg=#161b22 gui=bold
hi PmenuSel guibg=#98C379 gui=bold
hi PmenuSbar guibg=#161b22 gui=bold
hi PmenuThumb guibg=#30363d gui=bold
hi CursorLineNr guifg=#98c279
hi DiagnosticInfo guibg=black
hi DiagnosticHint guibg=black
hi DiagnosticWarn guibg=black
hi DiagnosticError guibg=black
hi Normal guibg=black

autocmd BufWritePre *.* :%s/\s\+$//e
map <D-s> :w<cr>
map <S-r> :%s/:\(\w\+\)\(\s*=>\s*\)/\1: /g<cr>
imap <D-s> <ESC>:w<cr>
map <D-a> <esc>ggVG<end>
vnoremap < <gv
vnoremap > >gv
cmap w!! %!sudo tee > /dev/null %
" autocmd! bufwritepost .vimrc nested source %
inoremap <c-x><c-]> <c-]>

" Bubble single&multiple lines
vnoremap <C-Up> <esc>`<gv:m '<-2<cr>gv
vnoremap <C-Down> <esc>`>gv:m '>+1<cr>gv
nnoremap <C-Up> mz:m-2<cr>`z
nnoremap <C-Down> mz:m+<cr>`z

" Tabs
nnoremap <D-S-tab> :tabprevious<CR>
nnoremap <D-Up>    :tabprevious<CR>
nnoremap <D-tab>   :tabnext<CR>
nnoremap <D-Down>  :tabnext<CR>
nnoremap <D-t>     :tabnew<CR>
nnoremap <D-w>     :q!<CR>
inoremap <D-S-tab> <Esc>:tabprevious<CR>i
inoremap <D-Up>  <Esc>:tabprevious<CR>i
inoremap <D-tab>   <Esc>:tabnext<CR>i
inoremap <D-Down>  <Esc>:tabnext<CR>i
inoremap <D-t>     <Esc>:tabnew<CR>
inoremap <D-e>     <Esc>:q!<CR>i

nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>
nnoremap <D-w>     :q!<CR>
nnoremap <D-t>     :tabnew<CR>
nnoremap <D-[> :tabprevious<CR>
nnoremap <D-]> :tabnext<CR>
inoremap <D-[> <Esc>:tabprevious<CR>i
inoremap <D-]>   <Esc>:tabnext<CR>i

nnoremap <silent> <S-tab> :Telescope buffers theme=dropdown prompt_title=🕒 prompt_prefix= preview_title=🕒<CR>
nnoremap <silent> <D-S-o> :Telescope find_files theme=dropdown<CR>
nnoremap <silent> <D-o> :Telescope find_files theme=dropdown<CR>
nnoremap <silent> <C-p> :Telescope find_files theme=dropdown prompt_prefix=🔍<CR>
" nnoremap <silent> <D-f> :Telescope lsp_references prompt_prefix=🔗<CR>
nnoremap <silent> <D-f> :lua require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({postfix=''}) <CR>

" Commentary
map <D-/> <esc>gcc<end>
vmap <D-/> gc
map cp "+y<CR>

" Rails
map gV :Eview<CR>
map gC :Econtroller<CR>
map gM :Emodel<CR>
map gH :Ehelper<CR>
map gJ :Ejavascript<CR>
map gS :Estylesheet<CR>

if exists("+undofile")
    set udf
    set undodir=~/.vim/undo
endif

"Open current directory
map <S-w> :e %:h<CR>
map <C-y> :w !xclip -sel c <CR><CR>

" OSX option
nmap <M-Right> e
nmap <M-Left> b
imap <M-Right> <Esc> wi
imap <M-Left> <Esc> bi
vmap <M-Right> e
vmap <M-Left> b

" Window resize
let g:gui_font_size = 15
silent! execute('set guifont=Menlo:h'.g:gui_font_size)
function! ResizeFont(delta)
  let g:gui_font_size = g:gui_font_size + a:delta
  execute('set guifont=Menlo:h'.g:gui_font_size)
endfunction
noremap <expr><D-=> ResizeFont(1)
noremap <expr><D--> ResizeFont(-1)
