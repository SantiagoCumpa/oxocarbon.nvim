local M = {}

local function rgb(hex)
	return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
end

--- Mezcla `fg` sobre `bg` con opacidad `alpha` (0..1), como los colores #rrggbbaa de VSCode.
---@param fg string #rrggbb
---@param bg string #rrggbb
---@param alpha number
---@return string
function M.blend(fg, bg, alpha)
	local fr, fgg, fb = rgb(fg)
	local br, bgg, bb = rgb(bg)
	local function mix(a, b)
		return math.floor(a * alpha + b * (1 - alpha) + 0.5)
	end
	return string.format("#%02x%02x%02x", mix(fr, br), mix(fgg, bgg), mix(fb, bb))
end

--- Punto medio entre dos colores (midpoint_hex del generador de VSCode).
function M.midpoint(a, b)
	local ar, ag, ab = rgb(a)
	local br, bg, bb = rgb(b)
	local function mid(x, y)
		return math.floor((x + y) / 2)
	end
	return string.format("#%02x%02x%02x", mid(ar, br), mid(ag, bg), mid(ab, bb))
end

--- Invierte un color (variante PRINT).
function M.invert(hex)
	local r, g, b = rgb(hex)
	return string.format("#%02x%02x%02x", 255 - r, 255 - g, 255 - b)
end

---@param value any
---@return boolean
function M.is_hex(value)
	return type(value) == "string" and value:match("^#%x%x%x%x%x%x$") ~= nil
end

return M
