local sys  = require 'luci.sys'
local http = require 'luci.http'
local util = require "luci.util"

module('luci.pbr.auth', package.seeall)

function index ( )
end

function login ( auth )
    local sess, token
    local rv   = { }

    if not auth.username or not auth.password then
        return false
    end
    if not sys.user.checkpasswd(auth.username, auth.password) then
        return false
    end

    local sdat = util.ubus("session", "create", { timeout = tonumber(luci.config.sauth.sessiontime) })
    if sdat then
        token = sys.uniqueid(16)
        util.ubus("session", "set", {
            ubus_rpc_session = sdat.ubus_rpc_session,
            values = {
                user = user,
                token = token,
                section = sys.uniqueid(16)
            }
        })
        sess = sdat.ubus_rpc_session
    end
    if sess and token then
        rv.date = os.time()
        rv.limit = luci.config.sauth.sessiontime
        rv.sysauth = sess
        auth.sysauth = sess
        http.header("Set-Cookie", 'sysauth=%s; path=%s' %{ sess, luci.dispatcher.build_url() })
        return rv
    else
        return false
    end
end

function logout ( )
    local auth = {
        sysauth = http.getcookie('sysauth') or nil
    }
    if not auth.sysauth then
        return false
    elseif not auth.sysauth:match('^[a-f%d]+$') then
        return false
    end

    util.ubus('session', 'destroy', { ubus_rpc_session = auth.sysauth })
    http.header("Set-Cookie", 'path=%s' %{ luci.dispatcher.build_url() })
    auth.sysauth = nil

    return true
end

function change( auth )
    if not auth.username or not auth.oldPwd or not auth.newPwd then
        return false
    end
    if auth.oldPwd == auth.newPwd then
        return false
    end
    if not sys.user.checkpasswd(auth.username, auth.oldPwd) then
        return false
    end
    luci.sys.user.setpasswd(auth.username, auth.newPwd)

    return true
end
function status ( auth )
    auth = auth or {
        sysauth = http.getcookie('sysauth') or nil
    }
    if not auth.sysauth then
        return false
    elseif not auth.sysauth:match('^[a-f%d]+$') then
        return false
    end

    local isAuth = (util.ubus("session", "get", { ubus_rpc_session = auth.sysauth }) or { }).values
    if not isAuth then
        return false
    end

    return true
end
