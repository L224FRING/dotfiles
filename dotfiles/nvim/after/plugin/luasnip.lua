local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node


vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})


ls.add_snippets("all", {
    s("!", {
        t({
            "<!DOCTYPE html>",
            "<html lang=\"en\">",
            "<head>",
            "    <meta charset=\"UTF-8\">",
            "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
            "    <title>",
        }),
        i(1, "Document"), -- The title can be edited
        t({
            "</title>",
            "</head>",
            "<body>",
            "",
        }),
        i(2), -- Insert point inside the body
        t({
            "",
            "</body>",
            "</html>",
        }),
    }),
    s("{",{
        t({
           "{",
           "    ",
        }),
        i(1),
        t({
            "",
            "}"
        }),
    }),
    s("(",{
        t({
           "(",
           "    ",
        }),
        i(1),
        t({
            "",
            ")"
        }),
    }),

    s("[",{
        t({
           "[",
           "    ",
        }),
        i(1),
        t({
            "",
            "]"
        }),
    }),
    s("div",{
        t({
           "<div>",
           " ",
        }),
        i(1),
        t({
            "",
            "</div>",
        }),
    })
})

