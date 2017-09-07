module("luci.pbr_module.pbrf9e0d3c0", package.seeall)

function index () end

function isBind (config, section, option)
    if config == 'upnpd' then
        return true
    end

    return false
end

function bind (config, section, option)
    if config == 'upnpd' then
        return "/etc/init.d/miniupnpd restart"
    end

    return nil
end
