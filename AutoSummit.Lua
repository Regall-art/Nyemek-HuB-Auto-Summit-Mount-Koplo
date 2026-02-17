-- [[ NYEMEK HUB - AUTO SUMMIT & NAME PROTECT ]] --
-- UI LAMA (RAYFIELD STYLE) TETAP DIGUNAKAN
-- FITUR FPS LAMA DIHAPUS, DIGANTI TOTAL SESUAI REQUEST

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- ============================================
-- CUSTOM LOGO (TETAP SAMA)
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

-- [[ GLOBAL VARIABLE ]] --
local _G = {
    AutoSummit = false,
    NameSpoof = false
}

-- ============================================
-- CORE LOGIC (TELEPORT & PROTECT)
-- ============================================

local function DirectTeleport()
    pcall(function()
        -- FIX PATH: Workspace > Checkpoints > BoxSpawnSummitA
        local target = Workspace:FindFirstChild("Checkpoints") and Workspace.Checkpoints:FindFirstChild("BoxSpawnSummitA")
        if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end

-- Loop System untuk Teleport & Spoofing Nama
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoSummit then 
            DirectTeleport() 
        end
        
        if _G.NameSpoof then
            pcall(function()
                if player.Character then
                    for _, v in pairs(player.Character:GetDescendants()) do
                        -- Mencari label "Nickname" sesuai permintaan
                        if v:IsA("TextLabel") and (v.Name == "Nickname" or v.Name == "NicknameLabel") then
                            v.Name = "Nickname label" -- Mengganti nama UI labelnya
                            v.Text = "Nyemek HuB Protect" -- Mengganti teks tampilannya
                            v.TextColor3 = Color3.fromRGB(0, 255, 255)
                        end
                    end
                end
            end)
        end
    end
end)

-- ============================================
-- UI LIBRARY (YOUR OLD UI CODE)
-- ============================================

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

   local ContentContainer = Instance.new("Frame", Main)
   ContentContainer.Size = UDim2.new(1, -170, 1, -52)
   ContentContainer.Position = UDim2.new(0, 165, 0, 47)
   ContentContainer.BackgroundTransparency = 1

   -- Mini Button (Logo Button)
   local MiniButton = Instance.new("ImageButton", ScreenGui)
   MiniButton.Size = UDim2.new(0, 60, 0, 60)
   MiniButton.Position = UDim2.new(1, -70, 0.95, -70)
   MiniButton.BackgroundColor3 = Color3.fromRGB(0, 125, 255)
   MiniButton.Image = LOGO_IMAGE
   MiniButton.ScaleType = Enum.ScaleType.Fit
   MiniButton.Visible = false
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

   return {TabContainer = TabContainer, ContentContainer = ContentContainer, Tabs = {}, CurrentTab = nil}
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
   ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
   ToggleFrame.BackgroundColor3 = Theme.ElementBackground
   Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 5)

   local Title = Instance.new("TextLabel", ToggleFrame)
   Title.Size = UDim2.new(1, -60, 1, 0)
   Title.Position = UDim2.new(0, 10, 0, 0)
   Title.BackgroundTransparency = 1
   Title.Text = config.Name
   Title.TextColor3 = Theme.TextColor
   Title.TextXAlignment = Enum.TextXAlignment.Left

   local Btn = Instance.new("TextButton", ToggleFrame)
   Btn.Size = UDim2.new(0, 40, 0, 20)
   Btn.Position = UDim2.new(1, -45, 0.5, -10)
   Btn.BackgroundColor3 = Theme.ToggleBackground
   Btn.Text = ""
   Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

   local active = config.CurrentValue or false
   Btn.MouseButton1Click:Connect(function()
      active = not active
      Btn.BackgroundColor3 = active and Theme.ToggleEnabled or Theme.ToggleBackground
      config.Callback(active)
   end)
end

function Rayfield:CreateButton(Tab, config)
   local BtnFrame = Instance.new("Frame", Tab.Content)
   BtnFrame.Size = UDim2.new(1, 0, 0, 35)
   BtnFrame.BackgroundColor3 = Theme.ElementBackground
   Instance.new("UICorner", BtnFrame).CornerRadius = UDim.new(0, 5)

   local Btn = Instance.new("TextButton", BtnFrame)
   Btn.Size = UDim2.new(1, 0, 1, 0)
   Btn.BackgroundTransparency = 1
   Btn.Text = config.Name
   Btn.TextColor3 = Theme.TextColor
   Btn.Font = Enum.Font.Gotham
   Btn.MouseButton1Click:Connect(config.Callback)
end

function Rayfield:CreateParagraph(Tab, config)
    local Label = Instance.new("TextLabel", Tab.Content)
    Label.Size = UDim2.new(1, 0, 0, 40)
    Label.BackgroundColor3 = Theme.ElementBackground
    Label.Text = config.Title .. "\n" .. config.Content
    Label.TextColor3 = Theme.TextColor
    Label.TextSize = 12
    Instance.new("UICorner", Label).CornerRadius = UDim.new(0, 5)
end

function Rayfield:Notify(config)
    print("Notification: " .. config.Title .. " - " .. config.Content)
end

-- ============================================
-- EKSEKUSI MENU (FULL CONTENT)
-- ============================================

local Window = Rayfield:CreateWindow({ Name = "Nyemek HuB | Mount Koplo Protect" })

local MainTab = Rayfield:CreateTab(Window, {Name = "🏠 Main"})
local ProtectTab = Rayfield:CreateTab(Window, {Name = "🛡️ Protection"})

-- TAB MAIN: AUTO SUMMIT
Rayfield:CreateParagraph(MainTab, {
   Title = "Summit Feature",
   Content = "Auto Teleport langsung ke BoxSpawnSummitA secara instan."
})

Rayfield:CreateToggle(MainTab, {
   Name = "AUTO SUMMIT (BOXSPAWN)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoSummit = Value
      if Value then DirectTeleport() end
   end
})

Rayfield:CreateButton(MainTab, {
   Name = "Manual Teleport Once",
   Callback = function()
      DirectTeleport()
   end
})

-- TAB PROTECTION: NAME SPOOFER
Rayfield:CreateParagraph(ProtectTab, {
   Title = "Identity Spoofer",
   Content = "Mengganti 'Nickname' label menjadi 'Nyemek HuB Protect'."
})

Rayfield:CreateToggle(ProtectTab, {
   Name = "SPOOF NICKNAME LABEL",
   CurrentValue = false,
   Callback = function(Value)
      _G.NameSpoof = Value
   end
})

print("✅ Nyemek HuB: Berhasil dimuat dengan UI LAMA & Fitur BARU!")
