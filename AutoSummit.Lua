-- NYEMEK HUB | MOUNT KOPLO PROTECT
-- FIXED AUTO SUMMIT TELEPORT

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local Settings = {
	AutoSummit = false,
	NameSpoofer = false,
	SpoofedName = "Nyemek HuB Protect",
}

-- [[ THEME & ANIMATIONS - TIDAK DIUBAH ]] --
local Theme = {
	Background = Color3.fromRGB(25, 25, 25),
	Topbar = Color3.fromRGB(30, 30, 30),
	TabBackground = Color3.fromRGB(20, 20, 20),
	ElementBackground = Color3.fromRGB(35, 35, 35),
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
	local dragging, dragStart, startPos
	handle = handle or frame
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true; dragStart = input.Position; startPos = frame.Position
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

local function CreateNYLogo(parent)
	local LogoBg = Instance.new("Frame"); LogoBg.Size = UDim2.new(1,0,1,0); LogoBg.BackgroundColor3 = Color3.fromRGB(100,180,255); LogoBg.BorderSizePixel = 0; LogoBg.Parent = parent
	local BgCorner = Instance.new("UICorner"); BgCorner.CornerRadius = UDim.new(0,12); BgCorner.Parent = LogoBg
	local BgGradient = Instance.new("UIGradient")
	BgGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(100,180,255)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,160,100))})
	BgGradient.Rotation = 135; BgGradient.Parent = LogoBg
	local NLetter = Instance.new("TextLabel"); NLetter.Size = UDim2.new(0.5,0,0.8,0); NLetter.Position = UDim2.new(0.05,0,0.1,0); NLetter.BackgroundTransparency = 1; NLetter.Text = "N"; NLetter.TextColor3 = Color3.fromRGB(50,130,255); NLetter.TextSize = 40; NLetter.Font = Enum.Font.GothamBlack; NLetter.TextScaled = true; NLetter.Parent = LogoBg
	local YLetter = Instance.new("TextLabel"); YLetter.Size = UDim2.new(0.5,0,0.8,0); YLetter.Position = UDim2.new(0.45,0,0.1,0); YLetter.BackgroundTransparency = 1; YLetter.Text = "y"; YLetter.TextColor3 = Color3.fromRGB(255,140,80); YLetter.TextSize = 40; YLetter.Font = Enum.Font.GothamBlack; YLetter.TextScaled = true; YLetter.Parent = LogoBg
	return LogoBg
end

-- [[ UI LIBRARY - TIDAK DIUBAH ]] --
local Rayfield = {}

function Rayfield:CreateWindow(config)
	local WindowName = config.Name or "Rayfield UI"
	local ScreenGui = Instance.new("ScreenGui"); ScreenGui.Name = "NyemekHubUI"; ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; ScreenGui.ResetOnSpawn = false
	pcall(function() ScreenGui.Parent = CoreGui end)
	if ScreenGui.Parent ~= CoreGui then ScreenGui.Parent = player.PlayerGui end

	local Main = Instance.new("Frame"); Main.Name = "Main"; Main.Size = UDim2.new(0,0,0,0); Main.Position = UDim2.new(0.5,0,0.5,0); Main.AnchorPoint = Vector2.new(0.5,0.5); Main.BackgroundColor3 = Theme.Background; Main.BorderSizePixel = 0; Main.ClipsDescendants = true; Main.Parent = ScreenGui
	local MainCorner = Instance.new("UICorner"); MainCorner.CornerRadius = UDim.new(0,6); MainCorner.Parent = Main
	local MainStroke = Instance.new("UIStroke"); MainStroke.Color = Color3.fromRGB(0,255,0); MainStroke.Thickness = 2; MainStroke.Parent = Main
	local Shadow = Instance.new("ImageLabel"); Shadow.AnchorPoint = Vector2.new(0.5,0.5); Shadow.BackgroundTransparency = 1; Shadow.Position = UDim2.new(0.5,0,0.5,0); Shadow.Size = UDim2.new(1,47,1,47); Shadow.ZIndex = 0; Shadow.Image = "rbxassetid://5554236805"; Shadow.ImageColor3 = Color3.fromRGB(0,0,0); Shadow.ImageTransparency = 0.5; Shadow.ScaleType = Enum.ScaleType.Slice; Shadow.SliceCenter = Rect.new(23,23,277,277); Shadow.Parent = Main

	local Topbar = Instance.new("Frame"); Topbar.Size = UDim2.new(1,0,0,42); Topbar.BackgroundColor3 = Theme.Topbar; Topbar.BorderSizePixel = 0; Topbar.Parent = Main
	local TopbarCorner = Instance.new("UICorner"); TopbarCorner.CornerRadius = UDim.new(0,6); TopbarCorner.Parent = Topbar
	local TopbarCover = Instance.new("Frame"); TopbarCover.Size = UDim2.new(1,0,0,6); TopbarCover.Position = UDim2.new(0,0,1,-6); TopbarCover.BackgroundColor3 = Theme.Topbar; TopbarCover.BorderSizePixel = 0; TopbarCover.Parent = Topbar
	local Title = Instance.new("TextLabel"); Title.Size = UDim2.new(1,-50,1,0); Title.Position = UDim2.new(0,12,0,0); Title.BackgroundTransparency = 1; Title.Text = WindowName; Title.TextColor3 = Color3.fromRGB(0,255,0); Title.TextSize = 15; Title.Font = Enum.Font.GothamBold; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.Parent = Topbar
	local CloseButton = Instance.new("ImageButton"); CloseButton.Size = UDim2.new(0,18,0,18); CloseButton.Position = UDim2.new(1,-30,0.5,-9); CloseButton.BackgroundTransparency = 1; CloseButton.Image = "rbxassetid://7733717447"; CloseButton.ImageColor3 = Theme.TextColor; CloseButton.Parent = Topbar

	local TabContainer = Instance.new("ScrollingFrame"); TabContainer.Size = UDim2.new(0,155,1,-52); TabContainer.Position = UDim2.new(0,5,0,47); TabContainer.BackgroundColor3 = Theme.TabBackground; TabContainer.BorderSizePixel = 0; TabContainer.ScrollBarThickness = 0; TabContainer.CanvasSize = UDim2.new(0,0,0,0); TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y; TabContainer.Parent = Main
	local TabContainerCorner = Instance.new("UICorner"); TabContainerCorner.CornerRadius = UDim.new(0,6); TabContainerCorner.Parent = TabContainer
	local TabList = Instance.new("UIListLayout"); TabList.Padding = UDim.new(0,3); TabList.Parent = TabContainer
	local TabPadding = Instance.new("UIPadding"); TabPadding.PaddingTop = UDim.new(0,5); TabPadding.PaddingLeft = UDim.new(0,5); TabPadding.PaddingRight = UDim.new(0,5); TabPadding.Parent = TabContainer

	local ContentContainer = Instance.new("Frame"); ContentContainer.Size = UDim2.new(1,-170,1,-52); ContentContainer.Position = UDim2.new(0,165,0,47); ContentContainer.BackgroundTransparency = 1; ContentContainer.Parent = Main

	local MiniButton = Instance.new("TextButton"); MiniButton.Size = UDim2.new(0,60,0,60); MiniButton.Position = UDim2.new(1,-70,0.95,-70); MiniButton.BackgroundTransparency = 1; MiniButton.Text = ""; MiniButton.Visible = false; MiniButton.AutoButtonColor = false; MiniButton.Parent = ScreenGui
	CreateNYLogo(MiniButton)
	local MiniStroke = Instance.new("UIStroke"); MiniStroke.Color = Color3.fromRGB(0,255,0); MiniStroke.Thickness = 3; MiniStroke.Parent = MiniButton

	CloseButton.MouseButton1Click:Connect(function()
		Tween(Main,{Size=UDim2.new(0,0,0,0)},Animations.Back); task.wait(0.5); Main.Visible = false
		MiniButton.Visible = true; MiniButton.Size = UDim2.new(0,0,0,0); Tween(MiniButton,{Size=UDim2.new(0,60,0,60)},Animations.Back)
	end)
	MiniButton.MouseButton1Click:Connect(function()
		MiniButton.Visible = false
		Main.Visible = true; Tween(Main,{Size=UDim2.new(0,500,0,400)},Animations.Back)
	end)

	MakeDraggable(Main, Topbar); MakeDraggable(MiniButton)
	Tween(Main,{Size=UDim2.new(0,500,0,400)},Animations.Back)
	return {Main=Main, ContentContainer=ContentContainer, TabContainer=TabContainer, Tabs={}, CurrentTab=nil}
end

function Rayfield:CreateTab(Window, config)
	local TabName = config.Name or "Tab"
	local TabButton = Instance.new("TextButton"); TabButton.Size = UDim2.new(1,0,0,32); TabButton.BackgroundColor3 = Theme.ElementBackground; TabButton.BackgroundTransparency = 1; TabButton.BorderSizePixel = 0; TabButton.Text = ""; TabButton.AutoButtonColor = false; TabButton.Parent = Window.TabContainer
	local TabTitle = Instance.new("TextLabel"); TabTitle.Size = UDim2.new(1,-20,1,0); TabTitle.Position = UDim2.new(0,10,0,0); TabTitle.BackgroundTransparency = 1; TabTitle.Text = TabName; TabTitle.TextColor3 = Theme.TextDark; TabTitle.TextSize = 13; TabTitle.Font = Enum.Font.GothamMedium; TabTitle.TextXAlignment = Enum.TextXAlignment.Left; TabTitle.Parent = TabButton
	local TabContent = Instance.new("ScrollingFrame"); TabContent.Size = UDim2.new(1,-10,1,-10); TabContent.Position = UDim2.new(0,5,0,5); TabContent.BackgroundTransparency = 1; TabContent.BorderSizePixel = 0; TabContent.ScrollBarThickness = 3; TabContent.ScrollBarImageColor3 = Color3.fromRGB(0,255,0); TabContent.Visible = false; TabContent.Parent = Window.ContentContainer
	Instance.new("UIListLayout", TabContent).Padding = UDim.new(0,8)

	local function SelectTab()
		for _, tab in pairs(Window.Tabs) do tab.Button.BackgroundTransparency=1; tab.Title.TextColor3=Theme.TextDark; tab.Content.Visible=false end
		Tween(TabButton,{BackgroundTransparency=0},Animations.Quart); Tween(TabTitle,{TextColor3=Color3.fromRGB(0,255,0)},Animations.Quart)
		TabContent.Visible = true; Window.CurrentTab = TabName
	end
	TabButton.MouseButton1Click:Connect(SelectTab)
	local Tab = {Button=TabButton, Title=TabTitle, Content=TabContent, Select=SelectTab}
	Window.Tabs[TabName] = Tab
	if not Window.CurrentTab then SelectTab() end
	return Tab
end

function Rayfield:CreateToggle(Tab, config)
	local ToggleFrame = Instance.new("Frame"); ToggleFrame.Size = UDim2.new(1,0,0,35); ToggleFrame.BackgroundColor3 = Theme.ElementBackground; ToggleFrame.Parent = Tab.Content
	Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0,5)
	local ToggleTitle = Instance.new("TextLabel"); ToggleTitle.Size = UDim2.new(1,-60,1,0); ToggleTitle.Position = UDim2.new(0,10,0,0); ToggleTitle.BackgroundTransparency = 1; ToggleTitle.Text = config.Name; ToggleTitle.TextColor3 = Theme.TextColor; ToggleTitle.TextXAlignment = "Left"; ToggleTitle.Parent = ToggleFrame
	local ToggleButton = Instance.new("TextButton"); ToggleButton.Size = UDim2.new(0,40,0,20); ToggleButton.Position = UDim2.new(1,-45,0.5,-10); ToggleButton.BackgroundColor3 = Theme.ToggleBackground; ToggleButton.Text = ""; ToggleButton.Parent = ToggleFrame
	Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1,0)
	local Indicator = Instance.new("Frame"); Indicator.Size = UDim2.new(0,16,0,16); Indicator.Position = UDim2.new(0,2,0.5,-8); Indicator.BackgroundColor3 = Theme.ToggleDisabled; Indicator.Parent = ToggleButton
	Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1,0)

	local toggled = config.CurrentValue or false
	local function Update()
		if toggled then
			Tween(Indicator,{Position=UDim2.new(1,-18,0.5,-8),BackgroundColor3=Theme.ToggleEnabled})
		else
			Tween(Indicator,{Position=UDim2.new(0,2,0.5,-8),BackgroundColor3=Theme.ToggleDisabled})
		end
	end
	Update()
	ToggleButton.MouseButton1Click:Connect(function()
		toggled = not toggled; Update()
		if config.Callback then config.Callback(toggled) end
	end)
end

function Rayfield:CreateParagraph(Tab, config)
	local Frame = Instance.new("Frame"); Frame.Size = UDim2.new(1,0,0,40); Frame.BackgroundColor3 = Theme.ElementBackground; Frame.Parent = Tab.Content
	Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,5)
	local T = Instance.new("TextLabel"); T.Size = UDim2.new(1,-20,1,0); T.Position = UDim2.new(0,10,0,0); T.Text = config.Title .. ": " .. config.Content; T.TextColor3 = Theme.TextColor; T.BackgroundTransparency = 1; T.TextXAlignment = "Left"; T.Parent = Frame
end

function Rayfield:Notify(config)
	print("[NyemekHub Notification]: " .. config.Content)
end

-- =============================================
-- FIXED AUTO SUMMIT LOGIC
-- =============================================

local function GetSummitPart()
	-- Mount Koplo Checkpoints Structure Fix
	local paths = {
		Workspace:FindFirstChild("Checkpoints"),
		Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("Checkpoints")
	}
	
	for _, folder in pairs(paths) do
		if folder then
			-- Cari secara rekursif karena sering didalam folder lagi
			for _, v in pairs(folder:GetDescendants()) do
				if (v.Name == "BoxSummitA" or v.Name == "BoxSpawnSummitA" or v.Name == "Summit") and v:IsA("BasePart") then
					return v
				end
			end
		end
	end
	return nil
end

local function TeleportToSummit()
	local target = GetSummitPart()
	local char = player.Character
	if target and char and char:FindFirstChild("HumanoidRootPart") then
		local hrp = char.HumanoidRootPart
		-- Teleport
		hrp.CFrame = target.CFrame * CFrame.new(0, 2, 0)
		
		-- Fire Touch Interest (Wajib untuk trigger server)
		task.spawn(function()
			firetouchinterest(hrp, target, 0)
			task.wait(0.1)
			firetouchinterest(hrp, target, 1)
		end)
	end
end

task.spawn(function()
	while task.wait(0.5) do
		if Settings.AutoSummit then
			TeleportToSummit()
		end
	end
end)

-- =============================================
-- NAME SPOOFER LOGIC
-- =============================================

task.spawn(function()
	while task.wait(1) do
		if Settings.NameSpoofer then
			for _, p in pairs(Players:GetPlayers()) do
				pcall(function()
					if p.Character and p.Character:FindFirstChild("Head") then
						for _, g in pairs(p.Character.Head:GetChildren()) do
							if g:IsA("BillboardGui") then
								for _, t in pairs(g:GetDescendants()) do
									if t:IsA("TextLabel") then
										t.Text = Settings.SpoofedName
										t.TextColor3 = Color3.fromRGB(0, 255, 0)
									end
								end
							end
						end
					end
				end)
			end
		end
	end
end)

-- =============================================
-- CREATE WINDOW & TABS
-- =============================================

local Window = Rayfield:CreateWindow({Name = "NYEMEK HUB | MOUNT KOPLO"})
local MainTab = Rayfield:CreateTab(Window, {Name = "🏔️ Main"})

Rayfield:CreateParagraph(MainTab, {
	Title = "Status",
	Content = "Auto Summit siap digunakan."
})

Rayfield:CreateToggle(MainTab, {
	Name = "AUTO SUMMIT (ON/OFF)",
	CurrentValue = false,
	Callback = function(val)
		Settings.AutoSummit = val
	end
})

Rayfield:CreateToggle(MainTab, {
	Name = "NAME SPOOFER PROTECT",
	CurrentValue = false,
	Callback = function(val)
		Settings.NameSpoofer = val
	end
})

print("[NyemekHub] Fixed Version Loaded!")
