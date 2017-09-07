module("luci.pbr.message", package.seeall)

function index ()
end

local function factory_message ( content, status )
    local P_UTIL = require("luci.pbr.util")

    local rv = content or { }
    rv.status = status or 'uknown'
    rv.length = #P_UTIL.keys(rv)

    luci.http.prepare_content("application/json")
    luci.http.write_json(rv)
end

function ok ( content )
    return factory_message( content, "ok" )
end

function warn ( content )
    return factory_message( content, "warn" )
end

function error ( content )
    return factory_message( content, "error" )
end

function uknown ( content )
    return factory_message( content, "unknown" )
end

function notfound ( content )
    return factory_message( content, "data not found" )
end

function panding ( content )
    return factory_message( content, "panding" )
end

function skiped ( content )
    return factory_message( content, "skiped" )
end

function unauth ( content )
    return factory_message( content, "unauthorized" )
end
