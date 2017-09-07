module("luci.controller.pbr.file", package.seeall)

local P_MSG  = require("luci.pbr.message")

function index ()
    entry({"pbr", "file"}, call("action_update_file"), nil, 20).index = true
end

function action_update_file ()
    local image_tmp = "/tmp/update.file"

    local fd   = nil
    luci.http.setfilehandler(function(field, chunk, eof)
        if not field then return end
        if not fd then
            fd = io.open(image_tmp, "w")
        end
        if fd then
            fd:write(chunk)
        end
        if eof and fd then
            fd:close()
            fd = nil
        end
    end)
    if luci.http.formvalue("image") then
        P_MSG.ok({ })
        return
    end
    P_MSG.uknown({ })
end
