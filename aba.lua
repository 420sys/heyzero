-- Deobfuscated by angelofthenorth
-- Detected obfuscation: Luraph v15
-- Local names are inferred from use (the original names are not in the bytecode)

-- Luarmor loader removed: this is the script it runs after authenticating.
-- serverConstants: the script's constants. The loader installs them through an LPH_ENCFUNC function
-- that only this script's Luarmor server key decrypts; merged here from a run-time capture.
-- Locals marked "set by the Luarmor loader" hold values it computes at run time: nil here.
-- (Their line numbers are those of the full program, loader included.)

local serverConstants = { [1] = "HieiCombo", [2] = 90, [3] = "HumanoidRootPart", [4] = "Builder", [5] = "M1TResponse", [6] = "HUD", [7] = "Gojo120", [8] = "Stats", [9] = "AsunaChildRemoved", [10] = 4, [11] = "Accelerator", [12] = "ZERO HUB", [13] = "Chance to land Nanamis Blackflash", [14] = 0.025000000000000001, [15] = "Byakuya", [16] = "shield_m3", [17] = 3340, [18] = "AntiConfusion", [19] = "InfJump", [20] = "AntiStun", [21] = 3323, [22] = "DekuDelawareSmash", [23] = "Jonathan Joestar", [24] = "Infinitely M1 Combos", [25] = "Old Joseph Barrel", [26] = 0.69999999999999996, [27] = "Yuji", [28] = "AntiPools", [29] = "noman", [30] = "NANAMIAIM", [31] = "AkainuFist", [32] = "3", [33] = "Auto Tengen Osu", [34] = "Noclip", [35] = "Replace Self", [36] = "maka_m1", [37] = "NanamiAuto2", [38] = 1000, [39] = "Backpack", [40] = "GaaraTsunami", [41] = "Text", [42] = 50, [43] = 3315, [44] = 0.016, [45] = "OnMode", [46] = "Kido", [47] = "Redirects Quake projectile to everyone on the map", [48] = 4040, [49] = "alucard_m4", [50] = "YusukeCombo", [51] = "Response Mode", [52] = "Raiden Auto Chop", [53] = "4", [54] = "Anime Battle Arena", [55] = "M1TGuardBreak", [56] = "Humanoid", [57] = "Toggle", [58] = "Jump unlimited times in the air", [59] = "CustomLeaderboard", [60] = 0, [61] = 5, [62] = "File Name", [63] = "ViewDeidara", [64] = "Misc", [65] = "Rukia", [66] = "Rengoku", [67] = "Server", [68] = "M1THoldBlock", [69] = 80, [70] = "guts_m4", [71] = "Teleport Clones", [72] = 1, [73] = "Redirects Kill Block projectile to everyone on the map", [74] = "2", [75] = "Speedhack", [76] = "Rapid Fire into triple M1", [77] = 976, [78] = "dodge", [79] = "Main", [80] = "BlueBuff", [81] = "Jujutsu Kaisen", [82] = "Sword Art Online", [83] = "OnRemoval", [84] = ".txt", [85] = "LuaFunctions.lua", [86] = "GrimjowPantherClaw", [87] = 0.5, [88] = " ", [89] = true, [90] = "Fly Speed", [91] = 2, [92] = "ReplicatedStorage", [93] = "SuperDummyKillBlock", [94] = "Bakugo", [95] = "Hercule Satan", [96] = "GutsCombo", [97] = "m3", [98] = "Automatically blocks then counters with an M1 when an enemy throws a melee attack within range", [99] = "gun1_m1", [100] = "InfiniteCombo", [101] = "RukiaBankai", [102] = "Ping Compensation", [103] = "Input", [104] = "ColorCorrectionEffect", [105] = 10, [106] = "Rapid Fire", [107] = "AcceleratorCombo", [108] = "RengokuCombo", [109] = "Morph_Mode.rbxm", [110] = 180, [111] = "AntiRisotto", [112] = "ScreenGui", [113] = 0.050000000000000003, [114] = 70, [115] = "ViewRisotto", [116] = "M1TNoTradeAttacking", [117] = "Shirt", [118] = "Combo", [119] = "Confuse", [120] = false, [121] = "BodyColors", [122] = "Bleach", [123] = "Hit Chance", [124] = 3, [125] = "TouchInterest", [126] = "M1", [127] = "NanamiAuto2Char", [128] = "Ball", [129] = "sanji_m1", [130] = 1790, [131] = 100, [132] = "M1TNoTradeBlocking", [133] = 42, [134] = "GojoBlue", [135] = "SpaceOff", [136] = "CustomCharSelect", [137] = "Tengen", [138] = "maka_m4", [139] = "AsunaCharAdded", [140] = "RunService", [141] = 0.10000000000000001, [142] = 9771, [143] = "Defense", [144] = "Thrown", [145] = "UseMove", [146] = "MacroRecord", [147] = "Model", [148] = "BlockBar", [149] = "kirito_m2", [150] = "TextLabel", [151] = "Visible", [152] = "Client", [153] = "KazumaSniper", [154] = "Danku", [155] = "OnMove", [156] = "TengenTiming", [157] = "PlayerGui", [158] = 0.29999999999999999, [159] = "M1TFaceCone", [160] = "AwakeningCamera", [161] = "vegito_m3", [162] = "DenjiCombo", [163] = "ESP", [164] = "Coming Soon", [165] = "YujiCombo", [166] = "Gojo Blue Ult", [167] = "sanji_m4", [168] = "Soundtrack.mp3", [169] = 16, [170] = "gogeta_m3", [171] = "BasePart", [172] = "m1", [173] = "paste macro data here...", [174] = "Jump Height", [175] = "Import Macro", [176] = "Bakugo Gauntlet Blast", [177] = "ABAFly", [178] = "AntiRaiden", [179] = "BlackFlashCheck", [180] = "ExplosiveTagTrap", [181] = "Yusuke Spirit Gun", [182] = 0.16, [183] = 4064, [184] = "Face Check", [185] = "Existing", [186] = "M1TRange", [187] = 9781, [188] = 3303, [189] = "asuna_m3", [190] = "Rock Lee", [191] = "Hiei", [192] = "Extras.rbxm", [193] = "Aizen Techs", [194] = 2185, [195] = "Value", [196] = 0.25, [197] = "Animator", [198] = 4519, [199] = "AsunaStrike", [200] = "vegito_m1" } -- captured at run time: table1-scan4-candidate1.lua
local flag -- set by the Luarmor loader at run time (line 111: flag = nil; assigned 7 more times)
local flag2 -- set by the Luarmor loader at run time (line 112: flag2 = nil; assigned 6 more times)
local lib, Players, service, UserInputService, VirtualInputManager, PathfindingService, localPlayer, v27, service2, HttpService
local Lighting, tbl6, connection, teamCheck2, child4, clone, recordMacro2, loopMacro2, tbl7, getText
local getMatches, fn18, fn19, fn20, fn21, fn22, fn23, fn24, fn25, fn26
local fn27, fn28, fn29, fn30, fn31, fn32, fn33, fn34, fn35, fn36
local fn37, fn38, fn39, Techs, Macro, v28, Special, Hitbox, Utility, v29
local v30, v31

do
	do
		repeat
			task.wait()
		until game:IsLoaded()

		task.wait()
		lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/toeerolo-z/ethossuiterewrite/refs/heads/main/ethossuite.lua"))()
		Players = game:GetService("Players")
		service = game:GetService(("RunService"))
		UserInputService = game:GetService("UserInputService")
		service2 = game:GetService(("ReplicatedStorage"))
		local TweenService = game:GetService("TweenService")
		HttpService = game:GetService("HttpService")
		VirtualInputManager = game:GetService("VirtualInputManager")
		PathfindingService = game:GetService("PathfindingService")
		game:GetService("VirtualUser")
		Lighting = game:GetService("Lighting")
		local Debris = game:GetService("Debris")
		localPlayer = Players.LocalPlayer

		if getgenv()._ZeroWindow then
			pcall(function()
				getgenv()._ZeroWindow:Unload()
			end)
		end

		tbl6 = {}
		local speed2 = 100
		local n13 = 100
		local y = (50)
		local selectCharacter2 = nil
		connection = nil
		teamCheck2 = (false)
		child4 = nil
		clone = nil

		pcall(function()
			if not isfolder("ZeroHub/Macros") then
				makefolder("ZeroHub/Macros")
			end
		end)

		recordMacro2 = false
		local connections

		do
			local flag13 = false
			loopMacro2 = false
			local thread = nil
			connections = {}
			local tbl9 = {}
			tbl7 = { Note = "", File = "Macro_1", Actions = {} }

			getText = function()
				local child = localPlayer.PlayerGui:FindFirstChild(("HUD"))

				if child then
					local characterSelect = child:FindFirstChild("CharacterSelect")
					if not characterSelect then
						return nil
					end
					local title1 = characterSelect:FindFirstChild("Title1", true)
					if title1 and title1:IsA("TextLabel") and title1.Text ~= "" then
						return title1.Text
					end
					return nil
				end

				do
					return nil
				end

				while true do
				end
			end

			getMatches = function()
				local matches = {}

				if isfolder("ZeroHub/Macros") then
					for _, macro in ipairs(listfiles("ZeroHub/Macros")) do
						local match = macro:match("([^/\\]+)%.txt$")

						if match then
							table.insert(matches, match)
						end
					end
				end

				return matches
			end

			fn18 = function()
				do
					pcall(function()
						writefile("ZeroHub/Macros/" .. tbl7.File .. ".txt", HttpService:JSONEncode(tbl7.Actions))
					end)

					return
				end

				while true do
				end
			end

			local function fn40()
				for k in pairs(tbl9) do
					pcall(function()
						if k == "m1" then
							VirtualInputManager:SendMouseButtonEvent(0, (0), (0), false, game, 0)
						elseif Enum.KeyCode[k] then
							VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[k], false, game)
						end
					end)
				end

				tbl9 = {}
			end

			fn19 = function()
				flag13 = false

				if thread then
					pcall(function()
						task.cancel(thread)
					end)

					thread = nil


				end

				fn40()
			end

			fn20 = function(arg, arg2)
				if flag13 then
					fn19()


				end

				local ok, result = pcall(function()
					return HttpService:JSONDecode(arg)
				end)

				if ok and type(result) == "table" and #result ~= 0 then
					flag13 = (true)
					tbl9 = {}

					thread = task.spawn(function()
						repeat
							local flag14 = (true)

							for _, v32 in ipairs(result) do
								if not flag13 then
									break
								end

								if v32:sub(1, (1)) ~= "=" then
									pcall(function()
										if v32 == "m1+" then
											tbl9.m1 = true
											VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, (0))
										elseif v32 == "m1-" then
											tbl9.m1 = nil
											VirtualInputManager:SendMouseButtonEvent((0), (0), 0, false, game, (0))
										elseif v32:sub(-1) == "+" then
											local str2 = v32:sub(1, -2)

											if Enum.KeyCode[str2] then
												tbl9[str2] = true
												VirtualInputManager:SendKeyEvent((true), Enum.KeyCode[str2], (false), game)
											end
										elseif v32:sub(-1) == "-" then
											local str2 = v32:sub(1, -2)

											if Enum.KeyCode[str2] then
												tbl9[str2] = nil
												VirtualInputManager:SendKeyEvent((false), Enum.KeyCode[str2], false, game)
											end
										end
									end)

									continue
								end

								if flag14 then
									flag14 = false
									continue
								end
								local n14 = math.max(tonumber(v32:sub(2)) or 0, 0)
								local n15 = 0

								while n15 < n14 and flag13 do
									n15 += task.wait()
								end

								if not flag13 then
									break
								end
							end
						until not (flag13 and arg2)

						fn40()
						flag13 = false
						thread = nil
					end)

					return
				end

				do
					return
				end

				while true do
				end
			end
		end

		local tbl9 = { [Enum.KeyCode.F4] = true, [Enum.KeyCode.F5] = true }

		fn21 = function()
			do
				for _, connection2 in pairs(connections) do
					pcall(function()
						connection2:Disconnect()
					end)
				end

				connections = {}
				tbl7.Actions = {}
				local now2 = tick()

				connections[1] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
					if gameProcessed then
						return
					end

					if tbl9[input.KeyCode] then
						return
					end

					if input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType ~= Enum.UserInputType.MouseButton1 then
						return
					end
					local now3 = tick()
					table.insert(tbl7.Actions, "=" .. string.format("%.4f", now3 - now2))
					now2 = now3

					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						table.insert(tbl7.Actions, "m1+")
					elseif input.KeyCode ~= Enum.KeyCode.Unknown then
						table.insert(tbl7.Actions, input.KeyCode.Name .. "+")
					end
				end)

				connections[2] = UserInputService.InputEnded:Connect(function(input, gameProcessed)
					if gameProcessed then
						return
					end

					if not tbl9[input.KeyCode] then
						if input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType ~= Enum.UserInputType.MouseButton1 then
							return
						end
						local now3 = tick()
						table.insert(tbl7.Actions, "=" .. string.format("%.4f", now3 - now2))
						now2 = now3

						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							table.insert(tbl7.Actions, "m1-")
						elseif input.KeyCode ~= Enum.KeyCode.Unknown then
							table.insert(tbl7.Actions, input.KeyCode.Name .. "-")
						end

						return
					end

					do
						return
					end

					while true do
					end
				end)
			end
		end

		fn22 = function()
			for _, connection2 in pairs(connections) do
				pcall(function()
					connection2:Disconnect()
				end)
			end

			connections = {}
		end

		local tbl10 = {
			GaaraTsunami = false,
			GaaraGreatTsunami = (false),
			OldJosephJeep = false,
			OldJosephBarrel = false,
			IchigoTSGetsuga = false,
			GrimjowPantherClaw = false,
			AkainuFist = false,
			DekuDelawareSmash = false,
			Bakugo = false,
			GojoHollowPurple = false,
			GojoBlueUlt = false,
			YusukeSpiritGun = (false),
			RengokuFlamingTiger = (false),
			KazumaSniper = false,
			AcceleratorQuake = (false),
			SuperDummyKillBlock = false,
		}

		local tbl11 = {
			Tsunami = { ("GaaraTsunami") },
			GreatTsunami = { "GaaraGreatTsunami" },
			Jeep = { "OldJosephJeep" },
			Barrel = { "OldJosephBarrel" },
			NewGetsuga = { "IchigoTSGetsuga" },
			Bal = { ("GrimjowPantherClaw") },
			Fist = { ("AkainuFist") },
			Ball = {
				"DekuDelawareSmash",
				"GojoHollowPurple",
				"YusukeSpiritGun",
				"AcceleratorQuake",
			},
			[localPlayer.Name .. "Fire"] = { "RengokuFlamingTiger" },
			GauntletBlast = { "Bakugo" },
			GrabBallMax = { "GojoBlueUlt" },
			KazumaArrow = { ("KazumaSniper") },
			Part = { "SuperDummyKillBlock" },
		}

		local function onChildAdded(child)
			local v32 = tbl11[child.Name]
			if not v32 then
				return
			end
			local flag13 = false

			for _, v33 in ipairs(v32) do
				if tbl10[v33] then
					flag13 = true
					break
				end
			end

			if not flag13 then
				return
			end

			for _, descendant in ipairs(child:GetDescendants()) do
				if descendant:IsA("BodyVelocity") then
					descendant.Velocity = Vector3.zero
				end
			end

			if child:IsA("BasePart") then
				child.AssemblyLinearVelocity = Vector3.zero
				child.AssemblyAngularVelocity = Vector3.zero
			end

			task.spawn(function()
				local live = workspace:FindFirstChild("Live") or workspace

				while child.Parent do
					local character = localPlayer.Character

					for _, child2 in ipairs(live:GetChildren()) do
						if not child.Parent then
							return
						end

						if child2 == character then
							continue
						end
						child2 = child2:IsA(("Model")) and child2.PrimaryPart or child2:IsA(("BasePart")) and child2

						if child2 then
							if child:IsA("Model") then
								child:PivotTo(child2.CFrame)
							else
								child.CFrame = child2.CFrame
							end

							task.wait()
						end
					end
				end
			end)
		end

		local function fn40()
			if tbl6.ProjectileListener then
				tbl6.ProjectileListener:Disconnect()
			end

			local thrown = workspace:FindFirstChild("Thrown")
			if not thrown then
				return
			end

			for _, child in ipairs(thrown:GetChildren()) do
				onChildAdded(child)
			end

			tbl6.ProjectileListener = thrown.ChildAdded:Connect(onChildAdded)
		end

		local becomeSnail
		local subwayHit
		local fn41, connections2, applieds, applied3, v32, clone2, fn42

		do
			subwayHit = service2:FindFirstChild("SubwayHit")
			becomeSnail = service2:FindFirstChild("BecomeSnail")

			fn23 = function(arg)
				local input = localPlayer:FindFirstChild(("Backpack")) and localPlayer.Backpack:FindFirstChild("Input")

				if input and localPlayer.Character then
					input:FireServer(("dodge"), arg)
				end
			end

			fn41 = function(name)
				do
					for _, v33 in ipairs(getgc()) do
						if typeof(v33) == "function" then
							local info = debug.getinfo(v33)

							if info.currentline == 8 and info.source:match("PrestigePick") then
								debug.setupvalue(v33, (1), localPlayer:FindFirstChild(name, true))
							end
						end
					end

					return
				end

				while true do
				end
			end

			local ContentProvider = game:GetService("ContentProvider")
			connections2 = {}

			applieds = {
				["Ferryman (Needs Misaka)"] = {
					base = "https://raw.githubusercontent.com/troidnox/Morph-2/main/",
					folder = "ABA_MorphData/Morphs/Misaka",
					files = { "Extras.rbxm", "LuaFunctions.lua", "Morph.rbxm", "Soundtrack.mp3" },
				},
				["Lord Regent (Needs Gilgamesh)"] = {
					base = "https://raw.githubusercontent.com/troidnox/Lord-Regent-Gilgamesh-/main/",
					folder = "ABA_MorphData/Morphs/Gilgamesh",
					files = { "Extras.rbxm", ("LuaFunctions.lua"), "Morph.rbxm" },
				},
				["Duke (Needs Accelerator)"] = {
					base = "https://raw.githubusercontent.com/troidnox/Duke-Accelerator-/main/",
					folder = "ABA_MorphData/Morphs/Accelerator",
					files = { ("Extras.rbxm"), "LuaFunctions.lua", "Morph.rbxm", ("Morph_Mode.rbxm") },
				},
			}

			local function fn43(applied)
				pcall(function()
					if not isfolder("ABA_MorphData") then
						makefolder("ABA_MorphData")
					end

					if not isfolder("ABA_MorphData/Morphs") then
						do
							makefolder("ABA_MorphData/Morphs")
						end
					end

					if not isfolder(applied.folder) then
						makefolder(applied.folder)
						if not flag2 then
							return
						end
					end
				end)

				for _, file in ipairs(applied.files) do
					local path = applied.folder .. "/" .. file

					if not isfile(path) then
						local ok, result = pcall(function()
							return game:HttpGet(applied.base .. file)
						end)

						if ok and result then
							writefile(path, result)
						end
					end
				end
			end

			local function fn44(applied)
				local tbl12 = {}

				local function fn45(arg, arg2)
					local path = applied.folder .. "/" .. arg2
					if not isfile(path) then
						return
					end

					if arg2:match("%.rbxm") then
						tbl12[arg] = game:GetObjects(getcustomasset(path))[1]
					elseif arg2:match("%.mp3") then
						local sound = Instance.new("Sound")
						sound.SoundId = getcustomasset(path)
						ContentProvider:PreloadAsync({ sound })
						tbl12[arg] = sound
					elseif arg2:match("%.lua") then
						tbl12[arg] = loadstring(readfile(path))()
					end
				end

				fn45("Extras", "Extras.rbxm")
				fn45("Morph", "Morph.rbxm")
				fn45("Morph_Mode", "Morph_Mode.rbxm")
				fn45("LuaFunctions", "LuaFunctions.lua")
				fn45("Sound", ("Soundtrack.mp3"))
				return tbl12
			end

			local function getChild(instance, arg)
				for _, child in ipairs(instance:GetChildren()) do
					if child:IsA("BasePart") and child.Name == arg then
						return child
					end
				end
			end

			local function morphFunction(arg, parent)
				local clone3 = arg:Clone()

				for _, child in ipairs(parent:GetChildren()) do
					if child:IsA("Pants") or child:IsA("Shirt") or child:IsA("BodyColors") or child:IsA("Model") then
						child:Destroy()
					end
				end

				for _, child in ipairs(clone3:GetChildren()) do
					if child:IsA("Model") then
						local clone4 = child:Clone()
						clone4.Parent = parent
						clone4.Name = "Morph"
						local child2 = parent:FindFirstChild(child.Name)
						if not child2 then
							continue
						end

						for _, child3 in ipairs(clone4:GetChildren()) do
							if not child3:IsA("BasePart") then
								continue
							end
							child3.CanCollide = false
							local c0 = getChild(clone3, child.Name).CFrame:ToObjectSpace(child3.CFrame)
							local weld = Instance.new("Weld")
							weld.Part0 = child2
							weld.Part1 = child3
							weld.C0 = c0
							weld.Name = child3.Name .. "Weld"
							weld.Parent = child2
						end
					elseif child:IsA("Pants") or child:IsA(("Shirt")) or child:IsA("BodyColors") or child:IsA("CharacterMesh") then
						child:Clone().Parent = parent
					elseif child:IsA("BasePart") and parent:FindFirstChild(child.Name) then
						parent[child.Name].Transparency = child.Transparency
					end
				end

				if parent:FindFirstChild("FakeHead") then
					parent.FakeHead.Color = parent:FindFirstChildWhichIsA(("BodyColors")) and parent:FindFirstChildWhichIsA("BodyColors").HeadColor3 or getChild(clone3, "Head").Color
				end

				task.wait()
				clone3:Destroy()
			end

			applied3 = nil
			v32 = nil
			clone2 = nil

			local function fn45(arg, ...)
				if not v32 or not v32.LuaFunctions then
					return
				end
				local luaFunctions = v32.LuaFunctions
				if not luaFunctions[arg] then
					return
				end
				local luaFunction = luaFunctions[arg]
				local env = getfenv(luaFunction)
				env.Character = localPlayer.Character
				env.Extras = v32.Extras
				env.HasCustomEnvironment = true
				env.MorphFunction = morphFunction
				env.EnvironmentFunctions = {}
				env.Morphs = { Morph = v32.Morph, ModeMorph = v32.Morph_Mode }

				if hookfunction and restorefunction then
					env.EnvironmentFunctions.restorefunction = restorefunction
					env.EnvironmentFunctions.hookfunction = hookfunction
				end

				if getcustomasset then
					env.EnvironmentFunctions.getcustomasset = getcustomasset
				end

				setfenv(luaFunction, env)
				return coroutine.wrap(luaFunction)(...)
			end

			local function fn46()
				task.wait()

				if clone2 then
					clone2:Destroy()
				end

				if v32 and v32.Sound then
					clone2 = v32.Sound:Clone()
					clone2.Volume = 1.1
					clone2.Parent = localPlayer.PlayerGui.HUD
					clone2:Play()

					clone2.Ended:Connect(function()
						do
							clone2:Destroy()
							return
						end

						while true do
						end
					end)
				end
			end

			local function fn47(arg, arg2)
				if connections2[arg] then
					pcall(function()
						connections2[arg]:Disconnect()
					end)
				end

				connections2[arg] = arg2
			end

			fn42 = function(applied)
				do
					for k, connection2 in pairs(connections2) do
						pcall(function()
							connection2:Disconnect()
						end)

						connections2[k] = nil
					end

					applied3 = nil
					v32 = nil
					local applied2 = applieds[applied]
					if not applied2 then
						return
					end
					fn43(applied2)
					v32 = fn44(applied2)
					applied3 = applied

					local function onCharacterAdded(character)
						repeat
							task.wait()
						until character.Parent and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChildOfClass(("Humanoid")) and character:FindFirstChildOfClass(("Humanoid")).Health > 0

						if not character.Parent or not v32 then
							do
								return
							end

							while (true) do
							end
						end

						if v32.Morph then
							morphFunction(v32.Morph, character)


						end

						fn45("OnSpawn")
						local charge = localPlayer:WaitForChild("Charge")

						fn47("Skill", character.ChildAdded:Connect(function(child)
							if child.Name == "UsingSkill" then
								fn45(("OnMove"), child.Value)
							end
						end))

						fn47("Mode", localPlayer.PlayerGui.ChildAdded:Connect(function(child)
							if child:IsA("LocalScript") and child.Name:match("CameraScene") then
								fn46()

								fn47("ModeEnd", charge:GetPropertyChangedSignal(("Value")):Connect(function()
									if charge.Value <= 0 then
										fn47("ModeEnd")

										if clone2 then
											clone2:Destroy()
										end

										if v32.Morph_Mode and v32.Morph then
											morphFunction(v32.Morph, character)
										end

										fn45("OnModeEnd")
									end
								end))

								if v32.Morph_Mode then
									morphFunction(v32.Morph_Mode, character)
								end

								fn45(("OnMode"))
							end
						end))

						fn47("Mode2", service2.PEffect.OnClientEvent:Connect(function(arg, arg2)
							if arg:match(("AwakeningCamera")) and arg2.root and arg2.root:IsAncestorOf(character) then
								fn46()

								fn47("ModeEnd", charge:GetPropertyChangedSignal("Value"):Connect(function()
									if charge.Value <= 0 then
										fn47("ModeEnd")

										if clone2 then
											clone2:Destroy()
										end

										if v32.Morph_Mode and v32.Morph then
											morphFunction(v32.Morph, character)
										end

										fn45("OnModeEnd")
									end
								end))

								if v32.Morph_Mode then
									morphFunction(v32.Morph_Mode, character)
								end

								fn45("OnMode")
							end
						end))
					end

					if localPlayer.Character then
						task.spawn(function()
							onCharacterAdded(localPlayer.Character)
						end)
					end

					fn47("CharAdded", localPlayer.CharacterAdded:Connect(onCharacterAdded))

					fn47("CharRemoving", localPlayer.CharacterRemoving:Connect(function()
						fn45(("OnRemoval"))

						if clone2 then
							clone2:Destroy()
						end

						fn47("ModeEnd")
					end))

					lib:Notify({ Title = "Custom Character", Description = "Applied: " .. applied, Type = "Success", Duration = 3 })
					return
				end

				while true do
				end
			end
		end

		fn24 = function(antiConfusion)
			if tbl6[("AntiConfusion")] then
				tbl6.AntiConfusion:Disconnect()
				tbl6[("AntiConfusion")] = nil
			end

			if not antiConfusion then
				return
			end

			tbl6.AntiConfusion = service.RenderStepped:Connect(function()
				local character = localPlayer.Character

				if character and character:FindFirstChild(("Confuse")) then
					character.Confuse:Destroy()
				end
			end)
		end

		fn25 = function(antiStun)
			if tbl6.AntiStun then
				tbl6[("AntiStun")]:Disconnect()
				tbl6[("AntiStun")] = nil
			end

			if not antiStun then
				return
			end

			tbl6[("AntiStun")] = service:BindToRenderStep("AntiStun", Enum.RenderPriority.Input.Value, function(arg)
				local character = localPlayer.Character
				if not character then
					return
				end
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if not humanoid or humanoid.Health <= 0 then
					return
				end
				local child = character:FindFirstChild(("HumanoidRootPart"))
				if not child then
					return
				end

				if humanoid.WalkSpeed < (16) and humanoid.MoveDirection.Magnitude > 0 then
					child.CFrame += humanoid.MoveDirection * 16 * arg
				end
			end)
		end

		fn26 = function(antiDeidaraMines)
			if tbl6.AntiDeidara then
				tbl6.AntiDeidara:Disconnect()
				tbl6.AntiDeidara = nil
			end

			if not antiDeidaraMines then
				return
			end

			tbl6.AntiDeidara = service.Heartbeat:Connect(function()
				local child = workspace:FindFirstChild(("Thrown"))
				if not child then
					return
				end

				for _, child2 in ipairs(child:GetChildren()) do
					if child2.Name == "Ball" and child2:FindFirstChild("explode_1.wav") and child2:FindFirstChild(("TouchInterest")) then
						child2.TouchInterest:Destroy()
					end
				end
			end)
		end

		fn27 = function(antiTobiTraps)
			if tbl6.AntiTobi then
				tbl6.AntiTobi:Disconnect()
				tbl6.AntiTobi = nil
			end

			if not antiTobiTraps then
				return
			end

			tbl6.AntiTobi = service.Heartbeat:Connect(function()
				for _, child in ipairs(workspace:GetChildren()) do
					if child.Name == "ExplosiveTagTrap" and child:FindFirstChild("HB") then
						child.HB:Destroy()
					end
				end
			end)
		end

		fn28 = function(antiRaidenClaymores)
			if tbl6.AntiRaiden then
				tbl6[("AntiRaiden")]:Disconnect()
				tbl6.AntiRaiden = nil
			end

			if not antiRaidenClaymores then
				return
			end

			tbl6.AntiRaiden = service.Heartbeat:Connect(function()
				local clearEachMatch = workspace:FindFirstChild("ClearEachMatch")
				if not clearEachMatch then
					return
				end

				for _, child in ipairs(clearEachMatch:GetChildren()) do
					if child.Name == "Claymore" then
						if child:FindFirstChild("TouchInterest") then
							child.TouchInterest:Destroy()
						end

						if child:FindFirstChild("Toucher") then
							child.Toucher:Destroy()
						end
					end
				end
			end)
		end

		fn29 = function(antiRisottoProjectiles)
			do
				if tbl6.AntiRisotto then
					tbl6[("AntiRisotto")]:Disconnect()
					tbl6[("AntiRisotto")] = nil
				end

				if not antiRisottoProjectiles then
					return
				end

				tbl6.AntiRisotto = service.Heartbeat:Connect(function()
					local thrown = workspace:FindFirstChild("Thrown")
					if not thrown then
						return
					end

					for _, child in ipairs(thrown:GetChildren()) do
						if child.Name:match(("Server")) and child:FindFirstChild("TouchInterest") then
							child.TouchInterest:Destroy()
						end
					end
				end)
			end
		end

		fn30 = function(antiSubway)
			if not subwayHit then
				return
			end
			subwayHit.Parent = antiSubway and game.ReplicatedFirst or service2
		end

		fn31 = function(antiSnail)
			if not becomeSnail then
				return
			end
			becomeSnail.Parent = antiSnail and game.ReplicatedFirst or service2
		end

		fn32 = function(noAnimations)
			if tbl6.NoAnims then
				tbl6.NoAnims:Disconnect()
				tbl6.NoAnims = nil
			end

			if not noAnimations then
				return
			end

			tbl6.NoAnims = service.RenderStepped:Connect(function()
				local character = localPlayer.Character
				if not character or not character:FindFirstChild("Humanoid") then
					return
				end

				for _, track in ipairs(character.Humanoid:GetPlayingAnimationTracks()) do
					track:AdjustSpeed(0)
					track:Stop()
				end
			end)
		end

		local children = {}

		for _, child in ipairs(Lighting:GetChildren()) do
			if child:IsA("PostEffect") then
				children[child] = true
			end
		end

		fn33 = function(antiSolarFlareBlind)
			if tbl6.AntiBlind then
				tbl6.AntiBlind:Disconnect()
				tbl6.AntiBlind = nil
			end

			if not antiSolarFlareBlind then
				return
			end

			tbl6.AntiBlind = Lighting.ChildAdded:Connect(function(child)
				if child:IsA("PostEffect") and not children[child] then
					task.wait()
					child:Destroy()
				end
			end)
		end

		fn34 = function(enabled2)
			if tbl6.AntiPools then
				tbl6.AntiPools:Disconnect()
				tbl6[("AntiPools")] = nil
			end

			if not enabled2 then
				return
			end

			tbl6[("AntiPools")] = service.Heartbeat:Connect(function()
				local child = workspace:FindFirstChild(("Thrown"))
				if not child then
					return
				end

				for _, child2 in ipairs(child:GetChildren()) do
					if (child2.Name == "LavaPool" or child2.Name == "GrayFloor") and child2:FindFirstChild(("TouchInterest")) then
						child2.TouchInterest:Destroy()
					end
				end
			end)
		end

		fn35 = function(antiGiornoFlowers)
			if tbl6.AntiGiorno then
				tbl6.AntiGiorno:Disconnect()
				tbl6.AntiGiorno = nil
			end

			if antiGiornoFlowers then
				tbl6.AntiGiorno = service.Heartbeat:Connect(function()
					local thrown = workspace:FindFirstChild("Thrown")
					if not thrown then
						return
					end

					for _, child in ipairs(thrown:GetChildren()) do
						if child:IsA(("BasePart")) and (child.Name == ("Existing") or child.Name:match("Flower")) and child:FindFirstChild("TouchInterest") then
							child.TouchInterest:Destroy()
						end
					end
				end)

				return
			end

			do
				if not flag2 then
					return
				end
				return
			end

			while true do
			end
		end

		fn36 = function(viewDeidaraMines)
			if tbl6.ViewDeidara then
				tbl6[("ViewDeidara")]:Disconnect()
				tbl6.ViewDeidara = nil
			end

			if not viewDeidaraMines then
				return
			end

			tbl6.ViewDeidara = service.Heartbeat:Connect(function()
				local child = workspace:FindFirstChild(("Thrown"))
				if not child then
					return
				end

				for _, child2 in ipairs(child:GetChildren()) do
					if child2.Name == ("Ball") and child2:FindFirstChild("explode_1.wav") and child2.Transparency == (1) then
						child2.Transparency = 0
					end
				end
			end)
		end

		fn37 = function(viewRisottoProjectiles)
			if tbl6.ViewRisotto then
				tbl6[("ViewRisotto")]:Disconnect()
				tbl6.ViewRisotto = nil
			end

			if not viewRisottoProjectiles then
				return
			end

			tbl6.ViewRisotto = service.Heartbeat:Connect(function()
				local thrown = workspace:FindFirstChild("Thrown")

				if not thrown then
					do
						return
					end

					while (true) do
					end
				end

				for _, child in ipairs(thrown:GetChildren()) do
					if child.Name:match("Server") and child:FindFirstChild("TouchInterest") and child.Transparency == 1 then
						child.Transparency = 0.5
					end
				end
			end)
		end

		fn38 = function(viewTobiTraps)
			if tbl6.ViewTobi then
				tbl6.ViewTobi:Disconnect()
				tbl6.ViewTobi = nil
			end

			do
				if not viewTobiTraps then
					return
				end

				tbl6.ViewTobi = service.Heartbeat:Connect(function()
					for _, child in ipairs(workspace:GetChildren()) do
						if child.Name == ("ExplosiveTagTrap") and child.Transparency == (1) then
							child.Transparency = 0.5
						end
					end
				end)

				return
			end

			while true do
			end
		end

		do
			local live = workspace:WaitForChild("Live")
			local playerGui = localPlayer.PlayerGui
			local connections3 = {}

			local function onChildAdded2(child)
				if not child:IsA("Frame") or child.Name == "TeamLabel" then
					return
				end

				if child:FindFirstChild("PlayerName") then
					local playerName = child.PlayerName
					playerName.Text = "discord.gg/zerohub"

					table.insert(connections3, playerName:GetPropertyChangedSignal(("Text")):Connect(function()
						if playerName.Text ~= "discord.gg/zerohub" then
							playerName.Text = "discord.gg/zerohub"
						end
					end))
				end
			end

			local function onChildAdded3(child)
				if child.Name == "Axis" or not child:IsA("Frame") then
					return
				end

				if not flag2 then
					return
				end

				for _, child2 in ipairs(child:GetChildren()) do
					onChildAdded2(child2)
				end

				table.insert(connections3, child.ChildAdded:Connect(onChildAdded2))
			end

			local function onChildAdded4(child)
				if child:IsA("ScreenGui") and child.Name == "StartFight" then
					for _, child2 in ipairs(child:GetChildren()) do
						if child2.Name:match("Team") and child2:FindFirstChild("picked") then
							child2.picked.Text = "discord.gg/zerohub"
						end
					end
				elseif child:IsA(("ScreenGui")) and child.Name == ("CustomLeaderboard") then
					local child2 = child:WaitForChild(("Main"))

					for _, child3 in ipairs(child2:GetChildren()) do
						onChildAdded3(child3)
					end

					table.insert(connections3, child2.ChildAdded:Connect(onChildAdded3))
				elseif child:IsA(("ScreenGui")) and child.Name == ("HUD") then
					local died = child:WaitForChild("Died")

					table.insert(connections3, died:GetPropertyChangedSignal(("Visible")):Connect(function()
						if died.Visible then
							died.Text = "Killed by discord.gg/zerohub"
						end
					end))
				end
			end

			local function onChildAdded5(child)
				local humanoid = child:WaitForChild("Humanoid")
				if not humanoid then
					return
				end
				local child3 = nil

				for _, child2 in ipairs(child:GetChildren()) do
					if child2.Name:match("^%[.-%]$") then
						child3 = child2
						break
					end
					child3 = nil
				end

				child3 = child3 and child3:FindFirstChildWhichIsA(("Humanoid"))

				if child3 then
					child3.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				end

				humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

				table.insert(connections3, humanoid:GetPropertyChangedSignal("DisplayDistanceType"):Connect(function()
					humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				end))
			end

			fn39 = function(streamerMode)
				for _, connection2 in ipairs(connections3) do
					connection2:Disconnect()
				end

				table.clear(connections3)
				if not streamerMode then
					return
				end

				if playerGui:FindFirstChild("StartFight") then
					onChildAdded4(playerGui.StartFight)
				end

				if playerGui:FindFirstChild(("CustomLeaderboard")) then
					onChildAdded4(playerGui.CustomLeaderboard)
				end

				if playerGui:FindFirstChild(("HUD")) then
					onChildAdded4(playerGui.HUD)
				end

				for _, child in ipairs(live:GetChildren()) do
					onChildAdded5(child)
				end

				table.insert(connections3, live.ChildAdded:Connect(onChildAdded5))
				table.insert(connections3, playerGui.ChildAdded:Connect(onChildAdded4))
			end
		end

		local window = lib:CreateWindow({ Title = ("ZERO HUB"), GameName = ("Anime Battle Arena"), Version = "v0.3.0" })
		local combat = window:AddCategory("COMBAT")
		local Skills = combat:AddTab("Skills")
		local Timing = combat:AddTab("Timing")
		local v33 = combat:AddTab(("Defense"))
		Techs = combat:AddTab("Techs")
		Macro = combat:AddTab("Macro")
		v28 = combat:AddTab(("Builder"))
		local local_ = window:AddCategory("LOCAL")
		local Character = local_:AddTab("Character")
		Special = local_:AddTab("Special")
		Hitbox = local_:AddTab("Hitbox")
		Utility = local_:AddTab("Utility")
		local farm = window:AddCategory("FARM")
		v27 = farm:AddTab("Auto Play")
		local v34 = farm:AddTab("Ranked Farm")
		v29 = farm:AddTab("Gold Skins")
		local visuals = window:AddCategory("VISUALS")
		local esp = visuals:AddTab("ESP")
		v30 = visuals:AddTab(("Client"))
		v34:AddGroupbox("Ranked Farm"):AddLabel("Coming Soon")
		esp:AddGroupbox(("ESP")):AddLabel(("Coming Soon"))
		lib:CreateSettingsTab(window)
		local Movement = Character:AddGroupbox("Movement")

		Movement:AddToggle(("Speedhack"), {
			Text = "Speedhack",
			Description = "Move faster than normal",
			Default = (false),
			Callback = function(speedhack)
				do
					if speedhack then
						service:BindToRenderStep("ABASpeed", Enum.RenderPriority.Input.Value, function(arg)
							local character = localPlayer.Character
							if not character then
								return
							end
							local humanoid = character:FindFirstChildOfClass("Humanoid")
							if not humanoid or humanoid.Health <= 0 then
								return
							end
							local child = character:FindFirstChild(("HumanoidRootPart"))
							if not child then
								return
							end

							if humanoid.MoveDirection.Magnitude > 0 then
								child.CFrame += humanoid.MoveDirection * speed2 * arg
							end
						end)
					else
						service:UnbindFromRenderStep("ABASpeed")
					end

					return
				end

				while true do
				end
			end,
		}):AddKeybind({ Mode = "Toggle" })

		Movement:AddSlider("SpeedhackSpeed", {
			Text = "Speed",
			Min = 0,
			Max = 5000,
			Default = 100,
			Callback = function(speed)
				speed2 = speed
			end,
		})

		Movement:AddToggle("Flyhack", {
			Text = "Fly",
			Description = "Fly around the map freely",
			Default = (false),
			Callback = function(fly)
				if fly then
					service:BindToRenderStep("ABAFly", Enum.RenderPriority.Input.Value, function(arg)
						local character = localPlayer.Character
						if not character then
							return
						end
						local child = character:FindFirstChild(("HumanoidRootPart"))
						if not child then
							return
						end

						if not getgenv()._ABA_flyFrame then


							getgenv()._ABA_flyFrame = child.CFrame
						end

						local abaFlyFrame = getgenv()._ABA_flyFrame
						local cframe = workspace.CurrentCamera.CFrame
						local vector = Vector3.zero
						local unit = Vector3.new(cframe.LookVector.X, 0, cframe.LookVector.Z).Unit
						local unit2 = Vector3.new(cframe.RightVector.X, (0), cframe.RightVector.Z).Unit

						if UserInputService:IsKeyDown(Enum.KeyCode.W) then
							vector += unit
						end

						if UserInputService:IsKeyDown(Enum.KeyCode.S) then
							vector -= unit
						end

						if UserInputService:IsKeyDown(Enum.KeyCode.A) then
							vector -= unit2
						end

						if UserInputService:IsKeyDown(Enum.KeyCode.D) then


							vector += unit2
						end

						if UserInputService:IsKeyDown(Enum.KeyCode.Space) then


							vector += Vector3.new((0), 1, (0))
						end

						if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
							vector -= Vector3.new(0, 1, 0)
						end

						if vector.Magnitude > 0 then
							abaFlyFrame += vector.Unit * n13 * arg
						end

						local vector2 = Vector3.new(cframe.LookVector.X, 0, cframe.LookVector.Z)

						if vector2.Magnitude > 0 then
							abaFlyFrame = CFrame.new(abaFlyFrame.Position, abaFlyFrame.Position + vector2.Unit)
						end

						getgenv()._ABA_flyFrame = abaFlyFrame
						child.AssemblyLinearVelocity = Vector3.zero
						child.CFrame = abaFlyFrame
					end)
				else
					service:UnbindFromRenderStep(("ABAFly"))
					getgenv()._ABA_flyFrame = nil
				end
			end,
		}):AddKeybind({ Mode = "Toggle" })

		Movement:AddSlider("FlySpeed", {
			Text = ("Fly Speed"),
			Min = 0,
			Max = 5000,
			Default = 100,
			Callback = function(value)
				n13 = value
			end,
		})

		Movement:AddToggle("InfiniteJump", {
			Text = "Infinite Jump",
			Description = ("Jump unlimited times in the air"),
			Default = false,
			Callback = function(infiniteJump)
				if tbl6[("InfJump")] then
					tbl6.InfJump:Disconnect()
					tbl6[("InfJump")] = nil
				end

				if not infiniteJump then
					return
				end

				tbl6[("InfJump")] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
					if gameProcessed or input.KeyCode ~= Enum.KeyCode.Space then
						return
					end
					local child = localPlayer.Character and localPlayer.Character:FindFirstChild(("HumanoidRootPart"))

					if child then
						child.AssemblyLinearVelocity = Vector3.new(child.AssemblyLinearVelocity.X, y, child.AssemblyLinearVelocity.Z)
					end
				end)
			end,
		}):AddKeybind({ Mode = "Toggle" })

		Movement:AddSlider("JumpHeight", {
			Text = ("Jump Height"),
			Min = (0),
			Max = 1000,
			Default = 50,
			Callback = function(value)
				y = value
			end,
		})

		local Prestige = Character:AddGroupbox("Prestige")

		Prestige:AddDropdown("PrestigeSelect", {
			Text = "Select Character",
			Description = "Pick any prestige character without owning it, open the prestige menu first",
			Values = {
				"Tokita Ohma",
				"Zenitsu",
				"Shisui",
				"Tobi",
				"Satsuki Kiryuin",
				"Achilles",
				"Zamasu [Fused]",
				"Super Dummy",
				("Hercule Satan"),
				"Shadow DIO",
				"Mr President",
				"Chiaotzu",
			},
			Default = nil,
			Multi = false,
			Callback = function(selectCharacter)
				selectCharacter2 = selectCharacter
			end,
		})

		Prestige:AddButton({
			Text = "Pick Prestige",
			Func = function()
				if selectCharacter2 then
					fn41(selectCharacter2)
				end
			end,
		})

		local v35 = Character:AddGroupbox("Custom Characters")
		local tbl12 = {}

		for k in pairs(applieds) do
			table.insert(tbl12, k)
		end

		v35:AddDropdown(("CustomCharSelect"), {
			Text = "Select Skin",
			Description = "All credits to ASU",
			Values = tbl12,
			Default = nil,
			Multi = false,
			Callback = function()
			end,
		})

		v35:AddButton({
			Text = "Apply Skin",
			Func = function()
				local value = lib.Options.CustomCharSelect and lib.Options.CustomCharSelect.Value

				if value and value ~= "" then
					fn42(value)
				end
			end,
		})

		v35:AddButton({
			Text = "Disable Skin",
			Func = function()
				for k, connection2 in pairs(connections2) do
					pcall(function()
						connection2:Disconnect()
					end)

					connections2[k] = nil
				end

				applied3 = nil
				v32 = nil

				if clone2 then
					clone2:Destroy()
				end

				local character = localPlayer.Character

				if character and character:FindFirstChildOfClass(("Humanoid")) then
					character:FindFirstChildOfClass(("Humanoid")).Health = 0
				end

				lib:Notify({
					Title = "Custom Character",
					Description = "Skin disabled, respawning",
					Type = "Warning",
					Duration = 3,
				})
			end,
		})

		Character:AddGroupbox("Clones"):AddToggle("CloneTP", {
			Text = ("Teleport Clones"),
			Description = "Teleports your clones to the nearest enemy when they spawn",
			Default = false,
			Callback = function(enabled2)
				if tbl6.CloneLive then
					tbl6.CloneLive:Disconnect()
					tbl6.CloneLive = nil
				end

				if tbl6.CloneThrown then
					tbl6.CloneThrown:Disconnect()
					tbl6.CloneThrown = nil
				end

				if not enabled2 then
					return
				end

				local function onChildAdded2(child)
					local name = child.Name:gsub((" "), "")
					if not Players:FindFirstChild(name) or Players:GetPlayerFromCharacter(child) then
						return
					end

					if name ~= localPlayer.Name then
						return
					end
					local humanoidRootPart = child:WaitForChild("HumanoidRootPart", (5))
					if not humanoidRootPart then
						return
					end
					task.wait(0.1)
					if not isnetworkowner(humanoidRootPart) then
						return
					end
					local character = nil

					for _, player in ipairs(Players:GetPlayers()) do
						if player ~= localPlayer and player.Character and player.Character:FindFirstChild(("HumanoidRootPart")) then
							character = player.Character
							break
						end
						character = nil
					end

					if character then
						for i = (1), (10) do
							child:PivotTo(character:GetPivot())
							task.wait()
						end
					end
				end

				local live = workspace:FindFirstChild("Live")



				if not flag2 then
					return
				end

				if live then
					tbl6.CloneLive = live.ChildAdded:Connect(onChildAdded2)
				end

				local thrown = workspace:FindFirstChild("Thrown")

				if thrown then


					tbl6.CloneThrown = thrown.ChildAdded:Connect(function(child)
						task.wait(1)
						onChildAdded2(child)
					end)
				end
			end,
		})

		Character:AddGroupbox(("Rukia")):AddToggle("RukiaBankai", {
			Text = "Rukia Bankai Reset",
			Description = "Auto resets when hit by Rukia Bankai, saves time",
			Default = (false),
			Callback = function(rukiaBankaiReset)
				if tbl6.RukiaBankai then
					tbl6[("RukiaBankai")]:Disconnect()
					tbl6.RukiaBankai = nil
				end

				if not rukiaBankaiReset then
					return
				end
				local flag13 = false

				tbl6.RukiaBankai = service.RenderStepped:Connect(function()
					local character = localPlayer.Character

					if character and not flag13 then
						local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

						if humanoidRootPart and humanoidRootPart:FindFirstChild(("RukiaBankai")) then
							flag13 = true
							task.wait(4)

							if character and character:FindFirstChildOfClass(("Humanoid")) then
								character:BreakJoints()
							end

							task.wait((3))
							flag13 = false
						end

						return
					end

					do
						return
					end

					while true do
					end
				end)
			end,
		})

		Character:AddGroupbox("Misc"):AddToggle("Noclip", {
			Text = "Noclip",
			Description = "Walk through walls",
			Default = (false),
			Callback = function(noclip)
				if tbl6.Noclip then
					tbl6.Noclip:Disconnect()
					tbl6[("Noclip")] = nil
				end

				if not noclip then
					return
				end
				local parts = {}
				local character2 = nil

				tbl6.Noclip = service.Heartbeat:Connect(function()
					local character = localPlayer.Character

					if character ~= character2 then
						parts = {}



						character2 = character

						if character then
							for _, descendant in ipairs(character:GetDescendants()) do
								if descendant:IsA(("BasePart")) then
									parts[#parts + (1)] = descendant
								end
							end
						end
					end

					for _, part in ipairs(parts) do
						if part.Parent then
							part.CanCollide = false
						end
					end
				end)
			end,
		}):AddKeybind({ Mode = ("Toggle") })

		local Naruto = Skills:AddGroupbox("Naruto")

		Naruto:AddToggle(("GaaraTsunami"), {
			Text = "Gaara Tsunami",
			Description = "Redirects Tsunami projectile to everyone on the map",
			Default = (false),
			Callback = function(gaaraTsunami)
				tbl10.GaaraTsunami = gaaraTsunami
			end,
		})

		Naruto:AddToggle("GaaraGreatTsunami", {
			Text = "Gaara Great Tsunami",
			Description = "Redirects Great Tsunami projectile to everyone on the map",
			Default = (false),
			Callback = function(gaaraGreatTsunami)
				tbl10.GaaraGreatTsunami = gaaraGreatTsunami
			end,
		})

		local JoJo = Skills:AddGroupbox("JoJo")

		JoJo:AddToggle("OldJosephJeep", {
			Text = "Old Joseph Jeep",
			Description = "Redirects Jeep projectile to everyone on the map",
			Default = false,
			Callback = function(oldJosephJeep)
				tbl10.OldJosephJeep = oldJosephJeep
			end,
		})

		JoJo:AddToggle("OldJosephBarrel", {
			Text = ("Old Joseph Barrel"),
			Description = "Redirects Barrel projectile to everyone on the map",
			Default = (false),
			Callback = function(enabled2)
				tbl10.OldJosephBarrel = enabled2
			end,
		})

		local v36 = Skills:AddGroupbox(("Bleach"))

		v36:AddToggle("IchigoTSGetsuga", {
			Text = "Ichigo TS Getsuga",
			Description = "Redirects Getsuga projectile to everyone on the map",
			Default = (false),
			Callback = function(ichigoTsGetsuga)
				tbl10.IchigoTSGetsuga = ichigoTsGetsuga
			end,
		})

		v36:AddToggle("GrimjowPantherClaw", {
			Text = "Grimjow Panther Claw",
			Description = "Redirects Panther Claw projectile to everyone on the map",
			Default = false,
			Callback = function(grimjowPantherClaw)
				tbl10.GrimjowPantherClaw = grimjowPantherClaw
			end,
		})

		Skills:AddGroupbox("One Piece"):AddToggle("AkainuFist", {
			Text = "Akainu Fist",
			Description = "Redirects Fist projectile to everyone on the map",
			Default = false,
			Callback = function(akainuFist)
				tbl10.AkainuFist = akainuFist
			end,
		})

		local v37 = Skills:AddGroupbox("My Hero Academia")

		v37:AddToggle(("DekuDelawareSmash"), {
			Text = "Deku Delaware Smash",
			Description = "Redirects Delaware Smash projectile to everyone on the map",
			Default = (false),
			Callback = function(dekuDelawareSmash)
				tbl10.DekuDelawareSmash = dekuDelawareSmash
			end,
		})

		v37:AddToggle(("Bakugo"), {
			Text = ("Bakugo Gauntlet Blast"),
			Description = "Redirects Gauntlet Blast projectile to everyone on the map",
			Default = false,
			Callback = function(enabled2)
				tbl10.Bakugo = enabled2
				if not flag then
					return
				end
			end,
		})

		local v38 = Skills:AddGroupbox("Jujutsu Kaisen")

		v38:AddToggle("GojoHollowPurple", {
			Text = "Gojo Hollow Purple",
			Description = "Redirects Hollow Purple projectile to everyone on the map",
			Default = false,
			Callback = function(gojoHollowPurple)
				tbl10.GojoHollowPurple = gojoHollowPurple
			end,
		})

		v38:AddToggle("GojoBlueUlt", {
			Text = ("Gojo Blue Ult"),
			Description = "Redirects Blue Ult projectile to everyone on the map",
			Default = false,
			Callback = function(enabled2)
				tbl10.GojoBlueUlt = enabled2
			end,
		})

		v38:AddToggle(("NanamiAuto2"), {
			Text = "Nanami Auto 7:3 Combo",
			Description = "Auto uses 7:3 Combo for the 2nd slash",
			Default = (false),
			Callback = function(nanamiAuto7)
				if tbl6[("NanamiAuto2")] then
					tbl6[("NanamiAuto2")]:Disconnect()
					tbl6[("NanamiAuto2")] = nil
				end

				if tbl6[("NanamiAuto2Char")] then
					tbl6.NanamiAuto2Char:Disconnect()
					tbl6.NanamiAuto2Char = nil
				end

				if not nanamiAuto7 then
					return
				end

				local function onCharacterAdded(character)
					if tbl6.NanamiAuto2 then
						tbl6.NanamiAuto2:Disconnect()
					end

					tbl6.NanamiAuto2 = character.ChildAdded:Connect(function(child)
						if child.Name ~= "UsingSkill" or child.Value ~= "7:3 Combo" then
							return
						end
						local input = localPlayer.Backpack:FindFirstChild("Input")
						if not input then
							return
						end
						local currentCamera = workspace.CurrentCamera
						local magnitude2 = math.huge
						local child3 = nil

						for _, child2 in ipairs(workspace.Live:GetChildren()) do
							if child2 ~= character and child2:FindFirstChild("HumanoidRootPart") then
								local magnitude = (child2.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude

								if magnitude < magnitude2 then
									magnitude2 = magnitude
									child3 = child2
								end
							end
						end

						if not child3 then
							return
						end

						for i = 1, 3 do
							input:FireServer("UseMove", {
								air = (false),
								neutral = false,
								campos = currentCamera.CFrame.Position,
								range = ("2"),
								ToolName = "7:3 Combo",
								running = true,
								camdir = currentCamera.CFrame.LookVector,
								targ = child3,
								teamtarg = child3,
								mousehit = currentCamera.CFrame,
							})

							task.wait(0.1)
						end
					end)
				end

				if localPlayer.Character then
					onCharacterAdded(localPlayer.Character)
				end

				tbl6.NanamiAuto2Char = localPlayer.CharacterAdded:Connect(onCharacterAdded)
			end,
		})

		v38:AddToggle("GojoBlue", {
			Text = "Gojo Blue Buff",
			Description = "Gives you Gojo's blue dodge buff permanently",
			Default = false,
			Callback = function(gojoBlueBuff)
				if not flag then
					return
				end

				if tbl6[("GojoBlue")] then
					tbl6.GojoBlue:Disconnect()
					tbl6.GojoBlue = nil
				end

				if not gojoBlueBuff then
					local character = localPlayer.Character

					if character and character:FindFirstChild(("BlueBuff")) then
						character.BlueBuff:Destroy()
					end

					return
				end

				tbl6.GojoBlue = service.RenderStepped:Connect(function()
					local character = localPlayer.Character
					if not character then
						return
					end

					if not character:FindFirstChild(("BlueBuff")) then
						local highlight = Instance.new("Highlight", character)
						highlight.FillTransparency = 1
						highlight.OutlineColor = Color3.fromRGB(50, 50, 255)
						highlight.Name = ("BlueBuff")
					end
				end)
			end,
		})

		local Misc = Skills:AddGroupbox("Misc")

		Misc:AddToggle("YusukeSpiritGun", {
			Text = ("Yusuke Spirit Gun"),
			Description = "Redirects Spirit Gun projectile to everyone on the map",
			Default = false,
			Callback = function(enabled2)
				tbl10.YusukeSpiritGun = enabled2
			end,
		})

		Misc:AddToggle("RengokuFlamingTiger", {
			Text = "Rengoku Flaming Tiger",
			Description = "Redirects Flaming Tiger projectile to everyone on the map",
			Default = false,
			Callback = function(rengokuFlamingTiger)
				tbl10.RengokuFlamingTiger = rengokuFlamingTiger
			end,
		})

		Misc:AddToggle("KazumaSniper", {
			Text = "Kazuma Sniper Arrow",
			Description = "Redirects Sniper Arrow projectile to everyone on the map",
			Default = false,
			Callback = function(kazumaSniperArrow)
				tbl10.KazumaSniper = kazumaSniperArrow
			end,
		})

		Misc:AddToggle("AcceleratorQuake", {
			Text = "Accelerator Quake",
			Description = ("Redirects Quake projectile to everyone on the map"),
			Default = (false),
			Callback = function(acceleratorQuake)
				tbl10.AcceleratorQuake = acceleratorQuake
			end,
		})

		Misc:AddToggle(("SuperDummyKillBlock"), {
			Text = "Super Dummy Kill Block",
			Description = ("Redirects Kill Block projectile to everyone on the map"),
			Default = false,
			Callback = function(superDummyKillBlock)
				do
					tbl10.SuperDummyKillBlock = superDummyKillBlock
					return
				end

				while true do
				end
			end,
		})

		local enabled3 = false

		Misc:AddToggle("RaidenBlade", {
			Text = ("Raiden Auto Chop"),
			Description = "Spam slices in blade mode for max damage",
			Default = false,
			Callback = function(enabled2)
				enabled3 = enabled2

				if enabled2 then
					task.spawn(function()
						do
							local character = localPlayer.Character
							if not character then
								return
							end
							local bladeRemote = character:FindFirstChild("BladeRemote")
							if not bladeRemote then
								return
							end
							local tbl13 = { "Right", "Left", "Up", "Down" }

							for i = 1, 1000 do
								if not enabled3 then
									break
								end
								bladeRemote:FireServer(tbl13[math.random(1, 4)])
								task.wait()
							end

							return
						end

						while true do
						end
					end)

					if not flag2 then
						return
					end
					return
				end

				do
					return
				end

				while true do
				end
			end,
		}):AddKeybind({ Mode = ("Toggle") })

		fn40()

		do
			local v39 = Timing:AddGroupbox("Black Flash")
			local n14 = 100

			v39:AddToggle("BlackFlash", {
				Text = "Auto Black Flash",
				Description = "Always hit perfect timing with blackflash characters (Supports Itadori, Sukuna, Gojo, Toji, Geto, Todo & Future JJK Characters)",
				Default = false,
				Callback = function(autoBlackFlash)
					if not autoBlackFlash then
						return
					end
					local currentCamera = workspace.CurrentCamera

					service2:WaitForChild(("BlackFlashCheck")).OnClientInvoke = function(arg, delay)
						if n14 < math.random(1, (100)) then
							return false
						end
						local duration = arg - delay
						TweenService:Create(currentCamera, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), { FieldOfView = 6 }):Play()
						task.wait(duration + 0.01)

						if (0) < delay then


							TweenService:Create(currentCamera, TweenInfo.new(delay), { FieldOfView = 70 }):Play()
							task.wait(delay)
						end

						currentCamera.FieldOfView = 70

						task.spawn(function()
							task.wait(0.1)
							currentCamera.FieldOfView = 70
						end)

						return (true)
					end
				end,
			})

			v39:AddSlider("BlackFlashChance", {
				Text = ("Hit Chance"),
				Description = "Percentage chance to land black flash when the window opens, lower values look more natural",
				Min = 0,
				Max = (100),
				Default = 100,
				Suffix = "%",
				Callback = function(value)
					n14 = value
				end,
			})
		end

		do
			local Kokushibo = Timing:AddGroupbox("Kokushibo")
			local hitChance2 = 100

			Kokushibo:AddToggle("KokushiboTiming", {
				Text = "Auto Kokushibo Timing",
				Description = "Always hit perfect timing with Kokushibo's crescent moon slashes",
				Default = false,
				Callback = function(autoKokushiboTiming)
					if not autoKokushiboTiming then
						return
					end

					service2:WaitForChild("KokushiboCheck").OnClientInvoke = function(arg, arg2)
						if math.random(1, 100) > hitChance2 then
							return (false)
						end
						local delay = arg2 * 2
						local duration = arg * (2) - delay
						local clone3 = service2.FrenchKokushibo:Clone()

						for _, child in pairs(clone3:GetChildren()) do
							TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
								Position = UDim2.new(child.Position.X.Scale + math.random(1, 2) / 60 * (math.random((0), 1) == 0 and -1 or (1)), 0, child.Position.Y.Scale + math.random(1, 3) / 90 * (math.random(0, 1) == 0 and -1 or (1)), (0)),
							}):Play()
						end

						clone3.Parent = localPlayer.PlayerGui
						task.wait(duration + 0.01)

						for _, child in pairs(clone3:GetChildren()) do
							TweenService:Create(child.UIScale, TweenInfo.new((0.5), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Scale = 1.2 }):Play()
							TweenService:Create(child, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { ImageTransparency = 1 }):Play()
							child.ImageColor3 = Color3.new(0.345098, 0.847059, 1)
						end

						task.wait(delay)
						clone3:Destroy()
						return true
					end
				end,
			})

			Kokushibo:AddSlider("KokushiboChance", {
				Text = "Hit Chance",
				Description = "Percentage chance to land perfect Kokushibo timing, lower values look more natural",
				Min = 0,
				Max = (100),
				Default = 100,
				Suffix = "%",
				Callback = function(hitChance)
					do
						hitChance2 = hitChance
						return
					end

					while true do
					end
				end,
			})
		end

		do
			local Nanami = Timing:AddGroupbox("Nanami")
			local hitChance2 = 100

			Nanami:AddToggle("NanamiTiming", {
				Text = "Auto Nanami Black Flash",
				Description = "Auto hits Nanamis Blackflash",
				Default = false,
				Callback = function(autoNanamiBlackFlash)
					if not autoNanamiBlackFlash then
						return
					end
					local nanamiCheck = service2:WaitForChild("NanamiCheck")
					local nanamiCutGUI = service2:WaitForChild("NanamiCutGUI")
					local live = workspace:FindFirstChild("Live") or workspace

					nanamiCheck.OnClientInvoke = function(arg, arg2, instance)
						if math.random(1, 100) > hitChance2 then
							return false
						end
						local clone3 = nanamiCutGUI:Clone()
						clone3.MainBar.Rotation = -80
						clone3.Parent = live[arg.Name].HumanoidRootPart
						clone3.Adornee = live[arg.Name].HumanoidRootPart

						local mainBar = clone3.MainBar
						local cutter = mainBar.Cutter
						local flag13 = (false)
						local x = 0.005

						while x < (1) and instance:GetAttribute("NANAMIAIM") and not flag13 do
							local n14 = task.wait() / arg2
							local n15 = math.abs(0.7 - x)
							mainBar.Rotation = x < (0.69999999999999996) and x / 0.7 * 80 - (80) or (0)

							if n15 < 0.025 then
								n14 /= 8
							elseif n15 < (0.050000000000000003) then
								n14 /= 4
							end

							x += n14
							cutter.Position = UDim2.fromScale(x, 0.5)

							if n15 < 0.02 then
								flag13 = true
							end
						end

						if flag13 and instance:GetAttribute(("NANAMIAIM")) then
							cutter.Position = UDim2.fromScale(0.7, 0.5)
							TweenService:Create(clone3, TweenInfo.new((0.25)), { Size = UDim2.new(10, 200, 10, 200) }):Play()
							cutter.Size = UDim2.fromScale((0.016), 12)

							TweenService:Create(cutter, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
								Size = UDim2.fromScale(0, 24),
								BackgroundColor3 = Color3.new(1, 0, 0),
								BackgroundTransparency = (1),
							}):Play()

							local instance2 = Instance.new(("ColorCorrectionEffect"), Lighting)
							instance2.TintColor = Color3.new(0, 0, 0)
							Debris:AddItem(instance2, 0.15)
						end

						Debris:AddItem(clone3, 0.5)
						return flag13
					end
				end,
			})

			Nanami:AddSlider("NanamiChance", {
				Text = "Hit Chance",
				Description = ("Chance to land Nanamis Blackflash"),
				Min = 0,
				Max = 100,
				Default = (100),
				Suffix = "%",
				Callback = function(hitChance)
					hitChance2 = hitChance
				end,
			})
		end

		local flag13 = (false)
		local connection2 = nil

		local function onChildAdded2(child)
			if child.Name == "HUD" then
				child.ChildAdded:Connect(function(child2)
					if child2.Name == "KeysFrame" then
						child2:WaitForChild("LocalScript", 9e9).Disabled = true

						service2.OsuCheck.OnClientInvoke = function(delay, delay2, text, arg, arg2)
							local clone3 = child2.Ring:Clone()
							local clone4 = child2.Circle:Clone()
							clone3.Name = "Img"
							clone4.Name = "Img"
							local v39 = Random.new()
							clone4.Position = UDim2.new(v39:NextNumber((0), 1), 0, v39:NextNumber(0, (1)), (0))
							clone3.Position = clone4.Position
							Debris:AddItem(clone4, delay + delay2 + 0.3)
							Debris:AddItem(clone3, delay + delay2 + 0.3)
							clone4:FindFirstChild("TextLabel").Text = text
							clone4.Visible = (true)
							clone3.Visible = true
							clone4.Parent = child2
							clone3.Parent = child2
							TweenService:Create(clone3, TweenInfo.new(delay, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Size = UDim2.new(0.158, (0), 0.187, 0), Position = clone4.Position }):Play()
							local flag14 = false
							local v40 = (false)

							local connection3 = UserInputService.InputBegan:Connect(function(input)
								if not flag14 then
									if input.KeyCode == arg or input.KeyCode == arg2 then
										v40 = (true)

										task.spawn(function()
											TweenService:Create(clone3, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
												ImageTransparency = 1,
												Size = UDim2.new(clone3.Size.X.Scale * 1.2, (0), clone3.Size.Y.Scale * (2), 0),
											}):Play()

											TweenService:Create(clone4, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { ImageTransparency = 1, Size = UDim2.new(clone4.Size.X.Scale * 1.2, 0, clone4.Size.Y.Scale * 2, 0) }):Play()
											clone4:FindFirstChild("TextLabel").Text = ""
										end)

										flag14 = (true)

										task.spawn(function()
											clone3.ImageColor3 = Color3.new(1, 0.152941, 0.152941)
											clone4.ImageColor3 = Color3.new((1), 0.152941, 0.152941)
											TweenService:Create(clone3, TweenInfo.new((0.29999999999999999), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { ImageTransparency = 1, ImageColor3 = Color3.new((1), 0.152941, 0.152941) }):Play()
											TweenService:Create(clone4, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { ImageTransparency = (1) }):Play()
											clone4:FindFirstChild(("TextLabel")).Text = ""
										end)
									end
								end
							end)

							wait(delay)
							wait(delay2)
							connection3:Disconnect()
							return (true)
						end
					end
				end)
			end
		end

		Timing:AddGroupbox("Tengen"):AddToggle(("TengenTiming"), {
			Text = ("Auto Tengen Osu"),
			Description = "Hits every Tengen rhythm note automatically",
			Default = false,
			Callback = function(enabled2)
				if enabled2 and not flag13 then
					flag13 = true
					local child = localPlayer:FindFirstChild(("PlayerGui"))

					if child:FindFirstChild("HUD") then
						onChildAdded2(child.HUD)
					end

					if connection2 then
						connection2:Disconnect()
					end

					connection2 = child.ChildAdded:Connect(onChildAdded2)
				end
			end,
		})

		v31 = v33:AddGroupbox("Auto M1 Trade")
	end

	local fn40, fn41, fn42
	local tbl8
	local tbl9, instances, connections, connection2, enableAutoM1Trade2

	do
		local child = nil
		tbl9 = {}
		instances = {}
		connections = {}
		connection2 = nil
		enableAutoM1Trade2 = false
		local now2 = 0

		tbl8 = {
			["rbxassetid://1461128166"] = { delay = 0.1, name = "m1" },
			["rbxassetid://1461136273"] = { delay = 0.1, name = "m2" },
			["rbxassetid://1461128859"] = { delay = (0.10000000000000001), name = "m3" },
			["rbxassetid://1461136875"] = { delay = (0.16), name = ("noman") },
			["rbxassetid://1461145506"] = { delay = 0.1, name = "ypfling" },
			["rbxassetid://1461127258"] = { delay = 0.001, name = "downer" },
			["rbxassetid://1730596371"] = { delay = (0.10000000000000001), name = ("m1") },
			["rbxassetid://1730606513"] = { delay = 0.1, name = "m2" },
			["rbxassetid://1730618971"] = { delay = 0.1, name = ("m3") },
			["rbxassetid://1730629532"] = { delay = 0.1, name = "m4" },
			["rbxassetid://1947173251"] = { delay = 0.1, name = "law_m1" },
			["rbxassetid://1947196236"] = { delay = 0.1, name = "law_m2" },
			["rbxassetid://1947219719"] = { delay = (0.10000000000000001), name = "law_m3" },
			["rbxassetid://1947230024"] = { delay = 0.1, name = "law_m4" },
			["rbxassetid://1885667765"] = { delay = 0.1, name = ("sanji_m1") },
			["rbxassetid://1885679702"] = { delay = 0.1, name = "sanji_m2" },
			["rbxassetid://1885690040"] = { delay = 0.1, name = "sanji_m3" },
			["rbxassetid://1885693880"] = { delay = (0.10000000000000001), name = ("sanji_m4") },
			["rbxassetid://2653288957"] = { delay = 0.1, name = "enel_m1" },
			["rbxassetid://2653292053"] = { delay = 0.1, name = "enel_m2" },
			["rbxassetid://2653295985"] = { delay = 0.1, name = "enel_m3" },
			["rbxassetid://2653299927"] = { delay = 0.1, name = "enel_m4" },
			["rbxassetid://8442976984"] = { delay = 0.1, name = "broly_m3" },
			["rbxassetid://8442979908"] = { delay = 0.1, name = "broly_m4" },
			["rbxassetid://3238447426"] = { delay = 0.1, name = "gblack_m1" },
			["rbxassetid://3238448310"] = { delay = 0.1, name = "gblack_m2" },
			["rbxassetid://3238449301"] = { delay = 0.1, name = "gblack_m3" },
			["rbxassetid://3238450309"] = { delay = 0.1, name = "gblack_m4" },
			["rbxassetid://1470422387"] = { delay = 0.1, name = "sword_m1" },
			["rbxassetid://1470439852"] = { delay = (0.10000000000000001), name = "sword_m2" },
			["rbxassetid://1470449816"] = { delay = 0.1, name = "sword_m3" },
			["rbxassetid://1470447472"] = { delay = 0.1, name = "sword_m4" },
			["rbxassetid://10005397081"] = { delay = (0.10000000000000001), name = "guts_m1" },
			["rbxassetid://10005430027"] = { delay = 0.1, name = "guts_m2" },
			["rbxassetid://10005462854"] = { delay = 0.1, name = "guts_m3" },
			["rbxassetid://10005508646"] = { delay = 0.1, name = ("guts_m4") },
			["rbxassetid://102593351681033"] = { delay = (0.10000000000000001), name = ("maka_m1") },
			["rbxassetid://111366686942798"] = { delay = 0.1, name = "maka_m2" },
			["rbxassetid://71830104436314"] = { delay = 0.1, name = "maka_m3" },
			["rbxassetid://100538053697796"] = { delay = 0.1, name = ("maka_m4") },
			["rbxassetid://129856070992547"] = { delay = 0.1, name = "alucard_m1" },
			["rbxassetid://106548325298957"] = { delay = 0.1, name = "alucard_m2" },
			["rbxassetid://108198644371262"] = { delay = 0.1, name = "alucard_m3" },
			["rbxassetid://84395905295585"] = { delay = 0.1, name = ("alucard_m4") },
			["rbxassetid://14436312737"] = { delay = 0.1, name = "killerb_m1" },
			["rbxassetid://14437145085"] = { delay = 0.1, name = "killerb_m2" },
			["rbxassetid://14437148019"] = { delay = 0.1, name = "killerb_m3" },
			["rbxassetid://14437150122"] = { delay = (0.10000000000000001), name = "killerb_m4" },
			["rbxassetid://100004180935781"] = { delay = 0.1, name = "sjw_m1" },
			["rbxassetid://131393003451623"] = { delay = 0.1, name = "sjw_m2" },
			["rbxassetid://110197522831021"] = { delay = (0.10000000000000001), name = "sjw_m3" },
			["rbxassetid://99546053454432"] = { delay = 0.1, name = "sjw_m4" },
			["rbxassetid://6765035204"] = { delay = 0.1, name = "lance_m1" },
			["rbxassetid://6765057406"] = { delay = (0.10000000000000001), name = "lance_m2" },
			["rbxassetid://7413861926"] = { delay = 0.1, name = "unique_m1" },
			["rbxassetid://7413904138"] = { delay = (0.10000000000000001), name = "unique_m2" },
			["rbxassetid://17306010161"] = { delay = 0.1, name = ("vegito_m1") },
			["rbxassetid://17306012933"] = { delay = 0.1, name = "vegito_m2" },
			["rbxassetid://17306015782"] = { delay = 0.1, name = ("vegito_m3") },
			["rbxassetid://17306019069"] = { delay = 0.1, name = "vegito_m4" },
			["rbxassetid://17423591514"] = { delay = 0.1, name = "gogeta_m1" },
			["rbxassetid://17423592816"] = { delay = 0.1, name = "gogeta_m2" },
			["rbxassetid://17423594220"] = { delay = 0.1, name = ("gogeta_m3") },
			["rbxassetid://17442363923"] = { delay = (0.10000000000000001), name = "gogeta_m4" },
			["rbxassetid://9941010371"] = { delay = (0.10000000000000001), name = "shield_m1" },
			["rbxassetid://9941073313"] = { delay = (0.10000000000000001), name = "shield_m2" },
			["rbxassetid://9941176251"] = { delay = (0.10000000000000001), name = ("shield_m3") },
			["rbxassetid://9941247556"] = { delay = (0.10000000000000001), name = "shield_m4" },
			["rbxassetid://8442968861"] = { delay = 0.1, name = "punch_m1" },
			["rbxassetid://8442974672"] = { delay = (0.10000000000000001), name = "punch_m2" },
			["rbxassetid://8319862463"] = { delay = 0.1, name = "kirito_m1" },
			["rbxassetid://8320258247"] = { delay = 0.1, name = ("kirito_m2") },
			["rbxassetid://8321532463"] = { delay = 0.1, name = "kirito_m3" },
			["rbxassetid://8321564926"] = { delay = 0.1, name = "kirito_m4" },
			["rbxassetid://9068688717"] = { delay = 0.1, name = "asuna_m1" },
			["rbxassetid://9068689970"] = { delay = 0.1, name = "asuna_m2" },
			["rbxassetid://9068691739"] = { delay = 0.1, name = ("asuna_m3") },
			["rbxassetid://9068693092"] = { delay = 0.1, name = "asuna_m4" },
			["rbxassetid://10598162443"] = { delay = 0.1, name = ("gun1_m1") },
			["rbxassetid://10599060714"] = { delay = 0.1, name = "gun1_m2" },
			["rbxassetid://10599128601"] = { delay = (0.10000000000000001), name = "gun1_m3" },
			["rbxassetid://10599110274"] = { delay = 0.1, name = "gun1_m4" },
			["rbxassetid://14272212914"] = { delay = 0.1, name = "tatsu_m1" },
			["rbxassetid://14272246471"] = { delay = 0.1, name = "tatsu_m2" },
			["rbxassetid://14272266117"] = { delay = 0.1, name = "tatsu_m3" },
			["rbxassetid://14272296104"] = { delay = (0.10000000000000001), name = "tatsu_m4" },
			["rbxassetid://128980851549763"] = { delay = 0.1, name = "kara_m1" },
			["rbxassetid://122609664088954"] = { delay = (0.10000000000000001), name = "kara_m2" },
			["rbxassetid://75267484294449"] = { delay = 0.1, name = "kara_m3" },
		}

		local function getChild()
			if child and child.Parent then
				return child
			end
			child = localPlayer.Backpack:FindFirstChild(("Input")) or localPlayer.Character and localPlayer.Character:FindFirstChild(("Input"))
			return child
		end

		local function fn43(arg)
			local child2 = getChild()
			if not child2 then
				return
			end

			pcall(function()
				child2:FireServer(arg and "BlockOn" or "BlockOff")
			end)
		end

		local function fn44()
			local child2 = getChild()

			if not child2 then
				if not flag then
					return
				end
				return
			end

			local character = localPlayer.Character
			if not character then
				return
			end
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart then
				return
			end

			pcall(function()
				child2:FireServer("M1", { air = false, skeyreal = false, skeydown = true, mousehit = humanoidRootPart.CFrame, md = Vector3.new() })
				if not flag then
					return
				end
			end)
		end

		fn40 = function(arg, arg2)
			local option = lib.Options[arg]
			if option == nil or option.Value == nil then
				return arg2
			end
			return option.Value
		end

		local function fn45()
			local character = localPlayer.Character
			if not character then
				return (0)
			end
			local child2 = character:FindFirstChild(("BlockBar"))
			if not child2 then
				return 0
			end
			local fill = child2:FindFirstChild("Fill", true)
			if not fill then
				return 0
			end

			if not fill:IsA("GuiObject") then
				return 0
			end
			return math.clamp(fill.Size.X.Scale, (0), 1) * 100
		end

		fn41 = function()
			if not fn40(("M1TGuardBreak"), true) then
				return true
			end
			return fn45() < fn40("M1TGuardMax", (70))
		end

		local function fn46()
			local character = localPlayer.Character
			if not character then
				return false
			end
			local M1TCooldown = fn40("M1TCooldown", 0.6)
			if os.clock() - now2 < M1TCooldown then
				return false
			end

			if fn40(("M1TNoTradeBlocking"), true) then
				local blocking = character:FindFirstChild("Blocking")
				if blocking and blocking.Value == (true) then
					return false
				end
			end

			if fn40(("M1TNoTradeAttacking"), (true)) then
				local child2 = character:FindFirstChild(("Combo"))

				if child2 and child2.Value > 0 then
					do
						return (false)
					end

					while true do
					end
				end
			end

			return (true)
		end

		fn42 = function()
			if not fn46() then
				return
			end
			now2 = os.clock()
			fn43(true)
			local delay = fn40(("M1THoldBlock"), 120) / 1000
			local M1TResponse = fn40("M1TResponse", "Block + M1")

			task.delay(delay, function()
				fn43(false)
				if M1TResponse == "Block Only" then
					return
				end
				task.delay(0.02, fn44)
			end)
		end
	end

	local fn43, getMagnitude, fn44

	do
		local function fn45()
			local ok, result = pcall(function()
				return game:GetService(("Stats")).Network.ServerStatsItem["Data Ping"]:GetValue() / (1000)
			end)

			return (ok and result or (0.050000000000000003)) * (fn40("M1TPingComp", 100) / 100)
		end

		local function fn46(model)
			if not model then
				return false
			end
			local playerFromCharacter = Players:GetPlayerFromCharacter(model)
			if not playerFromCharacter then
				return false
			end

			if playerFromCharacter == localPlayer then
				return true
			end

			if playerFromCharacter.Team and localPlayer.Team and playerFromCharacter.Team == localPlayer.Team then
				return (true)
			end
			return false
		end

		fn43 = function(arg)
			if not fn40("M1TFaceCheck", true) then
				return true
			end
			local character = localPlayer.Character
			if not character then
				return true
			end
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart or not arg then
				return true
			end
			local vector = (humanoidRootPart.Position - arg.Position) * Vector3.new(1, 0, (1))
			if vector.Magnitude < 0.1 then
				return (true)
			end
			local vector2 = arg.CFrame.LookVector * Vector3.new(1, 0, (1))
			if vector2.Magnitude < 0.1 then
				return (true)
			end
			local v32 = fn40(("M1TFaceCone"), (90))
			return vector2.Unit:Dot(vector.Unit) >= math.cos(math.rad(v32 / 2))
		end

		getMagnitude = function(arg)
			local character = localPlayer.Character
			if not character then
				return nil
			end
			local child = character:FindFirstChild(("HumanoidRootPart"))
			if not child or not arg then
				return nil
			end
			return (child.Position - arg.Position).Magnitude
		end

		fn44 = function(instance)
			if instances[instance] then
				return
			end
			instances[instance] = true
			local model = instance:FindFirstAncestorWhichIsA("Model")

			local connection3 = instance.AnimationPlayed:Connect(function(track)
				if not enableAutoM1Trade2 then
					return
				end

				if model and model == (localPlayer and localPlayer.Character) then
					return
				end

				if fn46(model) then
					return
				end

				if track.Length and track.Length > 0 and track.Length < 0.15 then
					return
				end
				local str2 = tostring(track.Animation and track.Animation.AnimationId or "")
				local match = str2:match("%?id=(%d+)") or str2:match("rbxassetid://(%d+)") or str2:match("^(%d+)$")

				if match then
					str2 = "rbxassetid://" .. match
				end

				if str2 == "" then
					return
				end
				local v32 = tbl8[str2]
				if not v32 then
					return
				end
				local humanoidRootPart = model and model:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart then
					return
				end
				local magnitude = getMagnitude(humanoidRootPart)
				if not magnitude or magnitude > fn40("M1TRange", 20) then
					return
				end

				if not fn43(humanoidRootPart) then
					return
				end
				local n13 = math.max(v32.delay - fn45(), 0)

				if #tbl9 < 100 then
					table.insert(tbl9, { track = track, triggerTime = n13, root = humanoidRootPart, created = os.clock(), name = v32.name })
				end
			end)

			table.insert(connections, connection3)

			table.insert(connections, instance.Destroying:Connect(function()
				instances[instance] = nil
			end))
		end
	end

	local function fn45()
		for _, instance in next, workspace:GetDescendants() do
			if instance:IsA("Animator") then
				fn44(instance)
			elseif instance:IsA("AnimationController") then
				local child = instance:FindFirstChildOfClass(("Animator"))

				if child then
					fn44(child)
				end
			end
		end
	end

	local connection3 = nil

	local function fn46()
		connection3 = workspace.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("Animator") then
				fn44(descendant)
			elseif descendant:IsA("AnimationController") then
				local child = descendant:FindFirstChildOfClass(("Animator"))

				if child then
					fn44(child)
				end
			end
		end)

		table.insert(connections, connection3)

		connection2 = service.Heartbeat:Connect(function()
			if enableAutoM1Trade2 then
				for i = #tbl9, 1, -1 do
					local v32 = tbl9[i]
					local flag13 = (false)

					if os.clock() - v32.created > 1 then
						table.remove(tbl9, i)
					elseif not v32.root or not v32.root.Parent then
						table.remove(tbl9, i)
					elseif not v32.track.IsPlaying then
						table.remove(tbl9, i)
					elseif v32.triggerTime <= v32.track.TimePosition then
						table.remove(tbl9, i)
						flag13 = true
					end

					if not flag13 then
						continue
					end
					local magnitude = getMagnitude(v32.root)

					if magnitude and not (magnitude > fn40("M1TRange", 20)) then
						if fn43(v32.root) then
							if fn41() then
								fn42(v32.root.Parent)
							end
						end
					end
				end

				return
			end

			do
				return
			end

			while true do
			end
		end)

		fn45()
		task.delay((3), fn45)
	end

	local function fn47()
		enableAutoM1Trade2 = false

		if connection2 then
			connection2:Disconnect()
			connection2 = nil
		end

		tbl9 = {}

		for _, connection4 in ipairs(connections) do
			pcall(function()
				connection4:Disconnect()
			end)
		end

		connections = {}
		instances = {}
		connection3 = nil
	end

	v31:AddDropdown(("M1TResponse"), {
		Text = ("Response Mode"),
		Description = "What it does after the block lands",
		Values = { "Block + M1", "Block Only" },
		Default = "Block + M1",
		Multi = false,
		Callback = function()
		end,
	})

	v31:AddSlider(("M1TRange"), {
		Text = "Trade Range",
		Description = "How close they have to be to trigger a trade",
		Default = 20,
		Min = 5,
		Max = 60,
		Decimals = 0,
		Callback = function()
		end,
	})

	v31:AddToggle("M1TGuardBreak", {
		Text = "Guard Break Guard",
		Description = "Skips the trade when your guard is nearly broken",
		Default = true,
		Callback = function()
		end,
	})

	v31:AddSlider("M1TGuardMax", {
		Text = "Skip Above Guard %",
		Default = 70,
		Min = 10,
		Max = 100,
		Decimals = 0,
		Callback = function()
		end,
	})

	v31:AddToggle("M1TNoTradeBlocking", {
		Text = "Skip While Blocking",
		Description = "Won't trade if you're already holding block",
		Default = (true),
		Callback = function()
		end,
	})

	v31:AddToggle("M1TNoTradeAttacking", {
		Text = "Skip While Attacking",
		Description = "Won't trade if you're mid combo",
		Default = (true),
		Callback = function()
		end,
	})

	v31:AddSlider("M1TCooldown", {
		Text = "Trade Cooldown (s)",
		Description = "Minimum gap between trades so it doesn't spam",
		Default = 0.6,
		Min = 0.1,
		Max = (2),
		Decimals = (1),
		Callback = function()
		end,
	})

	v31:AddToggle("M1TFaceCheck", {
		Text = ("Face Check"),
		Description = "Only trades if they're actually swinging at you",
		Default = true,
		Callback = function()
		end,
	})

	v31:AddSlider("M1TFaceCone", {
		Text = "Face Check Angle",
		Description = "How wide the cone in front of them counts",
		Default = 90,
		Min = 20,
		Max = (180),
		Decimals = 0,
		Callback = function()
		end,
	})

	v31:AddSlider("M1THoldBlock", {
		Text = "Hold Block (ms)",
		Description = "How long block is held before the counter M1",
		Default = 120,
		Min = 20,
		Max = 400,
		Decimals = (0),
		Callback = function()
		end,
	})

	v31:AddSlider("M1TPingComp", {
		Text = ("Ping Compensation"),
		Description = "How much of your ping is subtracted from the timing",
		Default = 100,
		Min = 0,
		Max = 150,
		Decimals = 0,
		Callback = function()
		end,
	})

	v31:AddToggle("M1TradeEnabled", {
		Text = "Enable Auto M1 Trade",
		Description = ("Automatically blocks then counters with an M1 when an enemy throws a melee attack within range"),
		Default = false,
		Callback = function(enableAutoM1Trade)
			enableAutoM1Trade2 = enableAutoM1Trade

			if enableAutoM1Trade then
				fn46()
			else
				fn47()
			end
		end,
	})

	do
		local Combat = Techs:AddGroupbox("Combat")
		local thread = nil
		local part = nil

		local function getCframe()
			return CFrame.new(1, 1, 1, 1, 1, 1, 0, 0, 0, 0, (0), (0))
		end

		local function fn48(arg)
			local input = localPlayer.Backpack:FindFirstChild("Input")
			if not input then
				return
			end

			if arg then
				input:FireServer("SpaceOn")
			end

			task.wait((0.025000000000000001))
			input:FireServer(("M1"), { air = false, skeyreal = false, skeydown = true, mousehit = getCframe(), md = Vector3.zero })
			task.wait(0.025)

			if arg then
				input:FireServer(("SpaceOff"))
			end
		end

		Combat:AddToggle(("InfiniteCombo"), {
			Text = "Infinite Combo",
			Description = ("Infinitely M1 Combos"),
			Default = false,
			Callback = function(infiniteCombo)
				if not infiniteCombo then
					if thread then
						task.cancel(thread)
						thread = nil
					end

					if part then
						if not flag2 then
							return
						end
						part:Destroy()
						part = nil
					end

					return
				end

				part = Instance.new("Part", workspace)
				part.Anchored = true
				part.Size = Vector3.new(40, 1, 40)
				part.Transparency = 1

				thread = task.spawn(function()
					while part and part.Parent do
						for i = (1), (4) do
							fn48(false)
							task.wait(0.3)
						end

						fn48(true)
						task.wait(1.25)
						local character = localPlayer.Character

						if character and character:FindFirstChild("HumanoidRootPart") then
							local humanoidRootPart = character.HumanoidRootPart
							humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, (42), 0) + humanoidRootPart.CFrame.LookVector * 7
							part.CFrame = humanoidRootPart.CFrame - Vector3.new(0, (3), 0)
						end

						task.wait(0.22)
					end
				end)
			end,
		}):AddKeybind({ Mode = "Toggle" })

		local now2 = (0)

		Combat:AddToggle(("AsunaStrike"), {
			Text = "Asuna Strike Extender",
			Description = "Must hold M2 for the tech to work (Prevents knockback of Asuna Linear Strike)",
			Default = (false),
			Callback = function(asunaStrikeExtender)
				if tbl6.AsunaChildRemoved then
					tbl6.AsunaChildRemoved:Disconnect()
					tbl6.AsunaChildRemoved = nil
				end

				if tbl6.AsunaCharAdded then
					tbl6[("AsunaCharAdded")]:Disconnect()
					tbl6[("AsunaCharAdded")] = nil
				end

				if tbl6.AsunaHeartbeat then
					tbl6.AsunaHeartbeat:Disconnect()
					tbl6.AsunaHeartbeat = nil
				end

				if not asunaStrikeExtender then
					return
				end

				local function onCharacterAdded(character)
					if tbl6.AsunaChildRemoved then
						tbl6[("AsunaChildRemoved")]:Disconnect()
					end

					tbl6.AsunaChildRemoved = character.ChildRemoved:Connect(function(child)
						if child.Name == "BarrageOnly" and child:IsA("Folder") then
							now2 = os.clock()
						end
					end)
				end

				if localPlayer.Character then
					onCharacterAdded(localPlayer.Character)
				end

				tbl6[("AsunaCharAdded")] = localPlayer.CharacterAdded:Connect(onCharacterAdded)

				tbl6.AsunaHeartbeat = service.Heartbeat:Connect(function()
					local character = localPlayer.Character
					if not character or character:FindFirstChild("BarrageOnly") then
						return
					end

					if os.clock() - now2 <= 0.5 then
						local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
						if not humanoidRootPart then
							return
						end
						local tbl10 = {}

						for _, child in ipairs(humanoidRootPart:GetChildren()) do
							if child:IsA("BodyVelocity") then
								tbl10[#tbl10 + (1)] = child
							end
						end

						if #tbl10 == 1 then
							tbl10[1]:Destroy()
						end
					end
				end)
			end,
		})
	end

	do
		local v32 = Techs:AddGroupbox("Kiritsugu Techs")
		local flag13 = false

		local function getInput()
			return localPlayer.Backpack:FindFirstChild("Input")
		end

		local function getLookVector()
			return workspace.CurrentCamera.CFrame.LookVector
		end

		local function getPosition()
			local character = localPlayer.Character
			return character and character:FindFirstChild(("HumanoidRootPart")) and character.HumanoidRootPart.Position or Vector3.zero
		end

		local function fn48(remote, arg, arg2, arg3)
			remote:FireServer("UseMove", {
				air = false,
				neutral = arg3 or (false),
				campos = getPosition(),
				range = arg2,
				ToolName = arg,
				running = not arg3,
				camdir = getLookVector(),
				targ = nil,
				teamtarg = nil,
				mousehit = workspace.CurrentCamera.CFrame,
			})
		end

		v32:AddToggle("Kiri1Tech", {
			Text = "Rapid Fire Tech",
			Description = ("Rapid Fire into triple M1"),
			Default = false,
			Callback = function(rapidFireTech)
				if not rapidFireTech or flag13 then
					return
				end
				flag13 = true

				task.spawn(function()
					pcall(function()
						local input = getInput()
						if not input then
							flag13 = (false)
							return
						end
						input:FireServer("SpaceOn")
						task.wait(0.025)
						fn48(input, "Rapid Fire", "2", false)
						local character = localPlayer.Character

						if character and character:FindFirstChild("Slow") then
							if not flag2 then
								return
							end
							character.Slow.Destroying:Wait()
						end

						task.wait(0.2)

						for i = 1, 3 do
							input:FireServer("M1", {
								air = false,
								skeyreal = false,
								skeydown = true,
								mousehit = workspace.CurrentCamera.CFrame,
								md = Vector3.zero,
							})

							task.wait(0.025)
						end

						input:FireServer("SpaceOff")
					end)

					task.wait(0.1)
					flag13 = false

					if lib.Options.Kiri1Tech then
						lib.Options.Kiri1Tech:SetValue(false)
					end
				end)
			end,
		}):AddKeybind({ Mode = "Toggle" })

		v32:AddToggle("Kiri2Tech", {
			Text = "Accel + Knife",
			Description = "Triple Accel into Combat Knife",
			Default = false,
			Callback = function(enabled2)
				if not enabled2 or flag13 then
					return
				end
				flag13 = (true)

				task.spawn(function()
					pcall(function()
						local input = getInput()
						if not input then
							flag13 = false
							return
						end

						input:FireServer("M1", {
							air = false,
							skeyreal = false,
							skeydown = true,
							mousehit = workspace.CurrentCamera.CFrame,
							md = Vector3.zero,
						})

						task.wait((0.10000000000000001))
						fn48(input, "Triple Accel", ("4"), false)
						task.wait(0.025)
						fn48(input, "Combat Knife", "3", false)
					end)

					task.wait(0.1)
					flag13 = (false)

					if lib.Options.Kiri2Tech then
						lib.Options.Kiri2Tech:SetValue(false)
					end
				end)
			end,
		}):AddKeybind({ Mode = "Toggle" })

		v32:AddToggle("Kiri3Tech", {
			Text = "Accel + Contender",
			Description = "Triple Accel into Contender",
			Default = false,
			Callback = function(enabled2)
				if not enabled2 or flag13 then
					return
				end
				flag13 = true

				task.spawn(function()
					pcall(function()
						local input = getInput()
						if not input then
							flag13 = false
							return
						end
						fn48(input, "Triple Accel", "4", false)
						task.wait(0.025)
						fn48(input, "Contender", "1", true)
					end)

					task.wait((0.10000000000000001))
					flag13 = false

					if lib.Options.Kiri3Tech then
						lib.Options.Kiri3Tech:SetValue((false))
					end
				end)
			end,
		}):AddKeybind({ Mode = "Toggle" })

		v32:AddToggle("Kiri4Tech", {
			Text = "Accel + Rapid Fire",
			Description = "Triple Accel into Rapid Fire",
			Default = false,
			Callback = function(enabled2)
				if not enabled2 or flag13 then
					return
				end
				flag13 = true

				task.spawn(function()
					pcall(function()
						local input = getInput()
						if not input then
							flag13 = false
							return
						end
						fn48(input, "Triple Accel", "4", false)
						task.wait(0.025)
						fn48(input, ("Rapid Fire"), "2", false)
					end)

					task.wait(0.1)
					flag13 = false

					if lib.Options.Kiri4Tech then
						lib.Options.Kiri4Tech:SetValue(false)
					end
				end)
			end,
		}):AddKeybind({ Mode = ("Toggle") })
	end

	local v32 = Techs:AddGroupbox(("Aizen Techs"))

	local function fn48(tool, move, target, range)
		return function()
			pcall(function()
				local input = localPlayer.Backpack:FindFirstChild("Input")
				if not input then
					return
				end
				local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart then
					return
				end
				local currentCamera = workspace.CurrentCamera

				local tbl10 = {
					air = (false),
					neutral = (false),
					campos = humanoidRootPart.Position,
					range = range,
					ToolName = tool,
					moveChoice = move,
					running = true,
					camdir = currentCamera.CFrame.LookVector,
					mousehit = currentCamera.CFrame,
				}

				if target then
					local magnitude2 = 100
					local child2 = nil

					for _, child in ipairs(workspace.Live:GetChildren()) do
						if child ~= localPlayer.Character and child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 then
							local magnitude = (child.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude

							if magnitude < magnitude2 then
								magnitude2 = magnitude
								child2 = child
							end
						end
					end

					if child2 then
						tbl10.targ = child2
						tbl10.teamtarg = child2
					end
				end

				input:FireServer(("UseMove"), tbl10)
			end)
		end
	end

	for _, v33 in ipairs({
		{
			name = "Complete Swap",
			tool = "Kyoka Suigetsu",
			move = "Complete Swap",
			target = (true),
			range = ("2"),
		},
		{
			name = "True Power",
			tool = "Kyoka Suigetsu",
			move = "True Power",
			target = true,
			range = "2",
		},
		{
			name = "Replace Self",
			tool = "Kyoka Suigetsu",
			move = ("Replace Self"),
			target = false,
			range = "2",
		},
		{
			name = "Kurohitsugi",
			tool = ("Kido"),
			move = "Kurohitsugi",
			target = true,
			range = "3",
		},
		{ name = ("Danku"), tool = "Kido", move = "Danku", target = false, range = "3" },
		{
			name = "Raikoho",
			tool = "Kido",
			move = "Raikoho",
			target = false,
			range = ("3"),
		},
	}) do
		local v34 = fn48(v33.tool, v33.move, v33.target, v33.range)

		local tbl10 = {
			Text = v33.name,
			Description = "Auto uses Aizen's " .. v33.name,
			Default = (false),
			Callback = function(arg)
				if not arg then
					return
				end

				task.spawn(function()
					v34()
					task.wait(0.2)

					if lib.Options["Aizen_" .. v33.name:gsub(" ", "")] then
						lib.Options["Aizen_" .. v33.name:gsub(" ", "")]:SetValue(false)
					end
				end)
			end,
		}

		v32:AddToggle("Aizen_" .. v33.name:gsub(" ", ""), tbl10):AddKeybind({ Mode = "Toggle" })
	end

	local v33 = Macro:AddGroupbox(("Jujutsu Kaisen"))

	v33:AddToggle(("Gojo120"), {
		Text = "Gojo",
		Description = "Automatically does Gojo 120 - 0 Combo",
		Default = false,
		Callback = function(gojo)
			if gojo then
				fn20("[\"=0.7004\",\"Three+\",\"=0.0939\",\"Three-\",\"=0.3594\",\"m1+\",\"=0.9743\",\"Space+\",\"=0.3655\",\"Space-\",\"=0.0316\",\"m1-\",\"=0.4244\",\"Space+\",\"=0.0344\",\"Three+\",\"=0.0071\",\"m1+\",\"=0.0674\",\"Space-\",\"=0.0169\",\"Three-\",\"=0.0385\",\"m1-\",\"=0.0214\",\"Three+\",\"=0.0731\",\"Three-\",\"=0.1003\",\"W+\",\"=0.2621\",\"m1+\",\"=0.0680\",\"Space+\",\"=0.0532\",\"Three+\",\"=0.0150\",\"m1-\",\"=0.0886\",\"Three-\",\"=0.0829\",\"W-\",\"=0.1264\",\"m1+\",\"=1.7600\",\"Three+\",\"=0.1134\",\"Three-\",\"=0.0504\",\"m1-\",\"=0.1046\",\"Space-\",\"=0.0006\",\"W+\",\"=0.4559\",\"m1+\",\"=0.1022\",\"Space+\",\"=0.0111\",\"m1-\",\"=0.2681\",\"W-\",\"=0.0208\",\"m1+\",\"=0.2045\",\"W+\",\"=0.3344\",\"W-\",\"=0.2084\",\"W+\",\"=0.1453\",\"W-\",\"=0.5589\",\"Space-\",\"=0.3765\",\"m1-\",\"=0.4139\",\"Two+\",\"=0.0811\",\"Two-\",\"=0.0943\",\"W+\",\"=0.6342\",\"W-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F1, Mode = "Toggle" })

	v33:AddToggle("GetoCombo", {
		Text = "Geto",
		Description = "Automatically does Geto 120 - 0 Combo",
		Default = false,
		Callback = function(geto)
			if geto then
				fn20("[\"=2.9378\",\"Three+\",\"=0.0955\",\"Three-\",\"=0.5162\",\"m1+\",\"=0.1880\",\"W+\",\"=0.1710\",\"W-\",\"=0.7784\",\"Two+\",\"=0.1010\",\"m1-\",\"=0.0242\",\"Two-\",\"=0.4803\",\"m1+\",\"=0.0950\",\"m1-\",\"=0.5516\",\"m1+\",\"=1.1781\",\"One+\",\"=0.0768\",\"m1-\",\"=0.0332\",\"One-\",\"=0.0854\",\"One+\",\"=0.0998\",\"One-\",\"=0.8910\",\"m1+\",\"=1.4658\",\"Space+\",\"=0.3841\",\"Space-\",\"=0.0599\",\"m1-\",\"=0.5739\",\"Three+\",\"=0.0999\",\"Three-\",\"=0.7015\",\"W+\",\"=1.0523\",\"m1+\",\"=0.0061\",\"W-\",\"=1.6610\",\"m1-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F2, Mode = "Toggle" })

	v33:AddToggle(("YujiCombo"), {
		Text = ("Yuji"),
		Description = "Automatically does Yuji 120 - 0 Combo",
		Default = false,
		Callback = function(enabled2)
			if enabled2 then
				fn20("[\"=0.4034\",\"W+\",\"=0.1207\",\"W-\",\"=0.3170\",\"m1+\",\"=0.7707\",\"Space+\",\"=0.6264\",\"Space-\",\"=0.0078\",\"m1-\",\"=0.2906\",\"m1+\",\"=0.1125\",\"m1-\",\"=0.0503\",\"m1+\",\"=0.0923\",\"m1-\",\"=0.0781\",\"Two+\",\"=0.0925\",\"Two-\",\"=0.4373\",\"m1+\",\"=0.0916\",\"m1-\",\"=0.6243\",\"W+\",\"=0.1542\",\"m1+\",\"=0.0670\",\"W-\",\"=0.9095\",\"Space+\",\"=0.3656\",\"m1-\",\"=0.0453\",\"Space-\",\"=0.5004\",\"m1+\",\"=0.1166\",\"m1-\",\"=0.0497\",\"W+\",\"=0.4787\",\"Four+\",\"=0.1127\",\"Four-\",\"=0.1579\",\"W-\",\"=0.1334\",\"W+\",\"=0.0877\",\"W-\",\"=1.1331\",\"m1+\",\"=0.0836\",\"m1-\",\"=0.5664\",\"W+\",\"=0.2620\",\"Q+\",\"=0.0918\",\"Q-\",\"=0.0004\",\"m1+\",\"=0.6869\",\"W-\",\"=0.2547\",\"Space+\",\"=0.4741\",\"Space-\",\"=0.0048\",\"m1-\",\"=0.4743\",\"m1+\",\"=0.1380\",\"m1-\",\"=0.2792\",\"W+\",\"=0.2078\",\"W-\",\"=0.0623\",\"W+\",\"=0.1295\",\"W-\",\"=0.0629\",\"W+\",\"=0.0298\",\"One+\",\"=0.0788\",\"W-\",\"=0.0079\",\"One-\",\"=0.1368\",\"W+\",\"=0.1011\",\"W-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	local Bleach = Macro:AddGroupbox("Bleach")

	Bleach:AddToggle("GinCombo", {
		Text = "Gin",
		Description = "Automatically does Gin 120 - 0 Combo",
		Default = false,
		Callback = function(gin)
			if gin then
				fn20("[\"=0.5248\",\"m1+\",\"=0.8755\",\"Space+\",\"=0.1813\",\"Four+\",\"=0.0676\",\"m1-\",\"=0.0113\",\"Four-\",\"=0.0331\",\"Space-\",\"=0.7563\",\"m1+\",\"=0.4841\",\"m1-\",\"=0.2948\",\"W+\",\"=0.1346\",\"Two+\",\"=0.1200\",\"Two-\",\"=0.0506\",\"W-\",\"=0.0905\",\"W+\",\"=0.0400\",\"W-\",\"=0.5954\",\"m1+\",\"=0.0698\",\"A+\",\"=0.0547\",\"A-\",\"=0.8010\",\"W+\",\"=0.0693\",\"Space+\",\"=0.0343\",\"W-\",\"=0.3060\",\"m1-\",\"=0.0236\",\"Space-\",\"=0.5904\",\"m1+\",\"=0.4078\",\"m1-\",\"=0.2525\",\"W+\",\"=0.3141\",\"W-\",\"=0.1447\",\"One+\",\"=0.0866\",\"One-\",\"=0.7795\",\"D+\",\"=0.0394\",\"D-\"]", false)
			else
				fn19()
			end

			if not flag then
				return
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F7, Mode = "Toggle" })

	Bleach:AddToggle("ByakuyaCombo", {
		Text = ("Byakuya"),
		Description = "Automatically does Byakuya 120 - 0 Combo",
		Default = false,
		Callback = function(enabled2)
			if enabled2 then
				fn20("[\"=0.2317\",\"m1+\",\"=0.9075\",\"Space+\",\"=0.2767\",\"m1-\",\"=0.0384\",\"Space-\",\"=0.6162\",\"m1+\",\"=0.3845\",\"m1-\",\"=0.2506\",\"Four+\",\"=0.1339\",\"Four-\",\"=0.5103\",\"W+\",\"=0.4062\",\"W-\",\"=0.0008\",\"m1+\",\"=0.6046\",\"W+\",\"=0.2455\",\"D+\",\"=0.0675\",\"W-\",\"=0.0313\",\"D-\",\"=0.2501\",\"m1-\",\"=0.0299\",\"Three+\",\"=0.1355\",\"Three-\",\"=0.2388\",\"W+\",\"=0.1948\",\"W-\",\"=0.2456\",\"Two+\",\"=0.0948\",\"Two-\",\"=0.1056\",\"Two+\",\"=0.0792\",\"Two-\",\"=0.0708\",\"Two+\",\"=0.0755\",\"Two-\",\"=0.0832\",\"Two+\",\"=0.0519\",\"Two-\",\"=0.0695\",\"Two+\",\"=0.0697\",\"Two-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F8, Mode = "Toggle" })

	Bleach:AddToggle("ShinjiCombo", {
		Text = "Shinji",
		Description = "Automatically does Shinji 120 - 0 Combo",
		Default = (false),
		Callback = function(shinji)
			if shinji then
				fn20("[\"=0.3760\",\"m1+\",\"=0.8758\",\"Space+\",\"=0.2450\",\"Four+\",\"=0.0304\",\"m1-\",\"=0.1991\",\"Four-\",\"=0.7346\",\"m1+\",\"=1.2755\",\"Space-\",\"=0.4097\",\"m1-\",\"=0.2865\",\"Three+\",\"=0.1734\",\"Three-\",\"=0.0957\",\"W+\",\"=0.4402\",\"W-\",\"=0.3551\",\"m1+\",\"=0.9340\",\"Space+\",\"=0.1951\",\"Two+\",\"=0.0361\",\"m1-\",\"=0.0936\",\"Two-\",\"=0.9622\",\"m1+\",\"=1.2844\",\"S+\",\"=0.0022\",\"m1-\",\"=0.0791\",\"Space-\",\"=0.0514\",\"Q+\",\"=0.1163\",\"Q-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	Bleach:AddToggle("RukiaCombo", {
		Text = ("Rukia"),
		Description = "Automatically does Rukia 120 - 0 Combo",
		Default = false,
		Callback = function(enabled2)
			if enabled2 then
				fn20("[\"=0.9317\",\"m1+\",\"=0.9337\",\"Space+\",\"=0.1796\",\"Four+\",\"=0.0598\",\"m1-\",\"=0.0070\",\"Space-\",\"=0.0286\",\"Four-\",\"=0.7199\",\"Space+\",\"=0.2593\",\"D+\",\"=0.0014\",\"m1+\",\"=0.2030\",\"D-\",\"=1.0144\",\"Space-\",\"=0.2366\",\"One+\",\"=0.1294\",\"m1-\",\"=0.0145\",\"One-\",\"=0.0622\",\"m1+\",\"=0.0277\",\"One+\",\"=0.0463\",\"One-\",\"=0.0094\",\"m1-\",\"=0.0619\",\"m1+\",\"=0.0991\",\"m1-\",\"=0.0905\",\"m1+\",\"=0.0743\",\"m1-\",\"=0.9750\",\"m1+\",\"=0.1150\",\"m1-\",\"=1.0886\",\"m1+\",\"=0.9425\",\"Space+\",\"=0.3377\",\"Space-\",\"=0.0267\",\"m1-\",\"=0.4842\",\"m1+\",\"=0.0609\",\"Three+\",\"=0.0541\",\"m1-\",\"=0.0193\",\"Three-\",\"=1.8816\",\"S+\",\"=0.2542\",\"Q+\",\"=0.0944\",\"Q-\",\"=0.0800\",\"Q+\",\"=0.0693\",\"Q-\",\"=0.0917\",\"Q+\",\"=0.0301\",\"Q-\",\"=0.0705\",\"m1+\",\"=0.5639\",\"S-\",\"=0.3405\",\"Space+\",\"=0.0469\",\"A+\",\"=0.2573\",\"A-\",\"=0.0534\",\"Space-\",\"=0.0011\",\"m1-\",\"=0.4955\",\"m1+\",\"=0.0057\",\"Two+\",\"=0.0647\",\"Two-\",\"=0.0211\",\"m1-\",\"=0.4939\",\"W+\",\"=0.2149\",\"W-\",\"=0.2495\",\"W+\",\"=0.1398\",\"W-\",\"=0.4309\",\"A+\",\"=0.0838\",\"A-\"]", (false))


			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = ("Toggle") })

	Bleach:AddToggle("PTSIchigoCombo", {
		Text = "PTS Ichigo",
		Description = "Automatically does PTS Ichigo 120 - 0 Combo",
		Default = false,
		Callback = function(ptsIchigo)
			if ptsIchigo then
				fn20("[\"=0.2391\",\"m1+\",\"=0.9231\",\"Space+\",\"=0.1967\",\"One+\",\"=0.0011\",\"m1-\",\"=0.1234\",\"One-\",\"=0.8656\",\"m1+\",\"=1.3663\",\"Space-\",\"=0.4454\",\"m1-\",\"=0.4634\",\"W+\",\"=0.1262\",\"Three+\",\"=0.1280\",\"Three-\",\"=0.2407\",\"W-\"]", (false))
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	local JoJo = Macro:AddGroupbox("JoJo")

	JoJo:AddToggle("JonathanCombo", {
		Text = ("Jonathan Joestar"),
		Description = "Automatically does Jonathan Joestar 120 - 0 Combo",
		Default = false,
		Callback = function(enabled2)
			if enabled2 then
				fn20("[\"=0.3996\",\"m1+\",\"=0.8811\",\"Space+\",\"=0.3503\",\"Space-\",\"=0.0434\",\"m1-\",\"=0.5168\",\"m1+\",\"=0.0481\",\"Four+\",\"=0.0566\",\"m1-\",\"=0.0292\",\"Four-\",\"=2.6855\",\"m1+\",\"=1.4150\",\"Two+\",\"=0.0698\",\"m1-\",\"=0.0146\",\"Two-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F9, Mode = ("Toggle") })

	JoJo:AddToggle("JotaroCombo", {
		Text = "Jotaro",
		Description = "Automatically does Jotaro 120 - 0 Combo",
		Default = (false),
		Callback = function(jotaro)
			if jotaro then
				fn20("[\"=1.2290\",\"m1+\",\"=0.9147\",\"Space+\",\"=0.3544\",\"m1-\",\"=0.0059\",\"Space-\",\"=0.4200\",\"Three+\",\"=0.1087\",\"Three-\",\"=0.3346\",\"Space+\",\"=0.1319\",\"m1+\",\"=1.3923\",\"Space-\",\"=0.1768\",\"m1-\",\"=0.2342\",\"Four+\",\"=0.1002\",\"Four-\",\"=1.0966\",\"m1+\",\"=0.9140\",\"Space+\",\"=0.1612\",\"W+\",\"=0.2141\",\"Space-\",\"=0.0099\",\"m1-\",\"=0.0401\",\"W-\",\"=0.3402\",\"One+\",\"=0.1256\",\"One-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F10, Mode = "Toggle" })

	Macro:AddGroupbox("Naruto"):AddToggle("RockLeeCombo", {
		Text = ("Rock Lee"),
		Description = "Automatically does Rock Lee 120 - 0 Combo",
		Default = false,
		Callback = function(enabled2)
			if enabled2 then
				fn20("[\"=0.9597\",\"m1+\",\"=1.2144\",\"Four+\",\"=0.0952\",\"m1-\",\"=0.0550\",\"Four-\",\"=0.5496\",\"Space+\",\"=0.3461\",\"m1+\",\"=0.0287\",\"W+\",\"=1.1961\",\"W-\",\"=0.2788\",\"m1-\",\"=0.1410\",\"Space-\",\"=0.2648\",\"Two+\",\"=0.1858\",\"Two-\",\"=0.2886\",\"W+\",\"=0.2509\",\"Q+\",\"=0.0578\",\"m1+\",\"=0.0054\",\"Space+\",\"=0.0705\",\"Q-\",\"=1.3855\",\"One+\",\"=0.0909\",\"One-\",\"=0.0601\",\"One+\",\"=0.0196\",\"m1-\",\"=0.0711\",\"One-\",\"=0.0007\",\"Space-\",\"=0.3481\",\"W-\",\"=3.2156\",\"RightShift+\",\"=0.0936\",\"RightShift-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F11, Mode = ("Toggle") })

	local v34 = Macro:AddGroupbox("Yu Yu Hakusho")

	v34:AddToggle(("YusukeCombo"), {
		Text = "Yusuke",
		Description = "Automatically does Yusuke 120 - 0 Combo",
		Default = false,
		Callback = function(yusuke)
			if yusuke then
				fn20("[\"=0.1483\",\"W+\",\"=0.1459\",\"m1+\",\"=0.1248\",\"W-\",\"=0.3102\",\"W+\",\"=0.1439\",\"W-\",\"=0.2804\",\"Space+\",\"=0.3559\",\"m1-\",\"=0.0050\",\"Two+\",\"=0.1297\",\"Two-\",\"=0.6204\",\"W+\",\"=0.1311\",\"m1+\",\"=0.1782\",\"W-\",\"=0.3202\",\"W+\",\"=0.1844\",\"W-\",\"=0.2409\",\"S+\",\"=0.3109\",\"Space-\",\"=0.1151\",\"S-\",\"=0.0796\",\"S+\",\"=0.3426\",\"m1-\",\"=0.2267\",\"One+\",\"=0.1102\",\"S-\",\"=0.0297\",\"One-\",\"=0.1892\",\"W+\",\"=0.2755\",\"W-\",\"=0.1449\",\"S+\",\"=0.3428\",\"m1+\",\"=0.5657\",\"S-\",\"=0.8123\",\"Four+\",\"=0.0639\",\"W+\",\"=0.0532\",\"Four-\",\"=0.0779\",\"Four+\",\"=0.0900\",\"Four-\",\"=0.0687\",\"m1-\",\"=0.0897\",\"W-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	v34:AddToggle(("HieiCombo"), {
		Text = ("Hiei"),
		Description = "Automatically does Hiei 120 - 0 Combo",
		Default = (false),
		Callback = function(enabled2)
			if enabled2 then


				fn20("[\"=0.7241\",\"m1+\",\"=0.9425\",\"Space+\",\"=0.3994\",\"m1-\",\"=0.0120\",\"Space-\",\"=0.3589\",\"m1+\",\"=0.1002\",\"m1-\",\"=0.0616\",\"m1+\",\"=0.1045\",\"m1-\",\"=0.0797\",\"W+\",\"=0.4443\",\"W-\",\"=0.2346\",\"Two+\",\"=0.0950\",\"Two-\",\"=0.2752\",\"W+\",\"=0.1128\",\"W-\",\"=0.6708\",\"W+\",\"=0.0499\",\"m1+\",\"=0.5461\",\"W-\",\"=0.3584\",\"Space+\",\"=0.5784\",\"Space-\",\"=0.0167\",\"m1-\",\"=0.1000\",\"W+\",\"=0.2471\",\"m1+\",\"=0.1203\",\"m1-\",\"=0.0496\",\"m1+\",\"=0.1118\",\"m1-\",\"=0.5915\",\"One+\",\"=0.1133\",\"One-\",\"=0.1329\",\"W-\",\"=1.3305\",\"m1+\",\"=0.7940\",\"Space+\",\"=0.6796\",\"Space-\",\"=0.0453\",\"m1-\",\"=0.2047\",\"m1+\",\"=0.1291\",\"m1-\",\"=0.0083\",\"W+\",\"=0.0380\",\"m1+\",\"=0.1245\",\"m1-\",\"=0.4116\",\"W-\",\"=0.0424\",\"W+\",\"=0.1291\",\"Four+\",\"=0.0999\",\"Four-\",\"=0.0956\",\"W-\",\"=0.6007\",\"W+\",\"=0.4284\",\"Three+\",\"=0.0955\",\"Three-\",\"=0.6926\",\"W-\"]", (false))
			else


				fn19()
			end

			if not flag then
				return
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	local v35 = Macro:AddGroupbox("Fairy Tail")

	v35:AddToggle("NatsuCombo", {
		Text = "Natsu",
		Description = "Automatically does Natsu 120 - 0 Combo",
		Default = false,
		Callback = function(natsu)
			if natsu then
				fn20("[\"=0.4407\",\"m1+\",\"=0.8592\",\"Space+\",\"=0.4272\",\"Space-\",\"=0.0436\",\"m1-\",\"=0.3785\",\"m1+\",\"=0.4001\",\"m1-\",\"=0.3698\",\"Two+\",\"=0.0954\",\"Two-\",\"=0.7017\",\"Space+\",\"=0.1137\",\"m1+\",\"=1.3897\",\"One+\",\"=0.0794\",\"One-\",\"=0.0361\",\"Space-\",\"=0.0006\",\"m1-\"]", (false))
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	v35:AddToggle("GrayCombo", {
		Text = "Gray",
		Description = "Automatically does Gray 120 - 0 Combo",
		Default = false,
		Callback = function(gray)
			if gray then
				fn20("[\"=0.1675\",\"m1+\",\"=0.8694\",\"Space+\",\"=0.3129\",\"Space-\",\"=0.0603\",\"m1-\",\"=0.4312\",\"m1+\",\"=0.0352\",\"Three+\",\"=0.0689\",\"Three-\",\"=0.0244\",\"m1-\",\"=0.6801\",\"W+\",\"=0.3080\",\"W-\",\"=0.3310\",\"m1+\",\"=1.2727\",\"Space+\",\"=0.1725\",\"Four+\",\"=0.0938\",\"Four-\",\"=0.0184\",\"Space-\",\"=0.0056\",\"m1-\",\"=0.1094\",\"m1+\",\"=0.1212\",\"m1-\",\"=0.0997\",\"m1+\",\"=0.1271\",\"m1-\",\"=0.0715\",\"m1+\",\"=0.1330\",\"m1-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	local v36 = Macro:AddGroupbox(("Misc"))

	v36:AddToggle(("AcceleratorCombo"), {
		Text = ("Accelerator"),
		Description = "Automatically does Accelerator 120 - 0 Combo",
		Default = (false),
		Callback = function(enabled2)
			if enabled2 then
				fn20("[\"=0.3696\",\"m1+\",\"=1.0547\",\"One+\",\"=0.0270\",\"m1-\",\"=0.0533\",\"One-\",\"=0.8962\",\"m1+\",\"=0.3528\",\"S+\",\"=0.0951\",\"S-\",\"=0.4850\",\"Space+\",\"=0.3259\",\"Space-\",\"=0.0098\",\"m1-\",\"=0.5108\",\"m1+\",\"=0.0803\",\"Two+\",\"=0.0491\",\"m1-\",\"=0.0459\",\"Two-\",\"=1.3154\",\"W+\",\"=0.1625\",\"W-\",\"=0.0007\",\"m1+\",\"=0.7285\",\"W+\",\"=0.0818\",\"W-\",\"=0.0550\",\"Space+\",\"=0.3297\",\"Space-\",\"=0.0406\",\"m1-\",\"=0.5547\",\"m1+\",\"=0.0802\",\"Three+\",\"=0.0361\",\"m1-\",\"=0.0597\",\"Three-\",\"=0.6041\",\"W+\",\"=0.6757\",\"W-\",\"=0.2394\",\"m1+\",\"=0.1363\",\"m1-\",\"=0.9283\",\"m1+\",\"=1.6694\",\"m1-\"]", false)
				if not flag then
					return
				end
			else
				fn19()
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F12, Mode = "Toggle" })

	v36:AddToggle("MisakaCombo", {
		Text = "Misaka",
		Description = "Automatically does Misaka 120 - 0 Combo",
		Default = false,
		Callback = function(misaka)
			if misaka then
				fn20("[\"=0.3145\",\"m1+\",\"=0.1441\",\"m1-\",\"=0.2366\",\"m1+\",\"=0.1443\",\"m1-\",\"=0.2497\",\"W+\",\"=0.0151\",\"m1+\",\"=0.1152\",\"W-\",\"=0.0252\",\"m1-\",\"=0.2196\",\"Space+\",\"=0.0361\",\"m1+\",\"=0.1846\",\"m1-\",\"=0.0620\",\"Space-\",\"=0.2281\",\"W+\",\"=0.2083\",\"m1+\",\"=0.1702\",\"m1-\",\"=0.0467\",\"W-\",\"=0.2286\",\"Three+\",\"=0.1359\",\"Three-\",\"=0.3237\",\"W+\",\"=0.1817\",\"Q+\",\"=0.1888\",\"Q-\",\"=0.2780\",\"Three+\",\"=0.0934\",\"Three-\",\"=0.7134\",\"m1+\",\"=0.2129\",\"m1-\",\"=0.0087\",\"W-\",\"=0.1876\",\"m1+\",\"=0.2020\",\"m1-\",\"=0.2144\",\"m1+\",\"=0.1545\",\"m1-\",\"=0.0411\",\"Space+\",\"=0.1299\",\"m1+\",\"=0.2361\",\"W+\",\"=0.0206\",\"m1-\",\"=0.0050\",\"Space-\",\"=0.1426\",\"Four+\",\"=0.0856\",\"Four-\",\"=0.5499\",\"Space+\",\"=0.0864\",\"m1+\",\"=0.0341\",\"W-\",\"=1.6057\",\"One+\",\"=0.1135\",\"One-\",\"=0.0606\",\"One+\",\"=0.0849\",\"m1-\",\"=0.0094\",\"One-\",\"=0.0486\",\"Space-\",\"=0.8659\",\"S+\",\"=0.3094\",\"Q+\",\"=0.1062\",\"Q-\",\"=0.1007\",\"Q+\",\"=0.0939\",\"Q-\",\"=0.3692\",\"S-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F13, Mode = ("Toggle") })

	v36:AddToggle("RikkaCombo", {
		Text = "Rikka (Combo Starter)",
		Description = "Automatically does Rikka combo starter",
		Default = (false),
		Callback = function(rikka)
			if rikka then
				fn20("[\"=0.6903\",\"m1+\",\"=1.2309\",\"Two+\",\"=0.0007\",\"m1-\",\"=0.1278\",\"Two-\",\"=1.2946\",\"m1+\",\"=0.6509\",\"W+\",\"=0.0902\",\"W-\",\"=0.9692\",\"Space+\",\"=0.1695\",\"Four+\",\"=0.0849\",\"Four-\",\"=0.0062\",\"m1-\",\"=0.0597\",\"Space-\",\"=0.9597\",\"m1+\",\"=0.1103\",\"m1-\",\"=0.3430\",\"One+\",\"=0.0916\",\"One-\",\"=0.0655\",\"One+\",\"=0.0243\",\"W+\",\"=0.0796\",\"One-\",\"=0.0452\",\"One+\",\"=0.1002\",\"One-\",\"=0.0946\",\"W-\",\"=0.1152\",\"W+\",\"=0.1146\",\"W-\"]", (false))
			else
				fn19()
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F15, Mode = "Toggle" })

	v36:AddToggle(("DenjiCombo"), {
		Text = "Denji",
		Description = "Automatically does Denji 120 - 0 Combo",
		Default = false,
		Callback = function(denji)
			if denji then
				fn20("[\"=0.3543\",\"m1+\",\"=0.8587\",\"Space+\",\"=0.3745\",\"Space-\",\"=0.0153\",\"m1-\",\"=0.5307\",\"m1+\",\"=0.3743\",\"m1-\",\"=0.2704\",\"W+\",\"=0.1211\",\"Three+\",\"=0.1433\",\"Three-\",\"=0.0714\",\"W-\",\"=1.5948\",\"m1+\",\"=0.7829\",\"m1-\",\"=0.9130\",\"m1+\",\"=0.8957\",\"Space+\",\"=0.1791\",\"One+\",\"=0.0636\",\"m1-\",\"=0.0372\",\"One-\",\"=0.9931\",\"m1+\",\"=1.2747\",\"Space-\",\"=0.4207\",\"m1-\",\"=0.1861\",\"W+\",\"=0.1134\",\"Two+\",\"=0.1099\",\"Two-\",\"=0.5419\",\"W-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	v36:AddToggle(("GutsCombo"), {
		Text = "Guts",
		Description = "Automatically does Guts 120 - 0 Combo",
		Default = false,
		Callback = function(guts)
			if guts then
				fn20("[\"=0.7241\",\"m1+\",\"=0.9425\",\"Space+\",\"=0.3994\",\"m1-\",\"=0.0120\",\"Space-\",\"=0.3589\",\"m1+\",\"=0.1002\",\"m1-\",\"=0.0616\",\"m1+\",\"=0.1045\",\"m1-\",\"=0.0797\",\"W+\",\"=0.4443\",\"W-\",\"=0.2346\",\"Two+\",\"=0.0950\",\"Two-\",\"=0.2752\",\"W+\",\"=0.1128\",\"W-\",\"=0.6708\",\"W+\",\"=0.0499\",\"m1+\",\"=0.5461\",\"W-\",\"=0.3584\",\"Space+\",\"=0.5784\",\"Space-\",\"=0.0167\",\"m1-\",\"=0.1000\",\"W+\",\"=0.2471\",\"m1+\",\"=0.1203\",\"m1-\",\"=0.0496\",\"m1+\",\"=0.1118\",\"m1-\",\"=0.5915\",\"One+\",\"=0.1133\",\"One-\",\"=0.1329\",\"W-\",\"=1.3305\",\"m1+\",\"=0.7940\",\"Space+\",\"=0.6796\",\"Space-\",\"=0.0453\",\"m1-\",\"=0.2047\",\"m1+\",\"=0.1291\",\"m1-\",\"=0.0083\",\"W+\",\"=0.0380\",\"m1+\",\"=0.1245\",\"m1-\",\"=0.4116\",\"W-\",\"=0.0424\",\"W+\",\"=0.1291\",\"Four+\",\"=0.0999\",\"Four-\",\"=0.0956\",\"W-\",\"=0.6007\",\"W+\",\"=0.4284\",\"Three+\",\"=0.0955\",\"Three-\",\"=0.6926\",\"W-\"]", false)
			else
				if not flag then
					return
				end
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	local v37 = Macro:AddGroupbox("Demon Slayer")

	v37:AddToggle("TanjiroCombo", {
		Text = "Tanjiro",
		Description = "Automatically does Tanjiro 120 - 0 Combo",
		Default = (false),
		Callback = function(tanjiro)
			if tanjiro then
				fn20("[\"=0.2674\",\"m1+\",\"=0.9405\",\"Space+\",\"=0.2906\",\"m1-\",\"=0.0205\",\"Space-\",\"=0.3595\",\"W+\",\"=0.1446\",\"m1+\",\"=0.3700\",\"m1-\",\"=0.3305\",\"One+\",\"=0.1659\",\"One-\",\"=0.0444\",\"W-\",\"=0.8105\",\"m1+\",\"=0.5739\",\"W+\",\"=0.1821\",\"W-\",\"=0.1736\",\"W+\",\"=0.1438\",\"Four+\",\"=0.1460\",\"Four-\",\"=0.0287\",\"m1-\",\"=0.2267\",\"W-\",\"=0.4380\",\"Space+\",\"=0.5548\",\"m1+\",\"=1.1225\",\"Space-\",\"=0.3684\",\"m1-\",\"=0.0746\",\"W+\",\"=0.6457\",\"W-\",\"=0.0653\",\"Two+\",\"=0.1213\",\"Two-\",\"=1.6830\",\"m1+\",\"=0.4395\",\"m1-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	v37:AddToggle(("RengokuCombo"), {
		Text = ("Rengoku"),
		Description = "Automatically does Rengoku 120 - 0 Combo",
		Default = false,
		Callback = function(enabled2)
			if enabled2 then
				fn20("[\"=0.3339\",\"m1+\",\"=0.1388\",\"m1-\",\"=0.1952\",\"m1+\",\"=0.1705\",\"m1-\",\"=0.2105\",\"m1+\",\"=0.1333\",\"m1-\",\"=0.0610\",\"Space+\",\"=0.1458\",\"m1+\",\"=0.1497\",\"m1-\",\"=0.1389\",\"Three+\",\"=0.1347\",\"Three-\",\"=0.7005\",\"m1+\",\"=0.2363\",\"m1-\",\"=0.2241\",\"m1+\",\"=0.1789\",\"m1-\",\"=0.2554\",\"m1+\",\"=0.1593\",\"m1-\",\"=0.2259\",\"m1+\",\"=0.1612\",\"m1-\",\"=0.0532\",\"Space-\",\"=0.2103\",\"m1+\",\"=0.1449\",\"m1-\",\"=0.4815\",\"W+\",\"=0.0386\",\"Three+\",\"=0.0805\",\"W-\",\"=0.0197\",\"Three-\",\"=0.3451\",\"W+\",\"=0.1251\",\"W-\",\"=0.3085\",\"m1+\",\"=0.1963\",\"W+\",\"=0.1241\",\"W-\",\"=0.4420\",\"W+\",\"=0.0793\",\"Space+\",\"=0.2961\",\"W-\",\"=0.0789\",\"m1-\",\"=0.0954\",\"Space-\",\"=0.4511\",\"m1+\",\"=0.3311\",\"m1-\",\"=0.0576\",\"W+\",\"=0.0403\",\"One+\",\"=0.1785\",\"One-\",\"=0.0417\",\"W-\",\"=0.2934\",\"W+\",\"=0.3258\",\"W-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	v37:AddToggle("TengenCombo", {
		Text = ("Tengen"),
		Description = "Automatically does Tengen 120 - 0 Combo",
		Default = (false),
		Callback = function(enabled2)
			if enabled2 then
				fn20("[\"=0.1695\",\"m1+\",\"=0.1648\",\"m1-\",\"=0.2239\",\"m1+\",\"=0.2073\",\"m1-\",\"=0.2688\",\"m1+\",\"=0.1849\",\"m1-\",\"=0.1145\",\"Space+\",\"=0.1114\",\"m1+\",\"=0.1789\",\"m1-\",\"=0.2310\",\"Four+\",\"=0.1782\",\"Four-\",\"=0.7014\",\"m1+\",\"=0.2383\",\"m1-\",\"=0.2523\",\"m1+\",\"=0.1901\",\"m1-\",\"=0.2450\",\"m1+\",\"=0.1972\",\"m1-\",\"=0.2883\",\"m1+\",\"=0.1642\",\"m1-\",\"=0.0839\",\"Space-\",\"=0.1814\",\"m1+\",\"=0.0698\",\"Three+\",\"=0.0761\",\"m1-\",\"=0.0055\",\"Three-\",\"=0.0864\",\"Three+\",\"=0.0832\",\"Three-\",\"=0.0695\",\"Three+\",\"=0.0934\",\"Three-\",\"=0.7215\",\"m1+\",\"=0.2929\",\"m1-\",\"=0.1857\",\"m1+\",\"=0.2401\",\"m1-\",\"=0.2499\",\"m1+\",\"=0.1256\",\"Space+\",\"=0.0812\",\"m1-\",\"=0.2031\",\"m1+\",\"=0.1904\",\"m1-\",\"=0.0841\",\"Two+\",\"=0.0910\",\"Two-\",\"=0.0651\",\"Two+\",\"=0.0843\",\"Two-\",\"=0.0661\",\"Two+\",\"=0.0691\",\"Two-\",\"=0.1797\",\"Two+\",\"=0.0495\",\"Two-\",\"=0.2066\",\"m1+\",\"=1.2946\",\"Space-\",\"=0.0436\",\"m1-\",\"=0.2063\",\"m1+\",\"=0.2756\",\"m1-\",\"=0.2486\",\"W+\",\"=0.2053\",\"W-\",\"=0.1253\",\"One+\",\"=0.0895\",\"One-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	v37:AddToggle("KokushiboCombo", {
		Text = "Kokushibo",
		Description = "Automatically does Kokushibo 120 - 0 Combo",
		Default = false,
		Callback = function(kokushibo)
			if kokushibo then
				fn20("[\"=0.1207\",\"m1+\",\"=0.9929\",\"One+\",\"=0.1315\",\"One-\",\"=0.0826\",\"m1-\",\"=0.9533\",\"m1+\",\"=0.4540\",\"m1-\",\"=0.9147\",\"m1+\",\"=0.8656\",\"Space+\",\"=0.3459\",\"Space-\",\"=0.0899\",\"m1-\",\"=0.4098\",\"m1+\",\"=0.0586\",\"Four+\",\"=0.0853\",\"Four-\",\"=0.0115\",\"m1-\",\"=1.2249\",\"W+\",\"=0.1197\",\"m1+\",\"=0.0505\",\"W-\",\"=0.0869\",\"W+\",\"=0.1181\",\"W-\",\"=0.4139\",\"W+\",\"=0.1954\",\"Space+\",\"=0.2705\",\"W-\",\"=0.0874\",\"Two+\",\"=0.0560\",\"m1-\",\"=0.0341\",\"Two-\",\"=0.0766\",\"Two+\",\"=0.0845\",\"Two-\",\"=0.0910\",\"Two+\",\"=0.0751\",\"Two-\",\"=1.5458\",\"Space-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = ("Toggle") })

	v37:AddToggle("AkazaCombo", {
		Text = "Akaza",
		Description = "Automatically does Akaza 120 - 0 Combo",
		Default = (false),
		Callback = function(akaza)
			if akaza then
				do
					fn20("[\"=0.1690\",\"m1+\",\"=1.1203\",\"Four+\",\"=0.0795\",\"m1-\",\"=0.0259\",\"Four-\",\"=1.0701\",\"m1+\",\"=0.3516\",\"m1-\",\"=0.5316\",\"W+\",\"=0.1115\",\"m1+\",\"=0.2256\",\"W-\",\"=0.5189\",\"Two+\",\"=0.0943\",\"m1-\",\"=0.0155\",\"Two-\",\"=0.1046\",\"Two+\",\"=0.0510\",\"Two-\",\"=0.9323\",\"Space+\",\"=0.3423\",\"m1+\",\"=1.3695\",\"One+\",\"=0.0894\",\"One-\",\"=0.0754\",\"m1-\",\"=0.0067\",\"One+\",\"=0.0485\",\"Space-\",\"=0.0199\",\"One-\"]", false)
				end
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = "Toggle" })

	Macro:AddGroupbox(("Sword Art Online")):AddToggle("KiritoCombo", {
		Text = "Kirito",
		Description = "Automatically does Kirito 120 - 0 Combo",
		Default = false,
		Callback = function(kirito)
			if kirito then
				fn20("[\"=0.2202\",\"m1+\",\"=0.9411\",\"Space+\",\"=0.3798\",\"m1-\",\"=0.2847\",\"Three+\",\"=0.0941\",\"Three-\",\"=0.4817\",\"m1+\",\"=1.4041\",\"Two+\",\"=0.0909\",\"Two-\",\"=0.0099\",\"m1-\",\"=0.0835\",\"Space-\"]", false)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Mode = ("Toggle") })

	local v38 = v28:AddGroupbox("Macro Builder")

	v38:AddInput("MacroData", {
		Text = "Macro Data",
		Placeholder = ("paste macro data here..."),
		Default = "[]",
		Callback = function(macroData)
			local ok, actions = pcall(function()
				return HttpService:JSONDecode(macroData)
			end)

			if ok and actions then
				tbl7.Actions = actions
			end
		end,
	})

	v38:AddInput("MacroName", {
		Text = ("File Name"),
		Placeholder = "Macro_1",
		Default = "Macro_1",
		Callback = function(text)
			tbl7.File = text
		end,
	})

	v38:AddDivider()

	v38:AddToggle(("MacroRecord"), {
		Text = "Record Macro",
		Description = "Records your combo inputs",
		Default = false,
		Callback = function(recordMacro)
			recordMacro2 = recordMacro

			if recordMacro then
				local text = getText()

				if text then
					local n13 = 1

					while isfile("ZeroHub/Macros/" .. text .. ("Combo") .. n13 .. (".txt")) do
						n13 += (1)
					end

					tbl7.File = text .. ("Combo") .. n13

					if lib.Options.MacroName then
						lib.Options.MacroName:SetValue(tbl7.File)
					end
				end

				fn21()
			else
				fn22()
				fn18()

				if lib.Options.MacroFiles then
					lib.Options.MacroFiles:SetValues(getMatches())
				end

				if not flag2 then
					return
				end
			end

			do
				return
			end

			while true do
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F4, Mode = "Toggle" })

	v38:AddButton({
		Text = "Save Macro",
		Func = function()
			fn18()
			lib:Notify({ Title = "Macro", Description = "Saved: " .. tbl7.File, Type = "Success", Duration = 3 })

			if lib.Options.MacroFiles then
				lib.Options.MacroFiles:SetValues(getMatches())
			end
		end,
	})

	v38:AddButton({
		Text = ("Import Macro"),
		Func = function()
			local imported = lib.Options.MacroFiles and lib.Options.MacroFiles.Value
			if not imported or imported == "" then
				return
			end
			local path = "ZeroHub/Macros/" .. imported .. (".txt")
			if not isfile(path) then
				return
			end
			local content = readfile(path)

			local ok, actions = pcall(function()
				return HttpService:JSONDecode(content)
			end)

			if not ok then
				local match = content:match("^[^\n]*\n(.*)$") or content

				ok, actions = pcall(function()
					return HttpService:JSONDecode(match)
				end)
			end

			if ok and actions then
				tbl7.File = imported
				tbl7.Actions = actions
				lib:Notify({ Title = "Macro", Description = "Imported: " .. imported, Type = "Success", Duration = (3) })
			end
		end,
	})

	v38:AddButton({
		Text = "Export Macro",
		Func = function()
			local ok, result = pcall(function()
				return HttpService:JSONEncode(tbl7.Actions)
			end)

			if ok and result then
				pcall(function()
					setclipboard(result)
				end)

				lib:Notify({ Title = "Macro", Description = "Copied to clipboard", Type = "Success", Duration = 3 })
			end
		end,
	})

	v38:AddDropdown("MacroFiles", {
		Text = "Select File",
		Values = getMatches(),
		Default = nil,
		Multi = false,
		Callback = function()
		end,
	})

	v38:AddButton({
		Text = "Delete File",
		Func = function()
			local deleted = lib.Options.MacroFiles and lib.Options.MacroFiles.Value
			if not deleted or deleted == "" then
				return
			end
			local path = "ZeroHub/Macros/" .. deleted .. ".txt"

			pcall(function()
				if isfile(path) then
					delfile(path)
				end
			end)

			if lib.Options.MacroFiles then
				lib.Options.MacroFiles:SetValues(getMatches())
			end

			lib:Notify({ Title = "Macro", Description = "Deleted: " .. deleted, Type = "Warning", Duration = 3 })
		end,
	})

	local v39 = v28:AddGroupbox("Macro Player")

	v39:AddToggle("MacroPlay", {
		Text = "Play Macro",
		Description = "Replays your recorded combo",
		Default = false,
		Callback = function(playMacro)
			if playMacro then
				local json

				if #tbl7.Actions > 0 then
					json = HttpService:JSONEncode(tbl7.Actions)
				else
					json = lib.Options.MacroData and lib.Options.MacroData.Value or "[]"
				end

				fn20(json, loopMacro2)
			else
				fn19()
			end
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F5, Mode = ("Toggle") })

	v39:AddToggle("MacroLoop", {
		Text = "Loop Macro",
		Description = "Repeats until stopped",
		Default = (false),
		Callback = function(loopMacro)
			loopMacro2 = loopMacro
		end,
	}):AddKeybind({ Default = Enum.KeyCode.F6, Mode = ("Toggle") })

	local v40 = v28:AddGroupbox("Lock On")

	v40:AddToggle("LockOn", {
		Text = "Lock On",
		Description = "Locks your camera to the nearest enemy",
		Default = false,
		Callback = function(lockOn)
			if connection then
				connection:Disconnect()
				connection = nil
			end

			if not lockOn then
				if clone then
					clone:Destroy()
					clone = nil
				end

				child4 = nil
				return
			end

			local n13 = 15

			connection = service.RenderStepped:Connect(function()
				if not localPlayer.Character then
					return
				end

				if not child4 then
					local position = localPlayer.Character:GetPivot().Position
					local magnitude2 = 150
					local child2 = nil

					for _, child in ipairs(workspace.Live:GetChildren()) do
						if child == localPlayer.Character then
							continue
						end

						if not (child:FindFirstChild("Humanoid") and not (child.Humanoid.Health <= (0))) then
							continue
						end

						if not child:FindFirstChild("HumanoidRootPart") then
							continue
						end
						local playerFromCharacter = Players:GetPlayerFromCharacter(child)

						if not (teamCheck2 and playerFromCharacter and localPlayer.Team and playerFromCharacter.Team == localPlayer.Team) then
							local magnitude = (child:GetPivot().Position - position).Magnitude

							if magnitude < magnitude2 then
								magnitude2 = magnitude
								child2 = child
							end
						end
					end

					child4 = child2
					n13 = 15
				end

				if not clone then
					clone = game.StarterGui:FindFirstChild("SelectionBox", (true)):Clone()
				end

				if child4 then
					if child4:FindFirstChild("Humanoid") and child4.Humanoid.Health <= 0 then
						clone:Destroy()
						clone = nil
						child4 = nil
						return
					end

					clone.Parent = child4
					clone.Enabled = (true)
					local currentCamera = workspace.CurrentCamera

					if n13 > 0 then
						n13 = math.clamp(n13 - (1), 0, 15)
						currentCamera.CFrame = currentCamera.CFrame:Lerp(CFrame.new(currentCamera.CFrame.Position, child4:GetPivot().Position), 0.5)
					else
						currentCamera.CFrame = CFrame.new(currentCamera.CFrame.Position, child4:GetPivot().Position)
					end
				end
			end)
		end,
	}):AddKeybind({ Mode = "Toggle" })

	v40:AddToggle("LockTeamCheck", {
		Text = "Team Check",
		Description = "Skips teammates when locking on",
		Default = (false),
		Callback = function(teamCheck)
			teamCheck2 = teamCheck
		end,
	})

	local Passives = Special:AddGroupbox("Passives")

	for _, v41 in ipairs({
		{ text = "Wuxian Dodges", folder = "WuxianDodge", desc = "Gives Wuxian dodges" },
		{ text = "Mob Dodge", folder = "MobSoru", desc = "Gives Mob dodges" },
		{ text = "Geppo", folder = "ROKUSHIKI", desc = "Gives Geppo dodges" },
		{ text = "Flashstep Dodge", folder = "Soru", desc = "Gives Flashstep dodges" },
		{ text = "MUI Dodge", folder = "UIDodge", desc = "Gives MUI dodges" },
		{
			text = "Vigilante Float",
			folder = "FLOATPASSIVE",
			desc = "Gives Vigilante float",
		},
		{ text = "Raiden Dodge", folder = "FaceDodge", desc = "Gives Raiden dodges" },
	}) do
		local folder = nil

		Passives:AddToggle(v41.folder, {
			Text = v41.text,
			Description = v41.desc,
			Default = false,
			Callback = function(enabled2)
				if tbl6[v41.folder] then
					tbl6[v41.folder]:Disconnect()
					tbl6[v41.folder] = nil
				end

				if folder then
					folder:Destroy()
					folder = nil
				end

				if not enabled2 then
					return
				end

				tbl6[v41.folder] = service.RenderStepped:Connect(function()
					local character = localPlayer.Character
					if not character then
						return
					end

					if character:FindFirstChild(v41.folder) then
						return
					end

					if not folder or not folder.Parent then
						folder = Instance.new("Folder")
						folder.Name = v41.folder
					end

					folder.Parent = character
				end)
			end,
		})
	end

	Passives:AddToggle("KiritsuguDodge", {
		Text = "Kiritsugu Dodge",
		Description = "Gives Kiritsugu dodges",
		Default = false,
		Callback = function(kiritsuguDodge)
			do
				if tbl6.KiritsuguDodge then
					tbl6.KiritsuguDodge:Disconnect()
					tbl6.KiritsuguDodge = nil
				end

				if not kiritsuguDodge then
					local character = localPlayer.Character

					if character and character:FindFirstChild("ACCEL") then
						character.ACCEL:Destroy()
					end

					return
				end

				tbl6.KiritsuguDodge = service.RenderStepped:Connect(function()
					local character = localPlayer.Character
					if not character then
						return
					end

					if not character:FindFirstChild("ACCEL") then
						local accel = Instance.new("BoolValue")
						accel.Name = "ACCEL"
						accel.Parent = character
					end
				end)

				return
			end

			while true do
			end
		end,
	})

	local Dashes = Special:AddGroupbox("Dashes")

	Dashes:AddToggle("BakugoDash", {
		Text = "Bakugo Dash Spam",
		Description = "Spams Bakugo explosion dodge",
		Default = false,
		Callback = function(bakugoDashSpam)
			if tbl6.BakugoDash then
				tbl6.BakugoDash:Disconnect()
				tbl6.BakugoDash = nil
			end

			if bakugoDashSpam then
				tbl6.BakugoDash = service.RenderStepped:Connect(function()
					local character = localPlayer.Character
					if not character or not character:FindFirstChild("ExplodDodge") then
						return
					end
					local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
					if not humanoidRootPart then
						return
					end
					fn23({ TagName = "ExplodDodge", explod = Enum.KeyCode.W, ServerSwoosh = false, pos = humanoidRootPart.CFrame })
				end)

				return
			end

			do
				return
			end

			while true do
			end
		end,
	})

	Dashes:AddToggle("NatsuDash", {
		Text = "Natsu Dash Spam",
		Description = "Spams Natsu teleport dodge",
		Default = false,
		Callback = function(natsuDashSpam)
			if tbl6.NatsuDash then
				tbl6.NatsuDash:Disconnect()
				tbl6.NatsuDash = nil
			end

			if not natsuDashSpam then
				return
			end

			tbl6.NatsuDash = service.RenderStepped:Connect(function()
				local character = localPlayer.Character
				if not character or not character:FindFirstChild("NatsuTP") then
					return
				end
				local child = character:FindFirstChild(("HumanoidRootPart"))
				if not child then
					return
				end
				fn23({ TagName = "NatsuTP", explod = Enum.KeyCode.W, ServerSwoosh = false, pos = child.CFrame })
				task.wait(0.2)
			end)
		end,
	})

	local Rockets = Special:AddGroupbox("Rockets")
	local rocketSpeed2 = 100
	local child5 = nil

	Rockets:AddToggle("RocketController", {
		Text = "Rocket Controller",
		Description = "Control your rockets with WASD",
		Default = (false),
		Callback = function(rocketController)
			if tbl6.RocketControl then
				tbl6.RocketControl:Disconnect()
				tbl6.RocketControl = nil
			end

			if tbl6.RocketAdded then
				tbl6.RocketAdded:Disconnect()
				tbl6.RocketAdded = nil
			end

			child5 = nil
			if not rocketController then
				return
			end

			tbl6.RocketAdded = workspace.Thrown.ChildAdded:Connect(function(child)
				if child:IsA("BasePart") and child.Name == "Missile" and isnetworkowner(child) then
					child5 = child
				end
			end)

			tbl6.RocketControl = service.RenderStepped:Connect(function()
				if not child5 or not child5.Parent then
					return
				end
				local bodyVelocity = child5:FindFirstChildOfClass("BodyVelocity")
				if not bodyVelocity then
					return
				end
				local currentCamera = workspace.CurrentCamera
				local vector = Vector3.zero
				local lookVector = currentCamera.CFrame.LookVector
				local rightVector = currentCamera.CFrame.RightVector

				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					vector += lookVector
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					vector -= lookVector
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					vector -= rightVector
				end

				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					vector += rightVector
				end

				if vector.Magnitude > 0 then
					bodyVelocity.Velocity = vector.Unit * rocketSpeed2
				end
			end)
		end,
	})

	Rockets:AddSlider("RocketSpeed", {
		Text = "Rocket Speed",
		Min = 10,
		Max = 500,
		Default = 100,
		Callback = function(rocketSpeed)
			rocketSpeed2 = rocketSpeed
		end,
	})

	local v41 = Hitbox:AddGroupbox("Projectile Hitbox")
	local sizeMultiplier2 = (50)

	v41:AddToggle("HitboxExpander", {
		Text = "Hitbox Expander",
		Description = "Expands the hitbox of everything that has TouchInterest (All of Akainus moves, scattershots, Gray pools & more)",
		Default = false,
		Callback = function(hitboxExpander)
			if tbl6.HitboxExpander then
				tbl6.HitboxExpander:Disconnect()
				tbl6.HitboxExpander = nil
			end

			if not hitboxExpander then
				return
			end

			tbl6.HitboxExpander = service.Heartbeat:Connect(function()
				local thrown = workspace:FindFirstChild("Thrown")
				if not thrown then
					return
				end

				for _, child in ipairs(thrown:GetChildren()) do
					if child:IsA("BasePart") and child:FindFirstChild("TouchInterest") then
						child.CanCollide = false
						child.Size = child.Size:Lerp(Vector3.one * sizeMultiplier2, (0.5))
					end
				end
			end)
		end,
	})

	v41:AddSlider("HitboxSize", {
		Text = "Size Multiplier",
		Min = 1,
		Max = 75,
		Default = 50,
		Suffix = "x",
		Callback = function(sizeMultiplier)
			sizeMultiplier2 = sizeMultiplier
		end,
	})

	local v42 = Hitbox:AddGroupbox("Character Hitbox")

	v42:AddToggle("RasenganSize", {
		Text = "Expand Rasengan Size",
		Description = "Expands the hitbox of Rasengan to your choosing",
		Default = false,
		Callback = function(expandRasenganSize)
			if tbl6.RasenganSize then
				tbl6.RasenganSize:Disconnect()
				tbl6.RasenganSize = nil
			end

			if expandRasenganSize then
				tbl6.RasenganSize = service.RenderStepped:Connect(function()
					local character = localPlayer.Character
					if not character then
						return
					end
					local x = lib.Options.RasenganX and lib.Options.RasenganX.Value or 1
					local value = lib.Options.RasenganY and lib.Options.RasenganY.Value or (1)
					local z = lib.Options.RasenganZ and lib.Options.RasenganZ.Value or 1

					do
						local findFirstChild = character.FindFirstChild

						for _, instance in ipairs({ character:FindFirstChild("Right Arm"), findFirstChild(character, "Left Arm") }) do
							if not instance then
								continue
							end
							local handle = instance:FindFirstChild("Handle") or instance:FindFirstChild("RasenganPart")

							if handle then
								for _, child in ipairs(instance:GetChildren()) do
									if child:IsA("Weld") and (child.Part1 == handle or child.Part0 == handle) then
										child.C0 = CFrame.new(Vector3.new(x, 1.5 + value, z))
									end
								end
							end
						end

						return
					end

					while true do
					end
				end)

				return
			end

			do
				return
			end

			while true do
			end
		end,
	})

	v42:AddSlider("RasenganX", {
		Text = "Offset X",
		Min = -20,
		Max = 20,
		Default = 1,
		Callback = function()
		end,
	})

	v42:AddSlider("RasenganY", {
		Text = "Offset Y",
		Min = -20,
		Max = 20,
		Default = 1,
		Callback = function()
		end,
	})

	v42:AddSlider("RasenganZ", {
		Text = "Offset Z",
		Min = -20,
		Max = 20,
		Default = 1,
		Callback = function()
		end,
	})

	local Removals = Utility:AddGroupbox("Removals")

	Removals:AddToggle(("AntiConfusion"), {
		Text = "Anti Confusion",
		Description = "Blocks confusion from flipping your controls",
		Default = false,
		Callback = function(antiConfusion)
			fn24(antiConfusion)
		end,
	})

	Removals:AddToggle(("AntiStun"), {
		Text = "Anti Stun",
		Description = "Cancels stun when you get hit",
		Default = false,
		Callback = function(antiStun)
			fn25(antiStun)
		end,
	})

	Removals:AddToggle("AntiDeidara", {
		Text = "Anti Deidara Mines",
		Description = "Makes Deidara mines unable to hit you",
		Default = false,
		Callback = function(antiDeidaraMines)
			do
				fn26(antiDeidaraMines)
				return
			end

			while true do
			end
		end,
	})

	Removals:AddToggle("AntiTobi", {
		Text = "Anti Tobi Traps",
		Description = "Makes Tobi traps unable to hit you",
		Default = false,
		Callback = function(antiTobiTraps)
			fn27(antiTobiTraps)
		end,
	})

	Removals:AddToggle("AntiRaiden", {
		Text = "Anti Raiden Claymores",
		Description = "Makes Raiden claymores unable to hit you",
		Default = false,
		Callback = function(antiRaidenClaymores)
			fn28(antiRaidenClaymores)
		end,
	})

	Removals:AddToggle("AntiRisotto", {
		Text = "Anti Risotto Projectiles",
		Description = "Makes Risotto projectiles unable to hit you",
		Default = false,
		Callback = function(antiRisottoProjectiles)
			fn29(antiRisottoProjectiles)
		end,
	})

	Removals:AddToggle("AntiSubway", {
		Text = "Anti Subway",
		Description = "Blocks subway attacks from hitting you",
		Default = false,
		Callback = function(antiSubway)
			fn30(antiSubway)
		end,
	})

	Removals:AddToggle("AntiSnail", {
		Text = "Anti Snail",
		Description = "Blocks the snail transformation",
		Default = false,
		Callback = function(antiSnail)
			fn31(antiSnail)
		end,
	})

	Removals:AddToggle("NoAnims", {
		Text = "No Animations",
		Description = "Freezes all character animations",
		Default = false,
		Callback = function(noAnimations)
			fn32(noAnimations)
		end,
	})

	Removals:AddToggle("AntiBlind", {
		Text = "Anti Solar Flare Blind",
		Description = "Blocks blinding screen effects",
		Default = false,
		Callback = function(antiSolarFlareBlind)
			fn33(antiSolarFlareBlind)
		end,
	})

	Removals:AddToggle("AntiPools", {
		Text = "Anti Akainu & Gray Pools",
		Description = "Makes lava and gray pools unable to hit you",
		Default = (false),
		Callback = function(enabled2)
			fn34(enabled2)
		end,
	})

	Removals:AddToggle("AntiGiorno", {
		Text = "Anti Giorno Flowers",
		Description = "Makes Giorno flowers unable to stun you",
		Default = false,
		Callback = function(antiGiornoFlowers)
			fn35(antiGiornoFlowers)
		end,
	})

	Removals:AddToggle("TodorokiDefrost", {
		Text = "No Defrost",
		Description = "Removes Todoroki's freeze buildup on you",
		Default = false,
		Callback = function(noDefrost)
			if tbl6.TodorokiDefrost then
				tbl6.TodorokiDefrost:Disconnect()
				tbl6.TodorokiDefrost = nil
			end

			if not noDefrost then
				return
			end

			tbl6.TodorokiDefrost = service.RenderStepped:Connect(function()
				local character = localPlayer.Character
				if not flag2 then
					return
				end

				if character and character:FindFirstChild("TemperatureMeter") then
					character.TemperatureMeter.Value = 0
				end
			end)
		end,
	})

	local Visuals = v30:AddGroupbox("Visuals")

	Visuals:AddToggle(("ViewDeidara"), {
		Text = "View Deidara Mines",
		Description = "Makes invisible Deidara mines visible",
		Default = false,
		Callback = function(viewDeidaraMines)
			fn36(viewDeidaraMines)
		end,
	})

	Visuals:AddToggle("ViewRisotto", {
		Text = "View Risotto Projectiles",
		Description = "Makes invisible Risotto projectiles visible",
		Default = false,
		Callback = function(viewRisottoProjectiles)
			fn37(viewRisottoProjectiles)
		end,
	})

	Visuals:AddToggle("ViewTobi", {
		Text = "View Tobi Traps",
		Description = "Makes invisible Tobi traps visible",
		Default = false,
		Callback = function(viewTobiTraps)
			fn38(viewTobiTraps)
		end,
	})

	v30:AddGroupbox("Misc"):AddToggle("StreamerMode", {
		Text = "Streamer Mode",
		Description = "Hides all player names on screen",
		Default = (false),
		Callback = function(streamerMode)
			fn39(streamerMode)
		end,
	})

	local Graphics = v30:AddGroupbox("Graphics")

	Graphics:AddToggle("Fullbright", {
		Text = "Fullbright",
		Description = "Makes everything fully lit",
		Default = false,
		Callback = function(fullbright)
			if fullbright then
				Lighting.Ambient = Color3.new(1, 1, (1))
				Lighting.OutdoorAmbient = Color3.new(1, (1), 1)
				Lighting.Brightness = 2
				Lighting.GlobalShadows = false
			else
				Lighting.Ambient = Color3.fromRGB(128, 128, 128)
				Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
				Lighting.Brightness = 1
				Lighting.GlobalShadows = true
			end
		end,
	})

	Graphics:AddToggle("NoFog", {
		Text = "No Fog",
		Description = "Removes all fog",
		Default = (false),
		Callback = function(noFog)
			Lighting.FogEnd = noFog and 1e9 or 1000
		end,
	})

	Graphics:AddToggle("NoAtmosphere", {
		Text = "No Atmosphere",
		Description = "Removes atmosphere effects",
		Default = false,
		Callback = function(noAtmosphere)
			for _, child in ipairs(Lighting:GetChildren()) do
				if child:IsA("Atmosphere") then
					child.Density = noAtmosphere and 0 or 0.395
				end
			end
		end,
	})

	Graphics:AddToggle("RemoveDecals", {
		Text = "Remove Decals",
		Description = "Removes all decals and textures",
		Default = (false),
		Callback = function(removeDecals)
			if not removeDecals then
				do
					return
				end

				while (true) do
				end
			end

			for _, descendant in ipairs(workspace:GetDescendants()) do
				if descendant:IsA("Decal") or descendant:IsA("Texture") then
					descendant:Destroy()
				end
			end
		end,
	})

	Graphics:AddToggle("RemoveParticles", {
		Text = "Remove Particles",
		Description = "Disables all particle effects",
		Default = (false),
		Callback = function(removeParticles)
			if not removeParticles then
				return
			end

			for _, descendant in ipairs(workspace:GetDescendants()) do
				if descendant:IsA("ParticleEmitter") or descendant:IsA("Smoke") or descendant:IsA("Fire") or descendant:IsA("Sparkles") then
					descendant.Enabled = (false)
				end
			end
		end,
	})

	Graphics:AddButton({
		Text = "FPS Boost",
		Func = function()
			for _, descendant in ipairs(game:GetDescendants()) do
				if descendant:IsA("ParticleEmitter") or descendant:IsA("Smoke") or descendant:IsA("Fire") then
					descendant.Enabled = (false)
				end

				if descendant:IsA("BloomEffect") or descendant:IsA("BlurEffect") or descendant:IsA("SunRaysEffect") then
					descendant.Enabled = false
				end
			end

			lib:Notify({ Title = ("Client"), Description = "FPS Boost applied", Type = "Success", Duration = 3 })
		end,
	})

	v30:AddGroupbox("Platform"):AddDropdown("PlatformSpoof", {
		Text = "Platform Spoofer",
		Description = "Changes your platform for the server",
		Values = { "Keyboard", "Mobile", "Controller" },
		Default = "Keyboard",
		Multi = false,
		Callback = function(platformSpoofer)
			pcall(function()
				service2.Platform:FireServer(platformSpoofer)
			end)
		end,
	})

	local Server = v30:AddGroupbox("Server")

	Server:AddButton({
		Text = "Rejoin",
		Func = function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
		end,
	})

	Server:AddButton({
		Text = "Server Hop",
		Func = function()
			local ok, result = pcall(function()
				return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
			end)

			if ok and result then
				local v43 = ipairs
				local data = result.data or {}

				for _, v44 in v43(data) do
					if v44.id ~= game.JobId and v44.playing < v44.maxPlayers then
						game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v44.id, localPlayer)
						return
					end
				end
			end
		end,
	})

	Server:AddButton({
		Text = "Reset Character",
		Func = function()
			if localPlayer.Character then
				localPlayer.Character:BreakJoints()
			end
		end,
	})

	Server:AddDropdown("WorldTP", {
		Text = "Teleport to World",
		Values = { "Main Place", "Afk World", "Gon Exe", "Ranked" },
		Default = "Main Place",
		Multi = (false),
		Callback = function()
		end,
	})

	Server:AddButton({
		Text = "Teleport",
		Func = function()
			local v43 = ({
				["Main Place"] = 1458767429,
				["Afk World"] = 5411459567,
				["Gon Exe"] = 5240600335,
				Ranked = 2008032602,
			})[lib.Options.WorldTP and lib.Options.WorldTP.Value or "Main Place"]

			if v43 then
				game:GetService("TeleportService"):Teleport(v43, localPlayer)
			end
		end,
	})

	local data2 = {}
	local autoGoldSkinFarm2 = (false)
	local switchedTo = nil

	pcall(function()
		if isfile("ZeroHub/gold_skins_log.txt") then
			local data = HttpService:JSONDecode(readfile("ZeroHub/gold_skins_log.txt"))

			if type(data) == "table" then
				data2 = data
			end
		end
	end)

	local function fn49()
		pcall(function()
			writefile("ZeroHub/gold_skins_log.txt", HttpService:JSONEncode(data2))
		end)
	end

	local function fn50()
		local hud = localPlayer.PlayerGui:FindFirstChild("HUD")
		if not hud then
			return {}
		end
		local characterSelect = hud:FindFirstChild("CharacterSelect")
		if not characterSelect then
			return {}
		end
		local characters = characterSelect:FindFirstChild("Characters")
		if not characters then
			return {}
		end
		local names = {}

		for _, child in ipairs(characters:GetChildren()) do
			if not child:IsA("Frame") then
				continue
			end

			for _, child2 in ipairs(child:GetChildren()) do
				if not child2:IsA("Frame") then
					continue
				end
				local slots = child2:FindFirstChild("Slots")

				if slots then
					for _, child3 in ipairs(slots:GetChildren()) do
						if child3:IsA("ImageButton") and child3.ImageColor3 == Color3.new(1, 1, 1) then
							table.insert(names, child3.Name)
						end
					end
				end
			end
		end

		return names
	end

	local function fn51()
		local v43 = fn50()
		local tbl10 = {}

		if lib.Options.GoldBlacklist and type(lib.Options.GoldBlacklist.Value) == "table" then
			for k, v44 in pairs(lib.Options.GoldBlacklist.Value) do
				if v44 == true then
					tbl10[k] = true
				end
			end
		end

		local tbl11 = {}

		for _, v44 in ipairs(v43) do
			if not data2[v44] and not tbl10[v44] then
				table.insert(tbl11, v44)
			end
		end

		if #tbl11 == 0 then
			if not flag then
				return
			end
			return nil
		end

		return tbl11[math.random(1, #tbl11)]
	end

	local function fn52(switchedTo2)
		local child = localPlayer.Backpack:FindFirstChild(("Input"))
		if not child then
			return
		end
		child:FireServer("CharacterButton", switchedTo2)
		task.wait(0.5)
		child:FireServer("ClickPlay")
	end

	v29:AddGroupbox("Gold Skin Farm"):AddToggle("GoldSkinFarm", {
		Text = "Auto Gold Skin Farm",
		Description = "Cycles through your unlocked characters farming gold skins",
		Default = false,
		Callback = function(autoGoldSkinFarm)
			if tbl6.GoldSkinFarm then
				tbl6.GoldSkinFarm:Disconnect()



				tbl6.GoldSkinFarm = nil
			end

			if tbl6.GoldSkinDeath then
				tbl6.GoldSkinDeath:Disconnect()
				tbl6.GoldSkinDeath = nil
			end

			autoGoldSkinFarm2 = autoGoldSkinFarm
			switchedTo = nil
			if not autoGoldSkinFarm then
				return
			end
			local v43 = fn51()

			if not v43 then
				lib:Notify({
					Title = "Gold Skins",
					Description = "No characters left to farm",
					Type = "Warning",
					Duration = 3,
				})

				return
			end

			lib:Notify({
				Title = "Gold Skins",
				Description = "Will farm: " .. v43 .. " next respawn",
				Type = "Success",
				Duration = (3),
			})

			switchedTo = v43

			tbl6.GoldSkinFarm = localPlayer.PlayerGui.ChildAdded:Connect(function(child)
				if not autoGoldSkinFarm2 then
					return
				end

				if child.Name ~= "GoldNotification" then
					return
				end
				task.wait(0.5)
				local text = nil

				pcall(function()
					do
						local title1 = localPlayer.PlayerGui:FindFirstChild(("HUD")):FindFirstChild("CharacterSelect"):FindFirstChild("Title1", true)

						if title1 then
							text = title1.Text
						end

						return
					end

					while true do
					end
				end)

				if text and text ~= "" and text ~= "Random" then
					data2[text] = (true)
					fn49()

					lib:Notify({
						Title = "Gold Skins",
						Description = "Got gold skin for " .. text .. "!",
						Type = "Success",
						Duration = (5),
					})
				end

				local v44 = fn51()

				if v44 then
					switchedTo = v44

					lib:Notify({
						Title = "Gold Skins",
						Description = "Next character: " .. v44 .. " (on death)",
						Type = "Info",
						Duration = 3,
					})
				else
					lib:Notify({ Title = "Gold Skins", Description = "All characters farmed!", Type = "Success", Duration = 5 })
					autoGoldSkinFarm2 = (false)
					switchedTo = nil

					if lib.Options.GoldSkinFarm then
						lib.Options.GoldSkinFarm:SetValue(false)
					end
				end
			end)

			tbl6.GoldSkinDeath = localPlayer.CharacterRemoving:Connect(function()
				if not autoGoldSkinFarm2 or not switchedTo then
					return
				end
				task.wait((2))
				fn52(switchedTo)
				lib:Notify({ Title = "Gold Skins", Description = "Switched to: " .. switchedTo, Type = "Success", Duration = 3 })
			end)
		end,
	})

	v29:AddGroupbox("Blacklist"):AddDropdown("GoldBlacklist", {
		Text = "Blacklist Characters",
		Description = "These characters won't be picked when farming",
		Values = {},
		Default = nil,
		Multi = (true),
		Callback = function()
		end,
	})

	task.delay(3, function()
		local v43 = fn50()

		if lib.Options.GoldBlacklist then
			lib.Options.GoldBlacklist:SetValues(v43)
		end
	end)
end

local v28 = v27:AddGroupbox("Auto Play")
local tbl6 = { Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D }
local leftShift = Enum.KeyCode.LeftShift
local flag13 = false
local instance2 = nil
local child3 = nil
local connection = nil
local thread = nil
local thread2 = nil
local connection2 = nil
local flag14 = false
local character2 = nil
local humanoid = nil
local humanoidRootPart = nil
local child4 = nil
local now2 = (0)
local n13 = 1
local autoRotate = nil
local now3 = nil
local tbl7 = {}
local position = nil
local now6 = 0
local count2 = 0
local waypoints2 = nil
local n14 = 1
local v29 = nil

local function fn18(arg, arg2)
	local option = lib.Options[arg]
	if option == nil or option.Value == nil then
		return arg2
	end
	return option.Value
end

local function getInput()
	return localPlayer.Backpack:FindFirstChild("Input") or localPlayer.Character and localPlayer.Character:FindFirstChild(("Input"))
end

local function getChild(name)
	if name == "Moves" and child4 and child4.Parent then
		return child4
	end
	local playerGui = localPlayer:FindFirstChild("PlayerGui")
	local hud = playerGui and playerGui:FindFirstChild("HUD")
	local child = hud and hud:FindFirstChild(name)

	if name == "Moves" then
		child4 = child
	end

	return child
end

local function fn19(name)
	local Moves = getChild("Moves")
	if not Moves then
		return (false)
	end
	local child = Moves:FindFirstChild(name)
	if not child then
		return (false)
	end
	local disableCover = child:FindFirstChild("DisableCover")
	if disableCover and disableCover.Visible then
		return false
	end
	local cd = child:FindFirstChild("CD")
	if not cd then
		return (false)
	end
	return math.abs(cd.Size.Y.Scale) < 0.03
end

local function getText(name)
	local Moves = getChild("Moves")
	if not Moves then
		return nil
	end
	local child = Moves:FindFirstChild(name)
	if not child then
		return nil
	end
	local textLabel = child:FindFirstChild("TextLabel")
	local text = textLabel and textLabel.Text
	if text == nil or text == "" or text == "MOVE" then
		return nil
	end
	return text
end

local function fn20()
	local character = localPlayer.Character

	if not character then
		character2 = nil
		humanoid = nil
		humanoidRootPart = nil
		return (false)
	end

	if character ~= character2 or not (humanoid and humanoid.Parent) or not (humanoidRootPart and humanoidRootPart.Parent) then
		character2 = character
		humanoid = character:FindFirstChildOfClass("Humanoid")
		humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	end

	local humanoid2 = humanoid
	local humanoidRootPart2 = humanoidRootPart
	if not humanoid2 or not humanoidRootPart2 or humanoid2.Health <= 0 or humanoid2.PlatformStand then
		return false
	end
	local state = humanoid2:GetState()
	if state == Enum.HumanoidStateType.Dead or state == Enum.HumanoidStateType.Physics then
		return false
	end
	return (true), character, humanoid2, humanoidRootPart2
end

local function fn21()
	local playerGui = localPlayer:FindFirstChild("PlayerGui")
	if not playerGui then
		return false
	end
	local hud = playerGui:FindFirstChild("HUD")
	if not hud then
		return false
	end
	local health = hud:FindFirstChild("Health")
	if not health then
		return false
	end
	return health.Visible == true
end

local function fn22(arg)
	if arg == localPlayer.Character then
		return false
	end
	local playerFromCharacter = Players:GetPlayerFromCharacter(arg)

	if playerFromCharacter then
		if playerFromCharacter == localPlayer then
			return false
		end

		if playerFromCharacter.Team and localPlayer.Team and playerFromCharacter.Team == localPlayer.Team then
			return false
		end
	end

	return true
end

local function fn23(instance, arg)
	if not instance or not instance.Parent then
		return false
	end

	if not fn22(instance) then
		return false
	end
	local humanoid2 = instance:FindFirstChildOfClass("Humanoid")
	local humanoidRootPart2 = instance:FindFirstChild("HumanoidRootPart")
	if not humanoid2 or not humanoidRootPart2 or humanoid2.Health <= 0 then
		return (false)
	end
	return (humanoidRootPart2.Position - arg.Position).Magnitude < 400
end

local function fn24()
	local v30, v31, v32, v33 = fn20()

	if not v30 then
		child3 = nil
		if not flag then
			return
		end
		return nil, math.huge
	end

	local live = workspace:FindFirstChild("Live")
	if not live then
		return nil, math.huge
	end
	local magnitude2 = math.huge
	local child5 = nil

	for _, child in ipairs(live:GetChildren()) do
		if not fn22(child) then
			continue
		end
		local humanoid2 = child:FindFirstChildOfClass("Humanoid")
		local child2 = child:FindFirstChild(("HumanoidRootPart"))

		if humanoid2 and child2 and humanoid2.Health > 0 then
			local magnitude = (child2.Position - v33.Position).Magnitude

			if magnitude < 400 and magnitude < magnitude2 then
				magnitude2 = magnitude
				child5 = child
			end
		end
	end

	if fn18("APLockMode", "Sticky") == "Sticky" and fn23(child3, v33) then
		return child3, (child3.HumanoidRootPart.Position - v33.Position).Magnitude
	end
	child3 = child5
	return child5, magnitude2
end

local function fn25(arg)
	local input = getInput()
	if not input then
		return
	end
	local character = localPlayer.Character
	if not character then
		return
	end
	local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart2 then
		return
	end

	pcall(function()
		input:FireServer(("M1"), { air = arg, skeyreal = false, skeydown = true, mousehit = humanoidRootPart2.CFrame, md = Vector3.new() })
	end)
end

local function fn26(arg, instance)
	local input = getInput()
	if not input then
		return false
	end
	local text = getText(arg)
	if not text then
		return false
	end
	local humanoidRootPart2 = instance:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart2 then
		return (false)
	end
	local currentCamera = workspace.CurrentCamera

	return (pcall(function()
		input:FireServer(("UseMove"), {
			air = (false),
			neutral = true,
			campos = currentCamera.CFrame.Position,
			range = arg,
			ToolName = text,
			running = false,
			camdir = currentCamera.CFrame.LookVector,
			targ = instance,
			teamtarg = instance,
			mousehit = CFrame.new(humanoidRootPart2.Position),
		})
	end))
end

local function fn27()
	local input = getInput()
	if not input then
		return
	end

	pcall(function()
		input:FireServer("UseMode")
	end)
end

local function fn28(arg, arg2)
	tbl7[arg] = arg2
	if UserInputService:IsKeyDown(arg) == arg2 then
		return
	end

	pcall(function()
		VirtualInputManager:SendKeyEvent(arg2, arg, (false), game)
	end)
end

local function fn29()
	for _, v30 in ipairs(tbl6) do
		tbl7[v30] = false

		pcall(function()
			VirtualInputManager:SendKeyEvent((false), v30, false, game)
		end)
	end

	tbl7[leftShift] = false

	pcall(function()
		VirtualInputManager:SendKeyEvent(false, leftShift, (false), game)
	end)

	now3 = nil
	if not flag then
		return
	end
end

local function fn30()
	for _, v30 in ipairs(tbl6) do
		if tbl7[v30] then
			pcall(function()
				VirtualInputManager:SendKeyEvent(false, v30, false, game)
				VirtualInputManager:SendKeyEvent(true, v30, false, game)
			end)
		end
	end
end

local function getUnit(arg)


	local vector = arg * Vector3.new(1, 0, (1))
	return vector.Magnitude > 0.001 and vector.Unit or nil
end

local function fn31(position2)
	local character = localPlayer.Character
	local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart2 then
		fn29()
		return
	end
	local unit = getUnit(position2 - humanoidRootPart2.Position)
	if not unit then
		fn29()
		return
	end
	local currentCamera = workspace.CurrentCamera
	local unit2 = getUnit(currentCamera.CFrame.LookVector)
	local unit3 = getUnit(currentCamera.CFrame.RightVector)
	if not unit2 or not unit3 then
		return
	end
	local dot = unit:Dot(unit2)
	local dot2 = unit:Dot(unit3)
	fn28(Enum.KeyCode.W, dot > 0.35)
	fn28(Enum.KeyCode.S, dot < -0.35)
	fn28(Enum.KeyCode.D, dot2 > 0.35)
	fn28(Enum.KeyCode.A, dot2 < -0.35)
	local flag15 = (false)

	for _, v30 in ipairs(tbl6) do
		if tbl7[v30] then
			flag15 = true
			break
		end
	end

	if not flag15 then
		now3 = nil
		fn28(leftShift, (false))
		return
	end

	if not now3 then
		now3 = os.clock()
	end

	fn28(leftShift, os.clock() - now3 > (0.25))
end

local function fn32()
	waypoints2 = nil
	n14 = 1
	v29 = nil
end

local function fn33(arg)
	local v30, v31, v32, v33 = fn20()
	if not v30 then
		return false
	end
	local path = PathfindingService:CreatePath({ AgentRadius = 3, AgentHeight = 6, AgentCanJump = true, WaypointSpacing = 8 })

	if not pcall(function()
		path:ComputeAsync(v33.Position, arg)
	end) or path.Status ~= Enum.PathStatus.Success then
		fn32()
		return false
	end

	local waypoints = path:GetWaypoints()
	if #waypoints < 2 then
		fn32()
		return false
	end
	waypoints2 = waypoints
	n14 = 2
	v29 = arg
	return true
end

local function fn34(humanoid2, arg, position2)
	if not waypoints2 then
		return false
	end

	if v29 and (position2 - v29).Magnitude > 25 then
		fn32()
		return (false)
	end

	if n14 > #waypoints2 then
		fn32()
		return false
	end
	local waypoint = waypoints2[n14]

	if (arg.Position - waypoint.Position).Magnitude < 5 then
		n14 += 1
		if #waypoints2 < n14 then
			fn32()
			return false
		end
		waypoint = waypoints2[n14]
	end

	if waypoint.Action == Enum.PathWaypointAction.Jump and os.clock() - now2 > 0.8 then
		humanoid2.Jump = true
		now2 = os.clock()
	end

	fn31(waypoint.Position)
	return (true)
end

local function fn35()
	if not flag14 then
		return
	end
	flag14 = false

	pcall(function()
		service:UnbindFromRenderStep("ZeroHubLockOn")
	end)
end

local function fn36()
	if flag14 then
		return
	end
	flag14 = true

	pcall(function()
		service:BindToRenderStep("ZeroHubLockOn", Enum.RenderPriority.Camera.Value + 1, function()
			if not flag13 or not fn18("APLockOn", false) then
				return
			end
			local instance = instance2
			if not instance or not instance.Parent then
				return
			end
			local humanoidRootPart2 = instance:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart2 then
				return
			end
			local currentCamera = workspace.CurrentCamera
			if not ((humanoidRootPart2.Position - currentCamera.CFrame.Position).Magnitude < (0.10000000000000001)) then
				currentCamera.CFrame = CFrame.lookAt(currentCamera.CFrame.Position, humanoidRootPart2.Position)
				return
			end

			do
				return
			end

			while true do
			end
		end)
	end)
end

local function fn37()
	flag13 = false
	fn35()
	instance2 = nil
	child3 = nil
	fn32()

	if connection then
		connection:Disconnect()
		connection = nil
	end

	if connection2 then
		connection2:Disconnect()
		connection2 = nil
	end

	fn29()
	task.defer(fn29)
	local character = localPlayer.Character
	local child = character and character:FindFirstChildOfClass(("Humanoid"))

	if child and autoRotate ~= nil then
		child.AutoRotate = autoRotate
	end

	autoRotate = nil
end

local function fn38()
	do
		flag13 = (true)
		count2 = 0
		local now4 = os.clock()
		position = nil
		now6 = now4
		fn32()
		local character = localPlayer.Character
		local humanoid2 = character and character:FindFirstChildOfClass("Humanoid")
		autoRotate = humanoid2 and humanoid2.AutoRotate or true
		fn36()

		local function onCharacterAdded()
			character2 = nil
			humanoid = nil
			humanoidRootPart = nil
			child4 = nil
		end

		if localPlayer.Character then
			onCharacterAdded(localPlayer.Character)
		end

		connection2 = localPlayer.CharacterAdded:Connect(onCharacterAdded)

		connection = service.Heartbeat:Connect(function()
			if not flag13 then
				return
			end

			if not fn21() then
				fn29()
				return
			end
			local v30, v31, humanoid3, v32 = fn20()

			if humanoid3 and humanoid3.AutoRotate then
				humanoid3.AutoRotate = (false)
			end

			if not v30 then
				fn29()
				return
			end
			local instance = instance2
			if not instance or not instance.Parent then
				fn29()
				return
			end
			local humanoidRootPart2 = instance:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart2 then
				fn29()
				return
			end
			local magnitude = ((humanoidRootPart2.Position - v32.Position) * Vector3.new(1, 0, 1)).Magnitude

			if not fn34(humanoid3, v32, humanoidRootPart2.Position) then
				fn31(humanoidRootPart2.Position)

				if humanoidRootPart2.Position.Y - v32.Position.Y > (5) and humanoid3.FloorMaterial ~= Enum.Material.Air then
					if os.clock() - now2 > 0.8 then
						humanoid3.Jump = true
						now2 = os.clock()
					end
				end
			end

			if not (magnitude <= 9) then
				if not position then
					position = v32.Position
				end

				if (3) < (v32.Position - position).Magnitude then
					local position2 = v32.Position
					local now5 = os.clock()
					position = position2
					now6 = now5
					count2 = 0
				else
					if not (os.clock() - now6 > 1.2) then
						return
					end
					local position2 = v32.Position
					now6 = os.clock()
					position = position2
					count2 += 1
					humanoid3.Jump = true
					fn30()

					if count2 >= 2 and not waypoints2 then
						task.spawn(fn33, humanoidRootPart2.Position)
						count2 = (0)
					end
				end

				return
			end

			do
				local position2 = v32.Position
				local now5 = os.clock()
				local v33 = (0)
				position = position2
				now6 = now5
				count2 = v33
				return
			end

			while true do
			end
		end)

		thread = task.spawn(function()
			while flag13 do
				local v30, v31, humanoid3 = fn20()

				if not v30 or not fn21() then
					instance2 = nil
					fn29()
					task.wait(0.5)
					continue
				end

				local instance, v32 = fn24()
				instance2 = instance

				if not instance then
					task.wait(0.25)
				elseif v32 > 9 then
					task.wait((0.10000000000000001))
				elseif not instance:FindFirstChild("HumanoidRootPart") then
					task.wait(0.1)
				else
					fn25(humanoid3.FloorMaterial == Enum.Material.Air)
					task.wait(0.35)
				end
			end
		end)

		thread2 = task.spawn(function()
			while flag13 do
				if not fn21() then
					task.wait(0.5)
					continue
				end
				local v30 = fn20()
				local instance = instance2

				if v30 and instance2 and instance.Parent then
					if fn18("APAutoG", true) then
						local Ultimate = getChild("Ultimate")
						local ulti = Ultimate and Ultimate:FindFirstChild("ulti")

						if ulti and ulti.Visible then
							fn27()
						end
					end

					local v31, v32, v33, v34 = fn20()
					local humanoidRootPart2 = instance:FindFirstChild("HumanoidRootPart")

					if v34 and humanoidRootPart2 and (humanoidRootPart2.Position - v34.Position).Magnitude <= fn18("APSkillRange", 9) then
						local APSkills = fn18("APSkills", nil)

						for i = 1, 4 do
							local str2 = tostring(n13)
							n13 = n13 % 4 + 1
							local flag15 = (true)

							if type(APSkills) == "table" then
								flag15 = false

								for _, APSkill in ipairs(APSkills) do
									if APSkill == str2 then
										flag15 = (true)
										break
									end
									flag15 = false
								end
							end

							if flag15 and fn19(str2) then
								fn26(str2, instance)
								break
							end
						end
					end
				end

				task.wait((1))
			end
		end)

		return
	end

	while true do
	end
end

v28:AddToggle("AutoPlay", {
	Text = "Auto Play",
	Description = "Fights for you",
	Default = false,
	Callback = function(autoPlay)
		if autoPlay then
			fn38()
		else
			fn37()
		end
	end,
}):AddKeybind({ Mode = "Toggle" })

v28:AddToggle("APAutoG", {
	Text = "Auto G",
	Description = "Uses G when the bar is full",
	Default = true,
	Callback = function()
	end,
})

v28:AddToggle("APLockOn", {
	Text = "Lock On",
	Description = "Keeps your camera pointed at the target",
	Default = false,
	Callback = function()
	end,
})

v28:AddDropdown("APLockMode", {
	Text = "Lock Mode",
	Description = "Sticky stays on one target until they die, Nearest always swaps to the closest",
	Values = { "Sticky", "Nearest" },
	Default = "Sticky",
	Multi = false,
	Callback = function()
	end,
})

v28:AddSlider("APSkillRange", {
	Text = "Skill Range",
	Description = "How close it has to be to use skills",
	Default = 9,
	Min = 3,
	Max = 120,
	Decimals = 0,
	Callback = function()
	end,
})

v28:AddDropdown("APSkills", {
	Text = "Skills",
	Description = "Skills it can use",
	Values = { "1", ("2"), ("3"), ("4") },
	Default = { "1", "2", "3", "4" },
	Multi = true,
	Callback = function()
	end,
})

lib:Notify({ Title = "Zero Hub", Description = "ABA v0.3.0 loaded.", Type = "Success", Duration = 4 })
