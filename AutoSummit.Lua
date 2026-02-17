-- [[ NYEMEK HUB: AUTO SUMMIT & PROTECT - RAYFIELD STYLE ]] --
-- UI LAMA TETAP SAMA (LIBRARY PRESERVED)
-- FITUR LAMA DIHAPUS, DIGANTI TOTAL

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- ============================================
-- LOGO & THEME (SESUAIKAN DENGAN PUNYAMU)
-- ============================================
local LOGO_IMAGE = "rbxassetid://112653532744867" 

local Theme = {
   Background = Color3.fromRGB(25, 25, 25),
   Topbar = Color3.fromRGB(30, 30, 30),
   TabBackground = Color3.fromRGB(20, 20, 20),
   ElementBackground = Color3.fromRGB(35, 35, 35),
   ElementStroke = Color3.fromRGB(50, 50, 50),
   TextColor = Color3.fromRGB(240, 240, 240),
   TextDark = Color3.fromRGB(150, 150, 150)
}

-- [[ VARIABEL KONTROL ]] --
local _G = {
    AutoSummit = false,
    NameSpoof = false
}

-- ============================================
-- LOGIKA TELEPORT & SPOOF (FITUR BARU)
-- ============================================

local function DirectTeleport()
    pcall(function()
        -- Teleport Langsung ke BoxSpawnSummitA
        local target = Workspace:FindFirstChild("CheckPoints") and Workspace.CheckPoints:FindFirstChild("BoxSpawnSummitA")
        if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end

-- Loop System
task.spawn(function()
    while task.wait(0.1) do
        -- 1. Auto Summit (Langsung Teleport)
        if _G.AutoSummit then
            DirectTeleport()
        end
        
        -- 2. Name Spoofer (Overhead Protect)
        if _G.NameSpoof then
            pcall(function()
                -- Mencari label "Nickname" di overhead player
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("TextLabel") and (v.Name == "Nickname" or v.Name == "NicknameLabel") then
                        v.Text = "Nyemek HuB Protect"
                        v.TextColor3 = Color3.fromRGB(0, 255, 255) -- Warna Cyan Neon
                    end
                end
            end)
        end
    end
end)

-- ============================================
-- UI LIBRARY (MENGGUNAKAN KODE LAMA KAMU)
-- ============================================
-- PENTING: Paste/Tempel kode Library Rayfield milikmu di sini agar UI muncul.
-- Di bawah ini adalah contoh inisialisasi Tab dengan UI yang sama:

local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB | Mount Koplo Protect"
})

-- HANYA 2 TAB (SUMMIT & PROTECT)
local SummitTab = Rayfield:CreateTab(Window, {Name = "🌋 Summit"})
local ProtectTab = Rayfield:CreateTab(Window, {Name = "🛡️ Protection"})

-- TAB SUMMIT
Rayfield:CreateParagraph(SummitTab, {
   Title = "Teleport System",
   Content = "Auto Summit akan langsung mengirim kamu ke titik BoxSpawnSummitA secara instan."
})

Rayfield:CreateToggle(SummitTab, {
   Name = "Auto Summit (Direct Teleport)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoSummit = Value
      if Value then
          Rayfield:Notify({Title = "Summit Active", Content = "Teleporting to Peak...", Duration = 2})
      end
   end
})

Rayfield:CreateButton(SummitTab, {
   Name = "Manual Teleport Once",
   Callback = function()
      DirectTeleport()
   end
})

-- TAB PROTECTION
Rayfield:CreateParagraph(ProtectTab, {
   Title = "Identity Spoofer",
   Content = "Mengganti 'Nickname' label pada Overhead GUI menjadi 'Nyemek HuB Protect'."
})

Rayfield:CreateToggle(ProtectTab, {
   Name = "Spoof Nickname Label",
   CurrentValue = false,
   Callback = function(Value)
      _G.NameSpoof = Value
      if Value then
          Rayfield:Notify({Title = "Protector", Content = "Identity Spoofed Successfully!", Duration = 3})
      end
   end
})

Rayfield:CreateParagraph(ProtectTab, {
   Title = "No Visual Information",
   Content = "Fitur ini hanya mengubah teks pada overhead GUI (No Visual Hack)."
})

print("✅ Nyemek HuB: Fitur Lama Dihapus, Auto Summit & Spoof Aktif!")
