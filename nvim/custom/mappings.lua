---@type MappingsTable
local M = {}

M.general = {
  i = {
    ["<C-a>"] = { "<ESC>^i", "beginning of line" }, -- the way rms intended
    ["<C-e>"] = { "<End>", "end of line" },


    ["<C-n>"] = { "<Up>", "next line" },
    ["<C-p>"] = { "<Down>", "previous line" },
    ["<C-f>"] = { "<Right>", "move forward" },
    ["<C-b>"] = { "<Left>", "move backward" },

    ["<C-x>o"] = { "<ESC><C-w><C-w>i", "other window" },
    ["<M-a>"] = { "<ESC><C-w><C-w>i", "other window" },
    ["<leader>a"] = { "<ESC><C-w><C-w>i", "other window" },


    ["<C-x>2"] = { "<cmd> split <cr><cmd>", "split horizontal" },
    ["<C-x>3"] = { "<cmd> vs <cr><cmd>", "split vertical" },
    ["<C-x>0"] = { "<cmd> close <cr><cmd>", "close current buffer" },

    ["<C-x>k"] = { "<cmd> wclose <cr><cmd>", "kill buffer" },
    ["<C-x>s"] = { "<cmd> wall <cr><cmd>", "save some buffers" },
    ["<C-x><C-c>"] = { "<cmd> wqall <cr><cmd>", "sayoonara" },

    ["<M-q>"] = {"<cmd> NvimTreeToggle <cr><cmd>"},
  },

  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    -- DRY? what the fuck is that?

    ["<C-n>"] = { "<Up>", "next line" },
    ["<C-p>"] = { "<Down>", "previous line" },
    ["<C-f>"] = { "<Right>", "move forward" },
    ["<C-b>"] = { "<Left>", "move backward" },

    ["<C-x>o"] = { "<C-w><C-w>", "other window" },
    ["<M-a>"] = { "<C-w><C-w>", "other window" },
    ["<leader>a"] = { "<C-w><C-w>", "other window" },


    ["<C-x>2"] = { "<cmd> split <cr><cmd>", "split horizontal" },
    ["<C-x>3"] = { "<cmd> vs <cr><cmd>", "split vertical" },
    ["<C-x>0"] = { "<cmd> close <cr><cmd>", "close current buffer" },

    ["<C-x>k"] = { "<cmd> wclose <cr><cmd>", "kill buffer" },
    ["<C-x>s"] = { "<cmd> wall <cr><cmd>", "save some buffers" },
    ["<C-x><C-c>"] = { "<cmd> wqall <cr><cmd>", "sayoonara" },

    ["<M-q>"] = {"<cmd> NvimTreeToggle <cr><cmd>"},
  },
}

-- more keybinds!

return M
