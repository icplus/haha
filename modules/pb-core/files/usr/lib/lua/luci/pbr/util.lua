module("luci.pbr.util", package.seeall)

function index ()
end

function keys ( obj )
    local keys = { }

    if type(obj) ~= "table" then
        return keys
    end

    for key, _ in pairs(obj) do
        keys[#keys+1] = key
    end

    return keys
end
