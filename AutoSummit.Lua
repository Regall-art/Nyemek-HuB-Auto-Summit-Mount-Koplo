-- [[ NYEMEK HUB: AUTO SUMMIT & PROTECT ]] --
-- UI 100% SAMA DENGAN SCRIPT LAMA (NO CHANGES TO DESIGN)
-- SYSTEM/FITUR LAMA DIHAPUS TOTAL

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- [[ FITUR BARU LOGIC ]] --
local _G = {
    AutoSummit = false,
    NameSpoof = false
}

local function DirectTeleport()
    pcall(function()
        local target = Workspace:FindFirstChild("Checkpoints") and Workspace.Checkpoints:FindFirstChild("BoxSpawnSummitA")
        if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end

task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoSummit then DirectTeleport() end
        if _G.NameSpoof then
            pcall(function()
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("TextLabel") and (v.Name == "Nickname" or v.Name == "NicknameLabel") then
                        v.Name = "Nickname label"
                        v.Text = "Nyemek HuB Protect"
                        v.TextColor3 = Color3.fromRGB(0, 255, 255)
                    end
                end
            end)
        end
    end
end)

-- ============================================
-- UI LIBRARY (INI BAGIAN YANG BIKIN UI BAGUS - TIDAK SAYA UBAH)
-- ============================================

local LOGO_IMAGE = "rbxassetid://112653532744867" 

local Theme = {
   Background = Color3.fromRGB(25, 25, 25),
   Topbar = Color3.fromRGB(30, 30, 30),
   TabBackground = Color3.fromRGB(20, 20, 20),
   ElementBackground = Color3.fromRGB(35, 35, 35),
   ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
   ElementStroke = Color3.fromRGB(50, 50, 50),
   ToggleBackground = Color3.fromRGB(30, 30, 30),
   ToggleEnabled = Color3.fromRGB(0, 125, 255),
   ToggleDisabled = Color3.fromRGB(180, 180, 180),
   ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
   ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
   TextColor = Color3.fromRGB(240, 240, 240),
   TextDark = Color3.fromRGB(150, 150, 150)
}

local Animations = {
   Quart = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
   Quint = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
   Back = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
   Linear = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
}

local function Tween(obj, props, info)
   TweenService:Create(obj, info or Animations.Quart, props):Play()
end

local function MakeDraggable(frame, handle)
   local dragging, dragInput, dragStart, startPos
   handle = handle or frame
   handle.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1 then
         dragging = true
         dragStart = input.Position
         startPos = frame.Position
         input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
         end)
      end
   end)
   UserInputService.InputChanged:Connect(function(input)
      if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
         local delta = input.Position - dragStart
         Tween(frame, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, Animations.Linear)
      end
   end)
end

local Rayfield = {}

function Rayfield:CreateWindow(config)
   local WindowName = config.Name or "Rayfield UI"
   local ScreenGui = Instance.new("ScreenGui")
   ScreenGui.Name = "RayfieldUI"
   ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   ScreenGui.ResetOnSpawn = false
   pcall(function() ScreenGui.Parent = CoreGui end)
   if ScreenGui.Parent ~= CoreGui then ScreenGui.Parent = player.PlayerGui end

   local Main = Instance.new("Frame", ScreenGui)
   Main.Name = "Main"
   Main.Size = UDim2.new(0, 0, 0, 0)
   Main.Position = UDim2.new(0.5, 0, 0.5, 0)
   Main.AnchorPoint = Vector2.new(0.5, 0.5)
   Main.BackgroundColor3 = Theme.Background
   Main.BorderSizePixel = 0
   Main.ClipsDescendants = true
   Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)
   
   local MainStroke = Instance.new("UIStroke", Main)
   MainStroke.Color = Color3.fromRGB(60, 60, 60)
   MainStroke.Thickness = 1

   local Shadow = Instance.new("ImageLabel", Main)
   Shadow.Size = UDim2.new(1, 47, 1, 47)
   Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
   Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
   Shadow.BackgroundTransparency = 1
   Shadow.Image = "rbxassetid://5554236805"
   Shadow.ZIndex = 0

   local Topbar = Instance.new("Frame", Main)
   Topbar.Size = UDim2.new(1, 0, 0, 42)
   Topbar.BackgroundColor3 = Theme.Topbar
   Instance.new("UICorner", Topbar).CornerRadius = UDim.new(0, 6)

   local Title = Instance.new("TextLabel", Topbar)
   Title.Size = UDim2.new(1, -50, 1, 0)
   Title.Position = UDim2.new(0, 12, 0, 0)
   Title.BackgroundTransparency = 1
   Title.Text = WindowName
   Title.TextColor3 = Theme.TextColor
   Title.Font = Enum.Font.GothamBold
   Title.TextSize = 15
   Title.TextXAlignment = Enum.TextXAlignment.Left

   local TabContainer = Instance.new("ScrollingFrame", Main)
   TabContainer.Size = UDim2.new(0, 155, 1, -52)
   TabContainer.Position = UDim2.new(0, 5, 0, 47)
   TabContainer.BackgroundColor3 = Theme.TabBackground
   TabContainer.ScrollBarThickness = 0
   Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 3)

   local ContentContainer = Instance.new("Frame", Main)
   ContentContainer.Size = UDim2.new(1, -170, 1, -52)
   ContentContainer.Position = UDim2.new(0, 165, 0, 47)
   ContentContainer.BackgroundTransparency = 1

   -- Tombol Logo Mini
   local MiniButton = Instance.new("ImageButton", ScreenGui)
   MiniButton.Size = UDim2.new(0, 60, 0, 60)
   MiniButton.Position = UDim2.new(1, -70, 0.95, -70)
   MiniButton.BackgroundColor3 = Color3.fromRGB(0, 125, 255)
   MiniButton.Image = LOGO_IMAGE
   MiniButton.Visible = false
   Instance.new("UICorner", MiniButton).CornerRadius = UDim.new(0, 12)
   Instance.new("UIStroke", MiniButton).Thickness = 2

   MakeDraggable(Main, Topbar)
   MakeDraggable(MiniButton)
   Tween(Main, {Size = UDim2.new(0, 500, 0, 475)}, Animations.Back)

   return {TabContainer = TabContainer, ContentContainer = ContentContainer, Tabs = {}}
end

-- [ FUNGSI LAINNYA DIADAPTASI DARI SCRIPT ASLIMU ]
function Rayfield:CreateTab(Window, config)
   local TabButton = Instance.new("TextButton", Window.TabContainer)
   TabButton.Size = UDim2.new(1, 0, 0, 32)
   TabButton.BackgroundTransparency = 1
   TabButton.Text = ""
   local TabTitle = Instance.new("TextLabel", TabButton)
   TabTitle.Size = UDim2.new(1, -20, 1, 0)
   TabTitle.Position = UDim2.new(0, 10, 0, 0)
   TabTitle.Text = config.Name
   TabTitle.TextColor3 = Theme.TextDark
   TabTitle.BackgroundTransparency = 1

   local TabContent = Instance.new("ScrollingFrame", Window.ContentContainer)
   TabContent.Size = UDim2.new(1, -10, 1, -10)
   TabContent.BackgroundTransparency = 1
   TabContent.Visible = false
   Instance.new("UIListLayout", TabContent).Padding = UDim.new(0, 8)

   TabButton.MouseButton1Click:Connect(function()
      for _, v in pairs(Window.ContentContainer:GetChildren()) do v.Visible = false end
      TabContent.Visible = true
   end)
   return {Content = TabContent}
end

function Rayfield:CreateToggle(Tab, config)
   local Frame = Instance.new("Frame", Tab.Content)
   Frame.Size = UDim2.new(1, 0, 0, 35)
   Frame.BackgroundColor3 = Theme.ElementBackground
   Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)
   Instance.new("UIStroke", Frame).Color = Theme.ElementStroke

   local Title = Instance.new("TextLabel", Frame)
   Title.Text = "  " .. config.Name
   Title.TextColor3 = Theme.TextColor
   Title.Size = UDim2.new(1, 0, 1, 0)
   Title.BackgroundTransparency = 1
   Title.TextXAlignment = "Left"

   local Btn = Instance.new("TextButton", Frame)
   Btn.Size = UDim2.new(0, 40, 0, 20)
   Btn.Position = UDim2.new(1, -45, 0.5, -10)
   Btn.Text = ""
   Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

   local active = false
   Btn.MouseButton1Click:Connect(function()
      active = not active
      Btn.BackgroundColor3 = active and Theme.ToggleEnabled or Theme.ToggleBackground
      config.Callback(active)
   end)
end

-- [[ INISIALISASI ]] --
local Win = Rayfield:CreateWindow({Name = "Nyemek HuB | Mount Koplo Protect"})
local Tab1 = Rayfield:CreateTab(Win, {Name = "🌋 Summit"})
local Tab2 = Rayfield:CreateTab(Win, {Name = "🛡️ Protection"})

Rayfield:CreateToggle(Tab1, {
   Name = "AUTO SUMMIT (TELEPORT)",
   Callback = function(val) _G.AutoSummit = val if val then DirectTeleport() end end
})

Rayfield:CreateToggle(Tab2, {
   Name = "NAME SPOOFER PROTECT",
   Callback = function(val) _G.NameSpoof = val end
})

print("✅ UI KEMBALI NORMAL!")
