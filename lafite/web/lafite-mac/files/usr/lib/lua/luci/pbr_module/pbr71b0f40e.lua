module("luci.pbr_module.pbr71b0f40e", package.seeall)

function index () end

function isBind (config, section, option)
    if option == 'macaddr' then
        return true
    end

    return false
end

function bind (config, section, option)
    local commands = { }

    if option == 'macaddr' then
        commands[#commands+1] = "ubus call network reload"
        commands[#commands+1] = "/etc/init.d/network restart"
        return commands, 70
    end

    return nil
end
