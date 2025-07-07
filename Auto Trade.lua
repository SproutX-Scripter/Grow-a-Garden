--[[
Vojo Man Auto Trading
Theme: Retro
Colors: Beige (Background), Red (Buttons)
Note: Only supports fruit scanning and trading for now
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Dummy inventory for testing purpose
local mockInventory = {
    Apple = 10,
    Mango = 5,
    Pineapple = 3,
    Banana = 8,
    Watermelon = 1
}

local fruitValues = {
    Apple = 10000,
    Mango = 50000,
    Pineapple = 75000,
    Banana = 30000,
    Watermelon = 100000
}

-- Create GUI
local gui = Instance.new("ScreenGui")
gu i.Name = "VojoManAutoTraderGUI"
gu i.ResetOnSpawn = false
gu i.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(245, 235, 220) -- Beige
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "🍀 Vojo Man Auto Trading"
title.Font = Enum.Font.FredokaOne

title.TextColor3 = Color3.fromRGB(170, 30, 30) -- Red

title.TextScaled = true
title.Parent = mainFrame

-- Target Value Input
local targetBox = Instance.new("TextBox")
targetBox.PlaceholderText = "Target Value (e.g., 50k, 100k)"
targetBox.Position = UDim2.new(0.1, 0, 0.15, 0)
targetBox.Size = UDim2.new(0.8, 0, 0, 35)
targetBox.Text = ""
targetBox.Font = Enum.Font.Gotham
targetBox.TextScaled = true
targetBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
targetBox.TextColor3 = Color3.fromRGB(0, 0, 0)
targetBox.Parent = mainFrame

-- Scan Inventory and Match Fruit
local resultLabel = Instance.new("TextLabel")
resultLabel.Position = UDim2.new(0.1, 0, 0.25, 0)
resultLabel.Size = UDim2.new(0.8, 0, 0, 100)
resultLabel.Text = "Scan result will appear here."
resultLabel.BackgroundTransparency = 1
resultLabel.TextWrapped = true
resultLabel.TextScaled = true
resultLabel.Font = Enum.Font.Gotham\ nresultLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
resultLabel.Parent = mainFrame

local function parseTargetValue(str)
    str = str:lower():gsub(",", ""):gsub("%s", "")
    local num = tonumber(str:match("%d+")) or 0
    if str:find("k") then
        num = num * 1000
    elseif str:find("m") then
        num = num * 1_000_000
    elseif str:find("b") then
        num = num * 1_000_000_000
    end
    return num
end

local function scanAndMatch()
    local target = parseTargetValue(targetBox.Text)
    local result = ""
    for fruit, quantity in pairs(mockInventory) do
        local value = fruitValues[fruit] or 0
        local totalValue = value * quantity
        if totalValue >= target then
            result = result .. fruit .. " x" .. quantity .. " = " .. totalValue .. "\n"
        end
    end
    if result == "" then
        resultLabel.Text = "No suitable fruit matches found."
    else
        resultLabel.Text = "Matching Fruits:\n" .. result
    end
end

local scanBtn = Instance.new("TextButton")
scanBtn.Text = "🔍 Scan Inventory"
scanBtn.Size = UDim2.new(0.8, 0, 0, 40)
scanBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
scanBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40) -- Red
scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
scanBtn.Font = Enum.Font.GothamBold
scanBtn.TextScaled = true
scanBtn.Parent = mainFrame
scanBtn.MouseButton1Click:Connect(scanAndMatch)

-- Placeholder Auto Trade Button (not functional yet)
local tradeBtn = Instance.new("TextButton")
tradeBtn.Text = "🚀 Start Auto Trade"
tradeBtn.Size = UDim2.new(0.8, 0, 0, 40)
tradeBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
tradeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
tradeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tradeBtn.Font = Enum.Font.GothamBold
tradeBtn.TextScaled = true
tradeBtn.Parent = mainFrame
-- future feature hook
