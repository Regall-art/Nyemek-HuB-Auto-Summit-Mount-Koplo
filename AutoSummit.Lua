-- [[ NYEMEK HUB: AUTO SUMMIT & NAME PROTECT ]] --
-- MENGGUNAKAN UI LIBRARY LAMA (KODE INTERNAL)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- [[ LOGIKA FITUR ]] --
local _G = {
    AutoSummit = false,
    NameSpoof = false
}

-- Fungsi Teleport Langsung
local function DirectTeleport()
    pcall(function()
        -- Path diperbaiki sesuai gambar Dex: Workspace > Checkpoints > BoxSpawnSummitA
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
                            v.TextColor3 = Color3.fromRGB(0, 255, 255) -- Warna Cyan
                        end
                    end
                end
            end)
        end
    end
end)

-- [[ UI LIBRARY LAMA (RE-WRITTEN) ]] --
-- Ini adalah bagian UI yang tidak berubah sesuai permintaanmu

local Rayfield = {}
local Theme = {
   Background = Color3.fromRGB(25, 25, 25),
   Topbar = Color3.fromRGB(30, 30, 30),
   TabBackground = Color3.fromRGB(20, 20, 20),
   ElementBackground = Color3.fromRGB(35, 35, 35),
   TextColor = Color3.fromRGB(240, 240, 240),
   ToggleEnabled = Color3.fromRGB(0, 125, 255)
}

function Rayfield:CreateWindow(config)
   local ScreenGui = Instance.new("ScreenGui", CoreGui)
   ScreenGui.Name = "NyemekHubUI"
   
   local Main = Instance.new("Frame", ScreenGui)
   Main.Size = UDim2.new(0, 450, 0, 350)
   Main.Position = UDim2.new(0.5, 0, 0.5, 0)
   Main.AnchorPoint = Vector2.new(0.5, 0.5)
   Main.BackgroundColor3 = Theme.Background
   Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
   
   local Topbar = Instance.new("Frame", Main)
   Topbar.Size = UDim2.new(1, 0, 0, 40)
   Topbar.BackgroundColor3 = Theme.Topbar
   Instance.new("UICorner", Topbar).CornerRadius = UDim.new(0, 8)
   
   local Title = Instance.new("TextLabel", Topbar)
   Title.Text = "  " .. config.Name
   Title.Size = UDim2.new(1, 0, 1, 0)
   Title.TextColor3 = Theme.TextColor
   Title.BackgroundTransparency = 1
   Title.Font = Enum.Font.GothamBold
   Title.TextXAlignment = Enum.TextXAlignment.Left

   local Content = Instance.new("ScrollingFrame", Main)
   Content.Size = UDim2.new(1, -20, 1, -60)
   Content.Position = UDim2.new(0, 10, 0, 50)
   Content.BackgroundTransparency = 1
   Content.ScrollBarThickness = 2
   local List = Instance.new("UIListLayout", Content)
   List.Padding = UDim.new(0, 5)

   return {Content = Content}
end

function Rayfield:CreateToggle(parent, config)
   local Btn = Instance.new("TextButton", parent.Content)
   Btn.Size = UDim2.new(1, 0, 0, 40)
   Btn.BackgroundColor3 = Theme.ElementBackground
   Btn.Text = "  " .. config.Name .. " : [ OFF ]"
   Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
   Btn.Font = Enum.Font.GothamBold
   Btn.TextXAlignment = Enum.TextXAlignment.Left
   Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

   local active = false
   Btn.MouseButton1Click:Connect(function()
      active = not active
      Btn.Text = "  " .. config.Name .. " : [ " .. (active and "ON" or "OFF") .. " ]"
      Btn.TextColor3 = active and Theme.ToggleEnabled or Color3.fromRGB(200, 200, 200)
      config.Callback(active)
   end)
end

-- [[ EKSEKUSI FITUR KE UI ]] --
local Window = Rayfield:CreateWindow({Name = "NYEMEK HUB | MOUNT KOPLO PROTECT"})

Rayfield:CreateToggle(Window, {
   Name = "AUTO SUMMIT (BOXSPAWN)",
   Callback = function(val)
      _G.AutoSummit = val
      if val then DirectTeleport() end
   end
})

Rayfield:CreateToggle(Window, {
   Name = "NAME SPOOFER (PROTECT)",
   Callback = function(val)
      _G.NameSpoof = val
   end
})

print("Nyemek HuB: Berhasil dimuat dengan UI Lama!")
