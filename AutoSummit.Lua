-- [[ NYEMEK HUB | MOUNT KOPLO PROTECT FIXED ]] --
-- SESUAI STRUKTUR DEX EXPLORER

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

local Settings = {
    AutoSummit = false,
    NameSpoofer = false,
    SpoofedName = "Nyemek HuB Protect",
}

-- [[ FUNGSI AUTO SUMMIT (FIXED PATH) ]] --
local function DoAutoSummit()
    pcall(function()
        -- Berdasarkan foto: Workspace -> Checkpoints -> BoxSpawnSummitA
        local target = Workspace:FindFirstChild("Checkpoints") and Workspace.Checkpoints:FindFirstChild("BoxSpawnSummitA")
        
        if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            -- Teleport ke posisi BoxSpawnSummitA
            hrp.CFrame = target.CFrame + Vector3.new(0, 3, 0)
            
            -- Trigger Touched agar Server deteksi kamu sampai
            if firetouchinterest then
                firetouchinterest(hrp, target, 0)
                task.wait(0.1)
                firetouchinterest(hrp, target, 1)
            end
        end
    end)
end

-- [[ FUNGSI NAME SPOOFER (FIXED FOR SUMMITLABEL) ]] --
local function UpdateNames()
    for _, v in pairs(Players:GetPlayers()) do
        pcall(function()
            if v.Character and v.Character:FindFirstChild("Head") then
                -- Berdasarkan foto: Head -> PlayerTitleGui -> SummitLabel
                local titleGui = v.Character.Head:FindFirstChild("PlayerTitleGui")
                if titleGui then
                    local label = titleGui:FindFirstChild("SummitLabel")
                    if label and label:IsA("TextLabel") then
                        label.Text = Settings.SpoofedName
                        label.TextColor3 = Color3.fromRGB(0, 255, 255) -- Warna Cyan Proteksi
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

-- =============================================
-- UI LIBRARY (KODE ASLI KAMU - TIDAK DIUBAH)
-- =============================================
-- ... (Gunakan sisa kode UI dari script terakhirmu di sini)
-- ... (Bagian CreateWindow, CreateTab, dan CreateToggle tetap sama)

-- CONTOH CALLBACK UNTUK TOGGLE:
-- Rayfield:CreateToggle(MainTab, {
--    Name = "AUTO SUMMIT (BOXSPAWN)",
--    Callback = function(v) Settings.AutoSummit = v end
-- })

-- Rayfield:CreateToggle(MainTab, {
--    Name = "NAME SPOOFER (PROTECT)",
--    Callback = function(v) Settings.NameSpoofer = v end
-- })
