module("luci.pbr_module.pbr0b6d64fb", package.seeall)

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

    commands = { 'wifi down;wifi up' }

    if option.mode and option.mode == 'sta' then
        commands[#commands+1] = 'ubus call network reload'
        commands[#commands+1] = '/etc/init.d/firewall restart'
    end

    return commands, 70
end
