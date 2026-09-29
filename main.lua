-- BloxNexus Ultra - Key System Loader for Blox Fruits
-- Simpan kode ini ke file main.lua di GitHub Anda
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ProtectedGui = (gethui and gethui()) or CoreGui
-- Hapus GUI lama jika ada
if ProtectedGui:FindFirstChild("BloxNexusKeySystem") then
ProtectedGui.BloxNexusKeySystem:Destroy()
end
-- 1. MEMBUAT GUI KEY SYSTEM (Tampilan awal seperti Airflow)
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "BloxNexusKeySystem"
KeyGui.Parent = ProtectedGui
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeyGui.ResetOnSpawn = false
local KeyFrame = Instance.new("Frame")
KeyFrame.Parent = KeyGui
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
KeyFrame.Position = UDim2.new(0.5, -210, 0.5, -130)
KeyFrame.Size = UDim2.new(0, 420, 0, 260)
KeyFrame.Active = true
KeyFrame.Draggable = true
local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 14)
KeyCorner.Parent = KeyFrame
local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(139, 92, 246)
KeyStroke.Thickness = 1.5
KeyStroke.Parent = KeyFrame
-- Judul Key System
local Title = Instance.new("TextLabel")
Title.Parent = KeyFrame
Title.BackgroundTransparency = 1.0
Title.Position = UDim2.new(0, 20, 0, 20)
Title.Size = UDim2.new(0, 380, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "BLOXNEXUS | Blox Fruits Key System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
local Subtitle = Instance.new("TextLabel")
Subtitle.Parent = KeyFrame
Subtitle.BackgroundTransparency = 1.0
Subtitle.Position = UDim2.new(0, 20, 0, 50)
Subtitle.Size = UDim2.new(0, 380, 0, 20)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Masukkan key akses untuk memuat script Blox Fruits."
Subtitle.TextColor3 = Color3.fromRGB(148, 163, 184)
Subtitle.TextSize = 12
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
-- Kotak Input Key
local TextBox = Instance.new("TextBox")
TextBox.Parent = KeyFrame
TextBox.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
TextBox.Position = UDim2.new(0, 20, 0, 90)
TextBox.Size = UDim2.new(0, 380, 0, 45)
TextBox.Font = Enum.Font.Code
TextBox.PlaceholderText = "Paste your key here (contoh: NEXUS2026)"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderColor3 = Color3.fromRGB(100, 116, 139)
TextBox.TextSize = 13
local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = TextBox
-- Tombol Submit
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Parent = KeyFrame
SubmitBtn.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
SubmitBtn.Position = UDim2.new(0, 20, 0, 155)
SubmitBtn.Size = UDim2.new(0, 180, 0, 42)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Text = "Submit Key"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 13
local SubCorner = Instance.new("UICorner")
SubCorner.CornerRadius = UDim.new(0, 8)
SubCorner.Parent = SubmitBtn
-- Tombol Auto-Fill Key
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Parent = KeyFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
GetKeyBtn.Position = UDim2.new(0, 220, 0, 155)
GetKeyBtn.Size = UDim2.new(0, 180, 0, 42)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "Auto-Fill Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 13
local GetCorner = Instance.new("UICorner")
GetCorner.CornerRadius = UDim.new(0, 8)
GetCorner.Parent = GetKeyBtn
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = KeyFrame
StatusLabel.BackgroundTransparency = 1.0
StatusLabel.Position = UDim2.new(0, 20, 0, 215)
StatusLabel.Size = UDim2.new(0, 380, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Key Required"
StatusLabel.TextColor3 = Color3.fromRGB(244, 63, 94)
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
-- LOGIKA VALIDASI KEY & MEMUAT SCRIPT BLOX FRUITS
local ValidKeys = {"NEXUS2026", "VIPUSER", "DEVELOPER"}
SubmitBtn.MouseButton1Click:Connect(function()
local enteredKey = TextBox.Text
local isCorrect = false
for _, k in ipairs(ValidKeys) do
if enteredKey == k then
isCorrect = true
break
end
end
if isCorrect then
StatusLabel.TextColor3 = Color3.fromRGB(16, 185, 129)
StatusLabel.Text = "Status: Key Valid! Memuat Blox Fruits Script..."
task.wait(0.8)
KeyGui:Destroy() -- Tutup jendela key system
-- Mengunduh dan menjalankan file bloxfruits.lua dari GitHub Anda secara otomatis
local success, err = pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cangcutpincen/main.lua/main/bloxfruits.lua"))()
end)
if not success then
warn("[BloxNexus]: Gagal memuat bloxfruits.lua -> " .. tostring(err))
end
else
StatusLabel.TextColor3 = Color3.fromRGB(244, 63, 94)
StatusLabel.Text = "Status: Key Salah! Coba lagi."
end
end)
GetKeyBtn.MouseButton1Click:Connect(function()
TextBox.Text = "NEXUS2026"
StatusLabel.TextColor3 = Color3.fromRGB(56, 189, 248)
StatusLabel.Text = "Status: Key otomatis terisi. Klik Submit!"
end)
print("[BloxNexus]: Key System berhasil dimuat!")
