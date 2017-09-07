module("luci.pbr_module.pbrcf1ccc39", package.seeall)

function index () end

function isBind (config, section, option)
    if config ~= 'dhcp' then
        return false
    end

    return true
end

function bind (config, section, option)
    -- DHCP
    if config == 'dhcp' then
        local commands = { }

        commands[#commands+1] = "ubus call network reload"
        commands[#commands+1] = "/etc/init.d/dnsmasq restart"
        return commands, 70
    end

    return nil
end
