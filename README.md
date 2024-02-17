CodeShade for Neovim(an easy highlighter of text, written in Lua)

CodeShade is a Neovim plugin written in Lua that enables persistent highlighting of code sections. Designed to assist in the development process, it allows for marking sections of code for review, emphasizing important parts, or maintaining focus on specific segments.

![Image](https://github.com/alexm3133/codeshade/blob/main/screenshots/neovim_screenshot.png?raw=true)

Features

   * Persistent Highlighting: Retains highlights across sessions, enabling you to immediately continue from where you left off.
   * Toggle Highlighting with Color Categories: Beyond simply toggling highlights, CodeShade now supports multiple color categories. Use :ToggleHighlight for the default yellow or :ToggleHighlight -question to apply a red highlight, enhancing code organization and readability. This feature allows for categorizing highlighted sections by importance, question, or any custom category you define. 
   * Buffer-Specific Highlighting: Ensures highlights are relevant to the specific files you're working on, avoiding cross-buffer highlight pollution.

Getting Started
Prerequisites

  * Neovim (0.5.0 or later)
  * Familiarity with configuring Neovim's init.vim or init.lua.

Installation

Install CodeShade using your preferred Neovim package manager. For vim-plug, add the following line to your init.vim:

      Plug 'alexm3133/codeshade'

Then run:

     :PlugInstall in Neovim.

Usage:

     Highlighting Sections: In visual mode, select lines and execute :ToggleHighlight or use the designated keybinding to highlight.
     Loading Highlights: Automatically done on file open. Manually invoke with :LoadHighlight.
     Removing Highlights: Reselect highlighted sections and execute :ToggleHighlight again to remove.

After you should add to your init.vim or init.lua 

      lua require'codeshade'

Keybindings

Configure default keybindings in your init.vim or init.lua:

vim

    " Visual mode - Toggle highlight
    vmap <Leader>hl :ToggleHighlight<CR>
    " Normal mode - Load highlights
    nmap <Leader>lh :LoadHighlight<CR>
    
Contributing:

Feedback, feature suggestions, and contributions are welcome. Feel free to open issues or pull requests on GitHub.



