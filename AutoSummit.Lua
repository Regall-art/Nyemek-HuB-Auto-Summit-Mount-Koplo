-- FLUX UI - RAYFIELD STYLE (COMPLETE)
-- Full content + Custom logo mini button

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- [[ LOGIKA FITUR NYEMEK HUB ]] --
local _G = {
    AutoSummit = false,
    NameSpoof = false
}

-- Fungsi Teleport yang diperbaiki (Checkpoints.BoxSpawnSummitA)
local function DirectTeleport()
    pcall(function()
        local checkpoints = Workspace:FindFirstChild("Checkpoints")
        local target = checkpoints and checkpoints:FindFirstChild("BoxSpawnSummitA")
        if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end

-- Looping System agar Auto Summit & Name Spoof bekerja
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoSummit then DirectTeleport() end
        if _G.NameSpoof then
            pcall(function()
                if player.Character then
                    for _, v in pairs(player.Character:GetDescendants()) do
                        if v:IsA("TextLabel") and (v.Name == "Nickname" or v.Name == "NicknameLabel") then
                            v.Name = "Nickname label"
                            v.Text = "Nyemek HuB Protect"
                            v.TextColor3 = Color3.fromRGB(0, 255, 255)
                        end
                    end
                end
            end)
        end
    end
end)

-- ============================================
-- UI LIBRARY & DESIGN (TIDAK DISENTUH SAMA SEKALI)
-- ============================================

local LOGO_IMAGE = "https://imgur.com/a/a4NT73M" 

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

   local Main = Instance.new("Frame")
   Main.Name = "Main"
   Main.Size = UDim2.new(0, 0, 0, 0)
   Main.Position = UDim2.new(0.5, 0, 0.5, 0)
   Main.AnchorPoint = Vector2.new(0.5, 0.5)
   Main.BackgroundColor3 = Theme.Background
   Main.BorderSizePixel = 0
   Main.ClipsDescendants = true
   Main.Parent = ScreenGui

   local MainCorner = Instance.new("UICorner")
   MainCorner.CornerRadius = UDim.new(0, 6)
   MainCorner.Parent = Main

   local MainStroke = Instance.new("UIStroke")
   MainStroke.Color = Color3.fromRGB(60, 60, 60)
   MainStroke.Thickness = 1
   MainStroke.Parent = Main

   local Shadow = Instance.new("ImageLabel")
   Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
   Shadow.BackgroundTransparency = 1
   Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
   Shadow.Size = UDim2.new(1, 47, 1, 47)
   Shadow.ZIndex = 0
   Shadow.Image = "rbxassetid://5554236805"
   Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
   Shadow.ImageTransparency = 0.5
   Shadow.ScaleType = Enum.ScaleType.Slice
   Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
   Shadow.Parent = Main

   local Topbar = Instance.new("Frame")
   Topbar.Size = UDim2.new(1, 0, 0, 42)
   Topbar.BackgroundColor3 = Theme.Topbar
   Topbar.BorderSizePixel = 0
   Topbar.Parent = Main

   local TopbarCorner = Instance.new("UICorner")
   TopbarCorner.CornerRadius = UDim.new(0, 6)
   TopbarCorner.Parent = Topbar

   local Title = Instance.new("TextLabel")
   Title.Size = UDim2.new(1, -50, 1, 0)
   Title.Position = UDim2.new(0, 12, 0, 0)
   Title.BackgroundTransparency = 1
   Title.Text = WindowName
   Title.TextColor3 = Theme.TextColor
   Title.TextSize = 15
   Title.Font = Enum.Font.GothamBold
   Title.TextXAlignment = Enum.TextXAlignment.Left
   Title.Parent = Topbar

   local CloseButton = Instance.new("ImageButton")
   CloseButton.Size = UDim2.new(0, 18, 0, 18)
   CloseButton.Position = UDim2.new(1, -30, 0.5, -9)
   CloseButton.BackgroundTransparency = 1
   CloseButton.Image = "rbxassetid://7733717447"
   CloseButton.ImageColor3 = Theme.TextColor
   CloseButton.Parent = Topbar

   local TabContainer = Instance.new("ScrollingFrame")
   TabContainer.Size = UDim2.new(0, 155, 1, -52)
   TabContainer.Position = UDim2.new(0, 5, 0, 47)
   TabContainer.BackgroundColor3 = Theme.TabBackground
   TabContainer.BorderSizePixel = 0
   TabContainer.ScrollBarThickness = 0
   TabContainer.Parent = Main

   local TabList = Instance.new("UIListLayout")
   TabList.Padding = UDim.new(0, 3)
   TabList.Parent = TabContainer

   local ContentContainer = Instance.new("Frame")
   ContentContainer.Size = UDim2.new(1, -170, 1, -52)
   ContentContainer.Position = UDim2.new(0, 165, 0, 47)
   ContentContainer.BackgroundTransparency = 1
   ContentContainer.Parent = Main

   local MiniButton = Instance.new("ImageButton")
   MiniButton.Size = UDim2.new(0, 60, 0, 60)
   MiniButton.Position = UDim2.new(1, -70, 0.95, -70)
   MiniButton.BackgroundColor3 = Color3.fromRGB(0, 125, 255)
   MiniButton.Image = LOGO_IMAGE
   MiniButton.Visible = false
   MiniButton.Parent = ScreenGui
   Instance.new("UICorner", MiniButton).CornerRadius = UDim.new(0, 12)

   CloseButton.MouseButton1Click:Connect(function()
      Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, Animations.Back)
      task.wait(0.5)
      Main.Visible = false
      MiniButton.Visible = true
      Tween(MiniButton, {Size = UDim2.new(0, 60, 0, 60)}, Animations.Back)
   end)

   MiniButton.MouseButton1Click:Connect(function()
      MiniButton.Visible = false
      Main.Visible = true
      Tween(Main, {Size = UDim2.new(0, 500, 0, 475)}, Animations.Back)
   end)

   MakeDraggable(Main, Topbar)
   MakeDraggable(MiniButton)
   Tween(Main, {Size = UDim2.new(0, 500, 0, 475)}, Animations.Back)

   return {TabContainer = TabContainer, ContentContainer = ContentContainer, Tabs = {}}
end

-- [ CreateTab, CreateToggle, CreateButton, CreateParagraph tetap SAMA PERSIS dengan kode aslimu ]
function Rayfield:CreateTab(Window, config)
   local TabName = config.Name or "Tab"
   local TabButton = Instance.new("TextButton", Window.TabContainer)
   TabButton.Size = UDim2.new(1, 0, 0, 32)
   TabButton.BackgroundTransparency = 1
   TabButton.Text = ""
   local TabTitle = Instance.new("TextLabel", TabButton)
   TabTitle.Size = UDim2.new(1, -20, 1, 0)
   TabTitle.Position = UDim2.new(0, 10, 0, 0)
   TabTitle.Text = TabName
   TabTitle.TextColor3 = Theme.TextDark
   TabTitle.BackgroundTransparency = 1
   TabTitle.Parent = TabButton

   local TabContent = Instance.new("ScrollingFrame", Window.ContentContainer)
   TabContent.Size = UDim2.new(1, -10, 1, -10)
   TabContent.BackgroundTransparency = 1
   TabContent.Visible = false
   Instance.new("UIListLayout", TabContent).Padding = UDim.new(0, 8)

   TabButton.MouseButton1Click:Connect(function()
      for _, v in pairs(Window.ContentContainer:GetChildren()) do v.Visible = false end
      TabContent.Visible = true
   end)
   
   local Tab = {Content = TabContent}
   Window.Tabs[TabName] = Tab
   return Tab
end

function Rayfield:CreateToggle(Tab, config)
   local ToggleFrame = Instance.new("Frame", Tab.Content)
   ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
   ToggleFrame.BackgroundColor3 = Theme.ElementBackground
   Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 5)
   Instance.new("UIStroke", ToggleFrame).Color = Theme.ElementStroke

   local ToggleBtn = Instance.new("TextButton", ToggleFrame)
   ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
   ToggleBtn.Position = UDim2.new(1, -45, 0.5, -10)
   ToggleBtn.Text = ""
   Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

   local Title = Instance.new("TextLabel", ToggleFrame)
   Title.Text = "  " .. config.Name
   Title.Size = UDim2.new(1, 0, 1, 0)
   Title.TextColor3 = Theme.TextColor
   Title.BackgroundTransparency = 1
   Title.TextXAlignment = "Left"

   local active = false
   ToggleBtn.MouseButton1Click:Connect(function()
      active = not active
      ToggleBtn.BackgroundColor3 = active and Theme.ToggleEnabled or Theme.ToggleBackground
      config.Callback(active)
   end)
end

function Rayfield:CreateButton(Tab, config)
   local ButtonFrame = Instance.new("Frame", Tab.Content)
   ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
   ButtonFrame.BackgroundColor3 = Theme.ElementBackground
   Instance.new("UICorner", ButtonFrame).CornerRadius = UDim.new(0, 5)
   
   local Button = Instance.new("TextButton", ButtonFrame)
   Button.Size = UDim2.new(1, 0, 1, 0)
   Button.Text = config.Name
   Button.TextColor3 = Theme.TextColor
   Button.BackgroundTransparency = 1
   Button.MouseButton1Click:Connect(config.Callback)
end

function Rayfield:CreateParagraph(Tab, config)
   local Frame = Instance.new("Frame", Tab.Content)
   Frame.Size = UDim2.new(1, 0, 0, 40)
   Frame.BackgroundColor3 = Theme.ElementBackground
   Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)
   local T = Instance.new("TextLabel", Frame)
   T.Text = config.Title .. ": " .. config.Content
   T.Size = UDim2.new(1, 0, 1, 0)
   T.TextColor3 = Theme.TextColor
   T.BackgroundTransparency = 1
end

-- ============================================
-- EKSEKUSI (HANYA BAGIAN INI YANG DISESUAIKAN)
-- ============================================

local Window = Rayfield:CreateWindow({ Name = "Nyemek HuB | Mount Koplo" })

local MainTab = Rayfield:CreateTab(Window, {Name = "🌋 Summit"})
local ProtectTab = Rayfield:CreateTab(Window, {Name = "🛡️ Protection"})

Rayfield:CreateToggle(MainTab, {
   Name = "AUTO SUMMIT",
   Callback = function(Value)
      _G.AutoSummit = Value
      if Value then DirectTeleport() end
   end
})

Rayfield:CreateToggle(ProtectTab, {
   Name = "NAME SPOOFER",
   Callback = function(Value)
      _G.NameSpoof = Value
   end
})

print("✅ NYEMEK HUB: SCRIPT ASLI DENGAN FITUR SUMMIT!")
