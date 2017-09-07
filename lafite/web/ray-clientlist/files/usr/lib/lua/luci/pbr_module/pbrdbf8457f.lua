module("luci.pbr_module.pbrdbf8457f", package.seeall)

function index () end

function isBind (config, section, option)
    if config == 'bandwidth' then
        return true
    end
    return false
end

function bind (config, section, option)
    -- Device
    if config ~= 'bandwidth' then
        return nil
    end

    local commands = { }

    commands[#commands+1] = "/etc/init.d/bandwidth restart"

    return commands, 30
end
