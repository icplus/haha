module("luci.pbr_module.pbr11519064", package.seeall)

function index () end

function isBind (config, section, option)
    if config == 'ddns' then
        return true
    end

    return false
end

function bind (config, section, option)
    if config == 'ddns' then
        return "/etc/init.d/ddns restart"
    end

    return nil
end
