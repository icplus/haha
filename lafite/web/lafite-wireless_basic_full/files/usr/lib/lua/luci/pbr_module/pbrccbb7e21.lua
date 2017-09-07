module("luci.pbr_module.pbrccbb7e21", package.seeall)

function index () end

function isBind (config, section, option)
    if config == 'wireless' then
        return true
    end
    return false
end

function bind (config, section, option)
    -- Device
    if config ~= 'wireless' then return nil end

    return 'wifi down;wifi up', 70
end
