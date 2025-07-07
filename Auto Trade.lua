-- Vojo Man Auto Trading UI + Functional Auto Fruit Trader
-- Theme: Retro Beige and Red | Game: Grow A Garden | Author: ChatGPT + User

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- SETTINGS --
local TARGET_PLAYER_NAME = ""  -- You can change this or make it dynamic later
local AUTO_TRADE = false
local TRADE_INTERVAL = 3  -- seconds

-- UI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VojoManAutoTrading"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.02, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(245, 233, 211)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
title.TextColor3 = Color3.new(1, 1, 1)
title.Text = "Vojo Man Auto Trading"
title.Font = Enum.Font.FredokaOne
title.TextScaled = true
title.Parent = frame

-- Target Input
local targetBox = Instance.new("TextBox")
targetBox.PlaceholderText = "Target player name"
targetBox.Size = UDim2.new(1, -20, 0, 25)
targetBox.Position = UDim2.new(0, 10, 0, 40)
targetBox.Text = ""
targetBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
targetBox.TextColor3 = Color3.new(0, 0, 0)
targetBox.Font = Enum.Font.Gotham
targetBox.TextScaled = true
targetBox.Parent = frame

targetBox.FocusLost:Connect(function()
    TARGET_PLAYER_NAME = targetBox.Text
end)

-- Toggle Auto
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -20, 0, 30)
toggleBtn.Position = UDim2.new(0, 10, 0, 75)
toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Text = "Auto Trade: OFF"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextScaled = true
toggleBtn.Parent = frame

toggleBtn.MouseButton1Click:Connect(function()
    AUTO_TRADE = not AUTO_TRADE
    toggleBtn.Text = "Auto Trade: " .. (AUTO_TRADE and "ON" or "OFF")
end)

-- Status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 115)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(70, 70, 70)
statusLabel.Text = "Status: Idle"
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextScaled = true
statusLabel.Parent = frame

-- Core: Find and Trade Fruit
local function findFruitInInventory()
    local inv = LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:WaitForChild("Backpack")
    for _, item in pairs(inv:GetChildren()) do
        if item:IsA("Tool") and item.Name:lower():find("fruit") then
            return item
        end
    end
    return nil
end

local function findPlayerByName(name)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Name:lower():find(name:lower()) then
            return plr
        end
    end
    return nil
end

local function tradeFruit()
    local fruit = findFruitInInventory()
    local target = findPlayerByName(TARGET_PLAYER_NAME)

    if fruit and target then
        -- Example trade function (adjust to actual game logic):
        local event = ReplicatedStorage:FindFirstChild("TradeRequest")
        if event then
            event:FireServer(target, fruit)
            statusLabel.Text = "Status: Traded " .. fruit.Name .. " to " .. target.Name
        else
            statusLabel.Text = "Status: Trade event not found"
        end
    else
        statusLabel.Text = "Status: No fruit or target"
    end
end

-- Loop
task.spawn(function()
    while true do
        if AUTO_TRADE and TARGET_PLAYER_NAME ~= "" then
            tradeFruit()
        end
        task.wait(TRADE_INTERVAL)
    end
end)

-- End of Script
