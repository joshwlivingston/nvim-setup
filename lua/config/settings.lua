-- ~/nvim/lua/settings.lua

local global = vim.g
local o = vim.opt

o.number = true -- Print the line number in front of each line
o.relativenumber = true -- Show the line number relative to the line with the cursor
o.clipboard  = "unnamedplus" -- uses the clipboard register for all opreations
o.syntax = "on" -- syntax with this name is loaded
o.autoindent = true -- copy indent from curent line when starting a new line
o.cursorline = true -- Highlight the screen line of the cursor with CursorLine
o.expandtab = true -- In insert modeL User the approriate number os spaces to insert a <Tab>
o.shiftwidth = 2 -- Number of spaces that a <Tab> in the file counts for
o.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
o.encoding = "UTF-8" -- sets character encoding inside vim
o.ruler = true -- show the line and column number of cursor position
o.mouse = "a" -- Enable the use of the mouse. "a" you cna use on all nodes
o.title = true -- When true, title of window is set to titlestring
o.hidden = true -- When on, a buffer becomes hiddent with it is abandoned
o.ttimeoutlen = 0 -- The time in milliseconds that is waited for a key code or mapped key sequence to complete
o.wildmenu = true -- Operate command-line completiton in enhanced mode
o.showcmd = true -- Show (partial) command in the last line of the screen.
o.showmatch = true -- When a bracket is inserted, briefly jump to the matching one
o.inccommand = "split" -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands
o.splitright = ture -- When true, splitting a window will puyt the window below the other
o.splitbelow = false -- When true, splitting a window will puyt the window below the other
o.termguicolors = true

