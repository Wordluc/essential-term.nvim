--- @param keys_mapping table<string, mapping>
--- @param buffer number
function Set_keys_mapping(keys_mapping, buffer)
	for key, mapping in pairs(keys_mapping) do
		for _, mode in pairs(mapping.mode) do
			vim.keymap.set(mode, key, function()
				Execute_mapping(mapping)
			end, { buffer = buffer, silent = true })
		end
	end
end

--- @param mapping mapping
function Execute_mapping(mapping)
	if type(mapping.what) == "function" then
		mapping.what()
	elseif type(mapping.what) == "string" then
		vim.cmd(mapping.what)
	end
end
