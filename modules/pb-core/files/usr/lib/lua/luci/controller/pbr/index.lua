module("luci.controller.pbr.index", package.seeall)

function index ()
    local page   = node("pbr")
    page.target  = firstchild()
    page.title   = nil
    page.order   = 97
    page.sysauth = false
    page.ucidata = true
    page.index   = true
end
