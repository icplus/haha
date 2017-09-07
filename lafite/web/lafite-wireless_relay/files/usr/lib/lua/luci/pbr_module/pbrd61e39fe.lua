module("luci.pbr_module.pbrd61e39fe", package.seeall)

function index () end

function isBind (config, section, option)
    if config == 'wireless' and option.mode == 'sta' then
        return true
    end
    return false
end

function bind (config, section, option)
    -- Device
    if config ~= 'wireless' then return nil end
    if option.mode ~= 'sta' then return nil end

    return 'ubus call network reload', 70
end
