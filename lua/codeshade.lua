"=================================================

"" File: lua/codeshade.lua

"" Description: Highlight lines in a file for enhanced code readability

""Author: Alex Matei

================================================="

local M = {}
local highlight_file = vim.fn.stdpath('data') .. '/highlighted_lines.txt'

-- Define los grupos de resaltado
vim.api.nvim_exec([[
  highlight CustomHighlight guifg=Black guibg=Yellow ctermfg=Black ctermbg=Yellow
  highlight CustomHighlightQuestion guifg=Black guibg=Red ctermfg=Black ctermbg=Red
]], false)



-- Función para parsear el archivo de resaltados y obtener solo los resaltados para el archivo actual
local function parse_highlight_file()
    local current_file_path = vim.api.nvim_buf_get_name(0) -- Obtiene la ruta completa del archivo actual
    local highlights = {}
    local file = io.open(highlight_file, "r")
    if not file then return {} end

    for line in file:lines() do
        local file_path, lnum = line:match("([^:]+):(%d+)")
        if file_path and lnum and file_path == current_file_path then
            lnum = tonumber(lnum)
            highlights[lnum] = true
        end
    end
    file:close()
    return highlights
end

-- Función para guardar los resaltados, incluyendo la ruta del archivo en cada entrada
local function save_highlights(highlights)
    local file = io.open(highlight_file, "w")
    local current_file_path = vim.api.nvim_buf_get_name(0)
    for lnum, _ in pairs(highlights) do
        file:write(current_file_path .. ":" .. lnum .. "\n")
    end
    file:close()
end

-- Función para alternar el resaltado de las líneas seleccionadas

function M.toggle_highlight(opts)
    local category = opts.args
    local bufnr = vim.api.nvim_get_current_buf()
    local start_line, end_line = vim.fn.line("'<"), vim.fn.line("'>")
    local highlights = parse_highlight_file()

    -- Determina el grupo de resaltado basado en la categoría
    local highlight_group = "CustomHighlight" -- Por defecto
    if category == "-question" then
        highlight_group = "CustomHighlightQuestion"
    end

    for lnum = start_line, end_line do
        -- Aquí, revisa si la línea ya está resaltada y alterna basado en eso
        if highlights[lnum] then
            vim.api.nvim_buf_clear_namespace(bufnr, -1, lnum-1, lnum)
            highlights[lnum] = nil
        else
            vim.api.nvim_buf_add_highlight(bufnr, -1, highlight_group, lnum - 1, 0, -1)
            highlights[lnum] = true
        end
    end

    save_highlights(highlights)
end

-- Función para cargar resaltados automáticamente al abrir un archivo

function M.load_highlights()
    local bufnr = vim.api.nvim_get_current_buf()
    local highlights = parse_highlight_file()

    for lnum, _ in pairs(highlights) do
        vim.api.nvim_buf_add_highlight(bufnr, -1, "CustomHighlight", lnum - 1, 0, -1)
    end
end

-- Comandos y atajos de teclado
vim.api.nvim_set_keymap('v', '<Leader>hl', ':ToggleHighlight<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>lh', ':LoadHighlight<CR>', { noremap = true, silent = true })

-- Esta es la definición correcta que permite argumentos opcionales.
vim.api.nvim_create_user_command('ToggleHighlight', function(opts)
    M.toggle_highlight(opts)
end, {nargs='?', range = true})

-- Autocargar resaltados al abrir archivos
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        M.load_highlights()
    end,
})

return M
