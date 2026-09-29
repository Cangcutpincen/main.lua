<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BloxNexus Ultra - Advanced Roblox Script Executor Hub</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;500;600&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                        mono: ['Fira Code', 'monospace'],
                    },
                    colors: {
                        darker: '#060913',
                        dark: '#0b0f19',
                        card: '#131c2e',
                        accent: {
                            400: '#38bdf8',
                            500: '#0ea5e9',
                            600: '#0284c7',
                            700: '#0369a1',
                        },
                        cyber: {
                            purple: '#a855f7',
                            emerald: '#10b981',
                            rose: '#f43f5e',
                            amber: '#f59e0b'
                        }
                    }
                }
            }
        }
    </script>
    <style>
        ::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }
        ::-webkit-scrollbar-track {
            background: #0b0f19;
        }
        ::-webkit-scrollbar-thumb {
            background: #1e293b;
            border-radius: 3px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #334155;
        }
        .glass-panel {
            background: rgba(19, 28, 46, 0.75);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }
        .glow-cyan {
            box-shadow: 0 0 25px rgba(14, 165, 233, 0.3);
        }
        .glow-purple {
            box-shadow: 0 0 25px rgba(168, 85, 247, 0.3);
        }
        @keyframes pulse-slow {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }
        .animate-pulse-slow {
            animation: pulse-slow 3s cubic-bezier(0.4, 0, 0.6, 1) infinite;
        }
    </style>
</head>
<body class="bg-darker text-slate-100 font-sans h-screen flex flex-col overflow-hidden select-none">

    <div id="toast" class="fixed top-5 right-5 z-50 transform translate-x-full transition-transform duration-300 bg-slate-900 border border-slate-700 text-white px-4 py-3 rounded-xl shadow-2xl flex items-center space-x-3">
        <div id="toast-icon" class="text-accent-500 text-lg"><i class="fa-solid fa-circle-info"></i></div>
        <div>
            <h4 id="toast-title" class="font-semibold text-sm">Notification</h4>
            <p id="toast-msg" class="text-xs text-slate-400">Action completed successfully.</p>
        </div>
    </div>

    <header class="h-14 bg-dark border-b border-slate-800 flex items-center justify-between px-4 z-20">
        <div class="flex items-center space-x-3">
            <div class="w-9 h-9 rounded-xl bg-gradient-to-tr from-cyan-500 to-indigo-600 flex items-center justify-center glow-cyan">
                <i class="fa-solid fa-cube text-white text-base"></i>
            </div>
            <div>
                <h1 class="font-bold text-sm tracking-wide text-white flex items-center gap-2">
                    BLOXNEXUS <span class="text-[10px] px-2 py-0.5 rounded-full bg-cyan-500/20 text-cyan-400 border border-cyan-500/30">Ultra v4.2 Roblox</span>
                </h1>
            </div>
        </div>

        <!-- Roblox Process Detector & Window Controls -->
        <div class="flex items-center space-x-4">
            <div id="roblox-status" class="flex items-center space-x-2 px-3 py-1.5 rounded-full bg-slate-800/80 border border-slate-700 text-slate-300 text-xs font-medium">
                <span class="w-2.5 h-2.5 rounded-full bg-amber-500 animate-ping"></span>
                <span id="roblox-status-text">Scanning Roblox Process...</span>
            </div>
            
            <div class="flex items-center space-x-1 text-slate-400 text-sm">
                <button onclick="showToast('Minimized to tray simulation', 'info')" class="w-8 h-8 rounded-lg hover:bg-slate-800 flex items-center justify-center transition"><i class="fa-solid fa-minus"></i></button>
                <button onclick="showToast('Fullscreen toggled', 'info')" class="w-8 h-8 rounded-lg hover:bg-slate-800 flex items-center justify-center transition"><i class="fa-solid fa-expand"></i></button>
                <button onclick="showToast('Closing application simulation', 'error')" class="w-8 h-8 rounded-lg hover:bg-rose-500/20 hover:text-rose-400 flex items-center justify-center transition"><i class="fa-solid fa-xmark"></i></button>
            </div>
        </div>
    </header>

    <div class="flex flex-1 overflow-hidden">
        <aside class="w-20 bg-dark/90 border-r border-slate-800 flex flex-col items-center py-5 space-y-5 z-10">
            <button onclick="switchTab('editor')" id="nav-editor" class="nav-btn w-12 h-12 rounded-2xl flex flex-col items-center justify-center text-cyan-400 bg-cyan-500/15 border border-cyan-500/30 transition group" title="Script Editor">
                <i class="fa-solid fa-code text-lg"></i>
                <span class="text-[10px] mt-1 font-medium">Editor</span>
            </button>
            <button onclick="switchTab('hub')" id="nav-hub" class="nav-btn w-12 h-12 rounded-2xl flex flex-col items-center justify-center text-slate-400 hover:text-white hover:bg-slate-800/60 transition group" title="Roblox Script Hub">
                <i class="fa-solid fa-gamepad text-lg"></i>
                <span class="text-[10px] mt-1 font-medium">Hubs</span>
            </button>
            <button onclick="switchTab('dex')" id="nav-dex" class="nav-btn w-12 h-12 rounded-2xl flex flex-col items-center justify-center text-slate-400 hover:text-white hover:bg-slate-800/60 transition group" title="Dex Explorer (DataModel)">
                <i class="fa-solid fa-sitemap text-lg"></i>
                <span class="text-[10px] mt-1 font-medium">Dex</span>
            </button>
            <button onclick="switchTab('unc')" id="nav-unc" class="nav-btn w-12 h-12 rounded-2xl flex flex-col items-center justify-center text-slate-400 hover:text-white hover:bg-slate-800/60 transition group" title="UNC Compatibility Tester">
                <i class="fa-solid fa-shield-halved text-lg"></i>
                <span class="text-[10px] mt-1 font-medium">UNC</span>
            </button>
            <button onclick="switchTab('console')" id="nav-console" class="nav-btn w-12 h-12 rounded-2xl flex flex-col items-center justify-center text-slate-400 hover:text-white hover:bg-slate-800/60 transition group relative" title="Execution Logs">
                <i class="fa-solid fa-terminal text-lg"></i>
                <span class="text-[10px] mt-1 font-medium">Logs</span>
                <span id="log-badge" class="absolute top-2 right-2 w-2 h-2 rounded-full bg-cyan-400 hidden"></span>
            </button>
            <button onclick="switchTab('settings')" id="nav-settings" class="nav-btn w-12 h-12 rounded-2xl flex flex-col items-center justify-center text-slate-400 hover:text-white hover:bg-slate-800/60 transition group" title="Settings">
                <i class="fa-solid fa-gear text-lg"></i>
                <span class="text-[10px] mt-1 font-medium">Config</span>
            </button>
            
            <div class="mt-auto">
                <button onclick="injectRoblox()" id="inject-btn" class="w-12 h-12 rounded-2xl bg-gradient-to-tr from-cyan-500 to-blue-600 text-white flex items-center justify-center shadow-lg hover:scale-105 active:scale-95 transition glow-cyan" title="Inject into RobloxPlayerBeta.exe">
                    <i class="fa-solid fa-bolt text-lg"></i>
                </button>
            </div>
        </aside>

        <main class="flex-1 flex flex-col bg-darker overflow-hidden relative">

            <!-- TAB 1: ADVANCED LUA EDITOR -->
            <section id="tab-editor" class="tab-content flex-1 flex flex-col overflow-hidden">
                
                <div class="bg-dark/90 border-b border-slate-800 px-4 py-3 flex flex-col md:flex-row md:items-center justify-between gap-3 z-10 shadow-inner">
                    <!-- Roblox Account Profile -->
                    <div class="flex items-center space-x-3.5">
                        <div class="relative">
                            <img src="https://placehold.co/48x48/131c2e/0ea5e9?text=Roblox" alt="Avatar" class="w-11 h-11 rounded-xl border border-cyan-500/40 object-cover shadow-md">
                            <span class="absolute -bottom-1 -right-1 w-3.5 h-3.5 rounded-full bg-emerald-500 border-2 border-dark animate-pulse"></span>
                        </div>
                        <div>
                            <div class="flex items-center gap-2">
                                <h4 class="font-bold text-xs text-white">xX_ScriptMaster_Pro_Xx</h4>
                                <span class="text-[9px] px-1.5 py-0.5 bg-cyan-500/20 text-cyan-400 rounded-md border border-cyan-500/30 font-mono font-semibold">HYPERION BYPASS</span>
                            </div>
                            <p class="text-[11px] text-slate-400 font-mono mt-0.5">UID: 489120581 • <span class="text-amber-400 font-bold"><i class="fa-solid fa-coins text-[10px] mr-0.5"></i> 1,450 R$</span></p>
                        </div>
                    </div>

                    <!-- Current Game Playing Widget -->
                    <div class="flex items-center space-x-3 bg-slate-900/90 border border-slate-800 rounded-xl px-3.5 py-2">
                        <div class="w-9 h-9 rounded-lg bg-gradient-to-tr from-amber-500 to-rose-600 flex items-center justify-center text-white text-sm shadow-md">
                            <i class="fa-solid fa-sailboat"></i>
                        </div>
                        <div class="text-left">
                            <div class="flex items-center gap-2">
                                <span class="text-[9px] uppercase font-bold text-cyan-400 tracking-wider">Active Experience</span>
                                <span class="inline-block w-1.5 h-1.5 rounded-full bg-emerald-400"></span>
                            </div>
                            <p class="text-xs font-bold text-slate-200 truncate max-w-[210px] md:max-w-xs">Blox Fruits [UPDATE 20] - Sea 3</p>
                        </div>
                        <button onclick="showToast('Joined VIP Server #4819', 'success')" class="ml-2 px-2.5 py-1.5 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 text-[11px] transition flex items-center gap-1 font-medium">
                            <i class="fa-solid fa-server text-cyan-400"></i> Server
                        </button>
                    </div>
                </div>

                <div class="h-11 bg-dark/60 border-b border-slate-800 flex items-center justify-between px-4">
                    <div id="editor-tabs" class="flex items-center space-x-1 overflow-x-auto py-1">
                        <div class="script-tab px-3 py-1.5 rounded-lg bg-slate-800 text-white text-xs font-medium flex items-center space-x-2 border border-slate-700 cursor-pointer">
                            <span class="w-2 h-2 rounded-full bg-cyan-400"></span>
                            <span>BloxFruits_AutoFarm.lua</span>
                            <button class="text-slate-400 hover:text-white ml-2"><i class="fa-solid fa-xmark text-[10px]"></i></button>
                        </div>
                        <div class="script-tab px-3 py-1.5 rounded-lg bg-dark/40 text-slate-400 text-xs font-medium flex items-center space-x-2 hover:bg-slate-800/40 cursor-pointer">
                            <span>Universal_Aimbot.lua</span>
                        </div>
                        <button onclick="addNewScriptTab()" class="w-7 h-7 rounded-lg bg-slate-800/50 hover:bg-slate-800 text-slate-400 hover:text-white flex items-center justify-center transition">
                            <i class="fa-solid fa-plus text-xs"></i>
                        </button>
                    </div>

                    <!-- Editor Quick Actions -->
                    <div class="flex items-center space-x-2">
                        <button onclick="openScriptFile()" class="px-2.5 py-1.5 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-medium transition flex items-center gap-1.5">
                            <i class="fa-solid fa-folder-open text-cyan-400"></i> Open
                        </button>
                        <button onclick="saveScriptFile()" class="px-2.5 py-1.5 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-medium transition flex items-center gap-1.5">
                            <i class="fa-solid fa-floppy-disk text-cyan-400"></i> Save
                        </button>
                        <button onclick="obfuscateScript()" class="px-2.5 py-1.5 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-medium transition flex items-center gap-1.5">
                            <i class="fa-solid fa-wand-magic-sparkles text-purple-400"></i> Obfuscate
                        </button>
                        <button onclick="clearEditorText()" class="px-2.5 py-1.5 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-medium transition flex items-center gap-1.5">
                            <i class="fa-solid fa-trash text-rose-400"></i> Clear
                        </button>
                    </div>
                </div>

                <!-- Textarea Editor with Line Numbers -->
                <div class="flex-1 flex overflow-hidden relative bg-[#070b14]">
                    <div id="line-numbers" class="w-12 py-4 bg-dark/40 border-r border-slate-800/50 font-mono text-xs text-slate-600 text-right pr-3 select-none leading-relaxed">
                        1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16
                    </div>
                    <textarea id="code-editor" spellcheck="false" oninput="updateLineNumbers()" class="flex-1 bg-transparent p-4 font-mono text-xs text-slate-200 resize-none focus:outline-none leading-relaxed selection:bg-cyan-500/30">-- BloxNexus Ultra - Roblox Environment Loader
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local localPlayer = Players.LocalPlayer

print("[BloxNexus]: Successfully attached to Roblox ID: " .. localPlayer.UserId)
print("[BloxNexus]: UNC Environment Score: 99.4% Compatible")

-- Blox Fruits Auto Farm Template
function InitAutoFarm(questName)
    print("[AutoFarm]: Initializing quest loop for: " .. tostring(questName))
    -- Hooking VirtualUser to prevent AFK kick
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        print("[Anti-AFK]: Successfully bypassed 20-minute kick timer.")
    end)
end

InitAutoFarm("Level Quest 1")</textarea>
                </div>

                <!-- Bottom Execution Toolbar -->
                <div class="h-14 bg-dark border-t border-slate-800 px-4 flex items-center justify-between">
                    <div class="flex items-center space-x-3">
                        <button onclick="executeRobloxScript()" class="px-5 py-2 rounded-xl bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-400 hover:to-blue-500 text-white font-semibold text-xs shadow-lg glow-cyan transition flex items-center gap-2">
                            <i class="fa-solid fa-play text-xs"></i> Execute Script
                        </button>
                        <button onclick="clearEditorText()" class="px-4 py-2 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-300 font-medium text-xs transition flex items-center gap-2">
                            <i class="fa-solid fa-rotate-right text-xs"></i> Reset
                        </button>
                    </div>

                    <div class="flex items-center space-x-4 text-xs text-slate-400">
                        <label class="flex items-center space-x-2 cursor-pointer">
                            <input type="checkbox" id="auto-attach-chk" class="rounded bg-slate-800 border-slate-700 text-cyan-500 focus:ring-0">
                            <span>Auto-Attach on Roblox Launch</span>
                        </label>
                        <label class="flex items-center space-x-2 cursor-pointer">
                            <input type="checkbox" checked class="rounded bg-slate-800 border-slate-700 text-cyan-500 focus:ring-0">
                            <span>Bypass Hyperion Check</span>
                        </label>
                    </div>
                </div>
            </section>

            <!-- TAB 2: ROBLOX SCRIPT HUB -->
            <section id="tab-hub" class="tab-content flex-1 flex flex-col p-6 overflow-y-auto hidden">
                <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
                    <div>
                        <h2 class="text-xl font-bold text-white flex items-center gap-2">
                            <i class="fa-solid fa-store text-cyan-400"></i> Roblox Featured Script Hub
                        </h2>
                        <p class="text-xs text-slate-400 mt-1">Verified community script hubs tested for the latest Roblox patches.</p>
                    </div>
                    <div class="relative w-full md:w-72">
                        <i class="fa-solid fa-search absolute left-3.5 top-3 text-slate-500 text-xs"></i>
                        <input type="text" id="script-search" oninput="filterRobloxScripts()" placeholder="Search game or script..." class="w-full bg-dark border border-slate-800 rounded-xl pl-10 pr-4 py-2 text-xs text-slate-200 focus:outline-none focus:border-cyan-500 transition">
                    </div>
                </div>

                <!-- Category Filters -->
                <div class="flex items-center space-x-2 mb-6 overflow-x-auto pb-2">
                    <button onclick="filterGameCategory('all')" class="game-cat-btn px-4 py-1.5 rounded-xl bg-cyan-600 text-white text-xs font-medium transition">All Games</button>
                    <button onclick="filterGameCategory('bloxfruits')" class="game-cat-btn px-4 py-1.5 rounded-xl bg-dark hover:bg-slate-800 text-slate-400 text-xs font-medium transition border border-slate-800">Blox Fruits</button>
                    <button onclick="filterGameCategory('brookhaven')" class="game-cat-btn px-4 py-1.5 rounded-xl bg-dark hover:bg-slate-800 text-slate-400 text-xs font-medium transition border border-slate-800">Brookhaven 🏡</button>
                    <button onclick="filterGameCategory('bedwars')" class="game-cat-btn px-4 py-1.5 rounded-xl bg-dark hover:bg-slate-800 text-slate-400 text-xs font-medium transition border border-slate-800">BedWars</button>
                    <button onclick="filterGameCategory('mm2')" class="game-cat-btn px-4 py-1.5 rounded-xl bg-dark hover:bg-slate-800 text-slate-400 text-xs font-medium transition border border-slate-800">Murder Mystery 2</button>
                    <button onclick="filterGameCategory('universal')" class="game-cat-btn px-4 py-1.5 rounded-xl bg-dark hover:bg-slate-800 text-slate-400 text-xs font-medium transition border border-slate-800">Universal Hubs</button>
                </div>

                <!-- Game Cards Grid -->
                <div id="roblox-script-grid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                    <!-- Script Card 1 -->
                    <div class="roblox-card glass-panel p-5 rounded-2xl flex flex-col justify-between hover:border-cyan-500/50 transition group" data-category="bloxfruits" data-name="redz hub blox fruits">
                        <div>
                            <div class="flex items-center justify-between mb-3">
                                <span class="px-2.5 py-1 rounded-lg bg-cyan-500/10 text-cyan-400 border border-cyan-500/20 text-[10px] font-semibold">Blox Fruits</span>
                                <span class="text-[10px] text-slate-400"><i class="fa-solid fa-fire text-amber-500 mr-1"></i> 2.4M Executions</span>
                            </div>
                            <h3 class="font-bold text-sm text-white group-hover:text-cyan-400 transition">Redz Hub (Auto Farm / Sea Events)</h3>
                            <p class="text-xs text-slate-400 mt-1 leading-relaxed">Ultimate GUI with auto-stats, Devil Fruit sniper, boss finder, and fast teleportation.</p>
                        </div>
                        <div class="mt-5 flex items-center justify-between pt-3 border-t border-slate-800">
                            <span class="text-[10px] text-slate-500 font-mono">Verified Safe</span>
                            <div class="flex space-x-2">
                                <button onclick="loadScriptToEditorFromHub(`loadstring(game:HttpGet('https://raw.githubusercontent.com/realredz/BloxFruits/main/source.lua'))()`)" class="px-2.5 py-1.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-white text-xs font-medium transition flex items-center gap-1">
                                    <i class="fa-solid fa-code text-[10px]"></i> Load
                                </button>
                                <button onclick="executeHubScript(`loadstring(game:HttpGet('https://raw.githubusercontent.com/realredz/BloxFruits/main/source.lua'))()`)" class="px-3 py-1.5 rounded-xl bg-cyan-600 hover:bg-cyan-500 text-white text-xs font-medium transition flex items-center gap-1">
                                    <i class="fa-solid fa-play text-[10px]"></i> Execute
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Script Card 2 -->
                    <div class="roblox-card glass-panel p-5 rounded-2xl flex flex-col justify-between hover:border-cyan-500/50 transition group" data-category="universal" data-name="infinite yield admin">
                        <div>
                            <div class="flex items-center justify-between mb-3">
                                <span class="px-2.5 py-1 rounded-lg bg-purple-500/10 text-purple-400 border border-purple-500/20 text-[10px] font-semibold">Universal Admin</span>
                                <span class="text-[10px] text-slate-400"><i class="fa-solid fa-fire text-amber-500 mr-1"></i> 5.1M Executions</span>
                            </div>
                            <h3 class="font-bold text-sm text-white group-hover:text-cyan-400 transition">Infinite Yield FE v6.5</h3>
                            <p class="text-xs text-slate-400 mt-1 leading-relaxed">The legendary client-side admin command suite with fly, noclip, ESP, and custom animations.</p>
                        </div>
                        <div class="mt-5 flex items-center justify-between pt-3 border-t border-slate-800">
                            <span class="text-[10px] text-slate-500 font-mono">EdgeIY</span>
                            <div class="flex space-x-2">
                                <button onclick="loadScriptToEditorFromHub(`loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()`)" class="px-2.5 py-1.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-white text-xs font-medium transition flex items-center gap-1">
                                    <i class="fa-solid fa-code text-[10px]"></i> Load
                                </button>
                                <button onclick="executeHubScript(`loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()`)" class="px-3 py-1.5 rounded-xl bg-cyan-600 hover:bg-cyan-500 text-white text-xs font-medium transition flex items-center gap-1">
                                    <i class="fa-solid fa-play text-[10px]"></i> Execute
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Script Card 3 -->
                    <div class="roblox-card glass-panel p-5 rounded-2xl flex flex-col justify-between hover:border-cyan-500/50 transition group" data-category="brookhaven" data-name="ice hub brookhaven">
                        <div>
                            <div class="flex items-center justify-between mb-3">
                                <span class="px-2.5 py-1 rounded-lg bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 text-[10px] font-semibold">Brookhaven RP</span>
                                <span class="text-[10px] text-slate-400"><i class="fa-solid fa-fire text-amber-500 mr-1"></i> 1.8M Executions</span>
                            </div>
                            <h3 class="font-bold text-sm text-white group-hover:text-cyan-400 transition">Ice Hub (VIP Music & House Troll)</h3>
                            <p class="text-xs text-slate-400 mt-1 leading-relaxed">Unlock all premium items, custom speed, flying cars, and sound ID bypass in Brookhaven.</p>
                        </div>
                        <div class="mt-5 flex items-center justify-between pt-3 border-t border-slate-800">
                            <span class="text-[10px] text-slate-500 font-mono">IceTeam</span>
                            <div class="flex space-x-2">
                                <button onclick="loadScriptToEditorFromHub(`loadstring(game:HttpGet('https://raw.githubusercontent.com/ice-hub/roblox/main/brookhaven.lua'))()`)" class="px-2.5 py-1.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-white text-xs font-medium transition flex items-center gap-1">
                                    <i class="fa-solid fa-code text-[10px]"></i> Load
                                </button>
                                <button onclick="executeHubScript(`loadstring(game:HttpGet('https://raw.githubusercontent.com/ice-hub/roblox/main/brookhaven.lua'))()`)" class="px-3 py-1.5 rounded-xl bg-cyan-600 hover:bg-cyan-500 text-white text-xs font-medium transition flex items-center gap-1">
                                    <i class="fa-solid fa-play text-[10px]"></i> Execute
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Script Card 4 -->
                    <div class="roblox-card glass-panel p-5 rounded-2xl flex flex-col justify-between hover:border-cyan-500/50 transition group" data-category="bedwars" data-name="vape v4 bedwars">
                        <div>
                            <div class="flex items-center justify-between mb-3">
                                <span class="px-2.5 py-1 rounded-lg bg-rose-500/10 text-rose-400 border border-rose-500/20 text-[10px] font-semibold">BedWars</span>
                                <span class="text-[10px] text-slate-400"><i class="fa-solid fa-fire text-amber-500 mr-1"></i> 3.2M Executions</span>
                            </div>
                            <h3 class="font-bold text-sm text-white group-hover:text-cyan-400 transition">Vape V4 for Roblox BedWars</h3>
                            <p class="text-xs text-slate-400 mt-1 leading-relaxed">The premier combat utility suite with Killaura, Scaffold, Velocity, and ESP widgets.</p>
                        </div>
                        <div class="mt-5 flex items-center justify-between pt-3 border-t border-slate-800">
                            <span class="text-[10px] text-slate-500 font-mono">7GrandDad</span>
                            <div class="flex space-x-2">
                                <button onclick="loadScriptToEditorFromHub(`loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua', true))()`)" class="px-2.5 py-1.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-white text-xs font-medium transition flex items-center gap-1">
                                    <i class="fa-solid fa-code text-[10px]"></i> Load
                                </button>
                                <button onclick="executeHubScript(`loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua', true))()`)" class="px-3 py-1.5 rounded-xl bg-cyan-600 hover:bg-cyan-500 text-white text-xs font-medium transition flex items-center gap-1">
                                    <i class="fa-solid fa-play text-[10px]"></i> Execute
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- TAB 3: DEX EXPLORER (DATAMODEL) -->
            <section id="tab-dex" class="tab-content flex-1 flex flex-col p-6 overflow-hidden hidden">
                <div class="flex items-center justify-between mb-4">
                    <div>
                        <h2 class="text-xl font-bold text-white flex items-center gap-2">
                            <i class="fa-solid fa-sitemap text-cyan-400"></i> Roblox DataModel Object Explorer (Dex v3)
                        </h2>
                        <p class="text-xs text-slate-400 mt-1">Inspect live Roblox game hierarchy, service nodes, instances, and properties.</p>
                    </div>
                    <button onclick="refreshDexTree()" class="px-3 py-1.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-medium transition flex items-center gap-1.5">
                        <i class="fa-solid fa-rotate text-cyan-400"></i> Refresh Tree
                    </button>
                </div>

                <div class="flex-1 grid grid-cols-1 md:grid-cols-3 gap-4 overflow-hidden">
                    <!-- Tree View Pane -->
                    <div class="glass-panel rounded-2xl p-4 overflow-y-auto font-mono text-xs flex flex-col space-y-2">
                        <div class="text-cyan-400 font-bold mb-2 flex items-center gap-2"><i class="fa-solid fa-cube"></i> game (DataModel)</div>
                        <div class="pl-4 space-y-1.5 text-slate-300">
                            <div onclick="selectDexNode('Workspace', 'Folder', 'Workspace')" class="cursor-pointer hover:text-cyan-400 flex items-center gap-2 py-1 px-2 rounded hover:bg-slate-800"><i class="fa-solid fa-folder text-amber-400 text-[10px]"></i> Workspace</div>
                            <div class="pl-4 space-y-1 text-slate-400 text-[11px]">
                                <div onclick="selectDexNode('Camera', 'Camera', 'Workspace.Camera')" class="cursor-pointer hover:text-cyan-400 py-0.5 px-2 rounded hover:bg-slate-800">📁 Camera</div>
                                <div onclick="selectDexNode('Terrain', 'Terrain', 'Workspace.Terrain')" class="cursor-pointer hover:text-cyan-400 py-0.5 px-2 rounded hover:bg-slate-800">📁 Terrain</div>
                                <div onclick="selectDexNode('Player_Test', 'Model', 'Workspace.Player_Test')" class="cursor-pointer hover:text-cyan-400 py-0.5 px-2 rounded hover:bg-slate-800">👤 Player_Test</div>
                            </div>
                            <div onclick="selectDexNode('Players', 'Players', 'Players')" class="cursor-pointer hover:text-cyan-400 flex items-center gap-2 py-1 px-2 rounded hover:bg-slate-800"><i class="fa-solid fa-folder text-blue-400 text-[10px]"></i> Players</div>
                            <div onclick="selectDexNode('ReplicatedStorage', 'ReplicatedStorage', 'ReplicatedStorage')" class="cursor-pointer hover:text-cyan-400 flex items-center gap-2 py-1 px-2 rounded hover:bg-slate-800"><i class="fa-solid fa-folder text-emerald-400 text-[10px]"></i> ReplicatedStorage</div>
                            <div onclick="selectDexNode('ReplicatedFirst', 'ReplicatedFirst', 'ReplicatedFirst')" class="cursor-pointer hover:text-cyan-400 flex items-center gap-2 py-1 px-2 rounded hover:bg-slate-800"><i class="fa-solid fa-folder text-purple-400 text-[10px]"></i> ReplicatedFirst</div>
                            <div onclick="selectDexNode('StarterGui', 'StarterGui', 'StarterGui')" class="cursor-pointer hover:text-cyan-400 flex items-center gap-2 py-1 px-2 rounded hover:bg-slate-800"><i class="fa-solid fa-folder text-rose-400 text-[10px]"></i> StarterGui</div>
                            <div onclick="selectDexNode('CoreGui', 'CoreGui', 'CoreGui')" class="cursor-pointer hover:text-cyan-400 flex items-center gap-2 py-1 px-2 rounded hover:bg-slate-800"><i class="fa-solid fa-folder text-indigo-400 text-[10px]"></i> CoreGui</div>
                        </div>
                    </div>

                    <!-- Properties Pane -->
                    <div class="glass-panel rounded-2xl p-4 overflow-y-auto col-span-2 flex flex-col justify-between">
                        <div>
                            <div class="flex items-center justify-between pb-3 border-b border-slate-800 mb-3">
                                <div>
                                    <h4 id="prop-instance-name" class="font-bold text-sm text-white">Workspace</h4>
                                    <p id="prop-instance-path" class="text-[11px] text-cyan-400 font-mono mt-0.5">game.Workspace</p>
                                </div>
                                <span id="prop-instance-class" class="px-2 py-1 rounded bg-slate-800 text-xs text-slate-300 font-mono">Workspace</span>
                            </div>

                            <table class="w-full text-xs font-mono text-left">
                                <thead>
                                    <tr class="text-slate-500 border-b border-slate-800/60">
                                        <th class="pb-2">Property</th>
                                        <th class="pb-2">Type</th>
                                        <th class="pb-2">Value</th>
                                    </tr>
                                </thead>
                                <tbody id="properties-table" class="divide-y divide-slate-800/40 text-slate-300">
                                    <tr>
                                        <td class="py-2 text-cyan-300">Name</td>
                                        <td class="py-2 text-slate-500">string</td>
                                        <td class="py-2">Workspace</td>
                                    </tr>
                                    <tr>
                                        <td class="py-2 text-cyan-300">Gravity</td>
                                        <td class="py-2 text-slate-500">float</td>
                                        <td class="py-2">196.2</td>
                                    </tr>
                                    <tr>
                                        <td class="py-2 text-cyan-300">DistributedGameTime</td>
                                        <td class="py-2 text-slate-500">double</td>
                                        <td class="py-2">412.854</td>
                                    </tr>
                                    <tr>
                                        <td class="py-2 text-cyan-300">FallenPartsDestroyHeight</td>
                                        <td class="py-2 text-slate-500">float</td>
                                        <td class="py-2">-500</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="pt-3 border-t border-slate-800 flex items-center justify-between">
                            <span class="text-[11px] text-slate-500">Right click instance to copy path or decompile</span>
                            <button onclick="showToast('Instance copied to clipboard!', 'success')" class="px-3 py-1.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs transition">
                                <i class="fa-solid fa-copy mr-1 text-cyan-400"></i> Copy Path
                            </button>
                        </div>
                    </div>
                </div>
            </section>

            <!-- TAB 4: UNC TESTER -->
            <section id="tab-unc" class="tab-content flex-1 flex flex-col p-6 overflow-y-auto hidden">
                <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
                    <div>
                        <h2 class="text-xl font-bold text-white flex items-center gap-2">
                            <i class="fa-solid fa-shield-halved text-cyan-400"></i> Unified Naming Convention (UNC) Tester
                        </h2>
                        <p class="text-xs text-slate-400 mt-1">Verify executor API function support for advanced Roblox script compatibility.</p>
                    </div>
                    <button onclick="runUNCTests()" class="px-4 py-2 rounded-xl bg-cyan-600 hover:bg-cyan-500 text-white font-semibold text-xs transition flex items-center gap-2 glow-cyan">
                        <i class="fa-solid fa-play text-xs"></i> Run UNC Test Suite
                    </button>
                </div>

                <!-- UNC Score Banner -->
                <div class="glass-panel p-6 rounded-2xl mb-6 flex items-center justify-between">
                    <div>
                        <span class="text-xs uppercase tracking-wider text-slate-400 font-semibold">Overall Compatibility Score</span>
                        <div class="text-3xl font-extrabold text-cyan-400 mt-1 flex items-baseline gap-2">
                            <span id="unc-score">99.4%</span>
                            <span class="text-xs text-emerald-400 font-normal bg-emerald-500/10 border border-emerald-500/20 px-2 py-0.5 rounded-full">Fully Passed (168 / 169)</span>
                        </div>
                    </div>
                    <div class="w-16 h-16 rounded-2xl bg-cyan-500/10 border border-cyan-500/30 flex items-center justify-center text-cyan-400 text-2xl">
                        <i class="fa-solid fa-check-double"></i>
                    </div>
                </div>

                <!-- Test Items Grid -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3 font-mono text-xs">
                    <div class="glass-panel p-3.5 rounded-xl flex items-center justify-between">
                        <span>getgenv()</span>
                        <span class="text-emerald-400 bg-emerald-500/10 px-2 py-0.5 rounded border border-emerald-500/20 font-sans text-[11px]">PASSED</span>
                    </div>
                    <div class="glass-panel p-3.5 rounded-xl flex items-center justify-between">
                        <span>getrenv()</span>
                        <span class="text-emerald-400 bg-emerald-500/10 px-2 py-0.5 rounded border border-emerald-500/20 font-sans text-[11px]">PASSED</span>
                    </div>
                    <div class="glass-panel p-3.5 rounded-xl flex items-center justify-between">
                        <span>fireclickdetector()</span>
                        <span class="text-emerald-400 bg-emerald-500/10 px-2 py-0.5 rounded border border-emerald-500/20 font-sans text-[11px]">PASSED</span>
                    </div>
                    <div class="glass-panel p-3.5 rounded-xl flex items-center justify-between">
                        <span>Drawing.new()</span>
                        <span class="text-emerald-400 bg-emerald-500/10 px-2 py-0.5 rounded border border-emerald-500/20 font-sans text-[11px]">PASSED</span>
                    </div>
                    <div class="glass-panel p-3.5 rounded-xl flex items-center justify-between">
                        <span>request() / syn.request</span>
                        <span class="text-emerald-400 bg-emerald-500/10 px-2 py-0.5 rounded border border-emerald-500/20 font-sans text-[11px]">PASSED</span>
                    </div>
                    <div class="glass-panel p-3.5 rounded-xl flex items-center justify-between">
                        <span>crypt.encrypt()</span>
                        <span class="text-amber-400 bg-amber-500/10 px-2 py-0.5 rounded border border-amber-500/20 font-sans text-[11px]">WARNING</span>
                    </div>
                </div>
            </section>

            <!-- TAB 5: CONSOLE LOGS -->
            <section id="tab-console" class="tab-content flex-1 flex flex-col p-6 overflow-hidden hidden">
                <div class="flex items-center justify-between mb-4">
                    <div>
                        <h2 class="text-xl font-bold text-white flex items-center gap-2">
                            <i class="fa-solid fa-terminal text-cyan-400"></i> Roblox Output & Execution Console
                        </h2>
                        <p class="text-xs text-slate-400 mt-1">Real-time print logs, warnings, and errors from Roblox virtual machine.</p>
                    </div>
                    <button onclick="clearConsoleLogs()" class="px-3 py-1.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-medium transition flex items-center gap-1.5">
                        <i class="fa-solid fa-trash text-rose-400"></i> Clear Logs
                    </button>
                </div>
                <div id="console-output" class="flex-1 bg-dark/95 border border-slate-800 rounded-2xl p-4 font-mono text-xs text-slate-300 overflow-y-auto space-y-2">
                    <div class="text-slate-500">[System]: BloxNexus Ultra initialized successfully. Waiting for Roblox injection...</div>
                    <div class="text-cyan-400">[Info]: Connected to RobloxClient (PID: 14892).</div>
                    <div class="text-emerald-400">[Success]: UNC Hook loaded. All environment globals injected safely.</div>
                </div>
            </section>

            <!-- TAB 6: SETTINGS -->
            <section id="tab-settings" class="tab-content flex-1 flex flex-col p-6 overflow-y-auto hidden">
                <div class="max-w-2xl">
                    <h2 class="text-xl font-bold text-white flex items-center gap-2">
                        <i class="fa-solid fa-gear text-cyan-400"></i> Executor Configuration
                    </h2>
                    <p class="text-xs text-slate-400 mt-1 mb-6">Customize execution behavior, auto-attach routines, and cyberpunk themes.</p>

                    <div class="space-y-4">
                        <div class="glass-panel p-4 rounded-2xl flex items-center justify-between">
                            <div>
                                <h4 class="font-semibold text-sm text-white">Hyperion Anti-Cheat Bypass</h4>
                                <p class="text-xs text-slate-400 mt-0.5">Enables kernel-level memory virtualization during script execution.</p>
                            </div>
                            <label class="relative inline-flex items-center cursor-pointer">
                                <input type="checkbox" checked class="sr-only peer">
                                <div class="w-9 h-5 bg-slate-800 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-slate-300 after:border after:rounded-full after:h-4 after:w-4 after:transition-all peer-checked:bg-cyan-500"></div>
                            </label>
                        </div>

                        <div class="glass-panel p-4 rounded-2xl flex items-center justify-between">
                            <div>
                                <h4 class="font-semibold text-sm text-white">Auto-Execute Workspace Scripts</h4>
                                <p class="text-xs text-slate-400 mt-0.5">Automatically runs any `.lua` file placed in the auto-exec folder upon joining game.</p>
                            </div>
                            <label class="relative inline-flex items-center cursor-pointer">
                                <input type="checkbox" class="sr-only peer">
                                <div class="w-9 h-5 bg-slate-800 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-slate-300 after:border after:rounded-full after:h-4 after:w-4 after:transition-all peer-checked:bg-cyan-500"></div>
                            </label>
                        </div>

                        <!-- Accent Theme Selector -->
                        <div class="glass-panel p-4 rounded-2xl">
                            <h4 class="font-semibold text-sm text-white mb-2">Accent Theme Color</h4>
                            <div class="flex items-center space-x-3">
                                <button onclick="setThemeAccent('cyan')" class="w-8 h-8 rounded-full bg-cyan-500 ring-2 ring-white/60 transition hover:scale-110"></button>
                                <button onclick="setThemeAccent('purple')" class="w-8 h-8 rounded-full bg-purple-600 transition hover:scale-110"></button>
                                <button onclick="setThemeAccent('emerald')" class="w-8 h-8 rounded-full bg-emerald-500 transition hover:scale-110"></button>
                                <button onclick="setThemeAccent('rose')" class="w-8 h-8 rounded-full bg-rose-500 transition hover:scale-110"></button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </main>
    </div>

    <script>
        let isRobloxInjected = false;

        // Toast Notification System
        function showToast(title, type = 'success') {
            const toast = document.getElementById('toast');
            const titleEl = document.getElementById('toast-title');
            const iconEl = document.getElementById('toast-icon');
            
            titleEl.innerText = title;
            if(type === 'error') {
                iconEl.innerHTML = '<i class="fa-solid fa-circle-exclamation text-rose-500"></i>';
            } else if(type === 'info') {
                iconEl.innerHTML = '<i class="fa-solid fa-circle-info text-cyan-400"></i>';
            } else {
                iconEl.innerHTML = '<i class="fa-solid fa-circle-check text-emerald-400"></i>';
            }

            toast.classList.remove('translate-x-full');
            setTimeout(() => {
                toast.classList.add('translate-x-full');
            }, 3000);
        }

        // Tab Navigation
        function switchTab(tabId) {
            document.querySelectorAll('.tab-content').forEach(el => el.classList.add('hidden'));
            document.querySelectorAll('.nav-btn').forEach(btn => {
                btn.classList.remove('text-cyan-400', 'bg-cyan-500/15', 'border', 'border-cyan-500/30');
                btn.classList.add('text-slate-400');
            });

            document.getElementById('tab-' + tabId).classList.remove('hidden');
            const activeBtn = document.getElementById('nav-' + tabId);
            activeBtn.classList.remove('text-slate-400');
            activeBtn.classList.add('text-cyan-400', 'bg-cyan-500/15', 'border', 'border-cyan-500/30');
            
            if(tabId === 'console') {
                document.getElementById('log-badge').classList.add('hidden');
            }
        }

        // Roblox Process Injection Simulation
        function injectRoblox() {
            const statusBadge = document.getElementById('roblox-status');
            const statusText = document.getElementById('roblox-status-text');
            const injectBtn = document.getElementById('inject-btn');

            if (!isRobloxInjected) {
                injectBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin text-lg"></i>';
                showToast('Injecting DLL into RobloxPlayerBeta.exe...', 'info');
                
                setTimeout(() => {
                    isRobloxInjected = true;
                    statusBadge.className = 'flex items-center space-x-2 px-3 py-1.5 rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-xs font-medium';
                    statusBadge.innerHTML = '<span class="w-2.5 h-2.5 rounded-full bg-emerald-500 animate-pulse"></span><span id="roblox-status-text">Roblox Attached (Ready)</span>';
                    injectBtn.innerHTML = '<i class="fa-solid fa-check text-lg"></i>';
                    injectBtn.classList.add('bg-emerald-600');
                    showToast('Successfully injected into Roblox!');
                    appendLog('[System]: Roblox process successfully hooked. Memory maps assigned.');
                }, 1600);
            } else {
                showToast('Already attached to Roblox process.', 'info');
            }
        }

        // Line number updater for textarea
        function updateLineNumbers() {
            const editor = document.getElementById('code-editor');
            const lineNums = document.getElementById('line-numbers');
            const lines = editor.value.split('\n').length;
            let html = '';
            for(let i = 1; i <= Math.max(lines, 16); i++) {
                html += i + '<br>';
            }
            lineNums.innerHTML = html;
        }

        // Execute Script
        function executeRobloxScript() {
            if (!isRobloxInjected) {
                showToast('Please inject into Roblox first!', 'error');
                appendLog('[Error]: Execution aborted. Executor is not attached to Roblox.');
                return;
            }

            const code = document.getElementById('code-editor').value;
            showToast('Script executed in Roblox VM!');
            appendLog('[Execution]: Running Lua script in local thread...');
            
            setTimeout(() => {
                appendLog('[Output]: [BloxNexus]: Successfully attached to Roblox ID: 89412054');
                appendLog('[Output]: [AutoFarm]: Initializing quest loop for: Level Quest 1');
                appendLog('[Output]: [Anti-AFK]: Successfully bypassed 20-minute kick timer.');
            }, 350);

            document.getElementById('log-badge').classList.remove('hidden');
        }

        function executeHubScript(scriptCode) {
            if (!isRobloxInjected) {
                showToast('Please inject into Roblox first!', 'error');
                appendLog('[Error]: Cannot execute hub script. Not attached.');
                return;
            }
            document.getElementById('code-editor').value = scriptCode;
            updateLineNumbers();
            executeRobloxScript();
        }

        function loadScriptToEditorFromHub(scriptCode) {
            document.getElementById('code-editor').value = scriptCode;
            updateLineNumbers();
            switchTab('editor');
            showToast('Hub script loaded into editor!');
        }

        function appendLog(text) {
            const consoleOut = document.getElementById('console-output');
            const time = new Date().toLocaleTimeString();
            consoleOut.innerHTML += `<div class="text-slate-300">[${time}] ${text}</div>`;
            consoleOut.scrollTop = consoleOut.scrollHeight;
        }

        function clearConsoleLogs() {
            document.getElementById('console-output').innerHTML = '<div class="text-slate-500">[System]: Console cleared.</div>';
            showToast('Console logs cleared', 'info');
        }

        function clearEditorText() {
            document.getElementById('code-editor').value = '';
            updateLineNumbers();
            showToast('Editor cleared', 'info');
        }

        function saveScriptFile() {
            showToast('Script saved to workspace successfully!');
        }

        function openScriptFile() {
            showToast('File dialog opened');
        }

        function obfuscateScript() {
            showToast('Script successfully obfuscated with IronBrew v3!');
            const editor = document.getElementById('code-editor');
            editor.value = `-- Obfuscated with BloxNexus IronBrew v3 Protection\n\n(function()\n    local _v1 = "Protected by BloxNexus";\n    print(_v1);\nend)();`;
            updateLineNumbers();
        }

        function addNewScriptTab() {
            showToast('New script tab created', 'info');
        }

        // Script Hub Filtering
        function filterGameCategory(cat) {
            document.querySelectorAll('.game-cat-btn').forEach(btn => {
                btn.className = 'game-cat-btn px-4 py-1.5 rounded-xl bg-dark hover:bg-slate-800 text-slate-400 text-xs font-medium transition border border-slate-800';
            });
            event.target.className = 'game-cat-btn px-4 py-1.5 rounded-xl bg-cyan-600 text-white text-xs font-medium transition';

            const cards = document.querySelectorAll('.roblox-card');
            cards.forEach(card => {
                if (cat === 'all' || card.dataset.category === cat) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        function filterRobloxScripts() {
            const query = document.getElementById('script-search').value.toLowerCase();
            const cards = document.querySelectorAll('.roblox-card');
            cards.forEach(card => {
                const name = card.dataset.name;
                if (name.includes(query)) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        // Dex Explorer Node selection
        function selectDexNode(name, className, path) {
            document.getElementById('prop-instance-name').innerText = name;
            document.getElementById('prop-instance-path').innerText = path;
            document.getElementById('prop-instance-class').innerText = className;
            showToast('Loaded properties for ' + name, 'info');
        }

        function refreshDexTree() {
            showToast('DataModel refreshed successfully!');
        }

        function runUNCTests() {
            showToast('Running 169 UNC API checks...');
            setTimeout(() => {
                showToast('UNC Test completed: 99.4% Passed!');
            }, 1200);
        }

        function setThemeAccent(color) {
            showToast(`Theme accent updated to ${color}`, 'info');
        }

        window.onload = function() {
            updateLineNumbers();
            // Auto check simulated Roblox process
            setTimeout(() => {
                document.getElementById('roblox-status-text').innerText = 'RobloxPlayerBeta.exe Found';
                document.getElementById('roblox-status').className = 'flex items-center space-x-2 px-3 py-1.5 rounded-full bg-cyan-500/10 border border-cyan-500/20 text-cyan-400 text-xs font-medium';
                document.querySelector('#roblox-status span').className = 'w-2.5 h-2.5 rounded-full bg-cyan-400';
            }, 1000);
        };
    </script>
</body>
</html>
