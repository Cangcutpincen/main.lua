-- CangcutNexus Hub - Professional Loader & Key System Template
-- Masukkan kode ini sebagai skrip utama yang dipanggil via loadstring di Delta.
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
-- Konfigurasi Loader & Keamanan Key
local Config = {
HubName = "CangcutNexus Ultra Hub",
KeyFileName = "CangcutNexus_Key.json",
-- Daftar kunci akses yang valid (bisa dihubungkan ke database online via HttpGet)
ValidKeys = {"NEXUS2026", "VIPUSER", "DEVELOPER_ACCESS"},
-- Pemetaan PlaceId game Roblox dengan file skrip cheat khusus di GitHub Anda
SupportedGames = {
[2753915549] = "https://raw.githubusercontent.com/Cangcutpincen/main.lua/main/bloxfruits.lua", -- Blox Fruits
[142823291]  = "https://raw.githubusercontent.com/Cangcutpincen/main.lua/main/mm2.lua",         -- Murder Mystery 2
[6516141723] = "https://raw.githubusercontent.com/Cangcutpincen/main.lua/main/bedwars.lua",      -- BedWars
},
-- Skrip cadangan jika game tidak terdaftar di atas
UniversalScript = "https://raw.githubusercontent.com/Cangcutpincen/main.lua/main/universal.lua"
}
-- Fungsi Notifikasi Internal (menggunakan CoreGui agar aman dari deteksi UI game)
local function SendNotification(title, text, duration)
pcall(function()
game:GetService("StarterGui"):SetCore("SendNotification", {
Title = title,
Text = text,
Duration = duration or 4,
})
end)
end
print("[" .. Config.HubName .. "]: Inisialisasi sistem keamanan loader...")
-- Cek apakah file key lokal sudah ada (agar user tidak perlu memasukkan key berulang kali)
local function HasValidSavedKey()
if writefile and readfile and isfile then
if isfile(Config.KeyFileName) then
local savedData = readfile(Config.KeyFileName)
for _, key in ipairs(Config.ValidKeys) do
if savedData == key then
return true
end
end
end
end
return false
end
-- Logika Utama Loader & Eksekusi Modul Game
local function InitializeLoader()
local currentPlaceId = game.PlaceId
local targetScriptUrl = Config.SupportedGames[currentPlaceId] or Config.UniversalScript
SendNotification(Config.HubName, "Game terdeteksi! Mengunduh modul cheat...", 3)
print("[" .. Config.HubName .. "]: Memuat skrip dari URL: " .. targetScriptUrl)
-- Mengunduh dan mengeksekusi skrip modul cheat target secara aman
local success, errorMessage = pcall(function()
local rawCode = game:HttpGet(targetScriptUrl)
local loadedFunction, compileError = loadstring(rawCode)
if compileError then
error("Kompilasi gagal: " tostring(compileError))
end
-- Jalankan fungsi skrip cheat
loadedFunction()
end)
if success then
SendNotification(Config.HubName, "Modul cheat berhasil diaktifkan!", 5)
print("[" .. Config.HubName .. "]: Skrip berhasil dieksekusi tanpa kendala.")
else
SendNotification(Config.HubName, "Gagal memuat modul! Cek console logs.", 5)
warn("[" .. Config.HubName .. "]: Error eksekusi -> " .. tostring(errorMessage))
end
end
-- Jalankan loader
InitializeLoader()
