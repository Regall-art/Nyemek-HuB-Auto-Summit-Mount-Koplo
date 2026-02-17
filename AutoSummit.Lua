-- [[ NYEMEK HUB: AUTO SUMMIT & NAME SPOOFER ]] --
-- Fitur: Auto Summit (Mount Koplo) + Nickname Spoofer
-- Target: BoxSpawnSummitA & Nickname Label Spoofing

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

-- [[ UI CONSTRUCTION ]] --
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "NyemekHub_Summit"
sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 400, 0, 250)
Main.Position = UDim2.new(0.5, -200, 0.5, -125)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 125, 255)
Stroke.Thickness = 2

-- Header
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.BorderSizePixel = 0
local HeaderCorner = Instance.new("UICorner", Header)
HeaderCorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Header)
Title.Text = "  NYEMEK HUB | MOUNT KOPLO PROTECT"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Container
local Container = Instance.new("ScrollingFrame", Main)
Container.Position = UDim2.new(0, 10, 0, 50)
Container.Size = UDim2.new(1, -20, 1, -60)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 1.2, 0)
Container.ScrollBarThickness = 0
local UIList = Instance.new("UIListLayout", Container)
UIList.Padding = UDim.new(0, 8)

-- [[ FITUR UTAMA ]] --
local autoSummit = false
local nameSpoof = false

-- 1. FUNGSI AUTO SUMMIT
task.spawn(function()
    while task.wait(0.1) do
        if autoSummit then
            pcall(function()
                -- Sesuai permintaan: Workspace > CheckPoints > BoxSpawnSummitA
                local checkpoint = Workspace:FindFirstChild("CheckPoints")
                local target = checkpoint and checkpoint:FindFirstChild("BoxSpawnSummitA")
                
                if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
                end
            end)
        end
    end
end)

-- 2. FUNGSI NAME SPOOFER (OVERHEAD GUI)
-- Mengganti label Nickname menjadi "Nyemek HuB Protect"
task.spawn(function()
    while task.wait(0.5) do
        if nameSpoof then
            pcall(function()
                -- Mencari label Nickname di dalam Character
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("TextLabel") and (v.Name == "Nickname" or v.Name:lower():find("name")) then
                        v.Text = "Nyemek HuB Protect"
                        v.TextColor3 = Color3.fromRGB(0, 255, 255) -- Warna neon agar keren
                    end
                end
            end)
        end
    end
end)

-- [[ UI BUILDER ]] --
local function CreateToggle(text, callback)
    local state = false
    local Btn = Instance.new("TextButton", Container)
    Btn.Size = UDim2.new(1, 0, 0, 45)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Btn.Text = "  " .. text .. ": [ OFF ]"
    Btn.TextColor3 = Color3.fromRGB(255, 50, 50)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.Text = "  " .. text .. ": [ " .. (state and "ON" or "OFF") .. " ]"
        Btn.TextColor3 = state and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
        callback(state)
    end)
end

-- Menambahkan Fitur ke UI
CreateToggle("AUTO SUMMIT (BOXSPAWN)", function(v)
    autoSummit = v
end)

CreateToggle("NAME SPOOFER (PROTECT)", function(v)
    nameSpoof = v
end)

-- [[ DRAGGABLE SYSTEM ]] --
local dragging, dragInput, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

print("Nyemek HuB: Auto Summit & Name Spoofer Ready!")
