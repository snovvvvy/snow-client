repeat task.wait() until game:IsLoaded()
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
local fps = 0
local lastTime = tick()

local lplr = game:GetService("Players").LocalPlayer
local char = lplr.Character or lplr.CharacterAdded:Wait()

local lightingtech = game:GetService("Lighting").Technology.Value
local animatronicsfolder = workspace.Animatronics

RunService.RenderStepped:Connect(function()
    local now = tick()
    fps = 1 / (now - lastTime)
    lastTime = now
end)

local function AnimatronicESP(boolean, fillcolor, outlinecolor) 
    if boolean then 
        for _, v in pairs(animatronicsfolder:GetChildren()) do 
            if v:IsA("Folder") then 
                if (v.Name ~= "Blackout" and v.Name ~= "GoldenFreddy") then 
                    Instance.new("Highlight", v:WaitForChild(v.Name.."NPC"))
                end
            end 
        end
    else
        for _, v in pairs(animatronicsfolder:GetChildren()) do 
            if v:IsA("Folder") then 
                if (v.Name ~= "Blackout" and v.Name ~= "GoldenFreddy") then 
                    if v:WaitForChild(v.Name.."NPC"):FindFirstChildWhichIsA("Highlight") then 
                        v:WaitForChild(v.Name.."NPC"):FindFirstChildWhichIsA("Highlight"):Destroy()
                    end
                end
            end 
        end
    end
end

local function fpsboost(boolean) 
    if boolean then 
        game:GetService("Lighting").Technology = Enum.Technology.Compatibility
    else
        game:GetService("Lighting").Technology = lightingtech
    end
end

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
})

local Main = Window:Tab({
    Title = "Main",
    Icon = "star",
    Locked = false,
})

local Player = Window:Tab({
    Title = "LocalPlayer",
    Icon = "person-standing",
    Locked = false,
})

-- HOME --

local welcome = Home:Paragraph({
    Title = "Welcome, "..lplr.DisplayName..".",
    Color = "White",
    Image = "info",
    ImageSize = 30,
    Locked = false,
})

local Keybind = Home:Keybind({
    Title = "Keybind",
    Desc = "Keybind to open ui",
    Value = "M",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
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

-- MAIN --
local MainSection = Main:Section({ 
    Title = "Main",
    TextXAlignment = "Left",
    TextSize = 24,
})

local ESPSection = Main:Section({ 
    Title = "ESP",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local ESP = Main:Toggle({
    Title = "Animatronic ESP",
    Desc = "useful for seeing animatronics through walls",
    Icon = "eye",
    Type = "Toggle",
    Default = false,
    Callback = function(state) 
        AnimatronicESP(state)
    end
})

local FPSSection = Main:Section({ 
    Title = "Performance",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local fpsboost = Main:Toggle({
    Title = "Boost FPS",
    Desc = "useful for low end devices",
    Icon = "gauge",
    Type = "Toggle",
    Default = false,
    Callback = function(state) 
        fpsboost(state)
    end
})

-- LOCALPLAYER --
local speedslider

local Speed = Player:Toggle({
    Title = "Speed",
    Desc = "makes you go fast",
    Icon = "chevrons-up",
    Type = "Toggle",
    Default = false,
    Callback = function(state) 
        fpsboost(state)
    end
})

speedslider = Player:Slider({
    Title = "Slider",
    Step = .5,
    Desc = "Default Value: 12",
    Value = {
        Min = 12,
        Max = 100,
        Default = 12,
    },
    Callback = function(value)
        char:FindFirstChildWhichIsA("Humanoid").WalkSpeed = value
    end
})

Window:SelectTab(1)