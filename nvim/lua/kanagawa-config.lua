require('kanagawa').setup({
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = { bold = true},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = { italic = true },
    transparent = false,
    dimInactive = true,
    terminalColors = true,

    overrides = function(colors)
        return {}
    end,

    theme = "dragon",
    background = {
        dark = "dragon",
        light = "lotus"
    },
})

vim.cmd("colorscheme kanagawa")
