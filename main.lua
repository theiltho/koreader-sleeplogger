local Device = require("device")
local Dispatcher = require("dispatcher")
local FFIUtil = require("ffi/util")
local InfoMessage = require("ui/widget/infomessage")
local UIManager = require("ui/uimanager")
local WidgetContainer = require("ui/widget/container/widgetcontainer")
local _ = require("gettext")

local SleepLogger = WidgetContainer:extend{
    name = "sleeplogger",
    is_doc_only = false,
}

function SleepLogger:init()
    -- Get plugin directory path
    self.plugin_dir = FFIUtil.realpath(FFIUtil.dirname(debug.getinfo(1).source:sub(2)))
    self.log_file = self.plugin_dir .. "/sleep_log.txt"
    self.max_entries = 6
    
    -- Register dispatcher action
    Dispatcher:registerAction("sleep_logger_show", {
        category = "none",
        event = "ShowSleepLog",
        title = _("Show Last Sleep Time"),
        general = true,
    })
    
    self:onDispatcherRegisterActions()
end

function SleepLogger:onDispatcherRegisterActions()
    Dispatcher:registerAction("sleep_logger_show", {
        category = "none", 
        event = "ShowSleepLog",
        title = _("Show Last Sleep Time"),
        general = true,
    })
end

function SleepLogger:onShowSleepLog()
    self:showLastSleepTime()
    return true
end

function SleepLogger:onSuspend()
    self:logSleepTime()
end

function SleepLogger:logSleepTime()
    local current_time = os.date("%Y-%m-%d %H:%M:%S")
    
    -- Read existing entries
    local entries = {}
    local file = io.open(self.log_file, "r")
    if file then
        for line in file:lines() do
            if line ~= "" then
                table.insert(entries, line)
            end
        end
        file:close()
    end
    
    -- Add new entry at the beginning
    table.insert(entries, 1, "Sleep: " .. current_time)
    
    -- Keep only last 6 entries
    while #entries > self.max_entries do
        table.remove(entries)
    end
    
    -- Write back to file
    file = io.open(self.log_file, "w")
    if file then
        for _, entry in ipairs(entries) do
            file:write(entry .. "\n")
        end
        file:close()
    end
end

function SleepLogger:showLastSleepTime()
    local content = ""
    local file = io.open(self.log_file, "r")
    
    if file then
        content = file:read("*all")
        file:close()
        
        if content == "" then
            content = "No sleep times recorded yet."
        end
    else
        content = "No sleep log file found."
    end
    
    UIManager:show(InfoMessage:new{
        text = "Last Sleep Times:\n\n" .. content,
        timeout = 3,
    })
end

return SleepLogger
