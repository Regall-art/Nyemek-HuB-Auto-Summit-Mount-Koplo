-- NYEMEK HUB | MOUNT KOPLO PROTECT
-- Auto Summit + Name Spoofer
-- Flux UI Rayfield Style with NY Logo

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

print("\n" .. string.rep("=", 70))
print("NYEMEK HUB | MOUNT KOPLO PROTECT")
print("Auto Summit + Name Spoofer")
print(string.rep("=", 70) .. "\n")

-- Settings
local Settings = {
   AutoSummit = false,
   NameSpoofer = false,
   SpoofedName = "Nyemek HuB Protect",
   SummitDelay = 0.1,
   TeleportSpeed = 1
}

-- Rayfield Colors
local Theme = {
   Background = Color3.fromRGB(25, 25, 25),
   Topbar = Color3.fromRGB(30, 30, 30),
   TabBackground = Color3.fromRGB(20, 20, 20),
   ElementBackground = Color3.fromRGB(35, 35, 35),
   ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
   ElementStroke = Color3.fromRGB(50, 50, 50),
   ToggleBackground = Color3.fromRGB(30, 30, 30),
   ToggleEnabled = Color3.fromRGB(0, 255, 0),
   ToggleDisabled = Color3.fromRGB(180, 180, 180),
   ToggleEnabledStroke = Color3.fromRGB(0, 200, 0),
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
            if input.UserInputState == Enum.UserInputState.End then
               dragging = false
            end
         end)
      end
   end)
   
   UserInputService.InputChanged:Connect(function(input)
      if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
         local delta = input.Position - dragStart
         Tween(frame, {
            Position = UDim2.new(
               startPos.X.Scale,
               startPos.X.Offset + delta.X,
               startPos.Y.Scale,
               startPos.Y.Offset + delta.Y
            )
         }, Animations.Linear)
      end
   end)
end

-- Create NY Logo
local function CreateNYLogo(parent)
   local LogoBg = Instance.new("Frame")
   LogoBg.Size = UDim2.new(1, 0, 1, 0)
   LogoBg.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
   LogoBg.BorderSizePixel = 0
   LogoBg.Parent = parent
   
   local BgCorner = Instance.new("UICorner")
   BgCorner.CornerRadius = UDim.new(0, 12)
   BgCorner.Parent = LogoBg
   
   local BgGradient = Instance.new("UIGradient")
   BgGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 180, 255)),
      ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 100))
   })
   BgGradient.Rotation = 135
   BgGradient.Parent = LogoBg
   
   local NLetter = Instance.new("TextLabel")
   NLetter.Size = UDim2.new(0.5, 0, 0.8, 0)
   NLetter.Position = UDim2.new(0.05, 0, 0.1, 0)
   NLetter.BackgroundTransparency = 1
   NLetter.Text = "N"
   NLetter.TextColor3 = Color3.fromRGB(50, 130, 255)
   NLetter.TextSize = 40
   NLetter.Font = Enum.Font.GothamBlack
   NLetter.TextScaled = true
   NLetter.Parent = LogoBg
   
   local YLetter = Instance.new("TextLabel")
   YLetter.Size = UDim2.new(0.5, 0, 0.8, 0)
   YLetter.Position = UDim2.new(0.45, 0, 0.1, 0)
   YLetter.BackgroundTransparency = 1
   YLetter.Text = "y"
   YLetter.TextColor3 = Color3.fromRGB(255, 140, 80)
   YLetter.TextSize = 40
   YLetter.Font = Enum.Font.GothamBlack
   YLetter.TextScaled = true
   YLetter.Parent = LogoBg
   
   return LogoBg
end

-- UI Library
local Rayfield = {}

function Rayfield:CreateWindow(config)
   local WindowName = config.Name or "Rayfield UI"
   
   local ScreenGui = Instance.new("ScreenGui")
   ScreenGui.Name = "NyemekHubUI"
   ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   ScreenGui.ResetOnSpawn = false
   
   pcall(function()
      ScreenGui.Parent = CoreGui
   end)
   
   if ScreenGui.Parent ~= CoreGui then
      ScreenGui.Parent = player.PlayerGui
   end
   
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
   MainStroke.Color = Color3.fromRGB(0, 255, 0)
   MainStroke.Thickness = 2
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
   
   local TopbarCover = Instance.new("Frame")
   TopbarCover.Size = UDim2.new(1, 0, 0, 6)
   TopbarCover.Position = UDim2.new(0, 0, 1, -6)
   TopbarCover.BackgroundColor3 = Theme.Topbar
   TopbarCover.BorderSizePixel = 0
   TopbarCover.Parent = Topbar
   
   local Title = Instance.new("TextLabel")
   Title.Size = UDim2.new(1, -50, 1, 0)
   Title.Position = UDim2.new(0, 12, 0, 0)
   Title.BackgroundTransparency = 1
   Title.Text = WindowName
   Title.TextColor3 = Color3.fromRGB(0, 255, 0)
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
   TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
   TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
   TabContainer.Parent = Main
   
   local TabContainerCorner = Instance.new("UICorner")
   TabContainerCorner.CornerRadius = UDim.new(0, 6)
   TabContainerCorner.Parent = TabContainer
   
   local TabList = Instance.new("UIListLayout")
   TabList.Padding = UDim.new(0, 3)
   TabList.Parent = TabContainer
   
   local TabPadding = Instance.new("UIPadding")
   TabPadding.PaddingTop = UDim.new(0, 5)
   TabPadding.PaddingLeft = UDim.new(0, 5)
   TabPadding.PaddingRight = UDim.new(0, 5)
   TabPadding.Parent = TabContainer
   
   local ContentContainer = Instance.new("Frame")
   ContentContainer.Size = UDim2.new(1, -170, 1, -52)
   ContentContainer.Position = UDim2.new(0, 165, 0, 47)
   ContentContainer.BackgroundTransparency = 1
   ContentContainer.Parent = Main
   
   local MiniButton = Instance.new("TextButton")
   MiniButton.Size = UDim2.new(0, 60, 0, 60)
   MiniButton.Position = UDim2.new(1, -70, 0.95, -70)
   MiniButton.BackgroundTransparency = 1
   MiniButton.Text = ""
   MiniButton.Visible = false
   MiniButton.AutoButtonColor = false
   MiniButton.Parent = ScreenGui
   
   CreateNYLogo(MiniButton)
   
   local MiniStroke = Instance.new("UIStroke")
   MiniStroke.Color = Color3.fromRGB(0, 255, 0)
   MiniStroke.Thickness = 3
   MiniStroke.Parent = MiniButton
   
   CloseButton.MouseButton1Click:Connect(function()
      Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, Animations.Back)
      task.wait(0.5)
      Main.Visible = false
      
      MiniButton.Visible = true
      MiniButton.Size = UDim2.new(0, 0, 0, 0)
      Tween(MiniButton, {Size = UDim2.new(0, 60, 0, 60)}, Animations.Back)
      
      task.spawn(function()
         while MiniButton.Visible do
            Tween(MiniButton, {Size = UDim2.new(0, 65, 0, 65)}, Animations.Quart)
            task.wait(1)
            Tween(MiniButton, {Size = UDim2.new(0, 60, 0, 60)}, Animations.Quart)
            task.wait(1)
         end
      end)
   end)
   
   MiniButton.MouseButton1Click:Connect(function()
      Tween(MiniButton, {Size = UDim2.new(0, 0, 0, 0)}, Animations.Quart)
      task.wait(0.3)
      MiniButton.Visible = false
      
      Main.Visible = true
      Tween(Main, {Size = UDim2.new(0, 500, 0, 400)}, Animations.Back)
   end)
   
   MiniButton.MouseEnter:Connect(function()
      Tween(MiniButton, {Size = UDim2.new(0, 68, 0, 68)}, Animations.Quart)
   end)
   
   MiniButton.MouseLeave:Connect(function()
      Tween(MiniButton, {Size = UDim2.new(0, 60, 0, 60)}, Animations.Quart)
   end)
   
   MakeDraggable(Main, Topbar)
   MakeDraggable(MiniButton)
   
   Tween(Main, {Size = UDim2.new(0, 500, 0, 400)}, Animations.Back)
   
   task.wait(0.6)
   Rayfield:Notify({
      Title = "Nyemek HuB",
      Content = "Mount Koplo Protect loaded!",
      Duration = 3
   })
   
   return {
      Main = Main,
      ContentContainer = ContentContainer,
      TabContainer = TabContainer,
      Tabs = {},
      CurrentTab = nil
   }
end

function Rayfield:CreateTab(Window, config)
   local TabName = config.Name or "Tab"
   
   local TabButton = Instance.new("TextButton")
   TabButton.Size = UDim2.new(1, 0, 0, 32)
   TabButton.BackgroundColor3 = Theme.ElementBackground
   TabButton.BackgroundTransparency = 1
   TabButton.BorderSizePixel = 0
   TabButton.Text = ""
   TabButton.AutoButtonColor = false
   TabButton.Parent = Window.TabContainer
   
   local TabCorner = Instance.new("UICorner")
   TabCorner.CornerRadius = UDim.new(0, 5)
   TabCorner.Parent = TabButton
   
   local TabTitle = Instance.new("TextLabel")
   TabTitle.Size = UDim2.new(1, -20, 1, 0)
   TabTitle.Position = UDim2.new(0, 10, 0, 0)
   TabTitle.BackgroundTransparency = 1
   TabTitle.Text = TabName
   TabTitle.TextColor3 = Theme.TextDark
   TabTitle.TextSize = 13
   TabTitle.Font = Enum.Font.GothamMedium
   TabTitle.TextXAlignment = Enum.TextXAlignment.Left
   TabTitle.Parent = TabButton
   
   local TabContent = Instance.new("ScrollingFrame")
   TabContent.Size = UDim2.new(1, -10, 1, -10)
   TabContent.Position = UDim2.new(0, 5, 0, 5)
   TabContent.BackgroundTransparency = 1
   TabContent.BorderSizePixel = 0
   TabContent.ScrollBarThickness = 3
   TabContent.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 0)
   TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
   TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
   TabContent.Visible = false
   TabContent.Parent = Window.ContentContainer
   
   local ContentList = Instance.new("UIListLayout")
   ContentList.Padding = UDim.new(0, 8)
   ContentList.Parent = TabContent
   
   local ContentPadding = Instance.new("UIPadding")
   ContentPadding.PaddingLeft = UDim.new(0, 5)
   ContentPadding.PaddingRight = UDim.new(0, 5)
   ContentPadding.PaddingTop = UDim.new(0, 5)
   ContentPadding.Parent = TabContent
   
   local function SelectTab()
      for _, tab in pairs(Window.Tabs) do
         tab.Button.BackgroundTransparency = 1
         tab.Title.TextColor3 = Theme.TextDark
         tab.Content.Visible = false
      end
      
      Tween(TabButton, {BackgroundTransparency = 0}, Animations.Quart)
      Tween(TabTitle, {TextColor3 = Color3.fromRGB(0, 255, 0)}, Animations.Quart)
      TabContent.Visible = true
      Window.CurrentTab = TabName
   end
   
   TabButton.MouseButton1Click:Connect(SelectTab)
   
   TabButton.MouseEnter:Connect(function()
      if Window.CurrentTab ~= TabName then
         Tween(TabButton, {BackgroundTransparency = 0.5}, Animations.Quart)
      end
   end)
   
   TabButton.MouseLeave:Connect(function()
      if Window.CurrentTab ~= TabName then
         Tween(TabButton, {BackgroundTransparency = 1}, Animations.Quart)
      end
   end)
   
   local Tab = {Button = TabButton, Title = TabTitle, Content = TabContent, Select = SelectTab}
   Window.Tabs[TabName] = Tab
   
   if not Window.CurrentTab then SelectTab() end
   
   return Tab
end

function Rayfield:CreateToggle(Tab, config)
   local ToggleFrame = Instance.new("Frame")
   ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
   ToggleFrame.BackgroundColor3 = Theme.ElementBackground
   ToggleFrame.BorderSizePixel = 0
   ToggleFrame.Parent = Tab.Content
   
   local ToggleCorner = Instance.new("UICorner")
   ToggleCorner.CornerRadius = UDim.new(0, 5)
   ToggleCorner.Parent = ToggleFrame
   
   local ToggleStroke = Instance.new("UIStroke")
   ToggleStroke.Color = Theme.ElementStroke
   ToggleStroke.Thickness = 1
   ToggleStroke.Parent = ToggleFrame
   
   local ToggleTitle = Instance.new("TextLabel")
   ToggleTitle.Size = UDim2.new(1, -60, 1, 0)
   ToggleTitle.Position = UDim2.new(0, 10, 0, 0)
   ToggleTitle.BackgroundTransparency = 1
   ToggleTitle.Text = config.Name or "Toggle"
   ToggleTitle.TextColor3 = Theme.TextColor
   ToggleTitle.TextSize = 13
   ToggleTitle.Font = Enum.Font.Gotham
   ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
   ToggleTitle.Parent = ToggleFrame
   
   local StatusLabel = Instance.new("TextLabel")
   StatusLabel.Size = UDim2.new(0, 40, 1, 0)
   StatusLabel.Position = UDim2.new(1, -95, 0, 0)
   StatusLabel.BackgroundTransparency = 1
   StatusLabel.Text = "[OFF]"
   StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
   StatusLabel.TextSize = 11
   StatusLabel.Font = Enum.Font.GothamBold
   StatusLabel.Parent = ToggleFrame
   
   local ToggleButton = Instance.new("TextButton")
   ToggleButton.Size = UDim2.new(0, 40, 0, 20)
   ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
   ToggleButton.BackgroundColor3 = Theme.ToggleBackground
   ToggleButton.BorderSizePixel = 0
   ToggleButton.Text = ""
   ToggleButton.AutoButtonColor = false
   ToggleButton.Parent = ToggleFrame
   
   local ToggleCorner2 = Instance.new("UICorner")
   ToggleCorner2.CornerRadius = UDim.new(1, 0)
   ToggleCorner2.Parent = ToggleButton
   
   local ToggleStroke2 = Instance.new("UIStroke")
   ToggleStroke2.Color = Theme.ToggleDisabledStroke
   ToggleStroke2.Thickness = 1
   ToggleStroke2.Parent = ToggleButton
   
   local Indicator = Instance.new("Frame")
   Indicator.Size = UDim2.new(0, 16, 0, 16)
   Indicator.Position = UDim2.new(0, 2, 0.5, -8)
   Indicator.BackgroundColor3 = Theme.ToggleDisabled
   Indicator.BorderSizePixel = 0
   Indicator.Parent = ToggleButton
   
   local IndicatorCorner = Instance.new("UICorner")
   IndicatorCorner.CornerRadius = UDim.new(1, 0)
   IndicatorCorner.Parent = Indicator
   
   local toggled = config.CurrentValue or false
   
   local function Update()
      if toggled then
         StatusLabel.Text = "[ON]"
         StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
         Tween(Indicator, {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Theme.ToggleEnabled}, Animations.Quart)
         Tween(ToggleStroke2, {Color = Theme.ToggleEnabledStroke}, Animations.Quart)
      else
         StatusLabel.Text = "[OFF]"
         StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
         Tween(Indicator, {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Theme.ToggleDisabled}, Animations.Quart)
         Tween(ToggleStroke2, {Color = Theme.ToggleDisabledStroke}, Animations.Quart)
      end
   end
   
   Update()
   
   ToggleButton.MouseButton1Click:Connect(function()
      toggled = not toggled
      Update()
      if config.Callback then
         pcall(config.Callback, toggled)
      end
   end)
end

function Rayfield:CreateParagraph(Tab, config)
   local Frame = Instance.new("Frame")
   Frame.Size = UDim2.new(1, 0, 0, 0)
   Frame.AutomaticSize = Enum.AutomaticSize.Y
   Frame.BackgroundColor3 = Theme.ElementBackground
   Frame.BorderSizePixel = 0
   Frame.Parent = Tab.Content
   
   local Corner = Instance.new("UICorner")
   Corner.CornerRadius = UDim.new(0, 5)
   Corner.Parent = Frame
   
   local Stroke = Instance.new("UIStroke")
   Stroke.Color = Theme.ElementStroke
   Stroke.Thickness = 1
   Stroke.Parent = Frame
   
   local Padding = Instance.new("UIPadding")
   Padding.PaddingTop = UDim.new(0, 10)
   Padding.PaddingBottom = UDim.new(0, 10)
   Padding.PaddingLeft = UDim.new(0, 10)
   Padding.PaddingRight = UDim.new(0, 10)
   Padding.Parent = Frame
   
   local Title = Instance.new("TextLabel")
   Title.Size = UDim2.new(1, 0, 0, 16)
   Title.BackgroundTransparency = 1
   Title.Text = config.Title or "Title"
   Title.TextColor3 = Color3.fromRGB(0, 255, 0)
   Title.TextSize = 13
   Title.Font = Enum.Font.GothamBold
   Title.TextXAlignment = Enum.TextXAlignment.Left
   Title.Parent = Frame
   
   local Content = Instance.new("TextLabel")
   Content.Size = UDim2.new(1, 0, 0, 0)
   Content.Position = UDim2.new(0, 0, 0, 20)
   Content.AutomaticSize = Enum.AutomaticSize.Y
   Content.BackgroundTransparency = 1
   Content.Text = config.Content or "Content"
   Content.TextColor3 = Theme.TextDark
   Content.TextSize = 12
   Content.Font = Enum.Font.Gotham
   Content.TextXAlignment = Enum.TextXAlignment.Left
   Content.TextWrapped = true
   Content.Parent = Frame
end

function Rayfield:Notify(config)
   local Notif = Instance.new("Frame")
   Notif.Size = UDim2.new(0, 300, 0, 75)
   Notif.Position = UDim2.new(1, 310, 1, -85)
   Notif.BackgroundColor3 = Theme.ElementBackground
   Notif.BorderSizePixel = 0
   
   pcall(function()
      Notif.Parent = CoreGui:FindFirstChild("NyemekHubUI")
   end)
   
   if not Notif.Parent then
      Notif.Parent = player.PlayerGui:FindFirstChild("NyemekHubUI") or player.PlayerGui
   end
   
   local Corner = Instance.new("UICorner")
   Corner.CornerRadius = UDim.new(0, 6)
   Corner.Parent = Notif
   
   local Stroke = Instance.new("UIStroke")
   Stroke.Color = Color3.fromRGB(0, 255, 0)
   Stroke.Thickness = 1
   Stroke.Parent = Notif
   
   local Title = Instance.new("TextLabel")
   Title.Size = UDim2.new(1, -20, 0, 18)
   Title.Position = UDim2.new(0, 10, 0, 10)
   Title.BackgroundTransparency = 1
   Title.Text = config.Title or "Notification"
   Title.TextColor3 = Theme.TextColor
   Title.TextSize = 14
   Title.Font = Enum.Font.GothamBold
   Title.TextXAlignment = Enum.TextXAlignment.Left
   Title.Parent = Notif
   
   local Content = Instance.new("TextLabel")
   Content.Size = UDim2.new(1, -20, 0, 37)
   Content.Position = UDim2.new(0, 10, 0, 33)
   Content.BackgroundTransparency = 1
   Content.Text = config.Content or "Content"
   Content.TextColor3 = Theme.TextDark
   Content.TextSize = 12
   Content.Font = Enum.Font.Gotham
   Content.TextXAlignment = Enum.TextXAlignment.Left
   Content.TextWrapped = true
   Content.Parent = Notif
   
   Tween(Notif, {Position = UDim2.new(1, -310, 1, -85)}, Animations.Quint)
   task.wait(config.Duration or 3)
   Tween(Notif, {Position = UDim2.new(1, 310, 1, -85)}, Animations.Quint)
   task.wait(0.3)
   Notif:Destroy()
end

-- ============================================
-- AUTO SUMMIT FUNCTIONS
-- ============================================

local autoSummitConnection

function FindSummitParts()
   local summitParts = {}
   
   -- Search for BoxSpawn parts in workspace
   for _, obj in pairs(Workspace:GetDescendants()) do
      if obj:IsA("BasePart") and obj.Name:lower():find("boxspawn") then
         table.insert(summitParts, obj)
      end
   end
   
   -- Alternative: Search by ClassName
   for _, obj in pairs(Workspace:GetDescendants()) do
      if obj:IsA("BasePart") and obj.ClassName == "Part" then
         -- Check if part is a summit checkpoint
         if obj:FindFirstChild("SummitID") or obj:FindFirstChild("Checkpoint") then
            table.insert(summitParts, obj)
         end
      end
   end
   
   return summitParts
end

function TeleportToSummit(part)
   if not part or not humanoidRootPart then return end
   
   pcall(function()
      humanoidRootPart.CFrame = part.CFrame * CFrame.new(0, 3, 0)
   end)
end

function StartAutoSummit()
   print("🚀 Auto Summit: ON")
   
   autoSummitConnection = RunService.Heartbeat:Connect(function()
      if not Settings.AutoSummit then return end
      
      local summitParts = FindSummitParts()
      
      for _, part in ipairs(summitParts) do
         if part and part.Parent then
            TeleportToSummit(part)
            task.wait(Settings.SummitDelay)
         end
      end
   end)
end

function StopAutoSummit()
   print("🛑 Auto Summit: OFF")
   
   if autoSummitConnection then
      autoSummitConnection:Disconnect()
      autoSummitConnection = nil
   end
end

-- ============================================
-- NAME SPOOFER FUNCTIONS
-- ============================================

local originalDisplayName = player.DisplayName
local nameSpooferActive = false

function SpoofOverheadName()
   print("👤 Name Spoofer: ON")
   nameSpooferActive = true
   
   -- Spoof BillboardGui overhead names
   for _, otherPlayer in pairs(Players:GetPlayers()) do
      task.spawn(function()
         local character = otherPlayer.Character
         if not character then return end
         
         local head = character:FindFirstChild("Head")
         if not head then return end
         
         -- Find existing BillboardGui
         for _, gui in pairs(head:GetChildren()) do
            if gui:IsA("BillboardGui") then
               -- Find TextLabel with player name
               for _, label in pairs(gui:GetDescendants()) do
                  if label:IsA("TextLabel") then
                     -- Check if it's the name label
                     if label.Text == otherPlayer.DisplayName or label.Text == otherPlayer.Name then
                        -- Spoof the name
                        label.Text = Settings.SpoofedName
                        label.TextColor3 = Color3.fromRGB(0, 255, 0)
                     end
                  end
               end
            end
         end
      end)
   end
   
   -- Monitor new players joining
   Players.PlayerAdded:Connect(function(newPlayer)
      if not nameSpooferActive then return end
      
      newPlayer.CharacterAdded:Connect(function(character)
         task.wait(1)
         
         local head = character:FindFirstChild("Head")
         if not head then return end
         
         for _, gui in pairs(head:GetChildren()) do
            if gui:IsA("BillboardGui") then
               for _, label in pairs(gui:GetDescendants()) do
                  if label:IsA("TextLabel") then
                     if label.Text == newPlayer.DisplayName or label.Text == newPlayer.Name then
                        label.Text = Settings.SpoofedName
                        label.TextColor3 = Color3.fromRGB(0, 255, 0)
                     end
                  end
               end
            end
         end
      end)
   end)
   
   -- Also spoof local player name displays
   for _, gui in pairs(player.PlayerGui:GetDescendants()) do
      if gui:IsA("TextLabel") then
         if gui.Text == player.DisplayName or gui.Text == player.Name then
            gui.Text = Settings.SpoofedName
            gui.TextColor3 = Color3.fromRGB(0, 255, 0)
         end
      end
   end
end

function RestoreOriginalNames()
   print("👤 Name Spoofer: OFF")
   nameSpooferActive = false
   
   -- Restore all player names
   for _, otherPlayer in pairs(Players:GetPlayers()) do
      task.spawn(function()
         local character = otherPlayer.Character
         if not character then return end
         
         local head = character:FindFirstChild("Head")
         if not head then return end
         
         for _, gui in pairs(head:GetChildren()) do
            if gui:IsA("BillboardGui") then
               for _, label in pairs(gui:GetDescendants()) do
                  if label:IsA("TextLabel") and label.Text == Settings.SpoofedName then
                     label.Text = otherPlayer.DisplayName
                     label.TextColor3 = Color3.fromRGB(255, 255, 255)
                  end
               end
            end
         end
      end)
   end
end

-- ============================================
-- CREATE UI
-- ============================================

local Window = Rayfield:CreateWindow({
   Name = "NYEMEK HUB | MOUNT KOPLO PROTECT"
})

local MainTab = Rayfield:CreateTab(Window, {Name = "🏔️ Main"})
local SettingsTab = Rayfield:CreateTab(Window, {Name = "⚙️ Settings"})

-- MAIN TAB
Rayfield:CreateParagraph(MainTab, {
   Title = "🏔️ Mount Koplo Auto Summit",
   Content = "Automatically teleport to BoxSpawn summit checkpoints. Enable to start farming!"
})

Rayfield:CreateToggle(MainTab, {
   Name = "AUTO SUMMIT (BOXSPAWN)",
   CurrentValue = false,
   Callback = function(value)
      Settings.AutoSummit = value
      if value then
         StartAutoSummit()
         Rayfield:Notify({
            Title = "Auto Summit",
            Content = "Auto summit activated!",
            Duration = 2
         })
      else
         StopAutoSummit()
         Rayfield:Notify({
            Title = "Auto Summit",
            Content = "Auto summit deactivated!",
            Duration = 2
         })
      end
   end
})

Rayfield:CreateParagraph(MainTab, {
   Title = "👤 Name Protection",
   Content = "Spoof all player overhead names to 'Nyemek HuB Protect' for privacy and protection!"
})

Rayfield:CreateToggle(MainTab, {
   Name = "NAME SPOOFER (PROTECT)",
   CurrentValue = false,
   Callback = function(value)
      Settings.NameSpoofer = value
      if value then
         SpoofOverheadName()
         Rayfield:Notify({
            Title = "Name Spoofer",
            Content = "All names protected!",
            Duration = 2
         })
      else
         RestoreOriginalNames()
         Rayfield:Notify({
            Title = "Name Spoofer",
            Content = "Names restored!",
            Duration = 2
         })
      end
   end
})

-- SETTINGS TAB
Rayfield:CreateParagraph(SettingsTab, {
   Title = "⚙️ Settings",
   Content = "Configure auto summit speed and behavior"
})

Rayfield:CreateParagraph(SettingsTab, {
   Title = "ℹ️ How It Works",
   Content = "Auto Summit finds all BoxSpawn parts in workspace and teleports to them automatically. Name Spoofer changes all player overhead names to protect identity."
})

Rayfield:CreateParagraph(SettingsTab, {
   Title = "⚠️ Warning",
   Content = "Use at your own risk! Auto summit may be detected by anti-cheat. Name spoofer is visual only."
})

print("\n✅ NYEMEK HUB LOADED!")
print("🏔️ Auto Summit ready!")
print("👤 Name Spoofer ready!")
print(string.rep("=", 70) .. "\n")
