repeat task.wait() until game:IsLoaded()
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
local fps = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    local now = tick()
    fps = 1 / (now - lastTime)
    lastTime = now
end)

local Window = WindUI:CreateWindow({
    Title = "Snow Client - FNAF: Coop",
    Icon = "snowflake",
    Author = "by Snow",
    Folder = "snowhub",

    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false
})

Window:EditOpenButton({
    Title = "Snow Client",
    Icon = "external-link",
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")),
    OnlyMobile = true,
    Enabled = true,
    Draggable = true
})

local Home = Window:Tab({
    Title = "Home",
    Icon = "house",
    Locked = false,
}) Window:SelectTab(1)


local warning = Home:Paragraph({
    Title = "In Lobby",
    Desc = "Please get in a game in order for the script to work",
    Color = "Orange",
    Image = "shield-alert",
    ImageSize = 30,
    Locked = false,
})

local performance_network = Home:Paragraph({
    Title= "Performance / Network", 
    Desc = "FPS: 0 | Ping: 0"
})

task.spawn(function()
    while true do 
        task.wait(1)
        ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        performance_network:SetDesc("FPS: "..math.round(fps).." | Ping: "..math.round(ping))
    end
end)

local Keybind = Home:Keybind({
    Title = "Keybind",
    Desc = "Keybind to open ui",
    Value = "M",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})