local WidgetContainer = require("ui/widget/container/widgetcontainer")
local UIManager = require("ui/uimanager")
local logger = require("logger")
local DataStorage = require("datastorage")

local SleepLogger = WidgetContainer:new{
    name = "sleeplogger",
}

function SleepLogger:init()
    -- Event-Handler für Suspend/Sleep
    self.handleEvent = function(this, event)
        if event == "Suspend" or event == "ScreenSaverShow" then
            local timestamp = os.date("%Y-%m-%d %H:%M:%S")
            -- logger.info("Sleep Logger: " .. timestamp)
            local log_file = DataStorage:getDataDir() .. "/sleep_log.txt"
            local f = io.open(log_file, "a")  -- "w" = überschreiben; "a" = anhängen
            if f then
                f:write(timestamp .. " - Sleep Mode\n")
                f:close()
            end
            return false  -- Weiterleiten an andere Handler
        end
    end
end

return SleepLogger
