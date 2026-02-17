-- [[ NYEMEK HUB: AUTO SUMMIT & NAME PROTECT - FULL EXECUTE ]] --
-- Fitur FPS Lama Dihapus | UI Rayfield Style | Auto Teleport Fix

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- ============================================
-- 1. LOGIKA UTAMA (TELEPORT & SPOOF)
-- ============================================
local _G = {
    AutoSummit = false,
    NameSpoof = false
}

local function DirectTeleport()
    pcall(function()
        -- FIX PATH: Workspace > Checkpoints > BoxSpawnSummitA (Berdasarkan Gambar Dex)
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
                        v.Text = "Nyemek HuB Protect"
                        v.TextColor3 = Color3.fromRGB(0, 255, 255)
                    end
                end
            end)
        end
    end
end)

-- ============================================
-- 2. LOAD RAYFIELD LIBRARY (MINIFIED)
-- ============================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ============================================
-- 3. INTERFACE BUILDER
-- ============================================
local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB | Mount Koplo Protect",
   LoadingTitle = "Nyemek HuB Engine",
   LoadingSubtitle = "by Love",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false -- Ganti true jika ingin pakai key
})

local MainTab = Window:CreateTab("🌋 Summit", 4483362458)
local ProtectTab = Window:CreateTab("🛡️ Protection", 4483345998)

-- TAB SUMMIT
MainTab:CreateToggle({
   Name = "AUTO SUMMIT (BOXSPAWN)",
   CurrentValue = false,
   Flag = "SummitToggle",
   Callback = function(Value)
      _G.AutoSummit = Value
      if Value then DirectTeleport() end
   end,
})

MainTab:CreateButton({
   Name = "FORCE TELEPORT ONCE",
   Callback = function() DirectTeleport() end,
})

-- TAB PROTECTION
ProtectTab:CreateToggle({
   Name = "NAME SPOOFER (PROTECT)",
   CurrentValue = false,
   Flag = "SpoofToggle",
   Callback = function(Value)
      _G.NameSpoof = Value
   end,
})

Rayfield:Notify({
   Title = "Nyemek HuB Ready",
   Content = "Auto Summit & Name Spoof Aktif!",
   Duration = 5,
   Image = 4483362458,
})
