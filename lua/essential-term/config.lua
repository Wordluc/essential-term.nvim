--- @class colors
--- @field bg? string
--- @field fg? string

--- @class mapping
--- @field mode string[]
--- @field what string|function

--- @class Options
--- @field shell?          string
--- @field size?           integer
--- @field close_on_exit?  boolean
--- @field start_in_insert? boolean
--- @field sidebar_width?  integer
--- @field display_mode?   "horizontal"|"vertical"|"float"
--- @field border?         string
--- @field colors?         colors
--- @field mapping?        table<string, mapping>
--- @field start_mapping?        table<string, mapping>

--- @class My
---	@field defaults Options
---	@field options Options
local M = {}

--- @value defaults Options
M.defaults =
{
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
}

M.options = {}

return M
