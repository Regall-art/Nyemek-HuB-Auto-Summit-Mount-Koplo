-- [[ NYEMEK HUB: AUTO SUMMIT & NAME PROTECT ]] --
-- 100% MENGGUNAKAN DESIGN & LIBRARY ASLIMU
-- HANYA MENGGANTI ISI TAB DAN TOMBOL

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- [[ LOGIKA FITUR BARU ]] --
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
-- CUSTOM LOGO URL (ASLI DARI SCRIPT KAMU)
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
   Title.TextSize = 15
   Title.Font = Enum.Font.GothamBold
   Title.TextXAlignment = Enum.TextXAlignment.Left

   local CloseButton = Instance.new("ImageButton", Topbar)
   CloseButton.Size = UDim2.new(0, 18, 0, 18)
   CloseButton.Position = UDim2.new(1, -30, 0.5, -9)
   CloseButton.BackgroundTransparency = 1
   CloseButton.Image = "rbxassetid://7733717447"
   CloseButton.ImageColor3 = Theme.TextColor

   local TabContainer = Instance.new("ScrollingFrame", Main)
   TabContainer.Size = UDim2.new(0, 155, 1, -52)
   TabContainer.Position = UDim2.new(0, 5, 0, 47)
   TabContainer.BackgroundColor3 = Theme.TabBackground
   TabContainer.ScrollBarThickness = 0
   Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 3)
   Instance.new("UIPadding", TabContainer).PaddingTop = UDim.new(0, 5)

   local ContentContainer = Instance.new("Frame", Main)
   ContentContainer.Size = UDim2.new(1, -170, 1, -52)
   ContentContainer.Position = UDim2.new(0, 165, 0, 47)
   ContentContainer.BackgroundTransparency = 1

   local MiniButton = Instance.new("ImageButton", ScreenGui)
   MiniButton.Size = UDim2.new(0, 60, 0, 60)
   MiniButton.Position = UDim2.new(1, -70, 0.95, -70)
   MiniButton.BackgroundColor3 = Color3.fromRGB(0, 125, 255)
   MiniButton.Image = LOGO_IMAGE
   MiniButton.Visible = false
   Instance.new("UICorner", MiniButton).CornerRadius = UDim.new(0, 12)
   local MiniStroke = Instance.new("UIStroke", MiniButton)
   MiniStroke.Color = Color3.fromRGB(0, 170, 255)
   MiniStroke.Thickness = 2

   CloseButton.MouseButton1Click:Connect(function()
      Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, Animations.Back)
      task.wait(0.5)
      Main.Visible = false
      MiniButton.Visible = true
      Tween(MiniButton, {Size = UDim2.new(0, 60, 0, 60)}, Animations.Back)
   end)

   MiniButton.MouseButton1Click:Connect(function()
      Tween(MiniButton, {Size = UDim2.new(0, 0, 0, 0)}, Animations.Quart)
      task.wait(0.3)
      MiniButton.Visible = false
      Main.Visible = true
      Tween(Main, {Size = UDim2.new(0, 500, 0, 475)}, Animations.Back)
   end)

   MakeDraggable(Main, Topbar)
   MakeDraggable(MiniButton)
   Tween(Main, {Size = UDim2.new(0, 500, 0, 475)}, Animations.Back)

   return {Main = Main, TabContainer = TabContainer, ContentContainer = ContentContainer, Tabs = {}, CurrentTab = nil}
end

function Rayfield:CreateTab(Window, config)
   local TabName = config.Name or "Tab"
   local TabButton = Instance.new("TextButton", Window.TabContainer)
   TabButton.Size = UDim2.new(1, 0, 0, 32)
   TabButton.BackgroundTransparency = 1
   TabButton.Text = ""
   
   local TabTitle = Instance.new("TextLabel", TabButton)
   TabTitle.Size = UDim2.new(1, -20, 1, 0)
   TabTitle.Position = UDim2.new(0, 10, 0, 0)
   TabTitle.BackgroundTransparency = 1
   TabTitle.Text = TabName
   TabTitle.TextColor3 = Theme.TextDark
   TabTitle.Font = Enum.Font.GothamMedium

   local TabContent = Instance.new("ScrollingFrame", Window.ContentContainer)
   TabContent.Size = UDim2.new(1, -10, 1, -10)
   TabContent.BackgroundTransparency = 1
   TabContent.ScrollBarThickness = 3
   TabContent.Visible = false
   Instance.new("UIListLayout", TabContent).Padding = UDim.new(0, 8)

   TabButton.MouseButton1Click:Connect(function()
      for _, v in pairs(Window.Tabs) do v.Content.Visible = false v.Title.TextColor3 = Theme.TextDark end
      TabContent.Visible = true
      TabTitle.TextColor3 = Theme.TextColor
      Window.CurrentTab = TabName
   end)

   local Tab = {Content = TabContent, Title = TabTitle}
   Window.Tabs[TabName] = Tab
   if not Window.CurrentTab then TabContent.Visible = true TabTitle.TextColor3 = Theme.TextColor Window.CurrentTab = TabName end
   return Tab
end

function Rayfield:CreateToggle(Tab, config)
   local ToggleFrame = Instance.new("Frame", Tab.Content)
   ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
   ToggleFrame.BackgroundColor3 = Theme.ElementBackground
   Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 5)
   Instance.new("UIStroke", ToggleFrame).Color = Theme.ElementStroke

   local ToggleTitle = Instance.new("TextLabel", ToggleFrame)
   ToggleTitle.Size = UDim2.new(1, -60, 1, 0)
   ToggleTitle.Position = UDim2.new(0, 10, 0, 0)
   ToggleTitle.BackgroundTransparency = 1
   ToggleTitle.Text = config.Name
   ToggleTitle.TextColor3 = Theme.TextColor
   ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

   local ToggleBtn = Instance.new("TextButton", ToggleFrame)
   ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
   ToggleBtn.Position = UDim2.new(1, -45, 0.5, -10)
   ToggleBtn.BackgroundColor3 = Theme.ToggleBackground
   ToggleBtn.Text = ""
   Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
   local Stroke2 = Instance.new("UIStroke", ToggleBtn)
   Stroke2.Color = Theme.ToggleDisabledStroke

   local Indicator = Instance.new("Frame", ToggleBtn)
   Indicator.Size = UDim2.new(0, 16, 0, 16)
   Indicator.Position = UDim2.new(0, 2, 0.5, -8)
   Indicator.BackgroundColor3 = Theme.ToggleDisabled
   Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

   local toggled = config.CurrentValue or false
   local function Update()
      if toggled then
         Tween(Indicator, {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Theme.ToggleEnabled})
         Tween(Stroke2, {Color = Theme.ToggleEnabledStroke})
      else
         Tween(Indicator, {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Theme.ToggleDisabled})
         Tween(Stroke2, {Color = Theme.ToggleDisabledStroke})
      end
   end
   Update()

   ToggleBtn.MouseButton1Click:Connect(function()
      toggled = not toggled
      Update()
      config.Callback(toggled)
   end)
end

function Rayfield:CreateButton(Tab, config)
   local ButtonFrame = Instance.new("Frame", Tab.Content)
   ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
   ButtonFrame.BackgroundColor3 = Theme.ElementBackground
   Instance.new("UICorner", ButtonFrame).CornerRadius = UDim.new(0, 5)
   Instance.new("UIStroke", ButtonFrame).Color = Theme.ElementStroke

   local Button = Instance.new("TextButton", ButtonFrame)
   Button.Size = UDim2.new(1, 0, 1, 0)
   Button.BackgroundTransparency = 1
   Button.Text = config.Name
   Button.TextColor3 = Theme.TextColor
   Button.Font = Enum.Font.Gotham
   Button.MouseButton1Click:Connect(config.Callback)
end

function Rayfield:CreateParagraph(Tab, config)
   local Frame = Instance.new("Frame", Tab.Content)
   Frame.Size = UDim2.new(1, 0, 0, 0)
   Frame.AutomaticSize = Enum.AutomaticSize.Y
   Frame.BackgroundColor3 = Theme.ElementBackground
   Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)
   Instance.new("UIStroke", Frame).Color = Theme.ElementStroke
   
   local T = Instance.new("TextLabel", Frame)
   T.Size = UDim2.new(1, -20, 0, 20)
   T.Position = UDim2.new(0, 10, 0, 5)
   T.Text = config.Title
   T.TextColor3 = Theme.TextColor
   T.Font = Enum.Font.GothamBold
   T.BackgroundTransparency = 1
   T.TextXAlignment = "Left"

   local C = Instance.new("TextLabel", Frame)
   C.Size = UDim2.new(1, -20, 0, 0)
   C.Position = UDim2.new(0, 10, 0, 25)
   C.AutomaticSize = Enum.AutomaticSize.Y
   C.Text = config.Content
   C.TextColor3 = Theme.TextDark
   C.BackgroundTransparency = 1
   C.TextWrapped = true
   C.TextXAlignment = "Left"
end

-- ============================================
-- EKSEKUSI MENU (TAB & BUTTON BARU)
-- ============================================

local Window = Rayfield:CreateWindow({ Name = "Nyemek HuB | Mount Koplo Protect" })

local MainTab = Rayfield:CreateTab(Window, {Name = "🌋 Summit"})
local ProtectTab = Rayfield:CreateTab(Window, {Name = "🛡️ Protection"})

Rayfield:CreateParagraph(MainTab, {
   Title = "Auto Summit System",
   Content = "Fungsi ini akan membuat anda teleport terus menerus ke puncak (BoxSpawnSummitA)."
})

Rayfield:CreateToggle(MainTab, {
   Name = "AUTO SUMMIT (ON/OFF)",
   Callback = function(v) _G.AutoSummit = v end
})

Rayfield:CreateButton(MainTab, {
   Name = "INSTANT TELEPORT ONCE",
   Callback = function() DirectTeleport() end
})

Rayfield:CreateToggle(ProtectTab, {
   Name = "NAME SPOOFER PROTECT",
   Callback = function(v) _G.NameSpoof = v end
})

print("✅ NYEMEK HUB LOADED WITH ORIGINAL DESIGN!")
