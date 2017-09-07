module("luci.controller.admin.lafite", package.seeall)

function index()
    local root = node()
    if not root.target then
        root.target = alias("lafite")
        root.index = true
    end

    local page = entry({"lafite"}, template("jump"), nil, 0)
    page.sysauth = false
    page.ucidata = true
    page.index = true
end
