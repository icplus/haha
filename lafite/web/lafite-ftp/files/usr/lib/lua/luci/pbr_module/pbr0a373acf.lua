module("luci.pbr_module.pbr0a373acf", package.seeall)

function index () end

function isBind (config, section, option)
    if config == 'vsftpd' then
        return true
    end

    return false
end

function bind (config, section, option)
    if config == 'vsftpd' then
        return "/etc/init.d/vsftpd restart"
    end

    return nil
end
