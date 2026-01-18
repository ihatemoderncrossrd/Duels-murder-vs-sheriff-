local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Duels",
    LoadingTitle = "Loading",
    LoadingSubtitle = "",
    ConfigurationSaving = { Enabled = false }
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local LP = Players.LocalPlayer

local function Char()
    return LP.Character or LP.CharacterAdded:Wait()
end

local function Hum()
    return Char():WaitForChild("Humanoid")
end

local function IsEnemy(plr)
    if plr == LP then return false end
    if not plr.Character then return false end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    if LP.Team and plr.Team and LP.Team == plr.Team then return false end
    return true
end

-- Tabs
local PlayerTab  = Window:CreateTab("Player", 4483362458)
local CombatTab  = Window:CreateTab("Combat", 4483362458)
local CreatorTab = Window:CreateTab("Creator", 4483362458)

-- Player
local InfiniteJump = false

PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {10,120},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        Hum().WalkSpeed = v
    end
})

PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = {20,250},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(v)
        Hum().JumpPower = v
    end
})

PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(v)
        InfiniteJump = v
    end
})

UIS.JumpRequest:Connect(function()
    if InfiniteJump then
        Hum():ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Hitbox
local HitboxEnabled = false
local HitboxSize = 10
local HitboxColor = Color3.fromRGB(255,0,0)
local Original = {}

local function Restore(hrp)
    local d = Original[hrp]
    if d then
        hrp.Size = d.Size
        hrp.Transparency = d.Transparency
        hrp.Material = d.Material
        hrp.Color = d.Color
        Original[hrp] = nil
    end
end

CombatTab:CreateToggle({
    Name = "Hitbox",
    CurrentValue = false,
    Callback = function(v)
        HitboxEnabled = v
        if not v then
            for hrp in pairs(Original) do
                if hrp and hrp.Parent then
                    Restore(hrp)
                end
            end
            table.clear(Original)
        end
    end
})

CombatTab:CreateSlider({
    Name = "Size",
    Range = {5,150},
    Increment = 1,
    CurrentValue = 10,
    Callback = function(v)
        HitboxSize = v
    end
})

CombatTab:CreateColorPicker({
    Name = "Color",
    Color = HitboxColor,
    Callback = function(c)
        HitboxColor = c
    end
})

RunService.Heartbeat:Connect(function()
    for _,plr in pairs(Players:GetPlayers()) do
        local char = plr.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        if hrp and hum then
            if hum.Health <= 0 or not HitboxEnabled or not IsEnemy(plr) then
                Restore(hrp)
            else
                if not Original[hrp] then
                    Original[hrp] = {
                        Size = hrp.Size,
                        Transparency = hrp.Transparency,
                        Material = hrp.Material,
                        Color = hrp.Color
                    }
                end
                hrp.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                hrp.Transparency = 0.6
                hrp.Material = Enum.Material.Neon
                hrp.Color = HitboxColor
                hrp.CanCollide = false
            end
        end
    end
end)

-- Creator
CreatorTab:CreateParagraph({
    Title = "Creator",
    Content = "BrayserX\nTelegram: @Brayser_X_Script"
})CombatTab:CreateToggle({
    Name = "Hitbox",
    CurrentValue = false,
    Callback = function(v)
        HitboxEnabled = v
        if not v then
            for hrp in pairs(Original) do
                if hrp and hrp.Parent then
                    Restore(hrp)
                end
            end
            table.clear(Original)
        end
    end
})

CombatTab:CreateSlider({
    Name = "Size",
    Range = {5,35},
    Increment = 1,
    CurrentValue = 10,
    Callback = function(v)
        HitboxSize = v
    end
})

CombatTab:CreateColorPicker({
    Name = "Color",
    Color = HitboxColor,
    Callback = function(c)
        HitboxColor = c
    end
})

RunService.Heartbeat:Connect(function()
    for _,plr in pairs(Players:GetPlayers()) do
        local char = plr.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        if hrp and hum then
            if hum.Health <= 0 or not HitboxEnabled or not IsEnemy(plr) then
                Restore(hrp)
            else
                if not Original[hrp] then
                    Original[hrp] = {
                        Size = hrp.Size,
                        Transparency = hrp.Transparency,
                        Material = hrp.Material,
                        Color = hrp.Color
                    }
                end
                hrp.Size = Vector3.new(HitboxSize,HitboxSize,HitboxSize)
                hrp.Transparency = 0.6
                hrp.Material = Enum.Material.Neon
                hrp.Color = HitboxColor
                hrp.CanCollide = false
            end
        end
    end
end)
