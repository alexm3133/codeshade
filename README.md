CodeShade for Neovim(an easy highlighter of text, written in Lua)

CodeShade is a Neovim plugin written in Lua that enables persistent highlighting of code sections. Designed to assist in the development process, it allows for marking sections of code for review, emphasizing important parts, or maintaining focus on specific segments.
Features

   * Persistent Highlighting: Retains highlights across sessions, enabling you to immediately continue from where you left off.
   * Toggle Highlighting: Provides commands and keybindings to add or remove highlights.
   * Buffer-Specific Highlighting: Ensures highlights are relevant to the specific files you're working on, avoiding cross-buffer highlight pollution.

Getting Started
Prerequisites

  * Neovim (0.5.0 or later)
  * Familiarity with configuring Neovim's init.vim or init.lua.

Installation

Install CodeShade using your preferred Neovim package manager. For vim-plug, add the following line to your init.vim:

vim

Plug 'alexm3133/codeshade'

Then run :PlugInstall in Neovim.
Usage
    * Highlighting Sections: In visual mode, select lines and execute :ToggleHighlight or use the designated keybinding to highlight.
    * Loading Highlights: Automatically done on file open. Manually invoke with :LoadHighlight.
    * Removing Highlights: Reselect highlighted sections and execute :ToggleHighlight again to remove.

After you should add to your init.vim or init.lua 
    lua require'codeshade'

Keybindings

Configure default keybindings in your init.vim or init.lua:

vim

" Visual mode - Toggle highlight
vmap <Leader>hl :ToggleHighlight<CR>
" Normal mode - Load highlights
nmap <Leader>lh :LoadHighlight<CR>

Contributing

Feedback, feature suggestions, and contributions are welcome. Feel free to open issues or pull requests on GitHub.



