module("luci.pbr_module.pbr89596939", package.seeall)

function index () end

function isBind (config, section, option)
    if config == 'network' and section:find('^wan') then
        return true
    end
    return false
end

function bind (config, section, option)
    -- Device
    if config ~= 'network' or not section:find('^wan') then
        return nil
    end

    local commands = { }
    if option == 'macaddr' then
        commands[#commands+1] = "ubus call network reload"
        commands[#commands+1] = "/etc/init.d/network restart"
        return commands, 70
    end

    commands[#commands+1] = "ubus call network reload"
    commands[#commands+1] = "ifup wan"

    return commands, 70
end
