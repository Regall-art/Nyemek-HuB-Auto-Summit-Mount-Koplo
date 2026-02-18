-- [[ NYEMEK HUB | MOUNT KOPLO PROTECT ]] --
-- FIXED BASED ON DEX EXPLORER SCREENSHOT

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- [[ SETTINGS ]] --
local Settings = {
    AutoSummit = false,
    NameSpoofer = false,
    SpoofedName = "Nyemek HuB Protect",
}

-- [[ LOGIC: AUTO SUMMIT ]] --
-- Sesuai screenshot: Workspace > Checkpoints > BoxSpawnSummitA
local function DoAutoSummit()
    pcall(function()
        local checkpoints = Workspace:FindFirstChild("Checkpoints")
        local target = checkpoints and checkpoints:FindFirstChild("BoxSpawnSummitA")
        
        if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            -- Teleport langsung ke posisi part
            hrp.CFrame = target.CFrame + Vector3.new(0, 3, 0)
            
            -- Trigger Touched agar server memberikan skor/badge
            if firetouchinterest then
                firetouchinterest(hrp, target, 0)
                task.wait(0.1)
                firetouchinterest(hrp, target, 1)
            end
        end
    end)
end

-- [[ LOGIC: NAME SPOOFER ]] --
-- Sesuai screenshot: Head > PlayerTitleGui > SummitLabel
local function UpdateNames()
    for _, v in pairs(Players:GetPlayers()) do
        pcall(function()
            if v.Character and v.Character:FindFirstChild("Head") then
                local titleGui = v.Character.Head:FindFirstChild("PlayerTitleGui")
                if titleGui then
                    -- Mengubah "SummitLabel" (teks Synx/Rank) menjadi nama proteksi
                    local label = titleGui:FindFirstChild("SummitLabel")
                    if label and label:IsA("TextLabel") then
                        label.Text = Settings.SpoofedName
                        label.TextColor3 = Color3.fromRGB(0, 255, 0) -- Hijau sesuai tema UI
                    end
                end
            end
        end)
    end
end

-- [[ LOOPING SYSTEM ]] --
task.spawn(function()
    while task.wait(0.5) do
        if Settings.AutoSummit then DoAutoSummit() end
        if Settings.NameSpoofer then UpdateNames() end
    end
end)

-- [[ UI LIBRARY & DESIGN - ASLI 100% ]] --
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

local Rayfield = {}

function Rayfield:CreateWindow(config)
    local WindowName = config.Name or "Rayfield UI"
    local ScreenGui = Instance.new("ScreenGui"); ScreenGui.Name = "NyemekHubUI"; ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = CoreGui end)
    if ScreenGui.Parent ~= CoreGui then ScreenGui.Parent = player.PlayerGui end

    local Main = Instance.new("Frame"); Main.Name = "Main"; Main.Size = UDim2.new(0,0,0,0); Main.Position = UDim2.new(0.5,0,0.5,0); Main.AnchorPoint = Vector2.new(0.5,0.5); Main.BackgroundColor3 = Theme.Background; Main.BorderSizePixel = 0; Main.ClipsDescendants = true; Main.Parent = ScreenGui
    local MainCorner = Instance.new("UICorner"); MainCorner.CornerRadius = UDim.new(0,6); MainCorner.Parent = Main
    local MainStroke = Instance.new("UIStroke"); MainStroke.Color = Color3.fromRGB(0,255,0); MainStroke.Thickness = 2; MainStroke.Parent = Main
    
    local Topbar = Instance.new("Frame"); Topbar.Size = UDim2.new(1,0,0,42); Topbar.BackgroundColor3 = Theme.Topbar; Topbar.Parent = Main
    local Title = Instance.new("TextLabel"); Title.Size = UDim2.new(1,-50,1,0); Title.Position = UDim2.new(0,12,0,0); Title.BackgroundTransparency = 1; Title.Text = WindowName; Title.TextColor3 = Color3.fromRGB(0,255,0); Title.Font = Enum.Font.GothamBold; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.Parent = Topbar
    local CloseButton = Instance.new("ImageButton"); CloseButton.Size = UDim2.new(0,18,0,18); CloseButton.Position = UDim2.new(1,-30,0.5,-9); CloseButton.BackgroundTransparency = 1; CloseButton.Image = "rbxassetid://7733717447"; CloseButton.Parent = Topbar

    local TabContainer = Instance.new("ScrollingFrame"); TabContainer.Size = UDim2.new(0,155,1,-52); TabContainer.Position = UDim2.new(0,5,0,47); TabContainer.BackgroundColor3 = Theme.TabBackground; TabContainer.ScrollBarThickness = 0; TabContainer.Parent = Main
    Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0,3)

    local ContentContainer = Instance.new("Frame"); ContentContainer.Size = UDim2.new(1,-170,1,-52); ContentContainer.Position = UDim2.new(0,165,0,47); ContentContainer.BackgroundTransparency = 1; ContentContainer.Parent = Main

    local MiniButton = Instance.new("TextButton"); MiniButton.Size = UDim2.new(0,60,0,60); MiniButton.Position = UDim2.new(1,-70,0.95,-70); MiniButton.BackgroundTransparency = 1; MiniButton.Text = ""; MiniButton.Visible = false; MiniButton.Parent = ScreenGui
    CreateNYLogo(MiniButton)

    CloseButton.MouseButton1Click:Connect(function()
        Tween(Main,{Size=UDim2.new(0,0,0,0)},Animations.Back); task.wait(0.5); Main.Visible = false
        MiniButton.Visible = true; MiniButton.Size = UDim2.new(0,0,0,0); Tween(MiniButton,{Size=UDim2.new(0,60,0,60)},Animations.Back)
    end)
    MiniButton.MouseButton1Click:Connect(function()
        MiniButton.Visible = false; Main.Visible = true; Tween(Main,{Size=UDim2.new(0,500,0,400)},Animations.Back)
    end)

    MakeDraggable(Main, Topbar); MakeDraggable(MiniButton)
    Tween(Main,{Size=UDim2.new(0,500,0,400)},Animations.Back)
    return {TabContainer=TabContainer, ContentContainer=ContentContainer, Tabs={}, CurrentTab=nil}
end

function Rayfield:CreateTab(Window, config)
    local TabName = config.Name or "Tab"
    local TabButton = Instance.new("TextButton", Window.TabContainer); TabButton.Size = UDim2.new(1,0,0,32); TabButton.BackgroundTransparency = 1; TabButton.Text = ""
    local TabTitle = Instance.new("TextLabel", TabButton); TabTitle.Size = UDim2.new(1,-20,1,0); TabTitle.Position = UDim2.new(0,10,0,0); TabTitle.BackgroundTransparency = 1; TabTitle.Text = TabName; TabTitle.TextColor3 = Theme.TextDark; TabTitle.Font = Enum.Font.GothamMedium; TabTitle.TextXAlignment = "Left"

    local TabContent = Instance.new("ScrollingFrame", Window.ContentContainer); TabContent.Size = UDim2.new(1,-10,1,-10); TabContent.BackgroundTransparency = 1; TabContent.Visible = false; TabContent.ScrollBarThickness = 3
    Instance.new("UIListLayout", TabContent).Padding = UDim.new(0,8)

    TabButton.MouseButton1Click:Connect(function()
        for _, t in pairs(Window.Tabs) do t.Content.Visible = false; t.Title.TextColor3 = Theme.TextDark end
        TabContent.Visible = true; TabTitle.TextColor3 = Color3.fromRGB(0,255,0); Window.CurrentTab = TabName
    end)
    
    local Tab = {Title=TabTitle, Content=TabContent, Button=TabButton}
    Window.Tabs[TabName] = Tab
    if not Window.CurrentTab then TabContent.Visible = true; TabTitle.TextColor3 = Color3.fromRGB(0,255,0); Window.CurrentTab = TabName end
    return Tab
end

function Rayfield:CreateToggle(Tab, config)
    local ToggleFrame = Instance.new("Frame", Tab.Content); ToggleFrame.Size = UDim2.new(1,0,0,35); ToggleFrame.BackgroundColor3 = Theme.ElementBackground
    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0,5)
    local Title = Instance.new("TextLabel", ToggleFrame); Title.Size = UDim2.new(1,-60,1,0); Title.Position = UDim2.new(0,10,0,0); Title.BackgroundTransparency = 1; Title.Text = config.Name; Title.TextColor3 = Theme.TextColor; Title.TextXAlignment = "Left"
    
    local ToggleBtn = Instance.new("TextButton", ToggleFrame); ToggleBtn.Size = UDim2.new(0,40,0,20); ToggleBtn.Position = UDim2.new(1,-45,0.5,-10); ToggleBtn.BackgroundColor3 = Theme.ToggleBackground; ToggleBtn.Text = ""
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)
    local Indicator = Instance.new("Frame", ToggleBtn); Indicator.Size = UDim2.new(0,16,0,16); Indicator.Position = UDim2.new(0,2,0.5,-8); Indicator.BackgroundColor3 = Theme.ToggleDisabled
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1,0)

    local toggled = config.CurrentValue or false
    local function Update()
        if toggled then
            Tween(Indicator, {Position=UDim2.new(1,-18,0.5,-8), BackgroundColor3=Theme.ToggleEnabled})
        else
            Tween(Indicator, {Position=UDim2.new(0,2,0.5,-8), BackgroundColor3=Theme.ToggleDisabled})
        end
    end
    Update()
    ToggleBtn.MouseButton1Click:Connect(function() toggled = not toggled; Update(); config.Callback(toggled) end)
end

function Rayfield:CreateParagraph(Tab, config)
    local Frame = Instance.new("Frame", Tab.Content); Frame.Size = UDim2.new(1,0,0,40); Frame.BackgroundColor3 = Theme.ElementBackground
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,5)
    local T = Instance.new("TextLabel", Frame); T.Size = UDim2.new(1,-20,1,0); T.Position = UDim2.new(0,10,0,0); T.BackgroundTransparency = 1; T.Text = config.Title .. ": " .. config.Content; T.TextColor3 = Theme.TextColor; T.TextXAlignment = "Left"
end

-- [[ EKSEKUSI MENU ]] --
local Window = Rayfield:CreateWindow({Name = "NYEMEK HUB | MOUNT KOPLO PROTECT"})
local MainTab = Rayfield:CreateTab(Window, {Name = "🏔️ Main"})

Rayfield:CreateParagraph(MainTab, {Title = "INFO", Content = "Auto Summit sesuai posisi Dex Explorer kamu."})

Rayfield:CreateToggle(MainTab, {
    Name = "AUTO SUMMIT (BOXSPAWN)",
    Callback = function(val) Settings.AutoSummit = val end
})

Rayfield:CreateToggle(MainTab, {
    Name = "NAME SPOOFER (PROTECT)",
    Callback = function(val) Settings.NameSpoofer = val end
})

print("✅ NYEMEK HUB LOADED!")
