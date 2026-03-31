# essential-term.nvim

A lightweight Neovim terminal plugin with multiple named sessions, three display modes, and a built-in session-picker UI.

## Demo

### Horizontal mode

![Horizontal mode demo](./assets/horizontal.gif)

### Vertical mode

![Vertical mode demo](./assets/vertical.gif)

### Float mode

![Float mode demo](./assets/float.gif)

## Features

- Multiple terminal sessions, each with a persistent buffer and shell process
- Sessions survive window closes — only the window is hidden, not the shell
- Three display modes: `horizontal` (bottom split), `vertical` (right split), and `float` (centered floating window)
- **Horizontal mode:** a sidebar listing all sessions appears automatically when 2+ sessions are open
- **Vertical / Float mode:** a tabline shows all sessions when 2+ sessions are open
- Both the sidebar and tabline are mouse-clickable for direct session switching
- Cycle between sessions without closing/reopening splits
- Rename sessions interactively

## Requirements

- Neovim >= 0.9
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)

## Installation

### lazy.nvim

```lua
{
  "wr9dg17/essential-term.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("essential-term").setup({
      display_mode = "horizontal", -- or "vertical" or "float"
      size = 70,                   -- percentage of editor height/width
    })
  end,
}
```

### packer.nvim

```lua
use {
  "wr9dg17/essential-term.nvim",
  config = function()
    require("essential-term").setup()
  end,
}
```

## Configuration

All options and their defaults:

```lua
require("essential-term").setup({
	shell = vim.o.shell,
	size = 70,
	close_on_exit = true,
	start_in_insert = true,
	sidebar_width = 22,
	display_mode = "horizontal", -- "horizontal" | "vertical" | "float"
	border = "rounded",       -- border style for float mode
	colors = { bg = nil, fg = nil },
	start_mapping = {
		["<C-\\>"] = { mode = { "n", "t" }, what = "EssentialTermToggle" },
	},
	mapping = {
		["<Esc>"] = { mode = { "i" }, what = "stopinsert", },
		["<C-t>"] = { mode = { "n", "t" }, what = "EssentialTermNew" },
		["<C-x>"] = { mode = { "n", "t" }, what = "EssentialTermClose" },
		["<C-h>"] = { mode = { "n", "t" }, what = "EssentialTermPrev" },
		["<C-l>"] = { mode = { "n", "t" }, what = "EssentialTermNext" },
	}
})
```

### Display modes

| Mode | Behaviour |
|------|-----------|
| `"horizontal"` | Opens a bottom split. A sidebar listing sessions appears on the left of the terminal when 2+ sessions exist. |
| `"vertical"` | Opens a right-side vertical split. A one-line tabline overlays the top of the terminal when 2+ sessions exist. |
| `"float"` | Opens a centered floating window with a rounded border. A one-line tabline floats above it when 2+ sessions exist. |

## Commands

| Command | Description |
|---------|-------------|
| `EssentialTermToggle` | Show the terminal (creating one if needed), or hide all visible terminals |
| `EssentialTermNew` | Create a new terminal session |
| `EssentialTermClose` | Destroy the active session |
| `EssentialTermNext` | Cycle to the next session |
| `EssentialTermPrev` | Cycle to the previous session |
| `EssentialTermRename [name]` | Rename the active session (prompts if no argument given) |
| `EssentialTermGotoIndex <n>` | Jump directly to the session at 1-based index `n` |

## Lua API

```lua
local term = require("essential-term")

term.setup(opts)          -- initialise with options (call once)
term.toggle()             -- show / hide terminal panel
term.new()                -- create a new session
term.close()              -- destroy the active session
term.next()               -- switch to next session
term.prev()               -- switch to previous session
term.goto_index(n)        -- jump directly to session number n (1-based)
term.rename("my-shell")   -- rename active session
```

## Project structure

```
lua/essential-term/
├── init.lua      -- Public API
├── state.lua     -- Data model (registry of sessions)
├── terminal.lua  -- Lifecycle: create, show, hide, swap, destroy
├── ui.lua        -- Sidebar (horizontal) + tabline (float) renderers
├── config.lua    -- Defaults + user config merge
└── keys.lua      -- Utils to apply keys mapping
plugin/
└── essential-term.lua  -- User commands + autocmds (auto-sourced)
```

## License

MIT
