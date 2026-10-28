# oxocarbon.nvim

Port para Neovim de [Oxocarbon para VSCode](https://github.com/nyoom-engineering/oxocarbon-vscode),

- Integraciones con [snacks.nvim](https://github.com/folke/snacks.nvim) y [mini.nvim](https://github.com/nvim-mini/mini.nvim) 

## Variantes

| Colorscheme | Descripción |
|-----|-----|
| `oxocarbon` | Tema original |
| `oxocarbon-compat` | Paneles (barra de estado, pestañas) y bordes con más contraste; comentarios en `#8d8d8d` (WCAG AA) |
| `oxocarbon-oled` | Fondo negro puro para pantallas OLED/MiniLED; la UI baja un escalón de gris |
| `oxocarbon-oled-compat` | OLED + compat |
| `oxocarbon-mono` | Monocromático: cada acento pasa al gris IBM de luminancia más cercana; itálicas en `#f2f4f8`, negritas en `#ffffff` |
| `oxocarbon-mono-compat` | Mono + compat |
| `oxocarbon-oled-mono` | OLED + mono |
| `oxocarbon-oled-mono-compat` | OLED + mono + compat |
| `oxocarbon-print` | OLED Mono invertido: tema claro para imprimir y pantallas e-ink |

## Instalación

Requiere Neovim 0.10+ con `termguicolors`.

[vim.pack](https://neovim.io/doc/user/pack.html#vim.pack) (Neovim 0.12+):

```lua
vim.pack.add({ "https://github.com/SantiagoCumpa/oxocarbon.nvim" })
```

## Uso

```lua
require("oxocarbon").setup({})
vim.cmd.colorscheme("oxocarbon-mono")
```

Si llamas a `setup()` con una variante ya activa, los cambios se aplican al instante.

## Configuración

Valores por defecto:

```lua
require("oxocarbon").setup({
	-- Sin color de fondo (usa el de la terminal)
	transparent = false,
	-- Define vim.g.terminal_color_0..15 con los colores ANSI de Oxocarbon
	terminal_colors = true,
	integrations = {
		snacks = true,
		mini = true,
	},
	-- Grupos propios. Tabla o función que recibe los colores de UI y la variante
	overrides = {},
})
```

### overrides

```lua
require("oxocarbon").setup({
	overrides = function(c, variant)
		return {
			CursorLine = { bg = c.bg2 },
			Comment = { fg = c.gray2, italic = variant ~= "print" },
		}
	end,
})
```

## Integraciones

| Integración | Qué hace |
|-----|-----|
| `snacks` | Terminal, lazygit, etc. con el mismo fondo que el editor; picker, dashboard, notifier, input, indent |
| `mini` | statusline, tabline, pick, files, clue, notify, starter, icons, diff, hipatterns, cursorword, indentscope, jump, surround, completion, map |


## Créditos

Colores y reglas de variantes de [oxocarbon-vscode](https://github.com/nyoom-engineering/oxocarbon-vscode) de Nyoom Engineering (MIT).
