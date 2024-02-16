local M = {}
local highlight_file = vim.fn.stdpath('data') .. '/highlighted_lines.txt'

-- Define el grupo de resaltado
vim.api.nvim_exec([[
  highlight CustomHighlight guifg=Black guibg=Yellow ctermfg=Black ctermbg=Yellow
]], false)

local function parse_highlight_file()
    local highlights = {}
    local file = io.open(highlight_file, "r")
    if not file then return highlights end

    for line in file:lines() do
        local bufnr, lnum = line:match("(%d+):(%d+)")
        if bufnr and lnum then
            bufnr, lnum = tonumber(bufnr), tonumber(lnum)
            if not highlights[bufnr] then highlights[bufnr] = {} end
            table.insert(highlights[bufnr], lnum)
        end
    end
    file:close()
    return highlights
end

local function save_highlights(highlights)
    local file = io.open(highlight_file, "w")
    for bufnr, lines in pairs(highlights) do
        for _, lnum in ipairs(lines) do
            file:write(bufnr .. ":" .. lnum .. "\n")
        end
    end
    file:close()
end
function M.toggle_highlight()
    local bufnr = vim.api.nvim_get_current_buf()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local highlights = parse_highlight_file()

    -- Inicializa el buffer si es necesario
    highlights[bufnr] = highlights[bufnr] or {}

    local updated = false
    for lnum = start_line, end_line do
        local exists = false
        -- Verifica si la línea ya está resaltada
        for index, line in ipairs(highlights[bufnr]) do
            if line == lnum then
                table.remove(highlights[bufnr], index)
                vim.api.nvim_buf_clear_namespace(bufnr, -1, lnum-1, lnum)
                exists = true
                updated = true
                break
            end
        end
        if not exists then
            table.insert(highlights[bufnr], lnum)
            updated = true
        end
    end

    if updated then
        save_highlights(highlights)
    end

    -- Reaplicar todos los resaltados para este buffer
    for _, lnum in ipairs(highlights[bufnr] or {}) do
        vim.api.nvim_buf_add_highlight(bufnr, -1, "CustomHighlight", lnum - 1, 0, -1)
    end
end


function M.load_highlights()
    local bufnr = vim.api.nvim_get_current_buf()
    local highlights = parse_highlight_file()

    for _, lnum in ipairs(highlights[bufnr] or {}) do
        vim.api.nvim_buf_add_highlight(bufnr, -1, "CustomHighlight", lnum - 1, 0, -1)
    end
end

-- Comandos y atajos de teclado
vim.api.nvim_create_user_command('ToggleHighlight', M.toggle_highlight, {range = true})
vim.api.nvim_create_user_command('LoadHighlight', M.load_highlights, {})
vim.api.nvim_set_keymap('v', '<Leader>hl', ':ToggleHighlight<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>lh', ':LoadHighlight<CR>', { noremap = true, silent = true })

return M


