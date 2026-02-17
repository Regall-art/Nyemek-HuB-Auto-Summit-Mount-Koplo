-- [[ NYEMEK HUB: MOUNT KOPLO PROTECT - FIXED TELEPORT ]] --
-- Fitur Lama Dihapus | UI Rayfield Style Preserved

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- ============================================
-- UI LIBRARY (RAYFIELD STYLE)
-- ============================================
-- Gunakan Logo rbxassetid://112653532744867 (Sesuaikan)
local LOGO_IMAGE = "rbxassetid://112653532744867"

local _G = {
    AutoSummit = false,
    NameSpoof = false
}

-- ============================================
-- FIXED TELEPORT & SPOOF LOGIC
-- ============================================

local function DirectTeleport()
    pcall(function()
        -- FIX PATH: Berdasarkan gambar Dex, pathnya adalah Workspace.Checkpoints.BoxSpawnSummitA
        local target = Workspace:FindFirstChild("Checkpoints") and Workspace.Checkpoints:FindFirstChild("BoxSpawnSummitA")
        
        if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- Teleport instan menggunakan CFrame
            player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end

-- Fast Loop System (0.1s)
task.spawn(function()
    while task.wait(0.1) do
        -- 1. Auto Summit (Langsung Teleport Tanpa Delay)
        if _G.AutoSummit then
            DirectTeleport()
        end
        
        -- 2. Name Spoofer (Nickname Label Spoofing)
        if _G.NameSpoof then
            pcall(function()
                -- Mencari label "Nickname" di overhead GUI karakter anda
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("TextLabel") and (v.Name == "Nickname" or v.Name == "NicknameLabel") then
                        v.Text = "Nyemek HuB Protect"
                        v.TextColor3 = Color3.fromRGB(0, 255, 255) -- Cyan Neon
                    end
                end
            end)
        end
    end
end)

-- ============================================
-- UI INITIALIZATION (RAYFIELD INTERFACE)
-- ============================================
-- PENTING: Gunakan fungsi Rayfield Library anda di sini
-- Saya buatkan inisialisasi tab sesuai UI lama anda:

local Window = Rayfield:CreateWindow({
    Name = "NYEMEK HUB | MOUNT KOPLO PROTECT",
    LoadingTitle = "Nyemek HuB Engine",
    LoadingSubtitle = "by Love",
    ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("🌋 Summit", 4483362458) -- Icon ID
local ProtectTab = Window:CreateTab("🛡️ Protection", 4483345998)

-- TAB SUMMIT (AUTO TELEPORT)
MainTab:CreateToggle({
    Name = "AUTO SUMMIT (BOXSPAWN)",
    CurrentValue = false,
    Flag = "ToggleSummit",
    Callback = function(Value)
        _G.AutoSummit = Value
        if Value then
            DirectTeleport() -- Langsung teleport sekali saat ON
            Rayfield:Notify({Title = "Status", Content = "Auto Summit: [ ON ]", Duration = 2})
        end
    end,
})

MainTab:CreateButton({
    Name = "FORCE TELEPORT ONCE",
    Callback = function()
        DirectTeleport()
    end,
})

-- TAB PROTECTION (NAME SPOOF)
ProtectTab:CreateToggle({
    Name = "NAME SPOOFER (PROTECT)",
    CurrentValue = false,
    Flag = "ToggleSpoof",
    Callback = function(Value)
        _G.NameSpoof = Value
        if Value then
            Rayfield:Notify({Title = "Status", Content = "Name Spoofed to Nyemek HuB Protect", Duration = 2})
        end
    end,
})

MainTab:CreateParagraph({Title = "Info", Content = "Script ini otomatis mendeteksi part di Workspace.Checkpoints.BoxSpawnSummitA"})

print("Nyemek HuB Protect Loaded Successfully!")
