module("luci.controller.pbr.api", package.seeall)

local UCI    = require('luci.model.uci').cursor()

local P_UTIL = require("luci.pbr.util")
local P_MSG  = require("luci.pbr.message")

function index ()
    entry({"pbr", "api"}, call("action_api_call"), nil, 20).index = true
end

function action_api_call ()
    local CONTENT_TYPE = luci.http.getenv("CONTENT_TYPE") or "text/plain"
    local content = luci.http.content() or nil

    if CONTENT_TYPE:find("application/json") then
        local json = require('luci.json').decode(content)

        if type(json) == "table" then
            if #json > 0 then return _api_getter(json) end
            if #json == 0 then return _api_setter(json) end
        end
    end

    P_MSG.uknown({ })
end

function _api_getter (json)
    local rv = { }

    for _, item in ipairs(json) do
        -- os.execute(string.format("echo 'Get %s' >> /tmp/pbr.log", item))
        rv[item] = UCI:get_all(item) or nil
    end

    if json['commands'] then
        rv['commands'] = json['commands']
    end

    P_MSG.ok(rv)
end

function _api_setter (json)
    local keys = P_UTIL.keys(json)
    if #keys == 0 then return _api_getter(keys) end

    --[[
    config : {
        section1 : {
            option1 : "..."
            ...
        }
        ...
    }
    --]]
    table.foreachi(keys, function (_, config)
        -- Config Key
        -- os.execute(string.format("echo '-> %s' >> /tmp/pbr.log", config))
        if config:find('^commands$') then return end

        table.foreachi(P_UTIL.keys(json[config]), function (_, section)
            -- Section
            ---- Add
            if section:find("__add$") then
                if not json[config][section][".type"] then
                    return
                end

                local wname = null

                wname = UCI:add(config, json[config][section][".type"])

                table.foreach(json[config][section], function (option, value)
                    UCI:set(config, wname, option, value)
                end)
                return
            end
            ---- Del
            if section:find("__del$") and
                json[config][section][".name"] == section:gsub("__del", "") then
                section = json[config][section][".name"]
                -- os.execute(string.format("echo 'del %s,%s' >> /tmp/pbr.log", config, section))
                UCI:delete(config, section)
                return
            end

            -- os.execute(string.format("echo '-> %s, %s' >> /tmp/pbr.log", config, section))
            table.foreach(json[config][section], function (option, value)
                if option:find("^%.") then return end

                if option:find("__del$") then
                    option = option:gsub("__del", "")
                    -- os.execute(string.format("echo 'del %s,%s,%s' >> /tmp/pbr.log", config, section, option))
                    UCI:delete(config, section, option)
                    return
                end

                -- os.execute(string.format("echo 'set %s,%s,%s -> %s' >> /tmp/pbr.log", config, section, option, value))
                UCI:set(config, section, option, value)
            end)
        end)
        UCI:commit(config)
    end)

    MODULEDIR = "/usr/lib/lua/luci/pbr_module/"
    fs = require 'nixio.fs'
    local modules = { }
    if fs.access(MODULEDIR) then
        -- Get Modules
        for v in fs.glob('%s*' % MODULEDIR) do
            if v ~= '.' and v ~= '..' then
                local module_name = fs.basename(v):match('^(.*)%.lua$')
                local module = {
                    obj  = require("luci.pbr_module." .. module_name),
                    name = module_name,
                    path = v
                }

                if module.obj.isBind == nil or module.obj.bind == nil then return end

                modules[#modules+1] = module
                -- os.execute(string.format("echo 'Found Module %s' >> /tmp/pbr.log", module_name))
            end
        end
    end
    -- Get Commands
    if #modules > 0 then
        local commands = { }
        table.foreachi(modules, function (_, item)
            -- os.execute(string.format("echo 'Use Module %s' >> /tmp/pbr.log", item.name))

            table.foreachi(keys, function (_, config)
                if config:find('^commands$') then return end

                table.foreachi(P_UTIL.keys(json[config]), function (_, section)
                    table.foreach(json[config][section], function (option, value)
                        if option:find("^%.") then return end
                        if item.obj.isBind(config, section, option) then
                            local obj = {
                                config  = config,
                                section = section,
                                option  = option
                            }
                            obj.commands, obj.priority = item.obj.bind(config, section, option)
                            if obj.commands == nil then return end
                            if type(obj.commands) == 'string' then
                                obj.commands = { obj.commands }
                            end
                            obj.priority = obj.priority or 100

                            -- os.execute(string.format("echo 'Module Bind %s, %s, %s' >> /tmp/pbr.log", config, section, option))
                            table.foreachi(obj.commands, function (_, command)
                                -- os.execute(string.format("echo 'Module Bind Command %s' >> /tmp/pbr.log", command))
                                commands[command] = {
                                    config   = obj.config,
                                    section  = obj.section,
                                    option   = obj.option,
                                    command  = command,
                                    priority = obj.priority
                                }
                            end)

                        end
                    end) -- End json[config][section] Repeater
                end) -- End P_UTIL.keys(json[config]) Repeater
            end) -- End P_UTIL.keys(json) Repeater
        end) -- End modules Repeater
        -- os.execute(string.format("echo 'Commands Length-: %s' >> /tmp/pbr.log", #P_UTIL.keys(commands)))
        if #P_UTIL.keys(commands) ~= 0 then
            -- Update List
            _list = { }
            table.foreach(commands, function (_, item)
                _list[#_list+1] = item
            end)
            table.sort(_list, function (a, b)
                return a.priority > b.priority
            end)
            -- os.execute(string.format("echo 'Commands Length: %s' >> /tmp/pbr.log", #_list))
            local commands = { }
            table.foreachi(_list, function (_, item)
                commands[#commands+1] = item.command
            end)
            -- Run Commands
            commands_action(commands, true)
        end
    end
    table.foreachi(keys, function (_, config)
        if not config:find('^commands$') then return end

        local commands = commands_action(json[config])

        if #commands ~= 0 then
            keys['commands'] = commands
        end
    end)

    return _api_getter(keys)
end

function commands_action (arr, isLimit)
    isLimit = isLimit or false

    commands = { }

    table.foreachi(arr, function (_, command)
        -- os.execute(string.format("echo 'command: %s' >> /tmp/pbr.log", command))
        if not isLimit and command:find('[&>;]') then return end
        if command:find('^GET ') then
            commands[#commands+1] = {
                command = command
            }

            local rv = { }
            if command:find('^GET @') then
                -- HTTP ENV
                -- os.execute(string.format("echo 'command ENV: %s' >> /tmp/pbr.log", command:match('^GET @(.*)')))
                rv[#rv+1] = luci.http.getenv(command:match('^GET @(.*)'))
            else
                -- 普通命令
                local bwc = io.popen(command:match("^GET (.*)"))
                if bwc then
                    local ln
                    -- Read Command Content
                    repeat
                        ln = bwc:read("*l")
                        if not ln then break end

                        rv[#rv+1] = ln
                    until not ln
                end
            end

            commands[#commands].content = rv
        elseif command:find('^NOHUP ') then
            luci.sys.exec("sleep 1 && " .. command:match("^NOHUP (.*)") .. " &")
        else
            luci.sys.exec(command)
        end
    end)

    if #commands ~= 0 then
        return commands
    end

    return { }
end
