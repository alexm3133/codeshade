CodeShade for Neovim

CodeShade is a nascent Neovim plugin crafted with Lua, aimed at augmenting your coding experience by providing the ability to persistently highlight sections of code. This capability is invaluable for flagging areas needing review, accentuating critical code segments, or simply maintaining focus on specific parts during your development sessions.
Features

    Persistent Highlighting: CodeShade remembers your highlighted sections, even after closing and reopening files, making it easier to pick up right where you left off.
    Toggle Highlighting: Easily highlight or remove highlighting from any section with a simple command or keybinding.
    Buffer-Specific Highlighting: Highlights are specific to each buffer, ensuring that your markings are always relevant to the file you're working on.

Getting Started
Prerequisites

    Neovim (0.5.0 or later)
    Knowledge of your Neovim's init.vim or init.lua file for configuration.

Installation

You can install CodeShade using your favorite Neovim package manager. Here's an example using vim-plug:

vim

Plug 'https://github.com/alexm3133/codeshade'

After adding the plugin, run :PlugInstall in Neovim to install it.
Usage

    Highlight Sections: Enter visual mode, select the lines you wish to highlight, and then use the :ToggleHighlight command or the configured keybinding to highlight the selection.
    Load Highlights: Highlights are loaded automatically upon opening files. To manually load highlights, use the :LoadHighlight command.
    Remove Highlights: Simply reselect highlighted sections and toggle the highlight off using the same command or keybinding.

Keybindings

Add the following to your init.vim or init.lua to set up default keybindings:

vim

" Visual mode - toggle highlight
vmap <Leader>hl :ToggleHighlight<CR>
" Normal mode - load highlights
nmap <Leader>lh :LoadHighlight<CR>

Contributing

Contributions to CodeShade are welcome! Whether it's bug reports, feature suggestions, or code contributions, please feel free to make a pull request or open an issue on GitHub.
License

Distributed under the MIT License. See LICENSE for more information.
