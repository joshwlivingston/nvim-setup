-- ~/nvim/lua/plugins/scroller.lua

return {
    "declancm/cinnamon.nvim",
    version = "*", -- use latest release
    opts = {
        keymaps = {
            basic = true,
            extra = true,
        },
        options = {
            delay = 3,
        },
    },
}
