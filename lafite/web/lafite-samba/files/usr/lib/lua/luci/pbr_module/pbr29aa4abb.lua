module("luci.pbr_module.pbr29aa4abb", package.seeall)

function index () end

function isBind (config, section, option)
    if config == 'samba' then
        return true
    end

    return false
end

function bind (config, section, option)
    if config == 'samba' then
        return "/etc/init.d/samba restart"
    end

    return nil
end
