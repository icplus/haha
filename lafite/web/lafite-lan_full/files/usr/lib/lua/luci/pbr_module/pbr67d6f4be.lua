module("luci.pbr_module.pbr67d6f4be", package.seeall)

function index () end

function isBind (config, section, option)
    if (config == 'network' and section == 'lan') or
            (config == 'dhcp' and section == 'lan') then
        return true
    end

    return false
end

function bind (config, section, option)
    -- Device
    if config == 'network' and section == 'lan' then
        local commands = { }

        if option == 'ipaddr' then
            return 'reboot', 0
        end

        commands[#commands+1] = "ubus call network reload"
        commands[#commands+1] = "/etc/init.d/network restart"
        return commands, 70
    end
    -- DHCP
    if config == 'dhcp' and section == 'lan' then
        local commands = { }

        commands[#commands+1] = "/etc/init.d/network restart"
        if option == 'ignore' then
            return commands, 70
        end

        commands[#commands+1] = "ubus call network reload"
        commands[#commands+1] = "/etc/init.d/dnsmasq restart"
        return commands, 70
    end

    return nil
end
