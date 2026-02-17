-- [[ NYEMEK HUB: AUTO SUMMIT & NAME PROTECT ]] --
-- UI LAMA (LIBRARY ASLI) TETAP DIGUNAKAN
-- FITUR FPS LAMA DIHAPUS, DIGANTI TOTAL

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
        -- FIX PATH: Workspace > Checkpoints > BoxSpawnSummitA (Sesuai Gambar Dex)
        local target = Workspace:FindFirstChild("Checkpoints") and Workspace.Checkpoints:FindFirstChild("BoxSpawnSummitA")
        if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end

-- Loop System untuk Teleport & Spoof
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoSummit then DirectTeleport() end
        if _G.NameSpoof then
            pcall(function()
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("TextLabel") and (v.Name == "Nickname" or v.Name == "NicknameLabel") then
                        v.Text = "Nyemek HuB Protect"
                        v.TextColor3 = Color3.fromRGB(0, 255, 255)
                    end
                end
            end)
        end
    end
end)

-- [[ UI LIBRARY ASLI (PRESERVED) ]] --
local function Tween(obj, props, info)
   TweenService:Create(obj, info or TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props):Play()
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
         Tween(frame, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, TweenInfo.new(0.2, Enum.EasingStyle.Linear))
      end
   end)
end

local Rayfield = {}
local Theme = {
   Background = Color3.fromRGB(25, 25, 25), Topbar = Color3.fromRGB(30, 30, 30),
   TabBackground = Color3.fromRGB(20, 20, 20), ElementBackground = Color3.fromRGB(35, 35, 35),
   ElementStroke = Color3.fromRGB(50, 50, 50), TextColor = Color3.fromRGB(240, 240, 240),
   TextDark = Color3.fromRGB(150, 150, 150), ToggleEnabled = Color3.fromRGB(0, 125, 255)
}

function Rayfield:CreateWindow(config)
   local ScreenGui = Instance.new("ScreenGui", CoreGui)
   ScreenGui.Name = "RayfieldUI"
   
   local Main = Instance.new("Frame", ScreenGui)
   Main.Size = UDim2.new(0, 500, 0, 475)
   Main.Position = UDim2.new(0.5, 0, 0.5, 0)
   Main.AnchorPoint = Vector2.new(0.5, 0.5)
   Main.BackgroundColor3 = Theme.Background
   Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)
   
   local Topbar = Instance.new("Frame", Main)
   Topbar.Size = UDim2.new(1, 0, 0, 42)
   Topbar.BackgroundColor3 = Theme.Topbar
   Instance.new("UICorner", Topbar).CornerRadius = UDim.new(0, 6)
   
   local Title = Instance.new("TextLabel", Topbar)
   Title.Text = "  " .. config.Name
   Title.Size = UDim2.new(1, 0, 1, 0)
   Title.TextColor3 = Theme.TextColor
   Title.BackgroundTransparency = 1
   Title.Font = Enum.Font.GothamBold
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

   MakeDraggable(Main, Topbar)

   return {Main = Main, TabContainer = TabContainer, ContentContainer = ContentContainer, Tabs = {}}
end

function Rayfield:CreateTab(Window, name)
   local TabButton = Instance.new("TextButton", Window.TabContainer)
   TabButton.Size = UDim2.new(1, 0, 0, 32)
   TabButton.BackgroundColor3 = Theme.ElementBackground
   TabButton.Text = name
   TabButton.TextColor3 = Theme.TextColor
   Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 5)

   local TabContent = Instance.new("ScrollingFrame", Window.ContentContainer)
   TabContent.Size = UDim2.new(1, 0, 1, 0)
   TabContent.BackgroundTransparency = 1
   TabContent.Visible = false
   Instance.new("UIListLayout", TabContent).Padding = UDim.new(0, 8)

   TabButton.MouseButton1Click:Connect(function()
      for _, v in pairs(Window.ContentContainer:GetChildren()) do v.Visible = false end
      TabContent.Visible = true
   end)
   
   if #Window.TabContainer:GetChildren() == 2 then TabContent.Visible = true end -- Auto open first tab

   return {Content = TabContent}
end

function Rayfield:CreateToggle(Tab, config)
   local Frame = Instance.new("Frame", Tab.Content)
   Frame.Size = UDim2.new(1, 0, 0, 40)
   Frame.BackgroundColor3 = Theme.ElementBackground
   Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)

   local Title = Instance.new("TextLabel", Frame)
   Title.Text = "  " .. config.Name
   Title.Size = UDim2.new(1, -50, 1, 0)
   Title.TextColor3 = Theme.TextColor
   Title.BackgroundTransparency = 1
   Title.TextXAlignment = Enum.TextXAlignment.Left

   local Btn = Instance.new("TextButton", Frame)
   Btn.Size = UDim2.new(0, 40, 0, 20)
   Btn.Position = UDim2.new(1, -45, 0.5, -10)
   Btn.Text = ""
   Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
   Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

   local state = config.CurrentValue or false
   Btn.MouseButton1Click:Connect(function()
      state = not state
      Btn.BackgroundColor3 = state and Theme.ToggleEnabled or Color3.fromRGB(50, 50, 50)
      config.Callback(state)
   end)
end

-- [[ INISIALISASI WINDOW & FITUR ]] --
local Window = Rayfield:CreateWindow({Name = "Nyemek HuB | Mount Koplo Protect"})

local MainTab = Rayfield:CreateTab(Window, "🌋 Summit")
local ProtectTab = Rayfield:CreateTab(Window, "🛡️ Protection")

Rayfield:CreateToggle(MainTab, {
   Name = "AUTO SUMMIT (INSTANT)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoSummit = Value
      if Value then DirectTeleport() end
   end
})

Rayfield:CreateToggle(ProtectTab, {
   Name = "SPOOF NICKNAME LABEL",
   CurrentValue = false,
   Callback = function(Value)
      _G.NameSpoof = Value
   end
})

print("✅ Nyemek HuB Loaded with OLD UI!")
