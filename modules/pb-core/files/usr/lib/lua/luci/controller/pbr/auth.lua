module("luci.controller.pbr.auth", package.seeall)

require 'luci.sys'

local P_AUTH = require("luci.pbr.auth")
local P_UTIL = require("luci.pbr.util")
local P_MSG  = require("luci.pbr.message")

function index ()
    entry({"pbr", "auth"}, call("action_auth_call"), nil, 20).index = true
end

function action_auth_call ( )
    local CONTENT_TYPE = luci.http.getenv("CONTENT_TYPE") or "text/plain"
    local content = luci.http.content() or nil
    local auth = {
        sysauth  = luci.http.getcookie('sysauth') or nil
    }

    if CONTENT_TYPE:find("application/json") then
        local json = require('luci.json').decode(content)

        if type(json) == "table" and json.action then
            if 'status' == json.action then
                return _auth_status(auth)
            elseif 'change' == json.action then
                auth.username = json['username'] or 'root'
                auth.oldPwd   = json['password'] or nil
                auth.newPwd   = json['change'] or nil
                return _auth_change(auth)
            elseif 'login' == json.action then
                auth.username = json['username'] or nil
                auth.password = json['password'] or nil
                return _auth_login(auth)
            elseif 'logout' == json.action then
                return _auth_logout(auth)
            end
        end
    end

    P_MSG.uknown({ })
end

function _auth_status ( auth )
    if P_AUTH.status(auth) then
        return P_MSG.ok(auth)
    else
        return P_MSG.unauth(auth)
    end
end

function _auth_change ( auth )
    local isSuc = P_AUTH.change(auth)
    auth.password = auth.oldPwd
    auth.change = auth.newPwd
    auth.newPwd = nil
    auth.oldPwd = nil
    if isSuc then
        auth.password = auth.change
        auth.change = nil
        return P_MSG.ok(auth)
    else
        return P_MSG.error(auth)
    end
end

function _auth_login ( auth )
    local isLogin = P_AUTH.login(auth)
    if isLogin then
        return P_MSG.ok(isLogin)
    else
        return P_MSG.error(auth)
    end
end

function _auth_logout ( auth )
    if P_AUTH.logout(auth) then
        return P_MSG.ok(auth)
    else
        return P_MSG.warn(auth)
    end
end
