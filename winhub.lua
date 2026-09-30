k -- Deobfuscated by @AngelOfTheNorth (gg skid)
local str2 = "Not specified" -- Luarmor user note (LRM_UserNote) when the loader has none
local tbl6, title, Players, RunService, Lighting, HttpService, localPlayer, myHubSession, myHubBaselines, fn15
local lib, lib2, lib3, tbl7, fn16, fn17, tbl8, fn18, myhubPinTP, myhubGuardTP
local getConnection, Utility

do
	tbl6 = {}

	local ok, result = pcall(function()
		local v24 = str2
		if type(v24) == "string" and v24 ~= "" then
			return v24
		end

		if type(getfenv) == "function" then
			for _, v25 in ipairs({ 1, 0 }) do
				local env = getfenv(v25)
				if type(env) == "table" and type(env.LRM_UserNote) == "string" and env.LRM_UserNote ~= "" then
					return env.LRM_UserNote
				end
			end
		end

		if type(getgenv) == "function" then
			local genv = getgenv()
			if type(genv) == "table" and type(genv.LRM_UserNote) == "string" and genv.LRM_UserNote ~= "" then
				return genv.LRM_UserNote
			end
		end

		if type(_G) == "table" and type(_G.LRM_UserNote) == "string" and _G.LRM_UserNote ~= "" then
			return _G.LRM_UserNote
		end
		return nil
	end)

	if not ok then
		result = nil
	end

	local str3 = type(result) == "string" and string.lower(result) or ""
	local mode2

	if string.find(str3, "premium", 1, true) then
		mode2 = "premium"
	elseif string.find(str3, "ad reward", 1, true) or string.find(str3, "boost", 1, true) then
		mode2 = "public"
	else
		mode2 = "public"
	end

	tbl6.mode = mode2
	tbl6.localTest = false
	tbl6.isDev = mode2 == "dev"
	tbl6.isPublic = mode2 == "public"
	tbl6.isPremium = mode2 == "premium"
	tbl6.title = tbl6.isDev and "WinHub - Dev" or tbl6.isPremium and "WinHub - Premium" or "WinHub - Free"

	if not tbl6.localTest then
		local genv = type(getgenv) == "function" and getgenv() or _G
		local value = rawget(genv, "__WinHubLaunch")
		genv.__WinHubLaunch = nil
		local flag10 = false

		pcall(function()
			local HttpService2 = game:GetService("HttpService")
			local result2 = nil

			if type(gethwid) == "function" then
				local ok2
				ok2, result2 = pcall(gethwid)
				ok2 = ok2 and type(result2) == "string" and #result2 > 0
				local v24 = nil

				if not ok2 then
					result2 = v24
				end
			end

			local ok2, result3 = pcall(function()
				return game:GetService("RbxAnalyticsService"):GetClientId()
			end)

			ok2 = ok2 and type(result3) == "string" and #result3 > 0
			local v24 = nil

			if not ok2 then
				result3 = v24
			end

			local v25 = (request or http_request or http and http.request)({
				Url = "https://winhubscript.com/api/hub/redeem",
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = HttpService2:JSONEncode({
					ticket = type(value) == "table" and type(value.ticket) == "string" and value.ticket or "",
					hwid = result2,
					clientId = result3,
					placeId = game.PlaceId,
				}),
			})

			flag10 = v25.StatusCode == 200 and HttpService2:JSONDecode(v25.Body).ok == true
		end)

		if not flag10 then
			return
		end
	end

	title = tbl6.title
	loadstring("    function LPH_NO_VIRTUALIZE(f) return f end;\n")()
	Players = game:GetService("Players")
	RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	Lighting = game:GetService("Lighting")
	HttpService = game:GetService("HttpService")
	local CollectionService = game:GetService("CollectionService")
	localPlayer = Players.LocalPlayer

	if not localPlayer then
		repeat
			task.wait()
		until Players.LocalPlayer

		localPlayer = Players.LocalPlayer
	end

	_G.MyHubSession = (_G.MyHubSession or 0) + 1
	myHubSession = _G.MyHubSession
	_G.__myhubEquippedSlot = nil
	_G.__myhubEquippedFingerprint = ""
	_G.__myhubLastFarmPressAt = 0

	if type(_G.MyHubBaselines) ~= "table" or _G.MyHubBaselines.ambient == nil then
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

		_G.MyHubBaselines = {
			ambient = Lighting.Ambient,
			brightness = Lighting.Brightness,
			fogEnd = Lighting.FogEnd,
			fogStart = Lighting.FogStart,
			walkSpeed = humanoid and humanoid.WalkSpeed or 16,
			jumpPower = humanoid and humanoid.JumpPower or 50,
		}
	end

	if type(_G.MyHubConns) ~= "table" then
		_G.MyHubConns = {}
	end

	myHubBaselines = _G.MyHubBaselines

	do
		local obj = setmetatable({}, { __mode = "k" })

		local function getConnection2(connection)
			if type(_G.MyHubConns) ~= "table" then
				_G.MyHubConns = {}
			end

			table.insert(_G.MyHubConns, connection)
			return connection
		end

		local function onPlayerAdded(player)
			if player.Character then
				obj[player.Character] = true
			end

			getConnection2(player.CharacterAdded:Connect(function(character)
				obj[character] = true
			end))

			getConnection2(player.CharacterRemoving:Connect(function(character)
				obj[character] = nil
			end))
		end

		for _, player in ipairs(Players:GetPlayers()) do
			onPlayerAdded(player)
		end

		getConnection2(Players.PlayerAdded:Connect(onPlayerAdded))
	end

	fn15 = function()
		pcall(function()
			if getgenv().Library and getgenv().Library.Unload and not getgenv().Library.Unloaded then
				getgenv().Library:Unload()
			end
		end)

		local tbl9 = { MyHubOverlay = true, MyHubHUD = true }
		local playerGui = localPlayer:FindFirstChild("PlayerGui")

		if playerGui then
			for _, child in ipairs(playerGui:GetChildren()) do
				if tbl9[child.Name] then
					pcall(function()
						child:Destroy()
					end)
				end
			end
		end

		Lighting.Ambient = myHubBaselines.ambient
		Lighting.Brightness = myHubBaselines.brightness
		Lighting.FogEnd = myHubBaselines.fogEnd
		Lighting.FogStart = myHubBaselines.fogStart
		local character = localPlayer.Character

		if character then
			local child = character:FindFirstChild("HumanoidRootPart")

			if child then
				for _, child2 in ipairs(child:GetChildren()) do
					if child2:IsA("BodyMover") then
						child2:Destroy()
					end
				end
			end

			for _, descendant in ipairs(character:GetDescendants()) do
				if descendant:IsA("BasePart") and descendant.Massless == true and descendant.CanCollide == true then
					descendant.CanCollide = false
				end
			end
		end

		if _G.MyHubConns then
			for _, myHubConn in ipairs(_G.MyHubConns) do
				pcall(function()
					myHubConn:Disconnect()
				end)
			end
		end

		_G.MyHubConns = {}
	end

	_G.__myhubWorldTeardown = nil
	_G.__myhubFarmTeardown = nil
	_G.__myhubKillAuraTeardown = nil
	_G.__myhubStreamerTeardown = nil
	_G.__myhubOwnershipTeardown = nil
	_G.__myhubESPTeardown = nil
	_G.__myhubFlyTeardown = nil
	_G.__myhubCombatHookTeardown = nil
	_G.__myhubAutoParryTeardown = nil

	local tbl9 = {
		MyHubESP = true,
		MyHubESPHL = true,
		MyHubOwnershipHL = true,
		MyHubOwnershipBox = true,
	}

	for _, descendant in ipairs(workspace:GetDescendants()) do
		if tbl9[descendant.Name] then
			pcall(function()
				descendant:Destroy()
			end)
		end
	end

	if type(cleardrawcache) == "function" then
		pcall(cleardrawcache)
	end

	fn15()

	if type(setfpscap) == "function" then
		pcall(setfpscap, 240)
	end

	task.spawn(function()
		while _G.MyHubSession == myHubSession do
			task.wait(60)
			if _G.MyHubSession ~= myHubSession then
				return
			end
			local U = {}

			for E, E in ipairs(_G.MyHubConns or {}) do
				local h, Q = pcall(function()
					return E.Connected
				end)

				if h and Q then
					table.insert(U, E)
				end
			end

			_G.MyHubConns = U
		end
	end)

	lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
	lib2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
	lib3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()

	task.spawn(function()
		if type(getcustomasset) ~= "function" then
			return
		end

		if type(isfile) == "function" and isfile("WinHub/GameName/logo.png") then
			return
		end

		if type(makefolder) == "function" and type(isfolder) == "function" then
			if not isfolder("WinHub") then
				pcall(makefolder, "WinHub")
			end

			if not isfolder("WinHub/GameName") then
				pcall(makefolder, "WinHub/GameName")
			end
		end

		local ok2, result2 = pcall(function()
			return game:HttpGet("https://github.com/B34n2/win95/blob/main/image.png?raw=true")
		end)

		if not ok2 or type(result2) ~= "string" or #result2 < 100 then
			return
		end

		if type(writefile) == "function" then
			pcall(writefile, "WinHub/GameName/logo.png", result2)
		end
	end)

	if lib and type(lib.Notify) == "function" then
		local notify = lib.Notify

		lib.Notify = function(arg, ...)
			local v24 = table.pack(...)

			pcall(function()
				notify(arg, table.unpack(v24, 1, v24.n))
			end)
		end
	end

	local window = lib:CreateWindow({
		Title = title,
		Footer = "discord.gg/winhub",
		NotifySide = "Right",
		ShowCustomCursor = false,
	})

	tbl7 = {
		Main = window:AddTab("Main", "swords"),
		Farm = window:AddTab("Farm", "target"),
		Quest = window:AddTab("Quest", "scroll"),
		Leveling = window:AddTab("Leveling", "chart-line"),
		Dungeon = window:AddTab("Dungeon", "castle"),
		Visuals = window:AddTab("Visuals", "eye"),
		Teleport = window:AddTab("Teleport", "map-pin"),
		Misc = window:AddTab("Misc", "info"),
		Settings = window:AddTab("UI", "settings"),
	}

	local function func()
		if lib and lib.Notify then
			lib:Notify({
				Title = "Premium Only",
				Description = "This feature requires WinHub Premium.",
				Time = 3,
			})
		end
	end

	fn16 = function(arg)
		if not arg or arg.__premiumLocked then
			return
		end
		arg.__premiumLocked = true

		pcall(function()
			local textLabel = arg.TextLabel

			if textLabel and type(textLabel.Text) == "string" and not textLabel.Text:find("⭐") then
				textLabel.Text = "⭐ " .. textLabel.Text
			end
		end)

		if type(arg.Value) == "boolean" then
		end

		local premiumLockedValue = arg.Value
		arg.__premiumLockedValue = premiumLockedValue
		local flag10 = false

		if arg.Callback ~= nil or type(arg.SetValue) == "function" then
			arg.Callback = function(arg2)
				if flag10 then
					return
				end

				if arg2 == premiumLockedValue then
					return
				end
				flag10 = true

				pcall(function()
					if type(arg.SetValue) == "function" then
						arg:SetValue(premiumLockedValue)
					end
				end)

				flag10 = false
				func()
			end
		end

		if type(arg.Func) == "function" then
			arg.Func = func
		end
	end

	fn17 = function()
		if not lib then
			return
		end

		for _, v24 in ipairs({
			lib.Toggles,
			lib.Sliders,
			lib.Dropdowns,
			lib.Buttons,
			lib.Labels,
			lib.KeyPickers,
			lib.ColorPickers,
			lib.Inputs,
		}) do
			if type(v24) ~= "table" then
				continue
			end

			for _, v25 in pairs(v24) do
				if v25 and v25.__premiumLocked and type(v25.SetValue) == "function" and v25.Value ~= v25.__premiumLockedValue then
					pcall(function()
						v25:SetValue(v25.__premiumLockedValue)
					end)
				end
			end
		end
	end

	local function fn19(arg)
		if not arg or not arg.Holder then
			return
		end

		if not lib then
			return
		end

		for _, v24 in ipairs({
			lib.Toggles,
			lib.Sliders,
			lib.Dropdowns,
			lib.Buttons,
			lib.Labels,
			lib.KeyPickers,
			lib.ColorPickers,
			lib.Inputs,
		}) do
			if type(v24) ~= "table" then
				continue
			end

			for _, v25 in pairs(v24) do
				local container = v25 and (v25.Container or v25.Holder or v25.Frame or v25.TextLabel)

				if container and container:IsDescendantOf(arg.Holder) then
					fn16(v25)
				end
			end
		end
	end

	if tbl6.isPremium then
		task.defer(function()
			local screenGui = lib and lib.ScreenGui
			if not screenGui then
				return
			end
			local n = 0

			while n < 5 do
				local child = screenGui:FindFirstChild("Main")

				if child then
					for _, descendant in ipairs(child:GetDescendants()) do
						if (descendant:IsA("TextLabel") or descendant:IsA("TextButton")) and descendant.Text == "WinHub" then
							pcall(function()
								descendant.Text = tbl6.title
							end)
						end
					end

					return
				end

				task.wait(0.15)
				n += 0.15
			end
		end)
	end

	tbl8 = {
		noclip = false,
		flyEnabled = false,
		flySpeed = 55,
		speedEnabled = false,
		walkSpeed = 50,
		autoPickup = false,
		autoPickupRange = 200,
		autoChest = false,
		autoChestRange = 200,
		autoTameHorse = false,
		skipCutscenes = false,
		notifyMuzan = false,
		autoReadyUp = false,
		autoDungeon = false,
		autoSkipWave = false,
		skipBossInsta = false,
		skipChampionInsta = false,
		autoCard = false,
		cardPriority = {},
		cardBlacklist = {},
		cardHealBelow = 50,
		autoReroll = false,
		autoRerollMin = 4,
		autoPath = false,
		pathSide = "Slayer",
		pathBreath = "None",
		pathArt = "None",
		pathHumanCap = 25,
		psOwner = "",
		psAutoJoin = false,
		autoBuyZeni = false,
		zeniBuyItems = {},
		zeniBuyAmount = 1,
		autoBuyCrystal = false,
		crystalBuyItems = {},
		crystalBuyAmount = 1,
		autoMeditate = false,
		autoPushUps = false,
		autoBoulderSplit = false,
		autoAimTraining = false,
		autoCupTraining = false,
		autoBoulderPush = false,
		autoSquat = false,
		autoFarmCache = false,
		sealedChestTiers = {},
		cachePickup = false,
		autoFarmSnowMounds = false,
		serverHopMounds = false,
		serverHopCache = false,
		farmMob = false,
		farmMobTarget = {},
		farmMobAuto = false,
		farmBoss = false,
		farmBossTarget = {},
		farmBossAuto = false,
		huntTrack = false,
		huntSide = "Auto",
		huntBossTarget = {},
		farmPlayer = false,
		farmPlayerTarget = nil,
		farmPlayerAuto = false,
		killAura = false,
		killAuraWeapon = "Auto",
		farmHotbarSlot = "Best",
		useSkill = false,
		useSkillKeys = {},
		useSkillDelay = 3,
		holdSkills = false,
		holdSkillKeys = {},
		holdSkillsDuration = 2,
		farmPosition = "Above",
		farmOffX = 0,
		farmOffY = 0,
		farmOffZ = 0,
		farmDistance = 6,
		farmInstaKill = false,
		farmInstaThresh = 99,
		farmYeti = false,
		spiderLily = false,
		autoFish = false,
		autoFishTeleport = true,
		autoBait = false,
		autoBaitAmount = 5,
		autoBaitType = "Worm",
		autoEquipBait = false,
		autoEquipBaitType = "Worm",
		noFog = false,
		noAtmosphere = false,
		fullBright = false,
		brightness = 2,
		unlockFPS = false,
		fpsCap = 240,
		perfMode = false,
		lowWater = false,
		noShadows = false,
		noPostFX = false,
		noParticles = false,
		streamerMode = false,
		staffDetect = false,
		showOwnership = false,
		win95Dark = false,
		espPlayers = false,
		espNpcs = false,
		espMobs = false,
		espItems = false,
		espQuestItems = false,
		espChests = false,
		espShowHl = true,
		espShowHp = true,
		espShowDist = true,
		espMaxDist = 500,
		espTextSize = 13,
		espPlayerColor = Color3.fromRGB(0, 200, 255),
		espNpcColor = Color3.fromRGB(255, 165, 40),
		espMobColor = Color3.fromRGB(255, 60, 60),
		espItemColor = Color3.fromRGB(255, 200, 0),
		espQuestItemColor = Color3.fromRGB(220, 120, 255),
		espChestColor = Color3.fromRGB(210, 140, 30),
		espHpColor = Color3.fromRGB(90, 220, 90),
		espDistColor = Color3.fromRGB(200, 200, 200),
		espFont = "GothamBold",
		antiAFK = true,
		autoReconnect = true,
		sunImmunity = false,
		noDrowning = false,
		noDashCd = false,
		noSlowdown = false,
	}

	do
		local character = nil
		local humanoid = nil
		local humanoidRootPart = nil

		local function fn20()
			character = localPlayer.Character
			humanoid = character and character:FindFirstChildOfClass("Humanoid") or nil
			humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart") or nil
		end

		fn20()

		table.insert(_G.MyHubConns, localPlayer.CharacterAdded:Connect(function()
			task.defer(fn20)
		end))

		fn18 = function()
			if character and character.Parent and humanoid and humanoid.Parent and humanoidRootPart and humanoidRootPart.Parent then
				return character, humanoid, humanoidRootPart
			end
			fn20()
			return character, humanoid, humanoidRootPart
		end
	end

	local now2 = 0

	do
		local v24 = 0

		myhubPinTP = function(arg, arg2)
			local cframe = typeof(arg) == "Vector3" and CFrame.new(arg) or arg
			if typeof(cframe) ~= "CFrame" then
				return false
			end
			arg2 = arg2 and arg2.cancel
			local v25, v26, instance = fn18()
			if not (instance and instance.Parent) then
				return false
			end

			local function fn20(part)
				now2 = os.clock()
				part.Anchored = false
				part.CFrame = cframe
				part.AssemblyLinearVelocity = Vector3.zero
				part.AssemblyAngularVelocity = Vector3.zero
			end

			v24 += 1
			local v27 = v24
			if (instance.Position - cframe.Position).Magnitude <= 80 then
				pcall(fn20, instance)
				return true
			end
			local position = cframe.Position
			local now3 = os.clock()
			local now4 = nil
			local count2 = 0

			local connection = RunService.Heartbeat:Connect(function()
				local v28, v29, instance2 = fn18()
				if not (instance2 and instance2.Parent) then
					return
				end

				if os.clock() - now3 > 0.05 and (instance2.Position - position).Magnitude > 30 then
					count2 += 1
					now4 = os.clock()
				end

				pcall(fn20, instance2)
			end)

			local flag10

			while true do
				task.wait()
				local now5 = os.clock()
				if v27 ~= v24 or _G.MyHubSession ~= myHubSession or arg2 and arg2() then
					flag10 = false
					break
				end
				local v28, v29, instance2 = fn18()
				if not (instance2 and instance2.Parent and v29 and v29.Health > 0) then
					flag10 = false
					break
				end

				if now4 then
					flag10 = true
					if now5 - now4 >= 1.5 then
						break
					end
				else
					flag10 = true
					if 2 <= now5 - now3 then
						break
					end
				end

				if count2 >= 6 or now5 - now3 > 8 then
					flag10 = false
					break
				end
			end

			connection:Disconnect()
			return flag10
		end

		_G.__myhubPinTP = myhubPinTP
		local n = 2.5
		local n10 = 1.5
		local n11 = 5

		myhubGuardTP = function(arg)
			local cframe = typeof(arg) == "Vector3" and CFrame.new(arg) or arg
			if typeof(cframe) ~= "CFrame" then
				return false
			end
			local v25, v26, part = fn18()
			if not (part and part.Parent) then
				return false
			end
			v24 += 1
			local v27 = v24
			local flag10 = (part.Position - cframe.Position).Magnitude > 80

			pcall(function()
				now2 = os.clock()
				part.Anchored = false
				part.CFrame = cframe
				part.AssemblyLinearVelocity = Vector3.zero
				part.AssemblyAngularVelocity = Vector3.zero
			end)

			if not flag10 then
				return true
			end
			local cframe2 = cframe
			local now3 = os.clock()
			local now5 = nil
			local connection = nil

			connection = RunService.Heartbeat:Connect(function()
				local now4 = os.clock()
				local v28, v29, part2 = fn18()
				if v27 ~= v24 or part2 ~= part or not (part2 and part2.Parent) or tbl8.flyEnabled or _G.__myhubFarmTarget ~= nil or _G.MyHubSession ~= myHubSession or now4 - now3 > n11 then
					connection:Disconnect()
					return
				end

				if 20 < (part2.Position - cframe2.Position).Magnitude then
					now5 = now4

					pcall(function()
						now2 = now4
						part2.CFrame = cframe2
						part2.AssemblyLinearVelocity = Vector3.zero
						part2.AssemblyAngularVelocity = Vector3.zero
					end)

					return
				end

				cframe2 = part2.CFrame

				if now4 - now3 >= n and (not now5 or now4 - now5 >= n10) then
					connection:Disconnect()
				end
			end)

			task.wait(0.2)
			return true
		end
	end

	_G.__myhubGuardTP = myhubGuardTP

	local function fn20(path)
		if type(makefolder) ~= "function" or type(isfolder) ~= "function" then
			return
		end

		if not isfolder(path) then
			pcall(makefolder, path)
		end
	end

	fn20("WinHub")
	fn20("WinHub/GameName")

	getConnection = function(connection)
		table.insert(_G.MyHubConns, connection)
		return connection
	end

	do
		local v24 = tbl7.Main:AddRightTabbox()
		local Movement = v24:AddTab("Movement")
		local Options = v24:AddTab("Options")

		Movement:AddToggle("Noclip", {
			Text = "Noclip",
			Default = false,
			Callback = function(enabled2)
				tbl8.noclip = enabled2
			end,
		}):AddKeyPicker("NoclipBind", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Noclip" })

		if tbl6.isDev then
			Movement:AddToggle("Fly", {
				Text = "Fly",
				Default = false,
				Callback = function(enabled2)
					tbl8.flyEnabled = enabled2
				end,
			}):AddKeyPicker("FlyBind", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Fly" })
		end

		Movement:AddToggle("Speed", {
			Text = "Speed",
			Default = false,
			Callback = function(speed)
				tbl8.speedEnabled = speed
			end,
		}):AddKeyPicker("SpeedBind", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Speed" })

		Movement:AddToggle("NoDashCd", {
			Text = "No Dash Cooldown",
			Default = false,
			Tooltip = "Dash without waiting",
			Callback = function(noDashCooldown)
				tbl8.noDashCd = noDashCooldown
			end,
		})

		Movement:AddToggle("NoSlowdown", {
			Text = "No Slowdown",
			Default = false,
			Tooltip = "Block WalkSpeed reductions (stun/attack/water)",
			Callback = function(enabled2)
				tbl8.noSlowdown = enabled2
			end,
		})

		local walkSpeed2 = 0

		getConnection(RunService.Heartbeat:Connect(function()
			if not tbl8.noSlowdown then
				local E = walkSpeed2

				if E ~= 0 then
					walkSpeed2 = 0
				end

				return
			end

			local E, E = fn18()
			if not E then
				return
			end
			local h, Q = E.WalkSpeed, walkSpeed2

			if h > Q then
				walkSpeed2 = h
			elseif (walkSpeed2 > 0) and (h < (walkSpeed2 * 0.85)) then
				pcall(function()
					E.WalkSpeed = walkSpeed2
				end)
			end
		end))

		getConnection(localPlayer.CharacterAdded:Connect(function()
			walkSpeed2 = 0
		end))

		if tbl6.isDev then
			Options:AddSlider("FlySpeed", {
				Text = "Fly Speed",
				Default = tbl8.flySpeed,
				Min = 10,
				Max = 900,
				Rounding = 0,
				Suffix = "",
				Callback = function(flySpeed)
					tbl8.flySpeed = math.min(flySpeed, 900)
				end,
			})
		end

		Options:AddSlider("WalkSpeed", {
			Text = "Walk Speed",
			Default = tbl8.walkSpeed,
			Min = 16,
			Max = 300,
			Rounding = 0,
			Suffix = "",
			Callback = function(walkSpeed)
				tbl8.walkSpeed = walkSpeed
			end,
		})
	end

	local flag10 = false

	getConnection(RunService.Heartbeat:Connect(function()
		local E, E = fn18()
		if not E then
			return
		end

		if tbl8.speedEnabled then
			flag10 = true

			if E.WalkSpeed ~= tbl8.walkSpeed then
				pcall(function()
					E.WalkSpeed = tbl8.walkSpeed
				end)
			end
		elseif flag10 then
			flag10 = false

			pcall(function()
				E.WalkSpeed = myHubBaselines.walkSpeed
			end)
		end
	end))

	Utility = tbl7.Main:AddLeftGroupbox("Utility")

	Utility:AddToggle("AutoPickup", {
		Text = "Auto Pickup",
		Default = false,
		Tooltip = "Pickup items",
		Callback = function(enabled2)


			tbl8.autoPickup = enabled2
		end,
	})

	Utility:AddToggle("AutoChest", {
		Text = "Auto Open Chests",
		Default = false,
		Tooltip = "Open nearby chests",
		Callback = function(autoOpenChests)
			tbl8.autoChest = autoOpenChests
		end,
	})

	Utility:AddToggle("AutoTameHorse", {
		Text = "Auto Tame Horse",
		Default = false,
		Tooltip = "Skip mount minigame",
		Callback = function(enabled2)
			tbl8.autoTameHorse = enabled2
			do
				return
			end
		end,
	})

	Utility:AddToggle("SkipCutscenes", {
		Text = "Skip Cutscenes",
		Default = false,
		Tooltip = "Auto-skip cutscene UI + fire skip button/keys",
		Callback = function(skipCutscenes)
			tbl8.skipCutscenes = skipCutscenes
		end,
	})

	Utility:AddToggle("SunImmunity", {
		Text = "Sun Immunity",
		Default = false,
		Tooltip = "Block sun damage",
		Callback = function(sunImmunity)
			tbl8.sunImmunity = sunImmunity
		end,
	})

	Utility:AddToggle("NoDrowning", {
		Text = "No Drowning",
		Default = false,
		Tooltip = "Block underwater damage",
		Callback = function(enabled2)
			tbl8.noDrowning = enabled2
		end,
	})

	tbl8.respawnAtDeath = false

	Utility:AddToggle("RespawnAtDeath", {
		Text = "Respawn At Death",
		Default = false,
		Tooltip = "TP back to death spot",
		Callback = function(respawnAtDeath)
			tbl8.respawnAtDeath = respawnAtDeath
		end,
	})

	do
		local cframe = nil
		local cframe2 = nil

		local function onCharacterAdded(character)
			local humanoid = character:WaitForChild("Humanoid", 5)
			local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
			if not (humanoid and humanoidRootPart) then
				return
			end

			if tbl8.respawnAtDeath and cframe2 then
				local cframe3 = cframe2
				cframe2 = nil
				task.wait(0.15)
				task.spawn(myhubGuardTP, cframe3)
			end

			task.spawn(function()
				while character.Parent and humanoid.Parent and humanoidRootPart.Parent do
					if humanoid.Health > 0 then
						cframe = humanoidRootPart.CFrame
					end

					task.wait(0.25)
				end
			end)

			humanoid.Died:Connect(function()
				if tbl8.respawnAtDeath then
					cframe2 = cframe
				end
			end)
		end

		if localPlayer.Character then
			task.spawn(onCharacterAdded, localPlayer.Character)
		end

		getConnection(localPlayer.CharacterAdded:Connect(onCharacterAdded))
	end

	do
		local RunService2 = game:GetService("RunService")
		game:GetService("Workspace")
		local tbl10 = {}

		local function fn21(arg)
			if type(arg) ~= "string" then
				return false
			end
			return arg:find("Debree", 1, true) ~= nil and arg:find("Cam", 1, true) ~= nil
		end

		local mt = getrawmetatable(game)
		setreadonly(mt, false)

		if not _G.__mhSkipCutOrigNC then
			_G.__mhSkipCutOrigNC = mt.__namecall
		end

		local mhSkipCutOrigNC = _G.__mhSkipCutOrigNC

		mt.__namecall = newcclosure(function(arg, ...)
			local v24 = table.pack(...)
			local method = getnamecallmethod()
			local v25

			if tbl8.skipCutscenes and arg == RunService2 then
				if method ~= "BindToRenderStep" then
					if method == "UnbindFromRenderStep" then
						local v26 = ...

						if fn21(v26) then
							tbl10[v26] = nil
						end

						v25 = table.pack(table.unpack(v24, 1, v24.n))
					else
						v25 = table.pack(...)
					end

					return mhSkipCutOrigNC(arg, table.unpack(v25, 1, v25.n))
				end

				local v26 = ...
				if fn21(v26) then
					return nil
				end
				v25 = table.pack(table.unpack(v24, 1, v24.n))
				return mhSkipCutOrigNC(arg, table.unpack(v25, 1, v25.n))
			elseif arg == RunService2 and method == "BindToRenderStep" then
				local v26 = ...

				if fn21(v26) then
					tbl10[v26] = true
				end

				v25 = table.pack(table.unpack(v24, 1, v24.n))
				return mhSkipCutOrigNC(arg, table.unpack(v25, 1, v25.n))
			else
				v25 = table.pack(...)
				return mhSkipCutOrigNC(arg, table.unpack(v25, 1, v25.n))
			end
		end)

		setreadonly(mt, true)

		task.spawn(function()
			local flag11 = false

			while _G.MyHubSession == myHubSession do
				local flag12 = tbl8.skipCutscenes and true or false

				if flag12 and not flag11 then
					for k in pairs(tbl10) do
						pcall(function()
							RunService2:UnbindFromRenderStep(k)
						end)

						tbl10[k] = nil
					end
				end

				task.wait(0.25)
				flag11 = flag12
			end
		end)
	end

	do
		local Server = tbl7.Main:AddRightGroupbox("Server")

		Server:AddInput("PSOwnerName", {
			Text = "Owner Name",
			Default = "",
			Placeholder = "blank = your own server",
			Callback = function(ownerName)
				tbl8.psOwner = (ownerName or ""):gsub("^%s+", ""):gsub("%s+$", "")
			end,
		})

		local function fn21(arg)
			if not (arg and getconnections) then
				return
			end

			for _, connection in ipairs(getconnections(arg)) do
				pcall(function()
					if connection.Fire then
						connection:Fire()
					elseif connection.Function then
						connection.Function()
					end
				end)
			end
		end

		local function fn22()
			local playerGui = localPlayer:FindFirstChild("PlayerGui")
			local components = playerGui and playerGui:FindFirstChild("Components")
			if not components then
				lib:Notify({ Title = "Ouwland", Description = "Need to be at main menu.", Time = 3 })
				return
			end
			local n1PlayPresenter = components:FindFirstChild("Menu") and components.Menu:FindFirstChild("OptionsHolder") and components.Menu.OptionsHolder:FindFirstChild("1-PLAY-Presenter")

			if n1PlayPresenter then
				for _, descendant in ipairs(n1PlayPresenter:GetDescendants()) do
					if descendant:IsA("TextButton") or descendant:IsA("ImageButton") then
						fn21(descendant.MouseButton1Click)
						break
					end
				end
			end

			task.wait(0.4)
			local child = components:FindFirstChild("Worlds") and components.Worlds:FindFirstChild("Holder") and components.Worlds.Holder:FindFirstChild("Ouwland")

			if child then
				fn21(child.MouseButton1Click)
			end

			task.wait(0.4)
			local child2 = components:FindFirstChild("BottomHolder") and components.BottomHolder:FindFirstChild("JoinHolder") and components.BottomHolder.JoinHolder:FindFirstChild("Actual")
			if not child2 then
				lib:Notify({ Title = "Ouwland", Description = "Join UI never appeared.", Time = 3 })
				return
			end
			local textButton = child2:FindFirstChild("TextButton")
			local textbox = child2:FindFirstChild("PrivateBox") and child2.PrivateBox:FindFirstChild("Textbox")
			if not (textButton and textbox) then
				lib:Notify({ Title = "Ouwland", Description = "Join UI not loaded.", Time = 3 })
				return
			end
			local psOwner = tbl8.psOwner or ""

			pcall(function()
				textbox.Text = psOwner ~= "" and psOwner or localPlayer.Name
			end)

			if not getconnections then
				lib:Notify({ Title = "Ouwland", Description = "Executor lacks getconnections.", Time = 3 })
				return
			end
			fn21(textButton.MouseButton1Down)
		end

		Server:AddToggle("PSAutoJoin", {
			Text = "Auto Join on Load",
			Default = false,
			Tooltip = "Join private server",
			Callback = function(autoJoinOnLoad)
				tbl8.psAutoJoin = autoJoinOnLoad

				if autoJoinOnLoad then
					fn22()
				end
			end,
		})
	end

	local Training = tbl7.Quest:AddLeftGroupbox("Training")

	Training:AddToggle("AutoMeditate", {
		Text = "Auto Meditate",
		Default = false,
		Callback = function(enabled2)
			tbl8.autoMeditate = enabled2
		end,
	})

	Training:AddToggle("AutoPushUps", {
		Text = "Auto Push Ups",
		Default = false,
		Callback = function(autoPushUps)


			tbl8.autoPushUps = autoPushUps
		end,
	})

	Training:AddToggle("AutoBoulderSplit", {
		Text = "Auto Boulder Split",
		Default = false,
		Callback = function(autoBoulderSplit)
			tbl8.autoBoulderSplit = autoBoulderSplit
		end,
	})

	Training:AddToggle("AutoAimTraining", {
		Text = "Auto Aim Training",
		Default = false,
		Callback = function(autoAimTraining)
			tbl8.autoAimTraining = autoAimTraining
		end,
	})

	Training:AddToggle("AutoCupTraining", {
		Text = "Auto Cup Training",
		Default = false,
		Callback = function(autoCupTraining)
			tbl8.autoCupTraining = autoCupTraining
		end,
	})

	Training:AddToggle("AutoBoulderPush", {
		Text = "Auto Boulder Push",
		Default = false,
		Callback = function(autoBoulderPush)
			tbl8.autoBoulderPush = autoBoulderPush
		end,
	})

	Training:AddToggle("AutoSquat", {
		Text = "Auto Squat",
		Default = false,
		Callback = function(autoSquat)
			tbl8.autoSquat = autoSquat
		end,
	})

	local service = game:GetService("ReplicatedStorage")
	local v24, fn21, getOk, getOk2, fn22, fn23

	do
		local service2 = game:GetService("Workspace")
		local vector = Vector3.new(-91.65, 1353.38, -2705.57)
		v24 = tbl7.Quest:AddRightGroupbox("Auto Quest")

		local function fn24(instance, cframe)
			if not (instance and instance.Parent) then
				return
			end
			myhubPinTP(cframe)
		end

		local v25 = nil

		fn21 = function()
			if v25 then
				return v25
			end
			local dialogue = service:FindFirstChild("CAM") and service.CAM:FindFirstChild("Client") and service.CAM.Client:FindFirstChild("Modules") and service.CAM.Client.Modules:FindFirstChild("GamePlay") and service.CAM.Client.Modules.GamePlay:FindFirstChild("Dialogue")
			if not dialogue then
				return nil
			end
			local ok2, result2 = pcall(require, dialogue)
			if ok2 and type(result2) == "table" and result2.Functions and type(result2.Functions.ProceedWithCartPurchase) == "function" then
				v25 = result2
				return result2
			end
			return nil
		end

		getOk = function(name)
			local ok2, result2 = pcall(function()
				local slot1 = service.Player_Service.Data[localPlayer.Name].slots.Slot1
				local completed = slot1:FindFirstChild("Quests") and slot1.Quests:FindFirstChild("Completed")
				if not completed then
					return false
				end
				return completed:FindFirstChild(name) ~= nil
			end)

			return ok2 and result2
		end

		getOk2 = function()
			local ok2, result2 = pcall(function()
				return service.Player_Service.Data[localPlayer.Name].slots.Slot1.Inventory.Inventory:FindFirstChild("Shovel") ~= nil
			end)

			return ok2 and result2
		end

		fn22 = function(arg, arg2, arg3)
			pcall(function()
				lib:Notify({ Title = arg, Description = arg2, Time = arg3 or 6 })
			end)
		end

		local function fn25(instance)
			for i = 1, 4 do
				if not instance then
					break
				end
				local attribute = instance:GetAttribute("DropOwnerUserId")
				if typeof(attribute) == "number" then
					return attribute == localPlayer.UserId
				end
				instance = instance.Parent
			end

			return true
		end

		local tbl10 = {
			Vector3.new(-503.728, 1383.197, -2987.042),
			Vector3.new(315.261, 1352.2791, -2685.55),
			Vector3.new(-805.652, 1329.754, -2212.8391),
			Vector3.new(-615.269, 1383.668, -2487.4839),
			Vector3.new(-61.762, 1353.264, -2227.8669),
		}

		local function getInstance(arg)
			local deadline = tick() + (arg or 10)

			while tick() < deadline do
				local v26, v27, instance = fn18()
				if instance and instance.Parent then
					return instance
				end
				task.wait(0.2)
			end

			return nil
		end

		local function fn26(position, instance)
			task.wait(1.5)
			local child = workspace:FindFirstChild("LootDrops")
			if not (child and tbl8.autoPickup) then
				return
			end

			if not (instance and instance.Parent) then
				instance = getInstance(8)
				if not instance then
					return
				end
			end

			local n = (tbl8.autoPickupRange or 200) ^ 2
			local children = {}
			local deadline = tick() + 15
			local deadline2 = tick() + 3

			while tick() < deadline and tick() < deadline2 do
				if not (instance and instance.Parent) then
					instance = getInstance(6)
					if not instance then
						break
					end
				end

				local dot2 = nil
				local child3 = nil
				local position2 = nil

				for _, child2 in ipairs(child:GetChildren()) do
					if not (child2:IsA("BasePart") and not children[child2] and child2.Parent and fn25(child2)) then
						continue
					end
					local position3 = child2.Position - position
					local dot = position3:Dot(position3)

					if dot <= n and (not dot2 or dot < dot2) then
						position2 = child2.Position
						dot2 = dot
						child3 = child2
					end
				end

				if not child3 then
					task.wait(0.3)
					continue
				end
				deadline2 = tick() + 3
				children[child3] = true
				myhubPinTP(CFrame.new(position2 + Vector3.new(0, 3, 0)))
				local proximityPrompt = child3:FindFirstChildWhichIsA("ProximityPrompt")

				if proximityPrompt then
					pcall(function()
						if fireproximityprompt then
							fireproximityprompt(proximityPrompt)
						end
					end)
				end

				local deadline3 = tick() + 1.5

				while tick() < deadline3 and child3.Parent do
					task.wait(0.1)
					local v26, v27, instance2 = fn18()

					if not (instance2 and instance2 ~= instance) then
						instance2 = instance
					end

					if not (instance2 and instance2.Parent) then
						instance = instance2
						break
					else
						instance = instance2
					end
				end
			end
		end

		local function fn27(arg)
			local instance = getInstance(10)

			if not instance then


				return false
			end

			fn24(instance, CFrame.new(arg + Vector3.new(0, 6, 0)))
			task.wait(1.2)
			local chests = service2:FindFirstChild("Chests")
			if not chests then
				return false
			end
			local dot2 = nil
			local child2 = nil
			local position3 = nil

			for _, child in ipairs(chests:GetChildren()) do
				if child.Name ~= "Snow Mound" then
					continue
				end
				local position = child:IsA("BasePart") and child.Position or child.PrimaryPart and child.PrimaryPart.Position

				if position then
					local position2 = position - arg
					local dot = position2:Dot(position2)

					if dot <= 900 and (not dot2 or dot < dot2) then
						dot2 = dot
						child2 = child
						position3 = position
					end
				end
			end

			if not child2 then
				return false
			end
			local instance2 = getInstance(8)
			if not instance2 then
				return false
			end
			fn24(instance2, CFrame.new(position3 + Vector3.new(0, 4, 0)))
			local flag11 = false

			for _, descendant in ipairs(child2:GetDescendants()) do
				if descendant:IsA("ProximityPrompt") then
					pcall(function()
						if fireproximityprompt then
							fireproximityprompt(descendant)
						end
					end)

					pcall(function()
						descendant:InputHoldBegin()
					end)

					task.delay(math.max(0.05, (descendant.HoldDuration or 0) + 0.05), function()
						pcall(function()
							descendant:InputHoldEnd()
						end)
					end)

					flag11 = true
					break
				end
			end

			if flag11 then
				fn26(position3, instance2)
			end

			return flag11
		end

		_G.__myhubFarmSnowMounds = function()
			fn22("Auto Shovel", ("Sweeping %d hardcoded mound slots..."):format(#tbl10), 4)
			local count2 = 0

			for _, v26 in ipairs(tbl10) do
				if fn27(v26) then
					count2 += 1
				end
			end

			local child = service2:FindFirstChild("Chests")
			local count3

			if child then
				for _, child2 in ipairs(child:GetChildren()) do
					if child2.Name ~= "Snow Mound" then
						continue
					end
					local position = child2:IsA("BasePart") and child2.Position or child2.PrimaryPart and child2.PrimaryPart.Position
					if not position then
						continue
					end
					local flag11 = false

					for _, v26 in ipairs(tbl10) do
						if (position - v26).Magnitude < 30 then
							flag11 = true
							break
						end
					end

					if flag11 then
						continue
					end
					local instance = getInstance(8)
					if not instance then
						continue
					end
					fn24(instance, CFrame.new(position + Vector3.new(0, 4, 0)))
					local flag12 = false

					for _, descendant in ipairs(child2:GetDescendants()) do
						if not descendant:IsA("ProximityPrompt") then
							continue
						end

						pcall(function()
							if fireproximityprompt then
								fireproximityprompt(descendant)
							end
						end)

						pcall(function()
							descendant:InputHoldBegin()
						end)

						task.delay(math.max(0.05, (descendant.HoldDuration or 0) + 0.05), function()
							pcall(function()
								descendant:InputHoldEnd()
							end)
						end)

						flag12 = true
						break
					end

					if flag12 then
						count2 += 1
						fn26(position, instance)
					end
				end

				count3 = count2
			else
				count3 = count2
			end

			fn22("Auto Shovel", ("Snow mound sweep complete — dug %d."):format(count3), 4)
		end

		fn23 = function()
			if getOk2() then
				return true
			end
			local v26 = fn21()
			if not v26 then
				fn22("Auto Shovel", "Dialogue module load failed.")
				return false
			end
			local v27, v28, v29 = fn18()
			if not v29 then
				return false
			end
			myhubGuardTP(CFrame.new(vector + Vector3.new(0, 3, 0)))

			pcall(function()
				v26.Storage.BuySelection = { Shovel = 1 }
				v26.Storage.CartShopNode = "Winter Store Rep Lynx"
				v26.Functions.ProceedWithCartPurchase("Deal", v26.Storage)
			end)

			task.wait(0.6)
			if getOk2() then
				fn22("Auto Shovel", "Shovel purchased.", 4)
				return true
			end
			fn22("Auto Shovel", "Purchase didn't register — LO may need to open Rep Lynx's shop once so we can spy the exact CartShopNode key.", 8)
			return false
		end
	end

	local fn24, fn25, fn26, getOk3

	do
		local vector = Vector3.new(-615.5, 1261, -1177.5)
		local vector2 = Vector3.new(507.2, 1121.5, -970.2)
		Vector3.new(540.5, 1121, -1023.5)

		local function fn27()
			local v25 = fn21()
			if not v25 then
				return false
			end
			local v26, v27, v28 = fn18()
			if not v28 then
				return false
			end
			myhubGuardTP(CFrame.new(vector + Vector3.new(0, 3, 0)))
			task.wait(0.4)

			local ok2 = pcall(function()
				v25.Functions.DeliverMeatToLucy("Hand over the meat", v25.Storage)
			end)

			task.wait(0.6)
			return ok2
		end

		fn24 = function(arg)
			for _, descendant in ipairs(workspace:GetDescendants()) do
				if not (descendant:IsA("Model") and descendant.Name == arg) then
					continue
				end

				for _, descendant2 in ipairs(descendant:GetDescendants()) do
					if descendant2:IsA("ProximityPrompt") and descendant2.ObjectText == arg then
						pcall(function()
							if fireproximityprompt then
								fireproximityprompt(descendant2)
							end
						end)

						return true
					end
				end
			end

			return false
		end

		fn25 = function()
			local v25 = fn21()
			if not v25 then
				return
			end
			local cancel = v25.CurrentDialogue and v25.CurrentDialogue.Cancel and v25.CurrentDialogue.Cancel[1]

			if cancel and type(cancel.func) == "function" then
				pcall(cancel.func)
			end
		end

		fn26 = function(arg, vector3, arg2)
			local v25 = fn21()
			if not v25 then
				return false
			end
			local v26, v27, v28 = fn18()
			if not v28 then
				return false
			end
			myhubGuardTP(CFrame.new(vector3 + Vector3.new(0, 3, 0)))
			task.wait(0.4)
			fn24(arg2)
			task.wait(0.5)

			pcall(function()
				v25.Functions.AddQuest(arg, v25.Storage)
			end)

			task.wait(0.4)
			fn25()
			task.wait(0.3)
			return true
		end

		local function getOk4()
			local ok2, result2 = pcall(function()
				local lastTime = service.Player_Service.Data[localPlayer.Name].slots.Slot1.Quests:FindFirstChild("LastTime")
				if not lastTime then
					return 0
				end
				local elapsed = os.time() - lastTime.Value
				if elapsed >= 30 then
					return 0
				end
				return 30 - elapsed
			end)

			return ok2 and result2 or 0
		end

		local function fn28(arg)
			local ok2 = getOk4()
			if ok2 <= 0 then
				return
			end
			local ok3 = ok2 + 1
			fn22(arg or "Cooked Bear Meat", ("AddQuest cooldown — waiting %.1fs."):format(ok3), math.min(6, ok3))
			task.wait(ok3)
		end

		local function getOk5(name)
			local ok2, result2 = pcall(function()
				return service.Player_Service.Data[localPlayer.Name].slots.Slot1.Quests.Holder:FindFirstChild(name) ~= nil
			end)

			return ok2 and result2
		end

		getOk3 = function(arg)
			return getOk(arg)
		end

		local function getOk6(name, arg)
			local n = arg or 1

			local ok2, result2 = pcall(function()
				local child = service.Player_Service.Data[localPlayer.Name].slots.Slot1.Inventory.Inventory:FindFirstChild(name)
				if not child then
					return false
				end
				local amount = child:FindFirstChild("Amount")
				if amount then
					return amount.Value >= n
				end
				return n == 1
			end)

			return ok2 and result2
		end

		local function fn29(arg)
			if not arg and getOk6("Cooked Bear Meat", 1) then
				fn22("Cooked Bear Meat", "Already have Cooked Bear Meat.", 4)
				return true
			end

			if not getOk5("Acquire Bear Meat") and not getOk3("Ill restock the pantry(Lv 10)") then
				local count2 = 0

				while not getOk5("Acquire Bear Meat") and count2 < 20 do
					count2 += 1
					fn28()
					fn22("Cooked Bear Meat", ("Step 1 (try %d): accepting Lucy's quest..."):format(count2), 4)
					fn26("Ill restock the pantry(Lv 10)", vector, "Lucy")
					if getOk5("Acquire Bear Meat") then
						break
					end
				end

				if not getOk5("Acquire Bear Meat") then
					fn22("Cooked Bear Meat", "Lucy quest still not accepted after 20 tries — aborting.", 10)
					return false
				end
				local v25, v26, v27 = fn18()

				if v27 then
					myhubGuardTP(CFrame.new(vector2 + Vector3.new(0, 3, 0)))
				end
			end

			local tbl10 = { key = "Ill drive the bears back(Lv 10)", instance = "Hunt the Bears" }
			local farmMob = tbl8.farmMob
			local farmMobTarget = tbl8.farmMobTarget
			local killAura = tbl8.killAura
			local myhubKillAura = _G.__myhubKillAura
			local flag11 = false

			local function fn30()
				if flag11 then
					return
				end
				flag11 = true
				tbl8.farmMobTarget = { ["Bear Cub"] = true, ["Mother Bear"] = true }
				tbl8.farmMob = true
				tbl8.killAura = true
				_G.__myhubKillAura = true
			end

			local function fn31()
				if not flag11 then
					return
				end
				flag11 = false
				tbl8.farmMob = farmMob
				tbl8.farmMobTarget = farmMobTarget
				tbl8.killAura = killAura
				_G.__myhubKillAura = myhubKillAura
			end

			local n = 0

			while not getOk6("Bear Meat", 1) and n < 8 do
				n += 1

				if not getOk5(tbl10.instance) then
					fn31()
					local v25 = 0

					while not getOk5(tbl10.instance) and not getOk6("Bear Meat", 1) and v25 < 20 do
						v25 += 1
						fn28()
						fn22("Cooked Bear Meat", ("Cycle %d try %d: taking '%s'"):format(n, v25, tbl10.key), 4)
						fn26(tbl10.key, vector2, "Tom")

						if not getOk5(tbl10.instance) then
							if not getOk6("Bear Meat", 1) then
								continue
							end
						end

						break
					end

					if not getOk5(tbl10.instance) and not getOk6("Bear Meat", 1) then
						fn22("Cooked Bear Meat", ("Tom still refused after %d tries — moving to next cycle."):format(v25), 6)
					end
				end

				fn22("Cooked Bear Meat", ("Cycle %d: farming bears..."):format(n), 4)
				fn30()
				local deadline = tick() + 180

				while tick() < deadline do
					if not getOk6("Bear Meat", 1) then
						if getOk5(tbl10.instance) then
							task.wait(1)
							continue
						end
					end

					break
				end
			end

			fn31()
			task.wait(0.4)
			if not getOk6("Bear Meat", 1) then
				fn22("Cooked Bear Meat", ("No Bear Meat after %d Tom-quest cycles."):format(n), 8)
				return false
			end
			fn22("Cooked Bear Meat", "Delivering Bear Meat to Lucy...", 4)
			fn27()
			task.wait(1)
			if getOk6("Cooked Bear Meat", 1) then
				fn22("Cooked Bear Meat", "Done — got Cooked Bear Meat.", 6)
				return true
			end
			fn22("Cooked Bear Meat", "Delivery didn't register.", 8)
			return false
		end

		local vector3 = Vector3.new(-138.148, 801.157, 518.745)
		local vector4 = Vector3.new(-106.78, 1351.5, -2498.56)
		local vector5 = Vector3.new(-114.398, 1354.044, -2520.924)
		local tbl10 = { key = "Ill help you survive the winter(Lv 100)", instance = "Supply the Settlement" }

		local function getOk7()
			local ok2, result2 = pcall(function()
				local demonHorns = service.Player_Service.Data[localPlayer.Name].slots.Slot1.Inventory.Inventory:FindFirstChild("Demon Horns")
				if not demonHorns then
					return 0
				end
				local amount = demonHorns:FindFirstChild("Amount")
				return amount and tonumber(amount.Value) or 0
			end)

			return ok2 and result2 or 0
		end

		local function getDescendant()
			local magnitude2 = nil
			local descendant2 = nil

			for _, descendant in ipairs(workspace:GetDescendants()) do
				if not descendant:IsA("ProximityPrompt") then
					continue
				end
				local parent = descendant.Parent
				local position

				if parent and parent:IsA("BasePart") then
					position = parent.Position
				else
					local isAttachment = parent and parent:IsA("Attachment")
					position = nil

					if isAttachment then
						position = parent.WorldPosition
					end
				end

				if not position then
					continue
				end
				local magnitude = (position - vector5).Magnitude
				if not (magnitude < 15) then
					continue
				end
				local str4 = tostring(descendant.ActionText or "")

				if str4 == "Load" or str4 == "Stock" or str4 == "Deposit" then
					if not magnitude2 or magnitude < magnitude2 then
						magnitude2 = magnitude
						descendant2 = descendant
					end
				end
			end

			return descendant2
		end

		local function fn30()
			local descendant = getDescendant()
			if not descendant then
				return false
			end

			pcall(function()
				do
					if fireproximityprompt then
						fireproximityprompt(descendant)
					end

					return
				end
			end)

			pcall(function()
				descendant:InputHoldBegin()
			end)

			task.delay(math.max(0.05, (descendant.HoldDuration or 0) + 0.05), function()
				pcall(function()
					descendant:InputHoldEnd()
				end)

			end)

			return true
		end

		local vector6 = Vector3.new(-675.66, 235, 397.13)
		local tbl11 = { "Lesser Demon", "LesserDemon", "LesserDemon_ButterflyEstate" }
		local tbl12 = { "Greater Demon", "GreaterDemon", "GreaterDemon_ButterflyEstate" }

		local function fn31()
			local tbl13 = {}

			for _, v25 in ipairs(tbl11) do
				tbl13[v25] = true
			end

			for _, descendant in ipairs(workspace:GetDescendants()) do
				if descendant:IsA("Model") and tbl13[descendant.Name] then
					local humanoid = descendant:FindFirstChildOfClass("Humanoid")
					if humanoid and humanoid.Health > 0 then
						return true
					end
				end
			end

			return false
		end

		local function fn32(arg)
			local n = arg or 2
			if getOk7() >= n then
				fn22("Demon Horns", ("Already have %d Demon Horns."):format(getOk7()), 4)
				return true
			end

			local function fn33()
				local v25, v26, v27 = fn18()
				if not v27 then
					return
				end
				myhubGuardTP(CFrame.new(vector6))
				task.wait(1)
			end

			fn33()
			local flag11 = true

			local connection = localPlayer.CharacterAdded:Connect(function()
				if not flag11 then
					return
				end
				task.wait(1.5)

				if flag11 then
					fn33()
				end
			end)

			local farmMob = tbl8.farmMob
			local farmMobTarget = tbl8.farmMobTarget
			local killAura = tbl8.killAura
			local myhubKillAura = _G.__myhubKillAura

			local function fn34(arg2)
				local tbl13 = {}

				for _, v25 in ipairs(tbl11) do
					tbl13[v25] = true
				end

				if arg2 then
					for _, v25 in ipairs(tbl12) do
						tbl13[v25] = true
					end
				end

				return tbl13
			end

			tbl8.farmMobTarget = fn34(false)
			tbl8.farmMob = true
			tbl8.killAura = true
			_G.__myhubKillAura = true
			fn22("Demon Horns", ("Farming Lesser Demons until you have %d horns..."):format(n), 6)
			local deadline = tick() + 600
			local flag12 = false

			while tick() < deadline do
				if n <= getOk7() then
					break
				end
				local flag13 = not fn31()

				if flag13 ~= flag12 then
					tbl8.farmMobTarget = fn34(flag13)

					if flag13 then
						fn22("Demon Horns", "No Lesser Demons alive — falling back to Greater Demons.", 4)
						flag12 = flag13
					else
						fn22("Demon Horns", "Lesser Demons back — swapping off Greater.", 3)
						flag12 = flag13
					end
				end

				task.wait(1)
			end

			flag11 = false

			pcall(function()
				connection:Disconnect()
			end)

			tbl8.farmMob = farmMob
			tbl8.farmMobTarget = farmMobTarget
			tbl8.killAura = killAura
			_G.__myhubKillAura = myhubKillAura
			task.wait(0.4)
			local ok2 = getOk7()
			if n <= ok2 then
				fn22("Demon Horns", ("Done — have %d Demon Horns."):format(ok2), 5)
				return true
			end
			fn22("Demon Horns", ("Timed out — only got %d/%d. May need to farm manually or extend cap."):format(ok2, n), 8)
			return false
		end

		local function fn33(name)
			local ok2, result2 = pcall(function()
				local supplyTheSettlement = service.Player_Service.Data[localPlayer.Name].slots.Slot1.Quests.Holder:FindFirstChild("Supply the Settlement")
				if not supplyTheSettlement then
					return nil
				end
				local child = supplyTheSettlement.Tasks:FindFirstChild(name)
				if not child then
					return nil
				end
				local max = child:FindFirstChild("Max")
				return max and max.Value
			end)

			return ok2 and type(result2) == "number" and result2 or nil
		end

		local function getOk8(name)
			local ok2, result2 = pcall(function()
				local child = service.Player_Service.Data[localPlayer.Name].slots.Slot1.Quests.Holder:FindFirstChild("Supply the Settlement")

				if child then
					local child2 = child.Tasks:FindFirstChild(name)
					if not child2 then
						return 0
					end
					local value = child2:FindFirstChild("Value")
					return value and value.Value or 0
				end

				do
					return 0
				end
			end)

			return ok2 and result2 or 0
		end

		local function getOk9(name)
			local ok2, result2 = pcall(function()
				local child = service.Player_Service.Data[localPlayer.Name].slots.Slot1.Inventory.Inventory:FindFirstChild(name)
				if not child then
					return 0
				end
				local amount = child:FindFirstChild("Amount")
				return amount and tonumber(amount.Value) or child and 1 or 0
			end)

			return ok2 and result2 or 0
		end

		local function fn34()
			if getOk3(tbl10.key) then
				return true
			end

			if getOk5(tbl10.instance) then
				return true
			end
			local count2 = 0

			while not getOk5(tbl10.instance) and count2 < 20 do
				count2 += 1
				fn28("Auto Shovel")
				fn22("Auto Shovel", ("Accepting Shiro's quest (try %d)"):format(count2), 4)
				fn26(tbl10.key, vector4, "Iceveil Guard Shiro")
			end

			return getOk5(tbl10.instance)
		end

		local function fn35(arg)
			local n = math.max(1, math.floor(tonumber(arg) or 1))
			if getOk7() < 2 then
				fn22("Auto Shovel", "Need 2 Demon Horns per Elixir — short.", 6)
				return 0
			end
			local v25 = fn21()
			if not v25 then
				return 0
			end
			local v26, v27, v28 = fn18()
			if not v28 then
				return 0
			end
			myhubGuardTP(CFrame.new(vector3 + Vector3.new(0, 3, 0)))
			task.wait(0.4)
			fn24("Alchemist Meku")
			task.wait(1.2)

			local ok2, result2 = pcall(function()
				return localPlayer.PlayerGui
			end)

			if ok2 and result2 then
				local dialogueFrame = result2:FindFirstChild("ComponentsHolder") and result2.ComponentsHolder:FindFirstChild("DialogueFrame")
				local child = dialogueFrame and dialogueFrame:FindFirstChild("Actual") and dialogueFrame.Actual:FindFirstChild("ClickDetector")

				if child and typeof(firesignal) == "function" then
					pcall(function()
						firesignal(child.MouseButton1Click)
					end)

					task.wait(0.8)
				end
			end

			local healthElixir = getOk9("Health Elixir")
			local n10 = 0

			for i = 1, n do
				if not (getOk7() < 2) then
					local healthElixir2 = getOk9("Health Elixir")

					pcall(function()
						v25.Storage.BuySelection = { ["Health Elixir"] = 1 }
						v25.Storage.CartShopNode = "Alchemist Meku_2"
						v25.Functions.ProceedWithCartPurchase("Deal", v25.Storage)
					end)

					task.wait(0.5)
					local healthElixir3 = getOk9("Health Elixir")
					if healthElixir2 < healthElixir3 then
						n10 += healthElixir3 - healthElixir2
						continue
					end
				end

				break
			end

			task.wait(0.3)
			fn25()
			task.wait(0.3)

			if n10 < n then
				if getOk9("Health Elixir") == healthElixir then
					fn22("Auto Shovel", "Meku buy silently refused — open his shop manually once (chat, click Elixirs, close), then re-run.", 12)
				else
					fn22("Auto Shovel", ("Bought %d/%d Elixirs (short on Horns or server refused mid-run)."):format(n10, n), 8)
				end
			end

			return n10
		end

		local function fn36(arg, arg2, arg3)
			local v25, v26, v27 = fn18()
			if not v27 then
				return false
			end
			myhubGuardTP(CFrame.new(vector5 + Vector3.new(0, 3, 0)))
			task.wait(2)
			local v28 = fn33(arg2) or arg3
			local deadline = tick() + 60

			while tick() < deadline do
				if v28 <= getOk8(arg2) then
					break
				end

				if getOk9(arg) <= 0 then
					break
				end

				if not fn30() then
					task.wait(0.5)
				else
					task.wait(0.4)
				end
			end

			return getOk8(arg2) >= v28
		end

		local function fn37()
			local v25 = fn21()
			if not v25 then
				return false
			end
			local v26, v27, v28 = fn18()
			if not v28 then
				return false
			end
			myhubGuardTP(CFrame.new(vector4 + Vector3.new(0, 3, 0)))
			task.wait(0.4)
			fn24("Iceveil Guard Shiro")
			task.wait(0.5)

			pcall(function()
				if v25.Functions.DeliverSuppliesToShiro then
					v25.Functions.DeliverSuppliesToShiro("Hand it over", v25.Storage)
				end
			end)

			task.wait(0.5)
			fn25()
			task.wait(0.4)
			return getOk3(tbl10.key)
		end

		local function fn38()
			if getOk2() then
				fn22("Auto Shovel", "Shovel already owned — enable Auto Farm Snow Mounds in Farm.", 6)
				return
			end

			while getOk9("Cooked Bear Meat") < 9 do
				local cookedBearMeat = getOk9("Cooked Bear Meat")
				fn22("Auto Shovel", ("Phase 1/9: Lucy's chain (%d/%d meat)..."):format(cookedBearMeat, 9), 4)

				if fn29(true) then
					if not (getOk9("Cooked Bear Meat") <= cookedBearMeat) then
						continue
					end
				end

				break
			end

			if not getOk3(tbl10.key) then
				fn22("Auto Shovel", "Phase 2/9: accepting Shiro's quest...", 4)
				if not fn34() then
					fn22("Auto Shovel", "Couldn't accept Shiro's quest — check level or bail.", 10)
					return
				end
			end

			local healthElixirsStocked = fn33("Health Elixirs stocked") or 25
			local n = fn33("Cooked Bear Meat stocked") or 3
			local ok2 = getOk9("Health Elixir")
			local ok3 = getOk9("Cooked Bear Meat")
			local n10 = math.max(0, healthElixirsStocked - ok2)
			local n11 = n10 * 2
			fn22("Auto Shovel", ("Quotas: %d Elixirs (%d to buy), %d Bear Meat (%d to grind), %d horns needed"):format(healthElixirsStocked, n10, n, math.max(0, n - ok3), n11), 10)

			while getOk9("Cooked Bear Meat") < n do
				local cookedBearMeat = getOk9("Cooked Bear Meat")
				fn22("Auto Shovel", ("Phase 4/9: topping up Bear Meat (%d/%d)..."):format(cookedBearMeat, n), 4)

				if fn29(true) then
					if not (getOk9("Cooked Bear Meat") <= cookedBearMeat) then
						continue
					end
				end

				break
			end

			if getOk7() < n11 then
				fn22("Auto Shovel", ("Phase 5/9: farming %d Demon Horns..."):format(n11), 4)
				fn32(n11)
			end

			if n10 > 0 then
				fn22("Auto Shovel", ("Phase 6/9: buying %d Health Elixirs..."):format(n10), 4)
				fn35(n10)
			end

			fn22("Auto Shovel", "Phase 7/9: depositing Elixirs at Supply Cart...", 4)
			fn36("Health Elixir", "Health Elixirs stocked", healthElixirsStocked)
			fn22("Auto Shovel", "Phase 8/9: depositing Cooked Bear Meat...", 4)
			fn36("Cooked Bear Meat", "Cooked Bear Meat stocked", n)
			fn22("Auto Shovel", "Phase 9/9: handing in to Shiro...", 4)
			fn37()
			task.wait(0.5)

			if getOk3(tbl10.key) or getOk("Ill help you survive the winter(Lv 100)") then
				fn22("Auto Shovel", "Buying Shovel...", 4)

				if fn23() then
					fn22("Auto Shovel", "Shovel bought — enable Auto Farm Snow Mounds in Farm to dig.", 8)
				end
			else
				fn22("Auto Shovel", "Hand-in didn't register as complete — press the button again to retry.", 10)


			end
		end

		local v25 = v24:AddButton({
			Text = "Auto Complete Shovel Questline",
			Tooltip = "Full questline",
			Func = function()
				task.spawn(fn38)
			end,
		})

		if not tbl6.isPremium then
			fn16(v25)
		end
	end

	do
		local v25 = nil

		local function fn27()
			if v25 then
				return v25
			end
			local service2 = game:GetService("ReplicatedStorage")
			local child = service2:FindFirstChild("CAM") and service2.CAM:FindFirstChild("Global") and service2.CAM.Global:FindFirstChild("Training")
			local boulderSplit = child and child:FindFirstChild("Boulder Split")
			local client = boulderSplit and boulderSplit:FindFirstChild("Client")
			if not client then
				return nil
			end
			local ok2, result2 = pcall(require, client)
			if not (ok2 and type(result2) == "table" and type(result2.Do) == "function") then
				return nil
			end
			local ok3, result3 = pcall(debug.getupvalues, result2.Do)
			if not (ok3 and type(result3) == "table") then
				return nil
			end
			local v26 = result3[6]
			if type(v26) ~= "table" or type(v26.ToServer) ~= "function" then
				return nil
			end
			v25 = v26
			return v26
		end

		local function fn28()
			local v26 = fn27()
			if not v26 then
				return
			end

			pcall(function()
				v26.ToServer("training_signaler", "StateChanged")
			end)

			pcall(function()
				v26.ToServer("training_signaler", "StateChanged")
			end)

			pcall(function()
				v26.ToServer("training_signaler", "StateChanged")
			end)

			pcall(function()
				v26.ToServer("training_signaler", "Stop", true)
			end)
		end

		local function fn29()
			local v26 = fn27()
			if not v26 then
				return
			end

			pcall(function()
				v26.ToServer("training_signaler", "Stop", true)
			end)
		end

		local tbl10 = {
			{ flag = "autoMeditate", folder = "Meditation", bypass = fn29, bypassWait = 1.1 },
			{ flag = "autoPushUps", folder = "Pushups", bypass = fn29, bypassWait = 1.1 },
			{
				flag = "autoBoulderSplit",
				folder = "Boulder Split",
				bypass = fn28,
				bypassWait = 12.8,
			},
			{
				flag = "autoAimTraining",
				folder = "Aim Training",
				bypass = fn29,
				bypassWait = 1.1,
			},
			{ flag = "autoCupTraining", folder = "Cup Game", bypass = fn29, bypassWait = 1.1 },
			{ flag = "autoBoulderPush", folder = "Boulder Push", bypass = fn29, bypassWait = 1.1 },
			{ flag = "autoSquat", folder = "Squat Rack", bypass = fn29, bypassWait = 1.1 },
		}

		local function fn30(instance)
			local root = instance:FindFirstChild("Root")
			if root and root:IsA("BasePart") then
				return root.CFrame
			end

			local ok2, result2 = pcall(function()
				return instance:GetPivot()
			end)

			if ok2 and result2 then
				return result2
			end
			return nil
		end

		local function fn31(name)
			local training = workspace:FindFirstChild("Training")
			if not training then
				return nil, nil
			end
			local child = training:FindFirstChild(name)
			if not child then
				return nil, nil
			end
			local positions = {}

			for _, child2 in ipairs(training:GetChildren()) do
				if not (child2 ~= child and child2:IsA("Folder")) then
					continue
				end

				for _, child3 in ipairs(child2:GetChildren()) do
					local v26 = fn30(child3)

					if v26 then
						table.insert(positions, v26.Position)
					end
				end
			end

			local function fn32(position)
				for _, position2 in ipairs(positions) do
					if math.abs(position2.X - position.X) < 5 and math.abs(position2.Z - position.Z) < 5 then
						return true
					end
				end

				return false
			end

			local child3 = nil
			local v26 = nil
			local child4 = nil
			local v27 = nil

			for _, child2 in ipairs(child:GetChildren()) do
				if child2.Name == "Sign" then
					continue
				end
				local v28 = fn30(child2)
				if not v28 then
					continue
				end

				if fn32(v28.Position) then
					if not child3 then
						child3 = child2
						v26 = v28
					end
				elseif not child4 then
					child4 = child2
					v27 = v28
				end
			end

			if child4 then
				return child4, v27
			end
			return child3, v26
		end

		local function getDescendant(instance)
			if not instance then
				return nil
			end

			for _, descendant in ipairs(instance:GetDescendants()) do
				if descendant:IsA("ProximityPrompt") and descendant.Enabled then
					return descendant
				end
			end

			return nil
		end

		local flag11 = false

		local function fn32(instance, arg, arg2, arg3)
			if not (instance and instance.Parent) then
				return
			end

			myhubPinTP(arg, { cancel = function()
				return arg3 and not tbl8[arg3]
			end })
		end

		for _, v26 in ipairs(tbl10) do
			task.spawn(function()
				while _G.MyHubSession == myHubSession do
					if not tbl8[v26.flag] or flag11 then
						task.wait(0.5)
						continue
					end
					flag11 = true
					local v27, v28 = fn31(v26.folder)
					local v29, v30, v31 = fn18()

					if v27 and v28 and v31 then
						local n = v28 + Vector3.new(0, 3, 0)

						if (v31.Position - n.Position).Magnitude > 8 then
							fn32(v31, n, 0.5, v26.flag)
						end

						local descendant = nil
						local n10 = 0

						while true do
							if n10 < 3 and tbl8[v26.flag] then
								descendant = getDescendant(v27)

								if not descendant then
									task.wait(0.2)
									n10 += 0.2
									continue
								end
							end

							break
						end

						if descendant then
							pcall(function()
								fireproximityprompt(descendant)
							end)

							task.wait()
							pcall(v26.bypass)
						end

						task.wait(v26.bypassWait or 2)
					else
						task.wait(1)
					end

					flag11 = false
				end
			end)
		end
	end

	do
		local service2 = game:GetService("ReplicatedStorage")

		local function fn27(name)
			local ouwland = service2:FindFirstChild("Ouwland")
			local child = ouwland and ouwland:FindFirstChild("Content") and ouwland.Content:FindFirstChild("Misc") and ouwland.Content.Misc:FindFirstChild("Npcs") and ouwland.Content.Misc.Npcs:FindFirstChild(name)
			if not child then
				return nil
			end
			local ok2, result2 = pcall(require, child)
			if not (ok2 and type(result2) == "table" and type(result2.Spawns) == "table") then
				return nil
			end
			return result2
		end

		local sealedChestTiers = { T1 = fn27("Sealed Chest T1"), T2 = fn27("Sealed Chest T2"), T3 = fn27("Sealed Chest T3") }
		local v25 = tbl7.Leveling:AddRightGroupbox("Sealed Chest")

		local AutoFarmCache = v25:AddToggle("AutoFarmCache", {
			Text = "Auto Farm Cache",
			Default = false,
			Tooltip = "Farm sealed caches",
			Callback = function(autoFarmCache)
				tbl8.autoFarmCache = autoFarmCache
			end,
		})

		local v26 = v25:AddToggle("CachePickup", {
			Text = "Pick Up Items",
			Default = tbl8.cachePickup,
			Tooltip = "Collect the chest's drops before moving on (off = open and go)",
			Callback = function(pickUpItems)
				tbl8.cachePickup = pickUpItems
			end,
		})

		local v27 = v25:AddToggle("ServerHopCache", {
			Text = "Server Hop",
			Default = false,
			Tooltip = "Hop to a fresh non-full server after each cache sweep",
			Callback = function(enabled2)
				tbl8.serverHopCache = enabled2
			end,
		})

		if not tbl6.isPremium then
			fn16(AutoFarmCache)
			fn16(v26)
			fn16(v27)
		end

		v25:AddDropdown("SealedChestTiers", {
			Text = "Tiers",
			Values = { "T1", "T2", "T3" },
			Multi = true,
			Default = {},
			AllowNull = true,
			Tooltip = "Which cache tiers to hunt (multi-select).",
			Callback = function(tiers)
				local sealedChestTiers2 = {}

				if type(tiers) == "table" then
					for k, tier in pairs(tiers) do
						if tier then
							sealedChestTiers2[#sealedChestTiers2 + 1] = k
						end
					end
				end

				table.sort(sealedChestTiers2)
				tbl8.sealedChestTiers = sealedChestTiers2
			end,
		})

		local function fn28(instance, arg)
			if not (instance and instance.Parent) then
				return
			end

			myhubPinTP(arg, { cancel = function()
				return not tbl8.autoFarmCache
			end })
		end

		local function fn29(arg)
			return arg:gsub("(%l)(%u)", "%1 %2")
		end

		local tbl10 = {}

		for k, sealedChestTier in pairs(sealedChestTiers) do
			local tbl11 = {}
			local tbl12 = {}

			local function fn30(arg)
				if type(arg) ~= "string" or arg == "" or tbl12[arg] then
					return
				end
				tbl12[arg] = true
				tbl11[#tbl11 + 1] = arg
			end

			if sealedChestTier and type(sealedChestTier.WorldEvent) == "table" and type(sealedChestTier.WorldEvent.Guards) == "table" then
				for _, guard in pairs(sealedChestTier.WorldEvent.Guards) do
					if type(guard) ~= "table" then
						continue
					end

					if type(guard.Config) == "string" then
						fn30(guard.Config)
						fn30(fn29(guard.Config))
					end

					if type(guard.NpcCode) == "string" then
						fn30(guard.NpcCode)
						fn30(fn29(guard.NpcCode))
					end
				end
			end

			tbl10[k] = tbl11
		end

		local function fn30(sealedChestTier, position, arg)
			local chests = workspace:FindFirstChild("Chests")
			if not chests then
				return nil
			end
			local str4 = "Sealed Cache " .. sealedChestTier
			local n = arg * arg

			for _, child in ipairs(chests:GetChildren()) do
				if not (child:IsA("Model") and child.Name == str4) then
					continue
				end
				local humanoidRootPart = child:FindFirstChild("HumanoidRootPart") or child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart", true)

				if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
					local position2 = humanoidRootPart.Position - position
					if position2:Dot(position2) <= n then
						return child, humanoidRootPart
					end
				end
			end

			return nil
		end

		local function getActiveNpcs()
			local child = workspace:FindFirstChild("Humanoids")
			local regions = child and child:FindFirstChild("Regions")
			local temporary = regions and regions:FindFirstChild("Temporary")
			return temporary and temporary:FindFirstChild("ActiveNpcs")
		end

		local function fn31(sealedChestTier, instance, arg)
			local activeNpcs = getActiveNpcs()
			if not activeNpcs then
				return 0
			end
			local v28 = tbl10[sealedChestTier]
			if not v28 or #v28 == 0 then
				return 0
			end
			local tbl11 = {}

			for _, v29 in ipairs(v28) do
				tbl11[v29] = true
			end

			local n = arg * arg
			local count2 = 0

			for _, child in ipairs(activeNpcs:GetChildren()) do
				if not tbl11[child.Name] then
					continue
				end

				for _, child2 in ipairs(child:GetChildren()) do
					if not child2:IsA("Model") then
						continue
					end
					local humanoid = child2:FindFirstChildOfClass("Humanoid")
					local child3 = child2:FindFirstChild("HumanoidRootPart") or child2.PrimaryPart

					if humanoid and humanoid.Health > 0 and child3 and child3:IsA("BasePart") then
						local position = child3.Position - instance.Position

						if position:Dot(position) <= n then
							count2 += 1
						end
					end
				end
			end

			return count2
		end

		local function fn32(instance)
			local humanoid = instance:FindFirstChildOfClass("Humanoid")

			if humanoid and humanoid.Health > 0 then
				pcall(function()
					humanoid.Health = 0
				end)
			end
		end

		local function fn33(instance)
			local flag11 = false

			for _, descendant in ipairs(instance:GetDescendants()) do
				if descendant:IsA("ProximityPrompt") then
					pcall(function()
						if fireproximityprompt then
							fireproximityprompt(descendant)
						end
					end)

					pcall(function()
						descendant:InputHoldBegin()
					end)

					task.delay(math.max(0.05, (descendant.HoldDuration or 0) + 0.05), function()
						pcall(function()
							descendant:InputHoldEnd()
						end)
					end)

					flag11 = true
				end
			end

			return flag11
		end

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				if not tbl8.autoFarmCache then
					task.wait(0.4)
					continue
				end
				local sealedChestTiers2 = tbl8.sealedChestTiers or {}
				if #sealedChestTiers2 == 0 then
					task.wait(0.5)
					continue
				end
				local killAura = tbl8.killAura
				local autoPickup = tbl8.autoPickup
				tbl8.killAura = true
				_G.__myhubKillAura = true
				local cachePickup = tbl8.cachePickup and true or autoPickup
				tbl8.autoPickup = cachePickup
				local farmMob = tbl8.farmMob
				local farmMobTarget = tbl8.farmMobTarget

				for _, sealedChestTier in ipairs(sealedChestTiers2) do
					if not tbl8.autoFarmCache then
						break
					end
					local sealedChestTier2 = sealedChestTiers[sealedChestTier]
					if not (sealedChestTier2 and sealedChestTier2.Spawns) then
						continue
					end
					local farmMobTarget2 = {}
					local v28 = ipairs
					local tbl11 = tbl10[sealedChestTier] or {}

					for _, v29 in v28(tbl11) do
						farmMobTarget2[v29] = true
					end

					for _, spawn_ in ipairs(sealedChestTier2.Spawns) do
						if not tbl8.autoFarmCache then
							break
						end
						tbl8.farmMob = false
						local v29, v30, v31 = fn18()
						if not v31 then
							task.wait(0.3)
							continue
						end
						fn28(v31, spawn_ + Vector3.new(0, 6, 0))
						local instance = nil
						local instance2 = nil

						for i = 1, 10 do
							if tbl8.autoFarmCache then
								instance, instance2 = fn30(sealedChestTier, spawn_.Position, 50)
								if not instance then
									task.wait(0.1)
									continue
								end
							end

							break
						end

						if not (instance and instance2) then
							continue
						end

						for i = 1, 10 do
							if tbl8.autoFarmCache then
								if not (0 < fn31(sealedChestTier, instance2, 150)) then
									task.wait(0.1)
									continue
								end
							end

							break
						end

						local flag11 = false

						if next(farmMobTarget2) then
							tbl8.farmMobTarget = farmMobTarget2
							tbl8.farmMob = true
							local deadline = tick() + 90

							while tbl8.autoFarmCache and instance2.Parent and tick() < deadline do
								if instance:GetAttribute("IsOpen") == true or instance:GetAttribute("ChestState") == "Opened" then
									break
								end

								if fn31(sealedChestTier, instance2, 150) == 0 then
									tbl8.farmMob = false
									tbl8.autoPickup = false
									local cframe = instance2.CFrame + Vector3.new(0, 4, 0)

									local connection = RunService.Heartbeat:Connect(function()
										local v32, v33, part = fn18()
										if not (part and part.Parent) then
											return
										end

										pcall(function()
											part.Anchored = false
											part.CFrame = cframe
											part.AssemblyLinearVelocity = Vector3.zero
											part.AssemblyAngularVelocity = Vector3.zero
										end)
									end)

									task.wait(0.1)
									local deadline2 = tick() + 1.5

									while tbl8.autoFarmCache and instance2.Parent and tick() < deadline2 do
										if instance:GetAttribute("IsOpen") == true or instance:GetAttribute("ChestState") == "Opened" then
											flag11 = true
											break
										end

										if fn31(sealedChestTier, instance2, 150) > 0 then
											break
										end
										fn33(instance)
										task.wait(0.1)
									end

									connection:Disconnect()
									if flag11 then
										break
									end
									tbl8.farmMob = true
								end

								task.wait(0.1)
							end

							tbl8.farmMob = false
							task.wait(0.4)
						end

						if tbl8.autoFarmCache and instance2.Parent then
							local v32, v33, v34 = fn18()

							if v34 then
								fn28(v34, instance2.CFrame + Vector3.new(0, 4, 0))
							end

							local position = instance2.Position
							fn33(instance)
							fn32(instance)

							if tbl8.cachePickup then
								local lootDrops = workspace:FindFirstChild("LootDrops")
								local str4 = "," .. tostring(localPlayer.UserId) .. ","
								local n = (tbl8.autoPickupRange or 200) ^ 2

								local function getChildren()
									local children = {}
									if not lootDrops then
										return children
									end

									for _, child in ipairs(lootDrops:GetChildren()) do
										if child:IsA("BasePart") and child.Parent then
											local attribute = child:GetAttribute("DropReservedFor")
											local flag12 = attribute == nil or attribute == "" or attribute == "," or type(attribute) == "string" and attribute:find(str4, 1, true) ~= nil
											local position2 = child.Position - position

											if flag12 and position2:Dot(position2) <= n and child:FindFirstChildWhichIsA("ProximityPrompt") then
												children[#children + 1] = child
											end
										end
									end

									return children
								end

								local function fn34(children)
									local tbl12 = {}
									local tbl13 = {}

									for _, child in ipairs(children) do
										tbl12[child] = true
									end

									while next(tbl12) do
										local positions = {}

										for k in pairs(tbl12) do
											positions[#positions + 1] = k.Position

											for k2 in pairs(tbl12) do
												if k2 ~= k then
													positions[#positions + 1] = (k.Position + k2.Position) / 2
												end
											end
										end

										local v35 = nil
										local position3 = nil
										local v36 = nil

										for _, position2 in ipairs(positions) do
											local tbl14 = {}
											local v37 = 0

											for k in pairs(tbl12) do
												if (k.Position - position2).Magnitude <= 8.5 then
													tbl14[#tbl14 + 1] = k
													v37 += 1
												end
											end

											if not v35 or v37 > v35 then
												v35 = v37
												position3 = position2
												v36 = tbl14
											end
										end

										if not (v35 and v35 ~= 0) then
											break
										end

										for _, v37 in ipairs(v36) do
											tbl12[v37] = nil
										end

										tbl13[#tbl13 + 1] = { pos = position3, drops = v36 }
									end

									return tbl13
								end

								task.wait(0.25)
								local deadline = tick() + 15

								for i = 1, 2 do
									if not (tbl8.autoFarmCache and not (tick() >= deadline)) then
										break
									end
									local children = getChildren()
									local v35 = fn34(children)
									if #v35 == 0 then
										break
									end

									for _, v36 in ipairs(v35) do
										if not (tbl8.autoFarmCache and not (tick() >= deadline)) then
											break
										end
										local cframe = CFrame.new(v36.pos + Vector3.new(0, 3, 0))
										myhubPinTP(cframe)

										local connection = RunService.Heartbeat:Connect(function()
											local v37, v38, part = fn18()

											if part and part.Parent then
												pcall(function()
													part.CFrame = cframe
													part.AssemblyLinearVelocity = Vector3.zero
													part.AssemblyAngularVelocity = Vector3.zero
												end)
											end
										end)

										task.wait(0.05)
										local deadline2 = tick() + 1.5

										while tick() < deadline2 do
											local flag12 = true

											for _, drop in ipairs(v36.drops) do
												local proximityPrompt = drop.Parent and drop:FindFirstChildWhichIsA("ProximityPrompt")
												if proximityPrompt and not proximityPrompt.Enabled then
													flag12 = false
													break
												end
												flag12 = true
											end

											if flag12 then
												break
											end
											task.wait(0.05)
										end

										local tbl12 = {}
										local n10 = 0

										for _, drop in ipairs(v36.drops) do
											local proximityPrompt = drop.Parent and drop:FindFirstChildWhichIsA("ProximityPrompt")

											if proximityPrompt then
												pcall(function()
													proximityPrompt.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow
												end)

												tbl12[#tbl12 + 1] = proximityPrompt
												n10 = math.max(n10, proximityPrompt.HoldDuration or 0)
											end
										end

										for _, v37 in ipairs(tbl12) do
											pcall(function()
												v37:InputHoldBegin()
											end)
										end

										local deadline3 = tick() + n10 + 1.2

										while tick() < deadline3 and tbl8.autoFarmCache do
											local flag12 = false

											for _, drop in ipairs(v36.drops) do
												if drop.Parent then
													flag12 = true
													break
												end
												flag12 = false
											end

											if not flag12 then
												break
											end
											task.wait(0.05)
										end

										for _, v37 in ipairs(tbl12) do
											pcall(function()
												v37:InputHoldEnd()
											end)
										end

										task.wait(0.1)
										connection:Disconnect()
									end
								end

								tbl8.autoPickup = cachePickup
							else
								tbl8.autoPickup = cachePickup
							end
						end

						tbl8.autoPickup = cachePickup
					end
				end

				tbl8.farmMobTarget = farmMobTarget
				tbl8.farmMob = farmMob
				tbl8.killAura = killAura
				_G.__myhubKillAura = killAura
				tbl8.autoPickup = autoPickup

				if tbl8.serverHopCache and _G.__myhubServerHop then
					_G.__myhubServerHop("Sealed Chest Hop")
				end

				task.wait(0.4)
			end
		end)
	end

	do
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local v25 = nil

		local function fn27()
			if v25 then
				return v25
			end
			local boulderSplit = ReplicatedStorage:FindFirstChild("CAM") and ReplicatedStorage.CAM:FindFirstChild("Global") and ReplicatedStorage.CAM.Global:FindFirstChild("Training") and ReplicatedStorage.CAM.Global.Training:FindFirstChild("Boulder Split")
			local client = boulderSplit and boulderSplit:FindFirstChild("Client")
			if not client then
				return nil
			end
			local ok2, result2 = pcall(require, client)
			if not (ok2 and type(result2) == "table" and type(result2.Do) == "function") then
				return nil
			end
			local ok3, result3 = pcall(debug.getupvalues, result2.Do)
			if not (ok3 and type(result3) == "table") then
				return nil
			end
			local v26 = result3[6]
			if type(v26) == "table" and type(v26.ToServer) == "function" then
				v25 = v26
				return v26
			end
			return nil
		end

		local function getSunDamage()
			local playerGui = localPlayer:FindFirstChild("PlayerGui")
			local ucs = playerGui and playerGui:FindFirstChild("UCS")
			local gamePlay = ucs and ucs:FindFirstChild("Game_Play")
			return gamePlay and gamePlay:FindFirstChild("SunDamage")
		end

		getConnection(RunService.Heartbeat:Connect(function()
			local E = getSunDamage()

			if E and (E.Disabled ~= tbl8.sunImmunity) then
				pcall(function()
					E.Disabled = tbl8.sunImmunity
				end)

				if tbl8.sunImmunity then
					local E = fn27()

					if E then
						pcall(function()
							E.ToServer("SunDamage", false)
						end)
					end
				end
			end
		end))
	end

	local function getChild()
		local character = localPlayer.Character
		if not character then
			return nil
		end
		local overHead = character:FindFirstChild("OverHead")
		local child = overHead and overHead:FindFirstChild("Holder")
		return child and child:FindFirstChild("BreathBar")
	end

	local function fn27()
		local character = localPlayer.Character
		if not character then
			return
		end

		if tbl8.noDrowning then
			pcall(function()
				character:SetAttribute("NoDrowning", true)
			end)

			local child = getChild()

			if child and child.Visible then
				pcall(function()
					child.Visible = false
				end)
			end
		else
			pcall(function()
				character:SetAttribute("NoDrowning", nil)
			end)

			local child = getChild()

			if child and not child.Visible then
				pcall(function()
					child.Visible = true
				end)
			end
		end
	end

	getConnection(localPlayer.CharacterAdded:Connect(function()
		task.wait(0.5)
		fn27()
	end))

	getConnection(RunService.Heartbeat:Connect(function()
		local E = localPlayer.Character
		if not E then
			return
		end
		local h = tbl8.noDrowning
		if h ~= ((E:GetAttribute("NoDrowning") and true) or false) then
			fn27()
			return
		end

		if h then
			E = getChild()

			if E and E.Visible then
				fn27()
			end
		end
	end))

	do
		local flag11 = false

		local function fn28()
			if flag11 then
				return
			end

			if type(hookfunction) ~= "function" then
				return
			end
			local ReplicatedStorage = game:GetService("ReplicatedStorage")

			local ok2, result2 = pcall(function()
				return require(ReplicatedStorage.CAM.Global.Subsets.Gameplay.manage_cd)
			end)

			if not (ok2 and type(result2) == "table" and type(result2.set_skill_cd) == "function") then
				return
			end
			local setSkillCd = result2.set_skill_cd

			if pcall(function()
				result2.set_skill_cd = function(arg, arg2, arg3)
					if tbl8.noDashCd and arg2 == "Dash" then
						return
					end
					return setSkillCd(arg, arg2, arg3)
				end
			end) then
				flag11 = true
			end
		end

		local function fn29()
			local character = localPlayer.Character
			if not character then
				return
			end
			local shc = character:FindFirstChild("SHC") or character:FindFirstChild("SHCS")
			if not shc then
				return
			end

			for _, child in ipairs(shc:GetChildren()) do
				if child:IsA("NumberValue") and child.Name == "Dash" then
					pcall(function()
						child:Destroy()
					end)
				end
			end
		end

		getConnection(RunService.Heartbeat:Connect(function()
			if not tbl8.noDashCd then
				return
			end
			fn28()
			fn29()
		end))
	end

	do
		local tbl10 = {
			chat = true,
			purchase = true,
			buy = true,
			["set spawn"] = true,
			["tame"] = true,
			["ride"] = true,
			dismount = true,
			enter = true,
			["exit"] = true,
			["open"] = true,
			close = true,
			trade = true,
		}

		local function fn28(arg)
			if not arg.Enabled then
				return false
			end

			if tbl10[tostring(arg.ActionText or ""):lower()] then
				return false
			end
			return true
		end

		local function fn29(instance)
			local parent = instance.Parent
			if not parent then
				return nil
			end

			if parent:IsA("BasePart") then
				return parent.Position
			end

			if parent:IsA("Attachment") then
				return parent.WorldPosition
			end
			local parent2 = parent

			for i = 1, 8 do
				if not parent2 then
					break
				end

				if parent2:IsA("BasePart") then
					return parent2.Position
				end

				if parent2:IsA("Model") then
					local ok2, result2 = pcall(function()
						return parent2:GetPivot()
					end)

					if ok2 and result2 then
						return result2.Position
					end
				end

				parent2 = parent2.Parent
			end

			return nil
		end

		local obj = setmetatable({}, { __mode = "k" })

		local function fn30(arg)
			if obj[arg] then
				return
			end

			pcall(function()
				if fireproximityprompt then
					fireproximityprompt(arg)
				end
			end)

			pcall(function()
				arg:InputHoldBegin()
			end)

			local holdDuration = arg.HoldDuration or 0
			local holdDuration2 = holdDuration > 0 and holdDuration + 0.15 or 0.05

			if 0 < holdDuration then
				obj[arg] = true
			end

			task.delay(holdDuration2, function()
				pcall(function()
					arg:InputHoldEnd()
				end)

				obj[arg] = nil
			end)
		end

		local obj2 = setmetatable({}, { __mode = "k" })
		local obj3 = setmetatable({}, { __mode = "k" })

		local function fn31(instance)
			local child = workspace:FindFirstChild("LootDrops")
			return child ~= nil and instance:IsDescendantOf(child)
		end

		local function fn32(descendant)
			obj2[descendant] = true

			if (descendant.HoldDuration or 0) > 0 then
				obj3[descendant] = true
			end

			if fn31(descendant) then
				pcall(function()
					descendant.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow
				end)
			end
		end

		local tbl11 = { Debree = true, LootDrops = true }
		local instances = {}

		local function fn33(instance)
			if instances[instance] then
				return
			end
			instances[instance] = true

			getConnection(instance.DescendantAdded:Connect(function(E)
				if E:IsA("ProximityPrompt") then
					fn32(E)
				end
			end))

			getConnection(instance.DescendantRemoving:Connect(function(E)
				if E:IsA("ProximityPrompt") then
					obj2[E] = nil
					obj3[E] = nil
				end
			end))

			for _, descendant in ipairs(instance:GetDescendants()) do
				if descendant:IsA("ProximityPrompt") then
					fn32(descendant)
				end
			end
		end

		for _, child in ipairs(workspace:GetChildren()) do
			if tbl11[child.Name] then
				fn33(child)
			end
		end

		getConnection(workspace.ChildAdded:Connect(function(E)
			if tbl11[E.Name] then
				fn33(E)
			end
		end))

		local function fn34(instance)
			for i = 1, 4 do
				if not instance then
					break
				end
				local attribute = instance:GetAttribute("DropOwnerUserId")
				if typeof(attribute) == "number" then
					return attribute == localPlayer.UserId
				end
				instance = instance.Parent
			end

			return true
		end

		local tbl12 = {
			"chest",
			"cache",
			"mound",
			"loot",
			"reward",
			"treasure",
			"coffin",
			"vault",
			"crate",
			"supply",
			"stash",
			"prize",
			"container",
			"sealed",
		}

		local function fn35(instance)
			if fn31(instance) then
				return false
			end
			local str4 = tostring(instance.ActionText or ""):lower()
			local str5 = tostring(instance.ObjectText or ""):lower()

			for _, v25 in ipairs(tbl12) do
				if str4:find(v25, 1, true) or str5:find(v25, 1, true) then
					return true
				end
			end

			local parent = instance.Parent

			for i = 1, 8 do
				if not parent then
					break
				end
				local name = parent.Name:lower()

				for _, v25 in ipairs(tbl12) do
					if name:find(v25, 1, true) then
						return true
					end
				end

				parent = parent.Parent
			end

			return false
		end

		local tbl13 = { "chest", "coffin", "mound", "vault" }

		local function fn36(instance)
			local parent = instance.Parent

			for i = 1, 8 do
				if not parent then
					break
				end

				if CollectionService:HasTag(parent, "Chest") or CollectionService:HasTag(parent, "ChestMound") then
					return true
				end

				if parent.Name == "Chests" and parent.Parent == workspace then
					return true
				end
				local name = parent.Name:lower()

				for _, v25 in ipairs(tbl13) do
					if name:find(v25, 1, true) then
						return true
					end
				end

				parent = parent.Parent
			end

			return false
		end

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				if not tbl8.autoPickup then
					task.wait(0.3)
					continue
				end
				local v25, v26, v27 = fn18()
				if not v27 then
					task.wait(0.3)
					continue
				end
				local position = v27.Position
				local n = tbl8.autoPickupRange * tbl8.autoPickupRange

				for k in pairs(obj2) do
					if not k.Parent then
						obj2[k] = nil
					else
						if not (not obj3[k] and fn28(k) and not fn36(k) and fn34(k)) then
							continue
						end
						local v28 = fn29(k)

						if v28 then
							local n10 = v28 - position
							local dot = n10:Dot(n10)

							if dot <= n and dot <= 225 then
								fn30(k)
							end
						end
					end
				end

				task.wait(0.2)
			end
		end)

		getConnection(RunService.Heartbeat:Connect(function()
			if not tbl8.autoPickup or (next(obj3) == nil) then
				return
			end
			local E, E, E = fn18()
			if not E then
				return
			end
			local h, Q = E.Position, tbl8.autoPickupRange * tbl8.autoPickupRange

			for l in pairs(obj3) do
				if not l.Parent then
					obj3[l] = nil
				elseif (fn28(l) and not fn36(l)) and (fn34(l)) then
					E = fn29(l)

					if E then
						local B = E - h
						local E, h = B:Dot(B), math.min(15, (l.MaxActivationDistance or 10) - 0.5)

						if (E <= Q) and (E <= (h * h)) then
							fn30(l)
						end
					end
				end
			end
		end))

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				if not tbl8.autoChest then
					task.wait(0.3)
					continue
				end
				local v25, v26, v27 = fn18()
				if not v27 then
					task.wait(0.3)
					continue
				end
				local position = v27.Position
				local n = tbl8.autoChestRange * tbl8.autoChestRange
				local instances2 = {}

				local function fn37(instance)
					if not (instance and instance.Parent) then
						return
					end

					if instances2[instance] then
						return
					end
					local v28 = fn29(instance)
					if not v28 then
						return
					end
					local n10 = v28 - position
					if n < n10:Dot(n10) then
						return
					end
					instances2[instance] = true
					fn30(instance)
				end

				for _, tag in ipairs({ "Chest", "ChestMound" }) do
					for _, instance in ipairs(CollectionService:GetTagged(tag)) do
						for _, descendant in ipairs(instance:GetDescendants()) do
							if descendant:IsA("ProximityPrompt") then
								fn37(descendant)
							end
						end
					end
				end

				local child = workspace:FindFirstChild("Chests")

				if child then
					for _, descendant in ipairs(child:GetDescendants()) do
						if descendant:IsA("ProximityPrompt") then
							fn37(descendant)
						end
					end
				end

				for k in pairs(obj2) do
					if k.Parent and k:IsA("ProximityPrompt") and fn35(k) then
						fn37(k)
					end
				end

				task.wait(0.25)
			end
		end)

		_G.__myhubAnyChestInR = function(arg, arg2)
			local function fn37(instance)
				if not (instance and instance.Parent) then
					return false
				end
				local v25 = fn29(instance)
				if not v25 then
					return false
				end
				local n = v25 - arg
				return n:Dot(n) <= arg2
			end

			for _, tag in ipairs({ "Chest", "ChestMound" }) do
				for _, instance in ipairs(CollectionService:GetTagged(tag)) do
					for _, descendant in ipairs(instance:GetDescendants()) do
						if descendant:IsA("ProximityPrompt") and fn37(descendant) then
							return true
						end
					end
				end
			end

			local chests = workspace:FindFirstChild("Chests")

			if chests then
				for _, descendant in ipairs(chests:GetDescendants()) do
					if descendant:IsA("ProximityPrompt") and fn37(descendant) then
						return true
					end
				end
			end

			for k in pairs(obj2) do
				if k.Parent and k:IsA("ProximityPrompt") and fn35(k) and fn37(k) then
					return true
				end
			end

			return false
		end
	end

	do
		local deadline = 0

		local function fn28()
			local service2 = game:GetService("ReplicatedStorage")
			local ok2, result2 = pcall(require, service2:FindFirstChild("Communication") and service2.Communication:FindFirstChild("ServerAndClient") and service2.Communication.ServerAndClient:FindFirstChild("Signals") and service2.Communication.ServerAndClient.Signals:FindFirstChild("SignalEvent"))
			if not (ok2 and type(result2) == "table" and type(result2.ToServer) == "function") then
				return
			end

			pcall(function()
				result2.ToServer("training_signaler", "Stop", true)
			end)
		end

		local connection = nil

		local function fn29()
			if connection then
				connection:Disconnect()
				connection = nil
			end

			local playerGui = localPlayer:FindFirstChild("PlayerGui")
			local child = playerGui and playerGui:FindFirstChild("Misc")
			if not child then
				return
			end

			connection = child.ChildAdded:Connect(function()
				if not tbl8.autoTameHorse then
					return
				end
				local now3 = os.clock()
				if now3 < deadline then
					return
				end
				deadline = now3 + 3
				task.wait(0.35)

				if tbl8.autoTameHorse then
					fn28()
				end
			end)

			getConnection(connection)
		end

		fn29()

		getConnection(localPlayer.CharacterAdded:Connect(function()
			task.wait(1)
			fn29()
		end))
	end

	local obj = setmetatable({}, { __mode = "k" })
	local flag11 = false

	getConnection(RunService.Stepped:Connect(function()
		local E = localPlayer.Character
		if not E then
			return
		end

		if tbl8.noclip then
			flag11 = true

			for h, h in ipairs(E:GetDescendants()) do
				if h:IsA("BasePart") and h.CanCollide then
					obj[h] = true
					h.CanCollide = false
				end
			end
		elseif flag11 then
			flag11 = false

			for E in pairs(obj) do
				if E and E.Parent then
					pcall(function()
						E.CanCollide = true
					end)
				end

				obj[E] = nil
			end
		end
	end))

	do
		local currentCamera = workspace.CurrentCamera

		getConnection(workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
			currentCamera = workspace.CurrentCamera
		end))

		local instance = nil
		local connection = nil
		local thread = nil

		local function fn28()
			if connection then
				connection:Disconnect()
				connection = nil
			end

			if thread then
				task.cancel(thread)
				thread = nil
			end
		end

		local function myhubFlyTeardown()
			if instance then
				pcall(function()
					instance:Destroy()
				end)

				instance = nil
			end

			fn28()
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local child = character and character:FindFirstChild("HumanoidRootPart")
			if not (humanoid and child) then
				return
			end

			if humanoid.FloorMaterial ~= Enum.Material.Air then
				local assemblyLinearVelocity = child.AssemblyLinearVelocity

				pcall(function()
					child.AssemblyLinearVelocity = Vector3.new(0, assemblyLinearVelocity.Y, 0)
				end)

				return
			end

			local function fn29()
				fn28()
				if not child.Parent then
					return
				end
				local assemblyLinearVelocity = child.AssemblyLinearVelocity

				pcall(function()
					child.AssemblyLinearVelocity = Vector3.new(0, assemblyLinearVelocity.Y, 0)
				end)
			end

			connection = humanoid.StateChanged:Connect(function(old, new)
				do
					if new == Enum.HumanoidStateType.Landed or new == Enum.HumanoidStateType.Running or new == Enum.HumanoidStateType.GettingUp then
						fn29()
					end

					return
				end
			end)

			thread = task.delay(6, function()
				thread = nil
				fn28()
			end)
		end

		_G.__myhubFlyTeardown = myhubFlyTeardown

		local function fn29()
			local v25, v26, parent = fn18()
			if not parent then
				return false
			end
			instance = Instance.new("BodyVelocity")
			instance.MaxForce = Vector3.new(1e9, 1e9, 1000000000)
			instance.Velocity = Vector3.zero
			instance.Parent = parent
			return true
		end

		local flag12 = false
		local flag13 = false

		getConnection(RunService.RenderStepped:Connect(function()
			if not tbl6.isDev then
				tbl8.flyEnabled = false
			end

			if not tbl8.flyEnabled then
				if flag12 then
					flag12 = false
					flag13 = true
					myhubFlyTeardown()
				end

				return
			end

			if not flag12 or not (instance and instance.Parent) then
				myhubFlyTeardown()
				if not fn29() then
					return
				end
				flag12 = true
			end

			local E, E, E = fn18()
			if not ((E and currentCamera) and instance) then
				return
			end
			local h = currentCamera.CFrame
			local Q = Vector3.zero
			Q = if UserInputService:IsKeyDown(Enum.KeyCode.W) then Q + h.LookVector else Q
			E = Enum
			Q = if UserInputService:IsKeyDown(Enum.KeyCode.A) then (if UserInputService:IsKeyDown(E.KeyCode.S) then Q - h.LookVector else Q) - h.RightVector else if UserInputService:IsKeyDown(E.KeyCode.S) then Q - h.LookVector else Q
			E = Enum
			Q = if UserInputService:IsKeyDown(Enum.KeyCode.Space) then (if UserInputService:IsKeyDown(E.KeyCode.D) then Q + h.RightVector else Q) + Vector3.yAxis else if UserInputService:IsKeyDown(E.KeyCode.D) then Q + h.RightVector else Q
			Q = if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Q - Vector3.yAxis else Q
			instance.Velocity = (if Q.Magnitude > 0 then Q.Unit else Q) * math.min(tbl8.flySpeed, 900)
		end))

		local cframe = nil
		local part = nil
		local now3 = -math.huge
		local cframe2 = nil
		local now4 = 0
		local tbl10 = {}

		getConnection(RunService.Heartbeat:Connect(function(E)
			local h, h, h = fn18()
			if not (h and h.Parent) then
				cframe, cframe2 = nil, nil
				return
			end

			if h ~= part then
				cframe, part = nil, h
			end

			local Q = os.clock()
			local l = ((Q - now2) < 0.5) or (_G.__myhubFarmTarget ~= nil)

			if (tbl8.flyEnabled and instance) and instance.Parent then
				cframe2 = nil
				tbl10[#tbl10 + 1] = {t = Q, p = h.Position}

				while (#tbl10 > 1) and ((Q - tbl10[1].t) > 2.5) do
					table.remove(tbl10, 1)
				end

				if cframe and not l then
					local B = math.max(20, ((tbl8.flySpeed or 55) * E) * 3)

					if (h.Position - cframe.Position).Magnitude > B then
						now3 = Q

						pcall(function()
							h.CFrame = cframe
							h.AssemblyLinearVelocity = instance.Velocity
						end)

						return
					end
				end

				cframe = h.CFrame
				return
			end

			if flag13 then
				flag13 = false
				E = 0

				if tbl10[1] then
					local B, y = tbl10[1].p, h.Position
					E = Vector3.new(y.X - B.X, 0, y.Z - B.Z).Magnitude
				end

				if (((Q - now3) < 3) or (E > 60)) and not l then
					cframe2, now4 = h.CFrame, Q
				end

				table.clear(tbl10)
			end

			if cframe2 then
				E = l or ((Q - now4) > 3)

				if E then
					cframe2 = nil
				else
					local E = (h.Position - cframe2.Position).Magnitude

					if E > 20 then
						now3 = Q
					end

					pcall(function()
						h.CFrame = cframe2
						h.AssemblyLinearVelocity = Vector3.zero
						h.AssemblyAngularVelocity = Vector3.zero
					end)

					E = now3 >= now4
					local h = (E and ((Q - now3) >= 0.4)) or (not E and ((Q - now4) >= 0.4))

					if h then
						cframe2 = nil
					end
				end
			end

			cframe = nil
		end))

		getConnection(localPlayer.CharacterAdded:Connect(function()
			flag12 = false
			cframe2 = nil
			table.clear(tbl10)
		end))
	end

	local v25 = tbl7.Main:AddLeftGroupbox("Security")

	v25:AddToggle("StreamerMode", {
		Text = "Streamer Mode",
		Default = false,
		Tooltip = "Hide names",
		Callback = function(streamerMode)
			tbl8.streamerMode = streamerMode
		end,
	})

	v25:AddToggle("StaffDetect", {
		Text = "Staff Detection",
		Default = false,
		Tooltip = "Warn on staff join",
		Callback = function(staffDetection)
			tbl8.staffDetect = staffDetection
		end,
	})

	do
		local obj2 = setmetatable({}, { __mode = "k" })
		local obj3 = setmetatable({}, { __mode = "k" })
		local title2 = nil

		local function getChildren()
			local children = {}
			local hui = nil

			if not (pcall(function()
				if type(gethui) == "function" then
					hui = gethui()
				end
			end) and hui) then
				hui = game:GetService("CoreGui")
			end

			for _, name in ipairs({ "PlayerList", "PlayerListMaster", "PlayerListApp", "RobloxGui" }) do
				local child = hui:FindFirstChild(name, true) or hui:FindFirstChild(name)

				if child then
					table.insert(children, child)
				end
			end

			return children
		end

		local function fn28()
			local tbl10 = {}

			for _, player in ipairs(Players:GetPlayers()) do
				tbl10[player.Name] = true

				if player.DisplayName and player.DisplayName ~= "" then
					tbl10[player.DisplayName] = true
				end
			end

			local child = workspace:FindFirstChild("Humanoids")

			if child then
				for _, child2 in ipairs(child:GetChildren()) do
					if not child2:IsA("Model") then
						continue
					end

					for _, descendant in ipairs(child2:GetDescendants()) do
						if (descendant:IsA("TextLabel") or descendant:IsA("TextButton")) and tbl10[descendant.Text] and descendant.Text ~= "DISCORD.GG/WINHUB" then
							if obj2[descendant] == nil then
								obj2[descendant] = descendant.Text
							end

							pcall(function()
								descendant.Text = "DISCORD.GG/WINHUB"
							end)
						end
					end
				end
			end

			for _, child2 in ipairs(getChildren()) do
				for _, descendant in ipairs(child2:GetDescendants()) do
					if (descendant:IsA("TextLabel") or descendant:IsA("TextButton")) and tbl10[descendant.Text] and descendant.Text ~= "DISCORD.GG/WINHUB" then
						if obj3[descendant] == nil then
							obj3[descendant] = descendant.Text
						end

						pcall(function()
							descendant.Text = "DISCORD.GG/WINHUB"
						end)
					end
				end
			end
		end

		local function fn29()
			for k, v26 in pairs(obj2) do
				if k and k.Parent then
					pcall(function()
						k.Text = v26
					end)
				end
			end

			table.clear(obj2)

			for k, v26 in pairs(obj3) do
				if k and k.Parent then
					pcall(function()
						k.Text = v26
					end)
				end
			end

			table.clear(obj3)
		end

		local function fn30(arg)
			do
				local myhubStatsLabel = _G.__myhubStatsLabel
				if not (myhubStatsLabel and myhubStatsLabel.SetText) then
					return
				end

				if arg then
					title2 = title2 or title

					pcall(function()
						myhubStatsLabel:SetText("DISCORD.GG/WINHUB · 0 fps · 0 ms")
					end)
				else
					pcall(function()
						myhubStatsLabel:SetText((title2 or title) .. " · 0 fps · 0 ms")
					end)
				end

				return
			end
		end

		local flag12 = false
		local n = 0

		getConnection(RunService.Heartbeat:Connect(function(E)
			if tbl8.streamerMode then
				if not flag12 then
					flag12 = true
					fn28()
					fn30(true)
					n = 0
				else
					n += E

					if n >= 0.5 then
						n = 0
						fn28()
					end
				end
			elseif flag12 then
				flag12 = false
				fn29()
				fn30(false)
			end
		end))

		_G.__myhubStreamerTeardown = function()
			fn29()
			fn30(false)
		end
	end

	do
		local color = Color3.fromRGB(0, 220, 60)
		local color2 = Color3.fromRGB(240, 40, 40)
		local instances = {}

		local function myhubOwnershipTeardown()
			for k, instance in pairs(instances) do
				if instance and instance.Parent then
					pcall(function()
						instance:Destroy()
					end)
				end

				instances[k] = nil
			end
		end

		_G.__myhubOwnershipTeardown = myhubOwnershipTeardown
		local n = 0

		getConnection(RunService.Heartbeat:Connect(function(E)
			if not tbl8.showOwnership then
				if next(instances) then
					myhubOwnershipTeardown()
				end

				return
			end

			n += E
			if n < 0.15 then
				return
			end
			n = 0
			E = workspace:FindFirstChild("Humanoids")
			if not E then
				return
			end
			local h = {}

			for Q, l in ipairs(E:GetDescendants()) do
				if l:IsA("Humanoid") and (l.Health > 0) then
					local E = l.Parent

					if (E and (E:IsA("Model"))) and (E ~= localPlayer.Character) then
						local B = l.RootPart or (E:FindFirstChild("HumanoidRootPart"))

						if B and (B:IsA("BasePart")) then
							h[E] = true
							Q = nil

							if B.Anchored then
								Q = false
							else
								local l, y = pcall(function()
									return B.ReceiveAge
								end)

								Q = (l and (type(y) == "number")) and (y == 0)
							end

							local l = instances[E]

							if not l or not l.Parent then
								l = Instance.new("Highlight")
								l.Name = "MyHubOwnershipHL"
								l.Adornee = E
								l.FillTransparency = 0.6
								l.OutlineTransparency = 0
								l.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
								l.Parent = E
								instances[E] = l
							end

							local E = (Q and color) or color2

							if l.FillColor ~= E then
								l.FillColor = E
							end

							if l.OutlineColor ~= E then
								l.OutlineColor = E
							end
						end
					end
				end
			end

			for E, Q in pairs(instances) do
				if not h[E] or not E.Parent then
					if Q and Q.Parent then
						pcall(function()
							Q:Destroy()
						end)
					end

					instances[E] = nil
				end
			end
		end))
	end

	do
		local tbl10 = { 1200769 }
		local tbl11 = { "admin", "moderator", "developer", "staff", " dev ", "mod " }
		local obj2 = setmetatable({}, { __mode = "k" })

		local function fn28(player, arg)
			if obj2[player] then
				return
			end
			obj2[player] = true

			lib:Notify({
				Title = "STAFF DETECTED",
				Description = string.format("%s (@%s) — %s", player.DisplayName or player.Name, player.Name, arg),
				Time = 12,
			})
		end

		local function fn29(player)
			if not tbl8.staffDetect or player == localPlayer then
				return
			end

			for _, v26 in ipairs(tbl10) do
				local ok2, result2 = pcall(function()
					return player:IsInGroup(v26)
				end)

				if ok2 and result2 then
					fn28(player, "Group " .. v26)
					return
				end
			end

			local name = player.Name:lower()
			local displayName = (player.DisplayName or ""):lower()

			for _, v26 in ipairs(tbl11) do
				if name:find(v26, 1, true) or displayName:find(v26, 1, true) then
					fn28(player, "Name keyword: " .. v26)
					return
				end
			end
		end

		getConnection(Players.PlayerAdded:Connect(function(player)
			task.wait(1)
			fn29(player)
		end))

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				task.wait(2)

				if tbl8.staffDetect then
					for _, player in ipairs(Players:GetPlayers()) do
						if player ~= localPlayer and not obj2[player] then
							fn29(player)
						end
					end
				end
			end
		end)
	end

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local v26 = nil
	local toServer = nil

	local ok2, result2 = pcall(function()
		local signalEvent = ReplicatedStorage:WaitForChild("Communication", 10):WaitForChild("ServerAndClient", 10):WaitForChild("Signals", 10):WaitForChild("SignalEvent", 10)
		return require(signalEvent)
	end)

	if ok2 and type(result2) == "table" and type(result2.ToServer) == "function" then
		v26 = result2
		toServer = result2.ToServer
	end

	_G.__myhub_getStyle = function()
		if type(tbl8.killAuraWeapon) == "string" and tbl8.killAuraWeapon ~= "" and tbl8.killAuraWeapon ~= "Auto" then
			_G.__myhub_styleResolved = true
			return tbl8.killAuraWeapon
		end
		local service2 = game:GetService("ReplicatedStorage")
		local localPlayer2 = Players.LocalPlayer
		if not localPlayer2 then
			_G.__myhub_styleResolved = false
			return "Combat"
		end

		local ok3, result3 = pcall(function()
			local tbl10 = {}

			local ok3, result3 = pcall(function()
				return require(service2.CAM.Global.Combat_presets)
			end)

			if ok3 and type(result3) == "table" and type(result3.Presets) == "table" then


				for k in pairs(result3.Presets) do
					tbl10[k] = true
				end
			end

			local child = service2:FindFirstChild("Player_Service") and service2.Player_Service:FindFirstChild("Data") and service2.Player_Service.Data:FindFirstChild(localPlayer2.Name)
			if not child then
				return "Combat"
			end
			local slot1 = child:FindFirstChild("slots") and child.slots:FindFirstChild("Slot1")
			if not slot1 then
				return "Combat"
			end
			local child2 = slot1:FindFirstChild("Inventory")
			local toolbar = child2 and child2:FindFirstChild("Toolbar")
			local myhubEquippedSlots = { "One", "Two", "Three", [4] = "Four", [5] = "Five" }
			local myhubEquippedSlot = _G.__myhubEquippedSlot
			local myhubEquippedSlot2 = type(myhubEquippedSlot) == "number" and myhubEquippedSlots[myhubEquippedSlot] or "One"
			local value = toolbar and toolbar:FindFirstChild(myhubEquippedSlot2) and toolbar[myhubEquippedSlot2].Value
			if not value or value == 0 then
				return "Combat"
			end
			local child3 = child2:FindFirstChild("Inventory")
			if not child3 then
				return "Combat"
			end

			for _, child4 in ipairs(child3:GetChildren()) do
				local id = child4:FindFirstChild("Id")
				if not (id and id.Value == value) then
					continue
				end

				if tbl10[child4.Name] then
					_G.__myhub_styleResolved = true
					return child4.Name
				end
				local items = service2:FindFirstChild("Items")
				if not items then
					return "Combat"
				end

				for _, child5 in ipairs(items:GetChildren()) do
					local child6 = child5:FindFirstChild(child4.Name)
					if not (child6 and child6:IsA("ModuleScript")) then
						continue
					end
					local ok4, result4 = pcall(require, child6)
					if not (ok4 and type(result4) == "table") then
						continue
					end

					if type(result4.CombatPreset) == "string" then
						_G.__myhub_styleResolved = true
						return result4.CombatPreset
					end
					local category = result4.Category
					if type(category) == "string" and tbl10[category] then
						_G.__myhub_styleResolved = true
						return category
					end

					if category == "Katana" then
						_G.__myhub_styleResolved = true
						return "Regular Katana"
					end
				end

				return "Combat"
			end

			return "Combat"
		end)

		if ok3 and type(result3) == "string" and result3 ~= "Combat" then
			_G.__myhub_styleResolved = true
			return result3
		end
		_G.__myhub_styleResolved = false
		return "Combat"
	end

	local tbl10 = {
		"bandit",
		"raider",
		"captain",
		"reaper",
		"grove",
		"raid",
		"demon",
		"hostile",
		"enemy",
		"boss",
		"subordinate",
		"guard",
		"grunt",
		"minion",
		"elite",
		"acolyte",
		"cultist",
		"thug",
		"brigand",
		"outlaw",
		"assassin",
		"mercenary",
		"goon",
		"lackey",
		"henchman",
		"trainee",
		"trainer",
	}

	local fn28 = nil

	local function fn29(arg)
		if fn28 and fn28(arg) then
			return false
		end
		local name = arg.Name:lower()

		if not name:find("*", 1, true) then
			for _, v27 in ipairs(tbl10) do
				if name:find(v27, 1, true) then
					return true
				end
			end

			return false
		end

		do
			return true
		end
	end

	do
		local v27 = tbl7.Farm:AddRightGroupbox("Mob Farm")

		local function getNames()
			local tbl11 = {}
			local names = {}
			local child = workspace:FindFirstChild("Humanoids")

			if child then
				for _, descendant in ipairs(child:GetDescendants()) do
					if descendant:IsA("Humanoid") and descendant.Health > 0 then
						local parent = descendant.Parent

						if parent and parent:IsA("Model") and fn29(parent) and not tbl11[parent.Name] then
							tbl11[parent.Name] = true
							table.insert(names, parent.Name)
						end
					end
				end
			end

			table.sort(names)
			table.insert(names, 1, "All")
			return names
		end

		local FarmMobTarget = v27:AddDropdown("FarmMobTarget", {
			Text = "Target Mobs",
			Values = getNames(),
			AllowNull = true,
			Multi = true,
			Default = {},
			Callback = function(targetMobs)
				tbl8.farmMobTarget = targetMobs or {}
			end,
		})

		v27:AddButton({
			Text = "Refresh Mobs",
			Func = function()
				pcall(function()
					FarmMobTarget:SetValues(getNames())
				end)
			end,
		})

		v27:AddToggle("FarmMobs", {
			Text = "Farm Mobs",
			Default = false,
			Tooltip = "Attach to target",
			Callback = function(enabled2)
				tbl8.farmMob = enabled2
			end,
		})
	end

	fn28 = function(instance)
		if not instance or Players:GetPlayerFromCharacter(instance) then
			return false
		end

		if not instance:FindFirstChildOfClass("Humanoid") then
			return false
		end
		local parent = instance.Parent
		if not parent then
			return false
		end
		local attribute = parent:GetAttribute("Icon")

		if type(attribute) ~= "string" or attribute == "" then
			return false
		end

		local name = instance.Name:lower()
		if name:find("trainee", 1, true) or name:find("trainer", 1, true) then
			return false
		end

		if instance:GetAttribute("ScaleDamage") == nil and instance:GetAttribute("ScaleBlockRemoval") == nil then
			return false
		end
		return true
	end

	local tbl11 = {
		["Zuko"] = Vector3.new(-281.35, 1226.7, -1022.49),
		Gyutai = Vector3.new(-266.14, 1045.73, -1138.46),
		Datai = Vector3.new(-163.24, 1045.5, -1130.36),
		["Akazo"] = Vector3.new(-1130.37, 1382.79, -1736.68),
		["Tengai"] = Vector3.new(-132.1, 1351.5, -2618.27),
		Domae = Vector3.new(-284.99, 1353, -3453.21),
		["Kaiden"] = Vector3.new(577.35, 1148.93, -1313.47),
		["Mother Bear"] = Vector3.new(536, 1123.5, -1033.63),
		Hoyuzo = Vector3.new(743.12, 1003.5, -1406.68),
		Zentaro = Vector3.new(1334.17, 823.5, -1011.8),
		Gyorei = Vector3.new(2575.44, 1091.5, -735.36),
		["Yahari"] = Vector3.new(823.22, 1021.7, -632.14),
		Sumari = Vector3.new(397.36, 1020.5, -612.3),
		Giyen = Vector3.new(388.28, 1020.5, -82.45),
		Reaper = Vector3.new(92.55, 1045.5, -571.71),
		Saneri = Vector3.new(-385.06, 1095.84, -425.89),
		Shinora = Vector3.new(-455.59, 967, 3.67),
		Enru = Vector3.new(817.04, 798.37, 543.15),
		Rengu = Vector3.new(-718.67, 967.5, 881.26),
		Nezura = Vector3.new(-1461.36, 278.45, 935.53),
		Fujiko = Vector3.new(-2466.55, 40.34, 1118.44),
		Obari = Vector3.new(770.52, 1121, -1047.04),
		["Yeti Demon"] = Vector3.new(-1381.88, -32.83, 502.63),
		["Flame Trainee"] = Vector3.new(-1128.9, 1029.05, 994.42),
		["Insect Trainee"] = Vector3.new(-1395.64, 261.5, 69.22),
		["Reaper Trainee Kuzan"] = Vector3.new(-1219.26, 1373.62, -3034.39),
		["Serpent Trainee"] = Vector3.new(-271.38, 1292, -1535.71),
		["Soryu Trainee Goki"] = Vector3.new(-426.99, 288.81, 543.27),
		["Sound Trainee"] = Vector3.new(192.5, 1349, -2581.31),
		["Stone Trainee"] = Vector3.new(2685.18, 1073.6, -568.75),
		["Tai Chi Trainee Suzume"] = Vector3.new(2360.47, 601.99, -642.31),
		["Thunder Trainee"] = Vector3.new(2425.51, 1073.63, -556.79),
		["Water Trainee Sabito"] = Vector3.new(815.35, 1018.88, 101.6),
		["Wind Trainee"] = Vector3.new(-941.57, 1381, -2635.57),
		["Hoyuzo Subordinate"] = Vector3.new(533, 1001, -1357),
		["Kaiden Subordinate"] = Vector3.new(585.71, 1146.55, -1314.89),
	}

	local function fn30(instance)
		for i = 1, 4 do
			if not instance then
				break
			end
			local attribute = instance:GetAttribute("DropOwnerUserId")
			if typeof(attribute) == "number" then
				return attribute == localPlayer.UserId
			end
			instance = instance.Parent
		end

		return true
	end

	do
		local v27 = tbl7.Farm:AddRightGroupbox("Boss Farm")

		local function fn31(arg)
			return arg:find(" Trainee") ~= nil or arg:find(" Subordinate") ~= nil
		end

		local function fn32()
			local tbl12 = {}

			for k in pairs(tbl11) do
				if not fn31(k) then
					table.insert(tbl12, k)
				end
			end

			table.sort(tbl12)
			table.insert(tbl12, 1, "All")
			return tbl12
		end

		v27:AddDropdown("FarmBossTarget", {
			Text = "Target Bosses",
			Values = fn32(),
			AllowNull = true,
			Multi = true,
			Default = {},
			Callback = function(targetBosses)
				tbl8.farmBossTarget = targetBosses or {}
			end,
		})

		v27:AddToggle("FarmBoss", {
			Text = "Farm Boss",
			Default = false,
			Tooltip = "Warp to boss",
			Callback = function(farmBoss)
				tbl8.farmBoss = farmBoss
			end,
		})

		if not tbl6.isPremium then
			fn19(v27)
		end
	end

	local v27 = tbl7.Farm:AddRightGroupbox("Muzan/Crow Boss Hunt")
	local Idle = v27:AddLabel("Idle")

	v27:AddToggle("HuntTrack", {
		Text = "Auto Boss Hunt",
		Default = false,
		Tooltip = "Auto-accept + hunt bosses",
		Callback = function(autoBossHunt)
			tbl8.huntTrack = autoBossHunt
		end,
	})

	if not tbl6.isPremium then
		fn19(v27)
	end

	local FarmYeti = tbl7.Farm:AddRightGroupbox("Yeti Farm"):AddToggle("FarmYeti", {
		Text = "Farm Yeti",
		Default = false,
		Tooltip = "Summon + kill yeti",
		Callback = function(farmYeti)
			tbl8.farmYeti = farmYeti
		end,
	})

	if not tbl6.isPremium then
		fn16(FarmYeti)
	end

	local v28 = tbl7.Farm:AddLeftGroupbox("Auto Farm Config")

	local apEnabled = v28:AddToggle("apEnabled", {
		Text = "Auto Perfect Block",
		Default = false,
		Tooltip = "Auto parry incoming hits",
		Callback = function(autoPerfectBlock)
			if type(_G.__myhubApHandler) == "function" then
				pcall(_G.__myhubApHandler, autoPerfectBlock)
			end
		end,
	})

	if not tbl6.isPremium then
		fn16(apEnabled)
	end

	v28:AddToggle("KillAura", {
		Text = "Kill Aura",
		Default = false,
		Tooltip = "Auto attack target",
		Callback = function(killAura)
			tbl8.killAura = killAura
			_G.__myhubKillAura = killAura
		end,
	})

	local fn31

	do
		local tbl12 = {
			Enum.KeyCode.One,
			Enum.KeyCode.Two,
			Enum.KeyCode.Three,
			Enum.KeyCode.Four,
			Enum.KeyCode.Five,
		}

		local tbl13 = { "One", "Two", "Three", "Four", "Five" }
		local tbl14 = {}

		local function fn32(arg)
			for _, descendant in ipairs(ReplicatedStorage.Items:GetDescendants()) do
				if not (descendant.Name == arg and descendant:IsA("ModuleScript")) then
					continue
				end

				if type(decompile) ~= "function" then
					return nil
				end
				local ok3, result3 = pcall(decompile, descendant)

				if ok3 and type(result3) == "string" then
					local n = tonumber(result3:match("%[\"Additional Damage\"%]%s*=%s*([%d%.]+)")) or 0
					local n10 = tonumber(result3:match("%[\"Additional Damage Factor\"%]%s*=%s*([%d%.]+)")) or 0
					if n == 0 and n10 == 0 then
						return nil
					end
					return n + n10 * 100
				end

				return nil
			end

			return nil
		end

		local tbl15 = { at = 0, slot = nil }

		local function getSlot()
			if tick() - tbl15.at < 4 then
				return tbl15.slot
			end
			local v29 = nil
			local n = -1

			local ok3 = pcall(function()
				local instance = ReplicatedStorage.Player_Service.Data[localPlayer.Name]
				local slot = instance.slots["Slot" .. (instance:FindFirstChild("slotEquipped") and instance.slotEquipped.Value or 1)]
				local tbl16 = {}

				for _, child in ipairs(slot.Inventory.Inventory:GetChildren()) do
					local id = child:FindFirstChild("Id")

					if id then
						tbl16[id.Value] = child.Name
					end
				end

				for i, name in ipairs(tbl13) do
					local child = slot.Inventory.Toolbar:FindFirstChild(name)
					if not (child and child.Value and child.Value ~= "") then
						continue
					end
					local v30 = tbl16[child.Value]

					if v30 then
						local str4 = "id:" .. tostring(child.Value)
						local flag12 = tbl14[str4]

						if flag12 == nil then
							flag12 = fn32(v30) or false
							tbl14[str4] = flag12
						end

						if flag12 and flag12 > n then
							v29 = i
							n = flag12
						end
					end
				end
			end)

			tbl15.at = tick()
			tbl15.slot = ok3 and v29 or nil
			return tbl15.slot
		end

		local function fn33()
			local farmHotbarSlot = tbl8.farmHotbarSlot
			if farmHotbarSlot == "Best" then
				return getSlot() or 1
			end

			if type(farmHotbarSlot) == "number" then
				return farmHotbarSlot
			end

			return tonumber(farmHotbarSlot) or 1
		end

		fn31 = function()
			local character = localPlayer.Character
			if not character then
				return false
			end
			local toolAccessories = character:FindFirstChild("Tool_Accessories")
			if not toolAccessories then
				return false
			end
			return #toolAccessories:GetChildren() > 1
		end

		local function fn34()
			local character = localPlayer.Character
			if not character then
				return ""
			end
			local toolAccessories = character:FindFirstChild("Tool_Accessories")
			if not toolAccessories then
				return ""
			end
			local names = {}

			for _, child in ipairs(toolAccessories:GetChildren()) do
				table.insert(names, child.Name)
			end

			table.sort(names)
			return table.concat(names, "|")
		end

		local v29 = nil

		local function fn35()
			if v29 then
				return v29
			end
			local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
			local signalEvent = ReplicatedStorage2:FindFirstChild("Communication") and ReplicatedStorage2.Communication:FindFirstChild("ServerAndClient") and ReplicatedStorage2.Communication.ServerAndClient:FindFirstChild("Signals") and ReplicatedStorage2.Communication.ServerAndClient.Signals:FindFirstChild("SignalEvent")
			if not signalEvent then
				return nil
			end
			local ok3, result3 = pcall(require, signalEvent)
			if ok3 and type(result3) == "table" and type(result3.ToServer) == "function" then
				v29 = result3
				return result3
			end
			return nil
		end

		local function myhubFarmEquip(value)
			if value == "Best" then
				value = fn33()
			end

			if not tbl12[value] then
				return
			end
			local itemsConfig = localPlayer:FindFirstChild("Items_Config")
			local equipped = itemsConfig and itemsConfig:FindFirstChild("Equipped")

			if equipped then
				pcall(function()
					equipped.Value = value
				end)
			end

			local v30 = fn35()

			if v30 then
				pcall(function()
					v30.ToServer("Item_Equip", value)
				end)
			end

			_G.__myhubEquippedSlot = value
			_G.__myhubLastFarmPressAt = tick()

			task.spawn(function()
				task.wait(0.4)
				_G.__myhubEquippedFingerprint = fn34()
			end)
		end

		_G.__myhubFarmEquip = myhubFarmEquip

		local function getFarmMob()
			return tbl8.farmMob or tbl8.farmBoss or tbl8.farmPlayer or tbl8.farmYeti or tbl8.autoFarmCache or tbl8.autoDungeon
		end

		local function getOk4(arg)
			local v30 = ({ [1] = "One", [2] = "Two", [3] = "Three", [4] = "Four", [5] = "Five" })[arg]
			if not v30 then
				return nil
			end

			local ok3, result3 = pcall(function()
				local instance = game:GetService("ReplicatedStorage").Player_Service.Data[localPlayer.Name]
				local slot = instance.slots["Slot" .. (instance:FindFirstChild("slotEquipped") and instance.slotEquipped.Value or 1)]
				local value = slot.Inventory.Toolbar[v30].Value
				if not value or value == 0 or value == "" then
					return nil
				end

				for _, child in ipairs(slot.Inventory.Inventory:GetChildren()) do
					local id = child:FindFirstChild("Id")
					if id and id.Value == value then
						return child.Name
					end
				end

				return nil
			end)

			return ok3 and result3 or nil
		end

		local function fn36(arg)
			if getOk4(arg) == "Combat" then
				return _G.__myhubEquippedSlot == arg
			end

			if not fn31() then
				return false
			end
			return _G.__myhubEquippedSlot == arg
		end

		v28:AddDropdown("FarmHotbarSlot", {
			Text = "Weapon Slot",
			Values = { "Best", "1", "2", "3", "4", "5" },
			Default = tostring(tbl8.farmHotbarSlot or "Best"),
			Tooltip = "Auto-equip while farming",
			Callback = function(weaponSlot)
				if weaponSlot == "Best" then
					tbl8.farmHotbarSlot = "Best"
				else
					tbl8.farmHotbarSlot = tonumber(weaponSlot) or 1
				end

				if getFarmMob() then
					myhubFarmEquip(fn33())
				end
			end,
		})

		local function fn37()
			if _G.__myhubEquipPressBusy then
				return
			end
			_G.__myhubEquipPressBusy = true

			task.spawn(function()
				local deadline = tick() + 8

				while tick() < deadline do
					if getFarmMob() then
						local v30 = fn33()

						if not fn36(v30) then
							myhubFarmEquip(v30)
							task.wait(0.9)
							continue
						end
					end

					break
				end

				task.wait(0.5)
				_G.__myhubEquipPressBusy = false
			end)
		end

		task.spawn(function()
			task.wait(1)
			local farmMob = getFarmMob()

			if farmMob then
				fn37()
			end

			while _G.MyHubSession == myHubSession do
				local farmMob2 = getFarmMob()

				if farmMob2 and not farmMob then
					fn37()
				end

				task.wait(0.3)
				farmMob = farmMob2
			end
		end)

		getConnection(localPlayer.CharacterAdded:Connect(function(E)
			_G.__myhubEquippedSlot = nil
			_G.__myhubEquippedFingerprint = ""
			tbl15.at = 0

			task.spawn(function()
				E:WaitForChild("Tool_Accessories", 5)
				local E, h = (tick()), ""

				while (tick() - E) < 0.3 do
					task.wait(0.05)
					local Q = fn34()

					if Q ~= h then
						h, E = Q, (tick())
					end
				end

				if getFarmMob() then
					fn37()
				end
			end)
		end))

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				task.wait(0.5)
				if not getFarmMob() then
					continue
				end

				if _G.__myhubEquipPressBusy then
					continue
				end

				if tick() - (_G.__myhubLastFarmPressAt or 0) < 1 then
					continue
				end
				local myhubEquippedFingerprint = _G.__myhubEquippedFingerprint

				if myhubEquippedFingerprint and myhubEquippedFingerprint ~= "" then
					if fn34() ~= myhubEquippedFingerprint then
						_G.__myhubEquippedSlot = nil
						_G.__myhubEquippedFingerprint = ""
						fn37()
					end
				end
			end
		end)
	end

	v28:AddDropdown("FarmPosition", {
		Text = "Position",
		Values = { "Above", "Below", "In Front", "Behind" },
		Default = tbl8.farmPosition,
		Callback = function(position)
			tbl8.farmPosition = position
		end,
	})

	v28:AddSlider("FarmOffX", {
		Text = "X Offset",
		Default = tbl8.farmOffX,
		Min = -20,
		Max = 20,
		Rounding = 1,
		Suffix = "",
		Callback = function(xOffset)
			tbl8.farmOffX = xOffset
		end,
	})

	v28:AddSlider("FarmOffY", {
		Text = "Y Offset",
		Default = tbl8.farmOffY,
		Min = -20,
		Max = 20,
		Rounding = 1,
		Suffix = "",
		Callback = function(yOffset)
			tbl8.farmOffY = yOffset
		end,
	})

	v28:AddSlider("FarmOffZ", {
		Text = "Z Offset",
		Default = tbl8.farmOffZ,
		Min = -20,
		Max = 20,
		Rounding = 1,
		Suffix = "",
		Callback = function(zOffset)
			tbl8.farmOffZ = zOffset
		end,
	})

	v28:AddSlider("FarmDistance", {
		Text = "Distance",
		Default = tbl8.farmDistance,
		Min = 1,
		Max = 50,
		Rounding = 0,
		Suffix = "",
		Callback = function(distance)
			tbl8.farmDistance = distance
		end,
	})

	v28:AddToggle("FarmInstaKill", {
		Text = "Insta Kill",
		Default = tbl8.farmInstaKill,
		Tooltip = "One-shot low HP mobs",
		Callback = function(instaKill)
			tbl8.farmInstaKill = instaKill
		end,
	})

	v28:AddSlider("FarmInstaThresh", {
		Text = "Insta Kill Threshold",
		Default = tbl8.farmInstaThresh,
		Min = 1,
		Max = 100,
		Rounding = 0,
		Suffix = "%",
		Callback = function(instaKillThreshold)
			tbl8.farmInstaThresh = instaKillThreshold
		end,
	})

	pcall(function()
		v28:AddDivider()
	end)

	do
		local tbl12 = { "Z", "X", "C", "V", "B", "N", "K", "L", "J" }

		v28:AddToggle("UseSkill", {
			Text = "Auto Skill",
			Default = false,
			Tooltip = "Cycle equipped skills",
			Callback = function(autoSkill)
				tbl8.useSkill = autoSkill
			end,
		})

		v28:AddDropdown("UseSkillKeys", {
			Text = "Skill Keys to Press",
			Values = tbl12,
			Multi = true,
			Default = {},
			AllowNull = true,
			Tooltip = "Keys tapped in order",
			Callback = function(skillKeysToPress)
				do
					tbl8.useSkillKeys = skillKeysToPress or {}
					return
				end
			end,
		})

		v28:AddSlider("UseSkillDelay", {
			Text = "Seconds Between Skills",
			Default = tbl8.useSkillDelay,
			Min = 0,
			Max = 15,
			Rounding = 1,
			Suffix = "s",
			Callback = function(secondsBetweenSkills)
				tbl8.useSkillDelay = secondsBetweenSkills
			end,
		})

		v28:AddToggle("HoldSkills", {
			Text = "Hold Skills",
			Default = false,
			Tooltip = "Hold selected skill keys",
			Callback = function(holdSkills)
				tbl8.holdSkills = holdSkills
			end,
		})

		v28:AddDropdown("HoldSkillKeys", {
			Text = "Skills to Hold Down",
			Values = tbl12,
			Multi = true,
			Default = {},
			AllowNull = true,
			Tooltip = "Keys held down in order",
			Callback = function(skillsToHoldDown)
				tbl8.holdSkillKeys = skillsToHoldDown or {}
			end,
		})

		v28:AddSlider("HoldSkillsDuration", {
			Text = "Hold Duration",
			Default = tbl8.holdSkillsDuration,
			Min = 0,
			Max = 15,
			Rounding = 1,
			Suffix = "s",
			Callback = function(holdDuration)
				tbl8.holdSkillsDuration = holdDuration
			end,
		})

		local function fn32()
			if _G.__myhubLootDwell then
				return false
			end
			local myhubFarmTarget = _G.__myhubFarmTarget or _G.__myhubDungeonTarget or _G.__myhubPathTarget
			if not myhubFarmTarget or not myhubFarmTarget.Parent then
				return false
			end
			local parent = myhubFarmTarget.Parent
			local humanoid = nil

			for i = 1, 3 do
				if parent then
					humanoid = parent:FindFirstChildOfClass("Humanoid")
					if not humanoid then
						parent = parent.Parent
						continue
					end
				end

				break
			end

			if humanoid and humanoid.Health <= 0 then
				return false
			end
			return true
		end

		local tbl13 = { Z = 1, X = 2, C = 3, V = 4, B = 5 }

		local function getOk4()
			local ok3, result3 = pcall(function()
				local v29 = ReplicatedStorage.Player_Service.Data[localPlayer.Name]
				local child = v29.slots:FindFirstChild("Slot" .. v29.slotEquipped.Value)
				if not (child and child.Powers) then
					return {}
				end
				local names = {}

				for _, name in ipairs({ "Breathing", "DemonArt", "FightingStyle" }) do
					local child2 = child.Powers:FindFirstChild(name)
					if not (child2 and type(child2.Value) == "string" and child2.Value ~= "") then
						continue
					end
					local value = child2.Value

					if name == "Breathing" then
						value = child2.Value .. " Breathing"
					end

					local child3 = ReplicatedStorage.Skills:FindFirstChild(value) or ReplicatedStorage.Skills:FindFirstChild(child2.Value)

					if child3 then
						for _, child4 in ipairs(child3:GetChildren()) do
							if child4:IsA("Folder") or child4:IsA("Configuration") then
								table.insert(names, child4.Name)
							end
						end
					end
				end

				return names
			end)

			return ok3 and result3 or {}
		end

		local v29 = nil

		local function fn33()
			if v29 then
				return v29
			end
			local ok3, result3 = pcall(require, ReplicatedStorage.Communication.ServerAndClient.Signals.SignalEvent)

			if ok3 then
				v29 = result3
			end

			return v29
		end

		local function fn34(arg)
			local v30 = fn33()
			if not (v30 and v30.ToServer) then
				return
			end
			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart then
				return
			end
			local position = humanoidRootPart.Position

			pcall(function()
				v30.ToServer("server_skill_controller_signaler", arg, "Hold", position)
			end)

			task.wait(0.05)
			position = (character and character:FindFirstChild("HumanoidRootPart") or humanoidRootPart).Position

			pcall(function()
				v30.ToServer("server_skill_controller_signaler", arg, "UnHold", position, nil)
			end)
		end

		local function fn35(arg, arg2)
			if _G.MyHubSession ~= myHubSession then
				return
			end
			local v30 = fn33()
			if not (v30 and v30.ToServer) then
				return
			end
			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart then
				return
			end

			pcall(function()
				do
					v30.ToServer("server_skill_controller_signaler", arg, "Hold", humanoidRootPart.Position)
					return
				end
			end)

			local deadline = tick() + arg2

			while tick() < deadline and tbl8.holdSkills and fn32() and _G.MyHubSession == myHubSession do
				task.wait(0.1)
			end

			local child = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") or humanoidRootPart

			pcall(function()
				v30.ToServer("server_skill_controller_signaler", arg, "UnHold", child.Position, nil)
			end)
		end

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				local useSkillKeys = tbl8.useSkillKeys
				local flag12 = type(useSkillKeys) == "table" and next(useSkillKeys) ~= nil
				if not tbl8.useSkill or not flag12 or not fn32() then
					task.wait(0.4)
					continue
				end
				local ok3 = getOk4()
				if #ok3 == 0 then
					task.wait(0.5)
					continue
				end

				for _, v30 in ipairs(tbl12) do
					if not (tbl8.useSkill and fn32() and _G.MyHubSession == myHubSession) then
						break
					end

					if not useSkillKeys[v30] then
						continue
					end
					local v31 = tbl13[v30]
					local v32 = v31 and ok3[v31]

					if v32 then
						fn34(v32)
					end

					local delay = tonumber(tbl8.useSkillDelay) or 0

					if delay > 0 then
						task.wait(delay)
					else
						task.wait()
					end
				end
			end
		end)

		local componentsHolder = localPlayer.PlayerGui:FindFirstChild("ComponentsHolder")
		local skillsHolder = componentsHolder and componentsHolder:FindFirstChild("BottomHolder") and componentsHolder.BottomHolder:FindFirstChild("SkillsHolder")

		if skillsHolder then
			for _, descendant in ipairs(skillsHolder:GetDescendants()) do
				if descendant.Name == "MyHubCd" then
					pcall(function()
						descendant:Destroy()
					end)
				end
			end
		end

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				local holdSkillKeys = tbl8.holdSkillKeys
				local flag12 = type(holdSkillKeys) == "table" and next(holdSkillKeys) ~= nil
				if not tbl8.holdSkills or not flag12 or not fn32() then
					task.wait(0.4)
					continue
				end
				local ok3 = getOk4()
				if #ok3 == 0 then
					task.wait(0.5)
					continue
				end

				for _, v30 in ipairs(tbl12) do
					if not (tbl8.holdSkills and fn32() and _G.MyHubSession == myHubSession) then
						break
					end

					if not holdSkillKeys[v30] then
						continue
					end
					local v31 = tbl13[v30]
					v31 = v31 and ok3[v31]

					if v31 then
						local n = math.max(0.05, tonumber(tbl8.holdSkillsDuration) or 0)
						fn35(v31, n)
					end

					task.wait()
				end
			end
		end)
	end

	do
		local v29 = tbl7.Farm:AddRightGroupbox("Player Farm")

		local function getNames()
			local names = {}

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= localPlayer then
					table.insert(names, player.Name)
				end
			end

			table.sort(names)
			return names
		end

		local FarmPlayerTarget = v29:AddDropdown("FarmPlayerTarget", {
			Text = "Target Player",
			Values = getNames(),
			AllowNull = true,
			Default = nil,
			Callback = function(targetPlayer)
				tbl8.farmPlayerTarget = targetPlayer ~= "" and targetPlayer or nil
			end,
		})

		v29:AddButton({
			Text = "Refresh Players",
			Func = function()
				pcall(function()
					do
						FarmPlayerTarget:SetValues(getNames())
						return
					end
				end)
			end,
		})

		v29:AddToggle("FarmPlayer", {
			Text = "Farm Player",
			Default = false,
			Tooltip = "Attach to target",
			Callback = function(farmPlayer)
				tbl8.farmPlayer = farmPlayer
			end,
		})

		getConnection(Players.PlayerAdded:Connect(function()
			task.defer(function()
				pcall(function()
					FarmPlayerTarget:SetValues(getNames())
				end)
			end)
		end))

		getConnection(Players.PlayerRemoving:Connect(function()
			task.defer(function()
				pcall(function()
					FarmPlayerTarget:SetValues(getNames())
				end)
			end)
		end))
	end

	local v29 = tbl7.Farm:AddRightGroupbox("Auto Fishing")

	do
		local v30 = tbl7.Farm:AddRightGroupbox("Snow Mound")

		local AutoFarmSnowMounds = v30:AddToggle("AutoFarmSnowMounds", {
			Text = "Auto Farm Snow Mounds",
			Default = false,
			Tooltip = "Dig snow mounds",
			Callback = function(autoFarmSnowMounds)
				tbl8.autoFarmSnowMounds = autoFarmSnowMounds
			end,
		})

		local ServerHopMounds = v30:AddToggle("ServerHopMounds", {
			Text = "Server Hop",
			Default = false,
			Tooltip = "Hop to a fresh non-full server after each sweep",
			Callback = function(serverHop)
				tbl8.serverHopMounds = serverHop
			end,
		})

		if not tbl6.isPremium then
			fn16(AutoFarmSnowMounds)
			fn16(ServerHopMounds)
		end
	end

	do
		local function getOk4()
			local ok3, result3 = pcall(function()
				return ReplicatedStorage.Player_Service.Data[localPlayer.Name].slots.Slot1.Inventory.Inventory:FindFirstChild("Shovel") ~= nil
			end)

			return ok3 and result3
		end

		local HttpService2 = game:GetService("HttpService")
		local TeleportService = game:GetService("TeleportService")
		local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
		local v30 = nil

		local ok3, result3 = pcall(function()
			return require(ReplicatedStorage2.Communication.ServerAndClient.Signals.SignalFunction)
		end)

		if ok3 then
			v30 = result3
		end

		local function fn32(arg)
			local request_ = request or http_request or syn and syn.request or fluxus and fluxus.request
			if not request_ then
				return nil, "executor lacks http"
			end
			local ok4, statusCode = pcall(request_, { Url = arg, Method = "GET" })
			if not ok4 then
				return nil, tostring(statusCode):sub(1, 200)
			end

			if not statusCode or statusCode.StatusCode ~= 200 then
				local v31 = tostring
				statusCode = statusCode and statusCode.StatusCode
				return nil, "status " .. v31(statusCode)
			end

			return statusCode.Body
		end

		local function fn33(placeId, nextPageCursor)
			local v31, v32 = fn32("https://games.roblox.com/v1/games/" .. tostring(placeId) .. "/servers/Public?sortOrder=Desc&limit=100" .. (nextPageCursor and "&cursor=" .. nextPageCursor or ""))
			if not v31 then
				return nil, v32
			end

			local ok4, result4 = pcall(function()
				return HttpService2:JSONDecode(v31)
			end)

			if not ok4 or type(result4) ~= "table" then
				return nil, "json parse"
			end
			return result4
		end

		local function fn34(jobId)
			local tbl12 = {}
			local nextPageCursor = nil
			local v31 = nil

			for i = 1, 6 do
				local v32
				v32, v31 = fn33(game.PlaceId, nextPageCursor)
				if not v32 then
					break
				end
				local v33 = ipairs
				local data = v32.data or {}

				for _, v34 in v33(data) do
					if v34.playing and v34.maxPlayers and v34.playing < v34.maxPlayers and v34.id ~= jobId then
						tbl12[#tbl12 + 1] = v34
					end
				end

				nextPageCursor = v32.nextPageCursor
				local flag12 = not nextPageCursor or nextPageCursor == ""
				v31 = nil

				if not flag12 then
					v31 = nil
					if not (#tbl12 >= 20) then
						v31 = nil
						continue
					end
				end

				break
			end

			return tbl12, v31
		end

		local function myhubServerHop(arg)
			local str4 = arg or "Server Hop"
			local jobId = game.JobId
			local tbl12 = nil

			local connection = TeleportService.TeleportInitFailed:Connect(function(arg2, arg3, arg4)
				if arg2 == localPlayer then
					tbl12 = { result = arg3, err = arg4 }
				end
			end)

			local n = 0

			while _G.MyHubSession == myHubSession do
				n += 1
				tbl12 = nil
				local v31, v32 = fn34(jobId)

				if #v31 == 0 then
					pcall(function()
						lib:Notify({
							Title = str4,
							Description = ("All servers full (try %d): %s — retrying"):format(n, tostring(v32 or "empty list")),
							Time = 4,
						})
					end)

					task.wait(3)
					continue
				end

				local v33 = v31[math.random(1, #v31)]

				pcall(function()
					lib:Notify({
						Title = str4,
						Description = ("Hop try %d → %d/%d players"):format(n, v33.playing or 0, v33.maxPlayers or 0),
						Time = 3,
					})
				end)

				local result4, str5

				if v30 then
					local ok4, result5

					ok4, result4, result5 = pcall(function()
						return v30.ToServer("TeleportServer", { placeId = game.PlaceId, jobId = v33.id, allowFallback = false })
					end)

					if ok4 then
						str5 = result5
					else
						str5 = tostring(result4):sub(1, 120)
						result4 = false
					end
				else
					str5 = "SignalFunction module missing"
					result4 = false
				end

				if not result4 then
					pcall(function()
						lib:Notify({ Title = str4, Description = ("Portal rejected: %s"):format(tostring(str5)), Time = 3 })
					end)

					task.wait(1)
					tbl12 = nil
				else
					local n10 = 0

					while n10 < 12 and not tbl12 do
						task.wait(0.5)
						n10 += 0.5
					end

					if not tbl12 then
						pcall(function()
							lib:Notify({ Title = str4, Description = "Teleport silently dropped — trying another.", Time = 3 })
						end)
					else
						local str6 = tostring(tbl12.result):gsub("Enum%.TeleportResult%.", "")

						pcall(function()
							lib:Notify({ Title = str4, Description = ("Teleport %s — retrying."):format(str6), Time = 3 })
						end)

						if tbl12.result == Enum.TeleportResult.Flooded or tbl12.result == Enum.TeleportResult.RateLimited then
							task.wait(3)
						else
							task.wait(0.5)
						end
					end
				end
			end

			pcall(function()
				connection:Disconnect()
			end)
		end

		_G.__myhubServerHop = myhubServerHop

		task.spawn(function()
			local flag12 = false

			while _G.MyHubSession == myHubSession do
				if not tbl8.autoFarmSnowMounds or not _G.__myhubFarmSnowMounds then
					task.wait(0.5)
					flag12 = false
				elseif not getOk4() then
					if not flag12 then
						pcall(function()
							lib:Notify({
								Title = "Snow Mound",
								Description = "You don't own a Shovel — complete the Shovel questline first.",
								Time = 8,
							})
						end)

						flag12 = true
					end

					task.wait(2)
				else
					pcall(_G.__myhubFarmSnowMounds)

					if tbl8.serverHopMounds then
						myhubServerHop("Snow Mound Hop")
					end

					local deadline = tick() + 30

					while true do
						local autoFarmSnowMounds = tick() < deadline and tbl8.autoFarmSnowMounds
						flag12 = false
						if not autoFarmSnowMounds then
							break
						end
						task.wait(1)
					end
				end
			end
		end)
	end

	tbl7.Quest:AddRightGroupbox("Spider Lily Farm"):AddToggle("SpiderLilyFarm", {
		Text = "Spider Lily Farm",
		Default = false,
		Tooltip = "Auto pick lilies",
		Callback = function(spiderLilyFarm)
			tbl8.spiderLily = spiderLilyFarm
		end,
	})

	local function fn32(position)
		local debree = workspace:FindFirstChild("Debree")
		if not debree then
			return nil
		end
		local magnitude2 = nil
		local tbl12 = nil

		for _, child in ipairs(debree:GetChildren()) do
			if not (child:IsA("Model") and child.Name == "Spider Lily") then
				continue
			end
			local rootPart = child:FindFirstChild("RootPart") or child:FindFirstChild("HumanoidRootPart") or child.PrimaryPart
			if not (rootPart and rootPart:IsA("BasePart")) then
				continue
			end
			local descendant2 = nil

			for _, descendant in ipairs(child:GetDescendants()) do
				if descendant:IsA("ProximityPrompt") and descendant.Enabled then
					descendant2 = descendant
					break
				end
				descendant2 = nil
			end

			if descendant2 then
				local magnitude = (rootPart.Position - position).Magnitude

				if not magnitude2 or magnitude < magnitude2 then
					tbl12 = { model = child, root = rootPart, prompt = descendant2 }
					magnitude2 = magnitude
				end
			end
		end

		return tbl12
	end

	task.spawn(function()
		while _G.MyHubSession == myHubSession do
			if not tbl8.spiderLily then
				task.wait(0.4)
				continue
			end
			local v30, v31, v32 = fn18()
			if not v32 then
				task.wait(0.4)
				continue
			end
			local v33 = fn32(v32.Position)

			if not v33 then
				task.wait(1)
			else
				myhubPinTP(v33.root.CFrame + Vector3.new(0, 3, 0), { cancel = function()
					return not tbl8.spiderLily
				end })

				task.wait(0.25)

				if not pcall(function()
					fireproximityprompt(v33.prompt)
				end) then
					pcall(function()
						v33.prompt:InputHoldBegin()
					end)

					task.wait(math.max(0.1, v33.prompt.HoldDuration + 0.1))

					pcall(function()
						v33.prompt:InputHoldEnd()
					end)
				end

				local n = 0

				while n < 1.5 and v33.model.Parent and v33.prompt.Parent and v33.prompt.Enabled and tbl8.spiderLily do
					task.wait(0.1)
					n += 0.1
				end
			end
		end
	end)

	local v30 = nil

	local function fn33()
		if v30 and type(v30.ToServer) == "function" then
			return v30
		end

		if type(getgc) ~= "function" then
			return nil
		end

		for _, v31 in ipairs(getgc(true)) do
			if type(v31) == "table" and type(rawget(v31, "ToServer")) == "function" and type(rawget(v31, "ToClient")) == "function" and type(rawget(v31, "Connect")) == "function" then
				v30 = v31
				return v31
			end
		end

		return nil
	end

	task.spawn(function()
		local misc = localPlayer.PlayerGui:WaitForChild("Misc", 5)
		if not misc then
			return
		end
		game:GetService("VirtualInputManager")
		local flag12 = false

		getConnection(misc.ChildAdded:Connect(function(child)
			if not tbl8.autoFish or flag12 then
				return
			end

			if child.ClassName ~= "CanvasGroup" then
				return
			end
			flag12 = true

			task.spawn(function()
				local descendant2 = nil
				local descendant3 = nil

				for _, descendant in ipairs(child:GetDescendants()) do
					if descendant.Name == "Bar" and descendant:IsA("Frame") then
						descendant2 = descendant
					elseif descendant.Name == "tracker" and descendant:IsA("Frame") then
						descendant3 = descendant
					end
				end

				if not (descendant2 and descendant3) then
					flag12 = false
					return
				end
				local flag13 = false

				local function onRenderStepped()
					if not descendant2.Parent or not descendant3.Parent then
						return
					end
					flag13 = true

					pcall(function()
						descendant2.Position = descendant3.Position
					end)

					flag13 = false
				end

				local connection = RunService.RenderStepped:Connect(onRenderStepped)
				local connection2 = RunService.Heartbeat:Connect(onRenderStepped)

				local connection3 = descendant2:GetPropertyChangedSignal("Position"):Connect(function()
					if flag13 then
						return
					end
					onRenderStepped()
				end)

				do
					local connection4 = descendant3:GetPropertyChangedSignal("Position"):Connect(onRenderStepped)
					local deadline = tick() + 15

					while child.Parent and tick() < deadline and tbl8.autoFish do
						task.wait(0.1)
					end

					for _, connection5 in ipairs({ connection, connection2, connection3, connection4 }) do
						pcall(function()
							connection5:Disconnect()
						end)
					end

					flag12 = false
					return
				end
			end)
		end))
	end)

	local cframe3

	do
		local cframe = CFrame.new(-198.65153503417969, 802.74993896484375, 505.08969116210938, 0.62955647706985474, 0, 0.77695471048355103, 0, 1, 0, -0.77695471048355103, 0, 0.62955647706985474)
		cframe3 = nil
		local ContextActionService = game:GetService("ContextActionService")

		local function fn34()
			pcall(function()
				ContextActionService:BindActionAtPriority("MyHub_AutoFishShiftSink", function()
					return Enum.ContextActionResult.Sink
				end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift)
			end)
		end

		local function fn35()
			pcall(function()
				ContextActionService:UnbindAction("MyHub_AutoFishShiftSink")
			end)
		end

		local function fn36()
			pcall(function()
				ContextActionService:BindActionAtPriority("MyHub_AutoFishM1Sink", function()
					return Enum.ContextActionResult.Sink
				end, false, Enum.ContextActionPriority.High.Value, Enum.UserInputType.MouseButton1)
			end)
		end

		local function fn37()
			pcall(function()
				ContextActionService:UnbindAction("MyHub_AutoFishM1Sink")
			end)
		end

		v29:AddToggle("AutoFish", {
			Text = "Auto Fishing",
			Default = false,
			Tooltip = "Hard-anchor + fishing loop",
			Callback = function(autoFishing)
				tbl8.autoFish = autoFishing

				if autoFishing then
					if tbl8.autoFishTeleport then
						cframe3 = cframe
					else
						local v31, v32, v33 = fn18()
						cframe3 = v33 and v33.CFrame or cframe
					end

					fn34()
					fn36()

					if tbl8.autoFishTeleport then
						task.spawn(function()
							_G.__myhubFishLockSuppress = true

							myhubPinTP(cframe3, { cancel = function()
								return not tbl8.autoFish
							end })

							_G.__myhubFishLockSuppress = false
						end)
					end
				else
					fn35()
					fn37()
					cframe3 = nil

					if _G.__myhubFishTeardownLock then
						_G.__myhubFishTeardownLock()
					end

					local v31, humanoid, part = fn18()

					if part then
						pcall(function()
							part.Anchored = false
						end)
					end

					if humanoid then
						pcall(function()
							humanoid.WalkSpeed = 16
						end)

						pcall(function()
							humanoid.AutoRotate = true
						end)
					end
				end
			end,
		})
	end

	v29:AddToggle("AutoFishTeleport", {
		Text = "Auto Fish Teleport",
		Default = true,
		Tooltip = "Off = anchor at current spot",
		Callback = function(autoFishTeleport)
			tbl8.autoFishTeleport = autoFishTeleport
		end,
	})

	do
		local function fn34(arg, visible)
			if not arg then
				return
			end

			if type(arg.SetVisible) == "function" then
				pcall(function()
					arg:SetVisible(visible)
				end)

				return
			end

			local container = arg.Container or arg.Holder or arg.Frame or arg.TextLabel

			if container and container.Visible ~= nil then
				pcall(function()
					container.Visible = visible
				end)
			end
		end

		local AutoEquipBaitType = nil

		v29:AddToggle("AutoEquipBait", {
			Text = "Auto Equip Bait",
			Default = false,
			Tooltip = "Keep the selected bait equipped",
			Callback = function(autoEquipBait)
				tbl8.autoEquipBait = autoEquipBait
				fn34(AutoEquipBaitType, autoEquipBait)
			end,
		})

		AutoEquipBaitType = v29:AddDropdown("AutoEquipBaitType", {
			Text = "Equip Bait Type",
			Values = { "Worm", "Fish Head", "Golden Tentacle", "Drowned Lure" },
			Default = tbl8.autoEquipBaitType,
			Tooltip = "Which bait to keep equipped",
			Callback = function(equipBaitType)
				tbl8.autoEquipBaitType = equipBaitType
			end,
		})

		fn34(AutoEquipBaitType, tbl8.autoEquipBait)
		local AutoBaitType = nil
		local AutoBaitAmount = nil

		v29:AddToggle("AutoBait", {
			Text = "Auto Buy Bait",
			Default = false,
			Tooltip = "Buy the selected bait when empty (needs Auto Fish on)",
			Callback = function(autoBuyBait)
				tbl8.autoBait = autoBuyBait
				fn34(AutoBaitType, autoBuyBait)
				fn34(AutoBaitAmount, autoBuyBait)
			end,
		})

		AutoBaitType = v29:AddDropdown("AutoBaitType", {
			Text = "Buy Bait Type",
			Values = { "Worm", "Fish Head", "Golden Tentacle" },
			Default = tbl8.autoBaitType,
			Tooltip = "Which bait to buy",
			Callback = function(buyBaitType)
				tbl8.autoBaitType = buyBaitType
			end,
		})

		AutoBaitAmount = v29:AddSlider("AutoBaitAmount", {
			Text = "Bait Amount",
			Default = 5,
			Min = 1,
			Max = 99,
			Rounding = 0,
			Tooltip = "Purchases per restock cycle",
			Callback = function(baitAmount)
				tbl8.autoBaitAmount = baitAmount
			end,
		})

		fn34(AutoBaitType, tbl8.autoBait)
		fn34(AutoBaitAmount, tbl8.autoBait)
	end

	if not tbl6.isPremium then
		fn19(v29)
	end

	do
		local myHubFishLockRef = nil
		local alignPosition = nil
		local alignOrientation = nil
		local attachment = nil
		local myHubFishLockAtt = nil

		local function myhubFishTeardownLock()
			for _, v31 in ipairs({ alignPosition, alignOrientation, myHubFishLockAtt, myHubFishLockRef }) do
				if v31 then
					pcall(function()
						v31:Destroy()
					end)
				end
			end

			myHubFishLockRef = nil
			alignPosition = nil
			alignOrientation = nil
			attachment = nil
			myHubFishLockAtt = nil
		end

		local function fn34()
			do
				local cframe = cframe3
				if not cframe then
					return
				end
				local v31, v32, parent = fn18()
				if not (parent and parent.Parent) then
					return
				end
				myHubFishLockRef = Instance.new("Part")
				myHubFishLockRef.Name = "MyHub_FishLockRef"
				myHubFishLockRef.Size = Vector3.new(0.1, 0.1, 0.1)
				myHubFishLockRef.Transparency = 1
				myHubFishLockRef.CanCollide = false
				myHubFishLockRef.CanQuery = false
				myHubFishLockRef.CanTouch = false
				myHubFishLockRef.Massless = true
				myHubFishLockRef.Anchored = true
				myHubFishLockRef.CFrame = cframe
				myHubFishLockRef.Parent = workspace
				attachment = Instance.new("Attachment", myHubFishLockRef)
				myHubFishLockAtt = Instance.new("Attachment", parent)
				myHubFishLockAtt.Name = "MyHub_FishLockAtt"
				alignPosition = Instance.new("AlignPosition")
				alignPosition.Attachment0 = myHubFishLockAtt
				alignPosition.Attachment1 = attachment
				alignPosition.RigidityEnabled = true
				alignPosition.Parent = parent
				alignOrientation = Instance.new("AlignOrientation")
				alignOrientation.Attachment0 = myHubFishLockAtt
				alignOrientation.Attachment1 = attachment
				alignOrientation.RigidityEnabled = true
				alignOrientation.Parent = parent
				return
			end
		end

		getConnection(RunService.Heartbeat:Connect(function()
			if not tbl8.autoFish then
				return
			end

			if _G.__myhubFishLockSuppress then
				if alignPosition and alignPosition.Enabled then
					alignPosition.Enabled = false
				end

				if alignOrientation and alignOrientation.Enabled then
					alignOrientation.Enabled = false
				end

				return
			end

			if not (((alignPosition and alignPosition.Parent) and myHubFishLockAtt) and myHubFishLockAtt.Parent) then
				myhubFishTeardownLock()
				fn34()
			end

			if alignPosition and not alignPosition.Enabled then
				alignPosition.Enabled = true
			end

			if alignOrientation and not alignOrientation.Enabled then
				alignOrientation.Enabled = true
			end

			local E, E = fn18()

			if E then
				if E.WalkSpeed ~= 0 then
					pcall(function()
						E.WalkSpeed = 0
					end)
				end

				if E.AutoRotate ~= false then
					pcall(function()
						E.AutoRotate = false
					end)
				end
			end
		end))

		getConnection(localPlayer.CharacterAdded:Connect(function()
			myhubFishTeardownLock()
		end))

		_G.__myhubFishTeardownLock = myhubFishTeardownLock
	end

	do
		local tbl12 = {
			Worm = { pos = Vector3.new(-192.04, 806.96, 602.66), buyKey = "Worm" },
			["Fish Head"] = { pos = Vector3.new(1643.24, 672.25, -190.13), buyKey = "Fish Head" },
			["Golden Tentacle"] = { pos = Vector3.new(1643.24, 672.25, -190.13), buyKey = "Golden Tentacle x10" },
		}

		local v31 = nil

		local function fn34()
			if v31 then
				return v31
			end
			local service2 = game:GetService("ReplicatedStorage")
			local signalFunction = service2:FindFirstChild("Communication") and service2.Communication:FindFirstChild("ServerAndClient") and service2.Communication.ServerAndClient:FindFirstChild("Signals") and service2.Communication.ServerAndClient.Signals:FindFirstChild("SignalFunction")
			if not signalFunction then
				return nil
			end
			local ok3, result3 = pcall(require, signalFunction)
			if ok3 and type(result3) == "table" and type(result3.ToServer) == "function" then
				v31 = result3
				return result3
			end
			return nil
		end

		local function getOk4()
			local service2 = game:GetService("ReplicatedStorage")
			local autoBaitType = tbl8.autoBaitType or "Worm"

			local ok3, result3 = pcall(function()
				local instance = service2.Player_Service.Data[localPlayer.Name]
				local child = instance.slots["Slot" .. (instance:FindFirstChild("slotEquipped") and instance.slotEquipped.Value or 1)].Inventory.Inventory:FindFirstChild(autoBaitType)
				if not child then
					return 0
				end
				local amount = child:FindFirstChild("Amount")
				return amount and tonumber(amount.Value) or 0
			end)

			return ok3 and result3 or 0
		end

		local v32 = nil

		local function fn35()
			if v32 then
				return v32
			end
			local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
			local signalEvent = ReplicatedStorage2:FindFirstChild("Communication") and ReplicatedStorage2.Communication:FindFirstChild("ServerAndClient") and ReplicatedStorage2.Communication.ServerAndClient:FindFirstChild("Signals") and ReplicatedStorage2.Communication.ServerAndClient.Signals:FindFirstChild("SignalEvent")
			if not signalEvent then
				return nil
			end
			local ok3, result3 = pcall(require, signalEvent)
			if ok3 and type(result3) == "table" and type(result3.ToServer) == "function" then
				v32 = result3
				return result3
			end
			return nil
		end

		local now3 = 0

		local function fn36(cframe)
			myhubPinTP(cframe, { cancel = function()
				return not tbl8.autoFish
			end })
		end

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				if not (tbl8.autoBait and tbl8.autoFish) then
					task.wait(0.6)
				else
					if getOk4() > 0 then
						task.wait(1)
						continue
					end
					local v33 = fn34()
					local v34, v35, v36 = fn18()
					local v37 = tbl12[tbl8.autoBaitType or "Worm"]
					if not (v33 and v36 and v37) then
						task.wait(0.6)
						continue
					end
					local cframe = v36.CFrame
					_G.__myhubFishLockSuppress = true
					_G.__myhubFishSuppress = true
					local deadline = tick() + 1.5

					while tick() < deadline and not _G.__myhubFishPaused do
						task.wait(0.05)
					end

					fn36(CFrame.new(v37.pos + Vector3.new(0, 3, 0)))
					local cframe2 = CFrame.new(v37.pos + Vector3.new(0, 3, 0))
					local n = math.clamp(tonumber(tbl8.autoBaitAmount) or 1, 1, 99)
					myhubPinTP(cframe2)

					pcall(function()
						v33.ToServer("PurchaseSelection", { [v37.buyKey] = n })
					end)

					pcall(function()
						local autoBaitType = tbl8.autoBaitType or "Worm"
						local instance = game:GetService("ReplicatedStorage").Player_Service.Data[localPlayer.Name]
						local slotEquipped = instance:FindFirstChild("slotEquipped")
						local child = instance.slots:FindFirstChild("Slot" .. (slotEquipped and slotEquipped.Value or 1))
						if not child then
							return
						end
						local child2 = child:FindFirstChild("Inventory")
						local inventory = child2 and child2:FindFirstChild("Inventory")
						local child3 = inventory and inventory:FindFirstChild(autoBaitType)
						if not child3 then
							return
						end
						local id = child3:FindFirstChild("Id")
						if not (id and id:IsA("ValueBase")) then
							return
						end
						local v38 = fn35()
						if not v38 then
							return
						end
						v38.ToServer("EquipBait", id.Value)
						now3 = tick()
					end)

					if tbl8.autoFish then
						fn36(cframe)
					end

					_G.__myhubFishLockSuppress = false
					_G.__myhubFishSuppress = false
				end
			end
		end)

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				if not tbl8.autoEquipBait then
					task.wait(0.6)
				else
					local autoEquipBaitType = tbl8.autoEquipBaitType or "Worm"
					local ReplicatedStorage2 = game:GetService("ReplicatedStorage")

					pcall(function()
						local instance = ReplicatedStorage2.Player_Service.Data[localPlayer.Name]
						local slotEquipped = instance:FindFirstChild("slotEquipped")
						local child = instance.slots:FindFirstChild("Slot" .. (slotEquipped and slotEquipped.Value or 1))
						if not child then
							return
						end
						local misc = child:FindFirstChild("Misc")
						local equippedBait = misc and misc:FindFirstChild("EquippedBait")
						if equippedBait and equippedBait.Value == autoEquipBaitType then
							return
						end

						if tick() - now3 < 3 then
							return
						end
						local child2 = child:FindFirstChild("Inventory")
						local inventory = child2 and child2:FindFirstChild("Inventory")
						local child3 = inventory and inventory:FindFirstChild(autoEquipBaitType)
						if not child3 then
							return
						end
						local id = child3:FindFirstChild("Id")
						if not (id and id:IsA("ValueBase")) then
							return
						end
						local v33 = fn35()
						if not v33 then
							return
						end
						v33.ToServer("EquipBait", id.Value)
						now3 = tick()
					end)

					task.wait(0.8)
				end
			end
		end)
	end

	_G.__myhubFishBiteCount = _G.__myhubFishBiteCount or 0

	do
		local function fn34()
			return true
		end

		local function fn35(instance)
			if instance:GetAttribute("MyHubCollectArmed") then
				return
			end
			instance:SetAttribute("MyHubCollectArmed", true)

			task.spawn(function()
				task.wait(1.5)
				if not instance.Parent or not tbl8.autoFish then
					return
				end
				local descendant2 = nil

				for _, descendant in ipairs(instance:GetDescendants()) do
					if descendant:IsA("ProximityPrompt") then
						descendant2 = descendant
						break
					end
				end

				if not descendant2 then
					return
				end

				if not descendant2.Enabled then
					pcall(function()
						descendant2.Enabled = true
					end)
				end

				local holdDuration = descendant2.HoldDuration or 0

				pcall(function()
					descendant2:InputHoldBegin()
				end)

				task.wait(holdDuration + 0.1)

				pcall(function()
					do
						descendant2:InputHoldEnd()
						return
					end
				end)
			end)
		end

		local function getIsModel(instance)
			return type(instance.Name) == "string" and instance.Name:find("^FishingCatch_") and (instance:IsA("Model") or instance:IsA("BasePart"))
		end

		local function fn36(instance)
			getConnection(instance.ChildAdded:Connect(function(child)
				if getIsModel(child) then


					fn35(child)
				end
			end))

			for _, child in ipairs(instance:GetChildren()) do
				if getIsModel(child) then
					fn35(child)
				end
			end
		end

		local debree = workspace:FindFirstChild("Debree")

		if debree then
			fn36(debree)
		else
			local connection = nil

			connection = workspace.ChildAdded:Connect(function(child)
				if child.Name == "Debree" then
					if connection then
						connection:Disconnect()
						connection = nil
					end

					fn36(child)
				end
			end)

			getConnection(connection)
		end

		local tbl12 = {
			One = Enum.KeyCode.One,
			Two = Enum.KeyCode.Two,
			Three = Enum.KeyCode.Three,
			Four = Enum.KeyCode.Four,
			Five = Enum.KeyCode.Five,
		}

		local tbl13 = { "One", "Two", "Three", "Four", "Five" }

		local function fn37(arg)
			if type(arg) ~= "string" or arg == "" then
				return false
			end
			local str4 = arg:lower()
			return (str4:find("rod") or str4:find("fish")) and not str4:find("permit")
		end

		local v31 = nil

		local tbl14 = {
			Equipped = true,
			SelectedSlot = true,
			ToolEquipped = true,
			EquippedItem = true,
			EquippedTool = true,
			CurrentSlot = true,
			ActiveSlot = true,
			HotbarSlot = true,
		}

		local function fn38(instance, arg, arg2)
			if instance then
				if instance:GetAttribute("LockedToolSlot") ~= nil then
					return true
				end
			end

			local ok3, result3 = pcall(function()
				local instance2 = game:GetService("ReplicatedStorage").Player_Service.Data[localPlayer.Name]
				local n = instance2:FindFirstChild("slotEquipped") and instance2.slotEquipped.Value or 1

				for _, descendant in ipairs(instance2.slots["Slot" .. n]:GetDescendants()) do
					if not (tbl14[descendant.Name] and descendant:IsA("ValueBase")) then
						continue
					end
					local value = descendant.Value

					if type(value) == "string" then
						if value == arg2 or fn37(value) then
							return true
						end

						if tbl12[value] == arg then
							return true
						end
						continue
					end

					if type(value) ~= "number" then
						continue
					end
					local v32 = tbl13[value]
					if v32 and tbl12[v32] == arg then
						return true
					end
				end

				return false
			end)

			if ok3 and result3 then
				return true
			end
			return v31 == arg
		end

		local function fn39()
			local v32 = nil
			local child3 = nil
			local v33 = nil

			pcall(function()
				local instance = game:GetService("ReplicatedStorage").Player_Service.Data[localPlayer.Name]
				local slot = instance.slots["Slot" .. (instance:FindFirstChild("slotEquipped") and instance.slotEquipped.Value or 1)]
				local toolbar = slot.Inventory.Toolbar
				local children = {}

				for _, child in ipairs(slot.Inventory.Inventory:GetChildren()) do
					local id = child:FindFirstChild("Id")

					if id then
						children[id.Value] = child.Name
					end
				end

				for i, name in ipairs(tbl13) do
					local child = toolbar:FindFirstChild(name)
					child = child and child.Value

					if child and child ~= "" then
						local child2 = children[child]

						if fn37(child2) then
							v32 = tbl12[name]
							child3 = child2
							v33 = i
							break
						end
					end
				end
			end)

			return v32, child3, v33
		end

		task.spawn(function()
			local flag12 = false

			getConnection(localPlayer.CharacterAdded:Connect(function()
				flag12 = false
				v31 = nil
			end))

			local flag13 = false
			local flag14 = false
			local now3 = 0

			while _G.MyHubSession == myHubSession do
				if not tbl8.autoFish then
					if flag13 then
						v31 = nil
						flag13 = false
					end

					task.wait(0.4)
				else
					if _G.__myhubFishSuppress then
						_G.__myhubFishPaused = true
						task.wait(0.25)
						continue
					end

					_G.__myhubFishPaused = nil

					if fn34() then
						local v32 = fn33()
						local v33, v34, v35 = fn18()

						if v32 and v35 and v33 then
							local v36, v37, value = fn39()

							if v36 then
								flag12 = false
								local cframe, lookVector, position, vector, myhubFishBiteCount, n, flag15, myhubFishBiteCount2, myhubFishBiteCount3

								if not fn38(v33, v36, v37) then
									if tick() - now3 < 0.6 then
										task.wait(0.15)
										flag13 = true
										flag14 = false
										continue
									end

									local itemsConfig = localPlayer:FindFirstChild("Items_Config")
									local equipped = itemsConfig and itemsConfig:FindFirstChild("Equipped")

									if equipped then
										pcall(function()
											equipped.Value = value
										end)
									end

									pcall(function()
										v32.ToServer("Item_Equip", value)
									end)

									now3 = tick()
									v31 = v36
									task.wait(0.4)
									cframe = cframe3 or v35.CFrame
									lookVector = cframe.LookVector
									position = cframe.Position
									vector = Vector3.new(position.X + lookVector.X * 15, position.Y, position.Z + lookVector.Z * 15)
									myhubFishBiteCount = _G.__myhubFishBiteCount or 0

									pcall(function()
										v32.ToServer("Tool_Mouse", "Down", vector)
									end)

									task.wait(0.08)

									pcall(function()
										v32.ToServer("Tool_Mouse", "Up", vector)
									end)

									n = 0

									while true do
										flag15 = n < 10 and tbl8.autoFish and not _G.__myhubFishSuppress

										if flag15 then
											myhubFishBiteCount2 = _G.__myhubFishBiteCount or 0
											flag15 = myhubFishBiteCount2 == myhubFishBiteCount
										end

										if not flag15 then
											break
										end
										task.wait(0.15)
										n += 0.15
									end

									if _G.__myhubFishSuppress then
										flag13 = true
										flag14 = false
										continue
									end

									myhubFishBiteCount3 = _G.__myhubFishBiteCount or 0

									if myhubFishBiteCount < myhubFishBiteCount3 then
										task.wait(1.2)
									else
										task.wait(0.15)
									end

									flag14 = false
									flag13 = true
									continue
								else
									cframe = cframe3 or v35.CFrame
									lookVector = cframe.LookVector
									position = cframe.Position
									vector = Vector3.new(position.X + lookVector.X * 15, position.Y, position.Z + lookVector.Z * 15)
									myhubFishBiteCount = _G.__myhubFishBiteCount or 0

									pcall(function()
										v32.ToServer("Tool_Mouse", "Down", vector)
									end)

									task.wait(0.08)

									pcall(function()
										v32.ToServer("Tool_Mouse", "Up", vector)
									end)

									n = 0

									while true do
										flag15 = n < 10 and tbl8.autoFish and not _G.__myhubFishSuppress

										if flag15 then
											myhubFishBiteCount2 = _G.__myhubFishBiteCount or 0
											flag15 = myhubFishBiteCount2 == myhubFishBiteCount
										end

										if not flag15 then
											break
										end
										task.wait(0.15)
										n += 0.15
									end

									if not _G.__myhubFishSuppress then
										myhubFishBiteCount3 = _G.__myhubFishBiteCount or 0

										if myhubFishBiteCount < myhubFishBiteCount3 then
											task.wait(1.2)
										else
											task.wait(0.15)
										end

										flag14 = false
										flag13 = true
										continue
									end

									flag13 = true
									flag14 = false
									continue
								end
							end

							if not flag12 then
								pcall(function()
									lib:Notify({ Title = "Auto Fishing", Description = "No rod detected in hotbar", Time = 6 })
								end)

								flag12 = true
							end

							task.wait(2)
							flag13 = true
							flag14 = false
							continue
						end

						task.wait(0.5)
						flag14 = false
						flag13 = true
						continue
					end

					if not flag14 then
						pcall(function()
							lib:Notify({
								Title = "Auto Fishing",
								Description = "This executor lacks hookfunction — cannot bypass the fishing mini-game.",
								Time = 6,
							})
						end)

						flag14 = true
					end

					task.wait(2)
					flag13 = true
				end
			end
		end)
	end

	do
		local function getHumanoidRootPart(position, arg, arg2)
			local tbl12

			if type(arg) ~= "string" then
				tbl12 = arg
			else
				tbl12 = { [arg] = true }
			end

			if type(tbl12) ~= "table" or not next(tbl12) then
				return nil
			end
			local flag12 = tbl12.All == true and type(arg2) == "function"
			local child = workspace:FindFirstChild("Humanoids")
			if not child then
				return nil
			end
			local magnitude2 = nil
			local humanoidRootPart2 = nil

			for _, descendant in ipairs(child:GetDescendants()) do
				if not (descendant:IsA("Humanoid") and descendant.Health > 0) then
					continue
				end
				local parent = descendant.Parent
				if not (parent and parent:IsA("Model")) then
					continue
				end

				if flag12 then
					if not arg2(parent) then
						continue
					end
					local humanoidRootPart = parent:FindFirstChild("HumanoidRootPart") or parent:FindFirstChild("Head")

					if humanoidRootPart then
						local magnitude = (humanoidRootPart.Position - position).Magnitude

						if not magnitude2 or magnitude < magnitude2 then
							magnitude2 = magnitude
							humanoidRootPart2 = humanoidRootPart
						end
					end
				else
					if not tbl12[parent.Name] then
						continue
					end
					local humanoidRootPart = parent:FindFirstChild("HumanoidRootPart") or parent:FindFirstChild("Head")

					if humanoidRootPart then
						local magnitude = (humanoidRootPart.Position - position).Magnitude

						if not magnitude2 or magnitude < magnitude2 then
							magnitude2 = magnitude
							humanoidRootPart2 = humanoidRootPart
						end
					end
				end
			end

			return humanoidRootPart2
		end

		local function getRootPart(name)
			local child = Players:FindFirstChild(name)
			if not child then
				return nil
			end
			local characters = {}

			if child.Character then
				table.insert(characters, child.Character)
			end

			local humanoids = workspace:FindFirstChild("Humanoids")

			if humanoids then
				for _, child2 in ipairs(humanoids:GetChildren()) do
					if child2:IsA("Model") and child2.Name == name and child2 ~= child.Character then
						table.insert(characters, child2)
					end
				end
			end

			for _, character in ipairs(characters) do
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				local rootPart = humanoid and humanoid.RootPart or character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
				if rootPart and rootPart:IsA("BasePart") and humanoid and humanoid.Health > 0 then
					return rootPart
				end
			end

			return nil
		end

		local humanoidRootPart3 = nil
		local cframe = nil
		local flag12 = nil
		local flag13 = false
		local position = nil
		local n = 1

		local function getVector()
			local farmDistance = tbl8.farmDistance
			local vector

			if tbl8.farmPosition == "Above" then
				vector = Vector3.new(0, farmDistance, 0)
			elseif tbl8.farmPosition == "Below" then
				vector = Vector3.new(0, -farmDistance, 0)
			elseif tbl8.farmPosition == "In Front" then
				vector = Vector3.new(0, 0, -farmDistance)
			else
				vector = Vector3.new(0, 0, farmDistance)
			end

			return vector + Vector3.new(tbl8.farmOffX, tbl8.farmOffY, tbl8.farmOffZ)
		end

		local function fn34()
			if not flag13 then
				return
			end
			flag13 = false
			humanoidRootPart3 = nil
			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")

			if humanoidRootPart then
				pcall(function()
					humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
				end)

				pcall(function()
					humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
				end)
			end

			if humanoid then
				pcall(function()
					humanoid:Move(Vector3.zero, false)
				end)
			end

			cframe = nil
			flag12 = nil
			position = nil
		end

		local function fn35(arg)
			if flag13 then
				return
			end
			flag13 = true
			cframe = arg.CFrame
			flag12 = false
		end

		_G.__myhubFarmTeardown = function()
			tbl8.farmMob = false
			tbl8.farmBoss = false
			tbl8.farmPlayer = false
			tbl8.farmYeti = false
			tbl8.spiderLily = false
			fn34()
		end

		getConnection(RunService.Heartbeat:Connect(function()
			if (not flag13 or not humanoidRootPart3) or not humanoidRootPart3.Parent then
				return
			end

			if _G.__myhubLootDwell then
				return
			end
			local E, E, h = fn18()
			if not h then
				return
			end

			pcall(function()
				if E and E.PlatformStand then
					E.PlatformStand = false
				end

				local Q, l = humanoidRootPart3.Position, humanoidRootPart3.CFrame.LookVector
				local B = Vector3.new(l.X, 0, l.Z)
				l = ((if B.Magnitude < 0.01 then (CFrame.new(Q)) else (CFrame.lookAt(Q, Q + B.Unit))) * CFrame.new(getVector())).Position
				h.CFrame = CFrame.lookAt(l, Q)
				h.AssemblyLinearVelocity = Vector3.zero
				h.AssemblyAngularVelocity = Vector3.zero

				if E then
					B = E:GetState()

					if ((B == Enum.HumanoidStateType.Physics) or (B == Enum.HumanoidStateType.Ragdoll)) or (B == Enum.HumanoidStateType.FallingDown) then
						E:ChangeState(Enum.HumanoidStateType.Running)
					end
				end

				if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				end
			end)
		end))

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				local farmMobTarget = tbl8.farmMobTarget
				local farmBossTarget = tbl8.farmBossTarget
				local huntBossTarget = tbl8.huntBossTarget
				local flag14 = type(farmMobTarget) == "table" and next(farmMobTarget) ~= nil
				local flag15 = type(farmBossTarget) == "table" and next(farmBossTarget) ~= nil
				local flag16 = type(huntBossTarget) == "table" and next(huntBossTarget) ~= nil
				local flag17

				if tbl8.huntTrack and flag16 then
					flag17 = true
				elseif tbl8.farmBoss and flag15 then
					flag17 = true
					huntBossTarget = farmBossTarget
				else
					huntBossTarget = farmBossTarget
					flag17 = flag15
				end

				if not (tbl8.farmMob and flag14 or tbl8.farmBoss and flag15 or tbl8.farmPlayer and tbl8.farmPlayerTarget or tbl8.farmYeti or tbl8.huntTrack and flag16) then
					if flag13 then
						fn34()
					end
				else
					local v31, v32, v33 = fn18()

					if v33 and v26 then
						local parent = humanoidRootPart3 and humanoidRootPart3.Parent

						if parent then
							parent = humanoidRootPart3.Parent:FindFirstChildOfClass("Humanoid")
							parent = parent and parent.Health > 0
						end

						if parent then
							pcall(function()
								position = humanoidRootPart3.Position
							end)
						end

						if parent and tbl8.farmYeti and humanoidRootPart3.Parent and humanoidRootPart3.Parent.Name == "Yeti Demon" then
							local humanoidRootPart = getHumanoidRootPart(v33.Position, { ["Small Yeti"] = true })

							if humanoidRootPart then
								humanoidRootPart3 = humanoidRootPart

								pcall(function()
									position = humanoidRootPart3.Position
								end)
							end
						end

						if not parent then
							local position2 = nil

							if (tbl8.farmYeti and tbl8.farmYeti and humanoidRootPart3 and humanoidRootPart3.Parent and humanoidRootPart3.Parent.Name == "Yeti Demon" or not tbl8.farmYeti and flag17 and not (tbl8.farmMob and flag14)) and (tbl8.autoPickup or tbl8.autoChest) then
								if humanoidRootPart3 and humanoidRootPart3.Parent then
									pcall(function()
										position2 = humanoidRootPart3.Position
									end)
								end

								position2 = position2 or position
							end

							humanoidRootPart3 = nil

							if position2 then
								_G.__myhubLootDwell = true
								local instance = v33
								task.wait(3)
								local child = workspace:FindFirstChild("LootDrops")

								if child and tbl8.autoPickup and instance and instance.Parent then
									local n10 = tbl8.autoPickupRange * tbl8.autoPickupRange
									local children = {}
									local deadline = tick() + 20
									local deadline2 = tick() + 4

									while tick() < deadline and tick() < deadline2 and (flag17 or tbl8.farmYeti) and instance and instance.Parent do
										local dot2 = nil
										local child3 = nil
										local position3 = nil

										for _, child2 in ipairs(child:GetChildren()) do
											if not (child2:IsA("BasePart") and not children[child2] and child2.Parent and fn30(child2)) then
												continue
											end
											local position4 = child2.Position - position2
											local dot = position4:Dot(position4)

											if dot <= n10 and (not dot2 or dot < dot2) then
												position3 = child2.Position
												dot2 = dot
												child3 = child2
											end
										end

										if not child3 then
											task.wait(0.3)
											continue
										end
										deadline2 = tick() + 4
										children[child3] = true
										myhubPinTP(CFrame.new(position3 + Vector3.new(0, 3, 0)))
										local deadline3 = tick() + 1.5
										local child2 = child3:FindFirstChildWhichIsA("ProximityPrompt")

										if child2 then
											pcall(function()
												if fireproximityprompt then
													fireproximityprompt(child2)
												end
											end)
										end

										while tick() < deadline3 and child3.Parent and (flag17 or tbl8.farmYeti) and instance and instance.Parent do
											task.wait(0.1)
											local v34, v35, v36 = fn18()

											if v36 and v36 ~= instance then
												instance = v36
											end
										end
									end
								end

								_G.__myhubLootDwell = false
								position = nil
								local v34, v35, v36 = fn18()
								v33 = v36 or v33
							end

							local position3 = cframe and cframe.Position or v33.Position

							if tbl8.farmMob and flag14 then
								humanoidRootPart3 = getHumanoidRootPart(position3, farmMobTarget, fn29)
							elseif tbl8.farmYeti then
								local tbl12 = { ["Small Yeti"] = true }
								local tbl13 = { ["Yeti Demon"] = true }
								humanoidRootPart3 = getHumanoidRootPart(position3, tbl12) or getHumanoidRootPart(position3, tbl13)

								if humanoidRootPart3 and humanoidRootPart3.Parent then
									pcall(function()
										v33.CFrame = humanoidRootPart3.CFrame + Vector3.new(0, 3, 0)
									end)
								end

								if not humanoidRootPart3 then
									local yetiDemon = tbl11["Yeti Demon"]

									if (v33.Position - yetiDemon).Magnitude >= 15 then
										myhubGuardTP(CFrame.new(yetiDemon) + Vector3.new(0, 5, 0))
									end

									local n10 = 0

									while n10 < 3 do
										task.wait(0.2)
										n10 += 0.2
										if not tbl8.farmYeti then
											break
										end

										if _G.MyHubSession == myHubSession then
											humanoidRootPart3 = getHumanoidRootPart(v33.Position, tbl12) or getHumanoidRootPart(v33.Position, tbl13)
											if not humanoidRootPart3 then
												continue
											end
										end

										break
									end
								end
							elseif flag17 then
								local flag18 = huntBossTarget.All == true

								if not flag18 or cframe == nil then
									humanoidRootPart3 = getHumanoidRootPart(position3, huntBossTarget, fn28)

									if humanoidRootPart3 and humanoidRootPart3.Parent then
										pcall(function()
											v33.CFrame = humanoidRootPart3.CFrame + Vector3.new(0, 3, 0)
										end)

										if flag18 then
											local name = humanoidRootPart3.Parent.Name
											local tbl12 = {}

											for k in pairs(tbl11) do
												table.insert(tbl12, k)
											end

											table.sort(tbl12)

											for i, v34 in ipairs(tbl12) do
												if v34 == name then
													n = i % #tbl12 + 1
													break
												end
											end
										end
									end
								end

								if not humanoidRootPart3 then
									local tbl12 = {}
									local tbl13

									if flag18 then
										tbl13 = {}

										for k in pairs(tbl11) do
											table.insert(tbl13, k)
										end

										table.sort(tbl13)
										local n10 = #tbl13

										if n < 1 or n > n10 then
											n = 1
										end

										for i = 0, n10 - 1 do
											local n11 = (n - 1 + i) % n10 + 1
											local v34 = tbl13[n11]
											table.insert(tbl12, { name = v34, coord = tbl11[v34], _rotIdx = n11 })
										end
									else
										for k in pairs(huntBossTarget) do
											if tbl11[k] then
												table.insert(tbl12, { name = k, coord = tbl11[k] })
											end
										end

										tbl13 = nil
									end

									local flag19 = cframe == nil

									for _, v34 in ipairs(tbl12) do
										if humanoidRootPart3 then
											break
										end

										if not (tbl8.farmBoss or tbl8.huntTrack) then
											break
										end

										if _G.MyHubSession ~= myHubSession then
											break
										end

										if flag19 or not ((v33.Position - v34.coord).Magnitude < 15) then
											myhubGuardTP(CFrame.new(v34.coord) + Vector3.new(0, 5, 0))
											flag19 = false
										end

										local v35 = 0

										while v35 < 3 do
											task.wait(0.2)
											v35 += 0.2
											if not (tbl8.farmBoss or tbl8.huntTrack) then
												break
											end

											if _G.MyHubSession == myHubSession then
												humanoidRootPart3 = getHumanoidRootPart(v33.Position, huntBossTarget, fn28)
												if not humanoidRootPart3 then
													continue
												end
											end

											break
										end

										if humanoidRootPart3 and flag18 and v34._rotIdx then
											n = v34._rotIdx % #tbl13 + 1
										end
									end
								end
							elseif tbl8.farmPlayer and tbl8.farmPlayerTarget then
								humanoidRootPart3 = getRootPart(tbl8.farmPlayerTarget)
							end
						end

						if humanoidRootPart3 then
							fn35(v33)
						end
					end
				end

				_G.__myhubFarmTarget = humanoidRootPart3
				task.wait(0.1)
			end
		end)

		local attributes = { Mythic = 3, Legendary = 2, Epic = 1 }

		local function fn36()
			if tbl8.huntSide == "Muzan" or tbl8.huntSide == "Crow" then
				return tbl8.huntSide
			end
			local ReplicatedStorage2 = game:GetService("ReplicatedStorage")

			local ok3, result3 = pcall(function()
				local instance = ReplicatedStorage2.Player_Service.Data[localPlayer.Name]
				local race = instance.slots["Slot" .. (instance:FindFirstChild("slotEquipped") and instance.slotEquipped.Value or 1)]:FindFirstChild("Race")
				return race and race.Value or nil
			end)

			if ok3 and type(result3) == "string" then
				if result3 == "Slayer" then
					return "Crow"
				end

				if result3 == "Demon" then
					return "Muzan"
				end
			end

			local bossHunts = ReplicatedStorage2:FindFirstChild("BossHunts")
			if not bossHunts then
				return "Muzan"
			end
			local v31 = 0
			local n10 = 0

			for _, child in ipairs(bossHunts:GetChildren()) do
				local attribute = child:GetAttribute("Side")

				if attribute == "Muzan" then
					v31 += 1
				elseif attribute == "Crow" then
					n10 += 1
				end
			end

			if n10 > v31 then
				return "Crow"
			end
			return "Muzan"
		end

		local function fn37()
			local service2 = game:GetService("ReplicatedStorage")
			local v31 = nil

			pcall(function()
				local instance = service2.Player_Service.Data[localPlayer.Name]
				local value = instance:FindFirstChild("slotEquipped") and instance.slotEquipped.Value or 1

				for _, child in ipairs(instance.slots["Slot" .. value].Quests.Holder:GetChildren()) do
					if type(child.Name) == "string" and child.Name:find("^Eliminate ") then
						local str4 = child.Name:sub(11)
						if tbl11[str4] then
							v31 = str4
							return
						end
					end
				end
			end)

			return v31
		end

		local now3 = 0

		local function fn38(text)
			if not Idle then
				return
			end

			pcall(function()
				if Idle.SetText then
					Idle:SetText(text)
				elseif Idle.Text then
					Idle.Text = text
				end
			end)
		end

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				task.wait(0.5)

				if not tbl8.huntTrack then
					fn38("Off")
					tbl8.huntBossTarget = {}
					continue
				end

				local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
				local hunting = fn37()

				if hunting then
					fn38("Hunting: " .. hunting)
					local huntBossTarget = tbl8.huntBossTarget

					if type(huntBossTarget) ~= "table" or not huntBossTarget[hunting] or next(huntBossTarget, next(huntBossTarget)) ~= nil then
						tbl8.huntBossTarget = { [hunting] = true }
					end
				else
					if tick() - now3 < 6 then
						fn38("Waiting (claim cooldown)")
						continue
					end
					local bossHunts = ReplicatedStorage2:FindFirstChild("BossHunts")
					if not bossHunts then
						continue
					end
					local v31 = fn36()
					local now4 = os.time()
					local n10 = -math.huge
					local attribute5 = nil
					local name = nil

					for _, child in ipairs(bossHunts:GetChildren()) do
						local attribute = child:GetAttribute("Side")
						local attribute2 = child:GetAttribute("Boss")
						local attribute3 = child:GetAttribute("Tier")
						local attribute4 = child:GetAttribute("ExpiresAt") or math.huge

						if attribute == v31 and attribute2 and tbl11[attribute2] and now4 < attribute4 then
							local n11 = (attributes[attribute3] or 0) * 1000000 - (attribute4 - now4)

							if n11 > n10 then
								name = child.Name
								n10 = n11
								attribute5 = attribute2
							end
						end
					end

					if name and toServer then
						fn38("Claiming: " .. attribute5)
						pcall(toServer, "BossHuntsRequest", { action = "Claim", id = name })
						task.wait(0.4)

						if fn37() then
							now3 = 0
						else
							now3 = tick()
							fn38("Claim rejected — retrying")
						end
					else
						fn38("No " .. v31 .. " hunts available")
					end

					if not fn37() then
						tbl8.huntBossTarget = {}
					end
				end
			end
		end)

		task.spawn(function()
			local yetiDemon = tbl11["Yeti Demon"]
			local now4 = 0

			while _G.MyHubSession == myHubSession do
				if not tbl8.farmYeti then
					task.wait(0.5)
				else
					if _G.__myhubLootDwell then
						task.wait(0.3)
						continue
					end
					local humanoids = workspace:FindFirstChild("Humanoids")
					local flag14 = false

					if humanoids then
						for _, descendant in ipairs(humanoids:GetDescendants()) do
							if descendant:IsA("Humanoid") and descendant.Health > 0 then
								local parent = descendant.Parent
								if parent and parent:IsA("Model") and parent.Name == "Yeti Demon" then
									flag14 = true
									break
								end
							end
						end
					end

					if flag14 then
						task.wait(1)
					else
						if tick() - now4 < 8 then
							task.wait(0.5)
							continue
						end
						local v31, v32, v33 = fn18()
						if not v33 then
							task.wait(0.5)
							continue
						end

						if (v33.Position - yetiDemon).Magnitude > 15 then
							myhubGuardTP(CFrame.new(yetiDemon) + Vector3.new(0, 5, 0))
							task.wait(0.2)
						end

						local map = workspace:FindFirstChild("Map")
						map = map and map:FindFirstChild("Map")
						local frozenYeti = map and map:FindFirstChild("FrozenYeti")

						if frozenYeti then
							for _, descendant in ipairs(frozenYeti:GetDescendants()) do
								if descendant:IsA("ProximityPrompt") then
									pcall(function()
										if fireproximityprompt then
											fireproximityprompt(descendant, 0)
										end
									end)

									break
								end
							end
						end

						now4 = tick()
						task.wait(1)
					end
				end
			end
		end)

		if _G.__myhubCombatDoWrap then
			pcall(function()
				_G.__myhubCombatDoWrap.module.Do = _G.__myhubCombatDoWrap.orig
			end)

			_G.__myhubCombatDoWrap = nil
			_G.__myhubCombatDoLastArgs = nil
		end

		_G.__myhubKillAura = tbl8.killAura
		_G.__myhubKillAuraMob = nil
		_G.__myhubKillAuraBoss = nil
		_G.__myhubKillAuraPlayer = nil
		local n10 = 0
		local humanoidRootPart4 = nil

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				local humanoidRootPart = flag13 and humanoidRootPart3 or nil
				local myhubDungeonTarget = _G.__myhubDungeonTarget
				local myhubPathTarget = _G.__myhubPathTarget
				local humanoidRootPart2 = humanoidRootPart or myhubDungeonTarget or myhubPathTarget

				if (_G.__myhubKillAura and humanoidRootPart2 ~= nil or tbl8.autoDungeon and myhubDungeonTarget ~= nil or tbl8.autoPath and myhubPathTarget ~= nil) and humanoidRootPart2 and toServer then
					local flag14 = humanoidRootPart2 ~= humanoidRootPart4
					humanoidRootPart4 = humanoidRootPart2

					if flag14 then
						n10 = 1
					else
						n10 = n10 % 5 + 1
					end

					pcall(toServer, "Combat_Service", _G.__myhub_getStyle(), n10, true, 0, true, nil)

					if _G.__myhub_styleResolved == false or not fn31() then
						pcall(toServer, "Combat_Service", "Combat", n10, true, 0, false, nil)
					end

					task.wait(0.05)
				else
					humanoidRootPart4 = nil
					task.wait(0.02)
				end
			end
		end)
	end

	local function fn34(parent, rootPart, descendant)
		pcall(function()
			descendant.Health = 0
		end)
	end

	local function fn35(instance)
		for _, child in ipairs(instance:GetChildren()) do
			if child:IsA("Highlight") and child.Name == "OuwigaharaMark" then
				local outlineColor = child.OutlineColor
				if math.abs(outlineColor.R * 255 - 255) < 6 and math.abs(outlineColor.G * 255 - 70) < 6 and math.abs(outlineColor.B * 255 - 70) < 6 then
					return true
				end
			end
		end

		return false
	end

	local function fn36(parent)
		if not fn35(parent) then
			return false
		end

		if workspace:GetAttribute("MinigameBossEntrance") == true then
			return tbl8.skipBossInsta
		end
		return tbl8.skipChampionInsta
	end

	task.spawn(function()
		while _G.MyHubSession == myHubSession do
			if tbl8.farmInstaKill then
				local farmInstaThresh = tbl8.farmInstaThresh or 99
				local v31, v32, v33 = fn18()

				if v33 then
					local position = v33.Position
					local humanoids = workspace:FindFirstChild("Humanoids")

					if humanoids then
						for _, descendant in ipairs(humanoids:GetDescendants()) do
							if not (descendant:IsA("Humanoid") and descendant.Health > 0) then
								continue
							end
							local parent = descendant.Parent
							if not (parent and parent:IsA("Model") and parent ~= localPlayer.Character and not Players:GetPlayerFromCharacter(parent) and not parent.Name:find("Sealed Cache", 1, true)) then
								continue
							end
							local rootPart = descendant.RootPart or parent:FindFirstChild("HumanoidRootPart")
							if not (rootPart and rootPart:IsA("BasePart") and not rootPart.Anchored) then
								continue
							end
							local position2 = rootPart.Position - position
							if not (position2:Dot(position2) <= 10000) then
								continue
							end

							local ok3, result3 = pcall(function()
								return rootPart.ReceiveAge
							end)

							if ok3 and type(result3) == "number" and result3 == 0 then
								if (descendant.MaxHealth > 0 and descendant.Health / descendant.MaxHealth * 100 or 100) <= farmInstaThresh and not fn36(parent) then
									fn34(parent, rootPart, descendant)
								end
							end
						end
					end
				end
			end

			task.wait(0.1)
		end
	end)

	local v31 = tbl7.Dungeon:AddLeftGroupbox("Auto Dungeon")

	v31:AddToggle("AutoDungeon", {
		Text = "Auto Dungeon",
		Default = false,
		Tooltip = "Hover + kill mobs",
		Callback = function(autoDungeon)
			tbl8.autoDungeon = autoDungeon
		end,
	})

	v31:AddToggle("AutoReadyUp", {
		Text = "Auto Ready Up",
		Default = false,
		Tooltip = "Ready up",
		Callback = function(autoReadyUp)
			tbl8.autoReadyUp = autoReadyUp
		end,
	})

	v31:AddToggle("AutoSkipWave", {
		Text = "Auto Skip Wave",
		Default = false,
		Tooltip = "Skip wave break",
		Callback = function(autoSkipWave)
			tbl8.autoSkipWave = autoSkipWave
		end,
	})

	v31:AddToggle("SkipBossInsta", {
		Text = "Skip Boss Insta Kill",
		Default = false,
		Tooltip = "Don't insta-kill the floor boss",
		Callback = function(skipBossInstaKill)
			tbl8.skipBossInsta = skipBossInstaKill
		end,
	})

	v31:AddToggle("SkipChampionInsta", {
		Text = "Skip Champion Insta Kill",
		Default = false,
		Tooltip = "Don't insta-kill mid-wave champions",
		Callback = function(skipChampionInstaKill)
			tbl8.skipChampionInsta = skipChampionInstaKill
		end,
	})

	v31:AddToggle("AutoCard", {
		Text = "Auto Card",
		Default = false,
		Tooltip = "Auto pick cards",
		Callback = function(autoCard)
			tbl8.autoCard = autoCard
		end,
	})

	_G._cardBaseName = function(arg)
		if type(arg) ~= "string" then
			return ""
		end
		return (arg:gsub("%s*,.*$", ""):gsub("%s*:%s*.*$", ""):gsub("%s+[%+%-]%d.*$", ""):gsub("%s+[xX]%s*%d.*$", ""):gsub("^%s+", ""):gsub("%s+$", ""))
	end

	v31:AddDropdown("CardPriority", {
		Text = "Card Priority",
		Values = {
			"Ascend Clan",
			"Clan",
			"Event",
			"Extra Life",
			"Forge",
			"Fortune",
			"Heal",
			"Points",
			"Potion",
			"Reroll",
			"Revive",
			"Skill",
			"Skill Swap",
			"Skip",
			"Skip Floor",
			"Stat",
			"Swap Map",
			"Trade",
			"Weapon",
			"Vampiric",
			"Lucky Draw",
			"Loaded Dice",
			"Jackpot Floor",
		},
		Multi = true,
		Default = {},
		AllowNull = true,
		Searchable = true,
		Tooltip = "Preferred types",
		Callback = function(cardPriority)
			local cardPriority2 = {}

			if type(cardPriority) == "table" then
				for k, v32 in pairs(cardPriority) do
					if v32 then
						table.insert(cardPriority2, k)
					end
				end
			end

			tbl8.cardPriority = cardPriority2
		end,
	})

	v31:AddDropdown("CardBlacklist", {
		Text = "Card Blacklist",
		Values = {
			"+2 Rerolls",
			"Adrenaline",
			"Arsenal",
			"Ascension",
			"Attack Speed",
			"Bare Hands",
			"Berserk",
			"Berserkers",
			"Bleeding Floor",
			"Block Points",
			"Blood Moon",
			"Blood Pact",
			"Bloodbank",
			"Boss Hunt",
			"Boss Rush",
			"Bounty",
			"Bulwark",
			"Cartographer",
			"Champion",
			"Cheap Seats",
			"Chill",
			"Clan Heir",
			"Communal Heal",
			"Cooldown Reduction",
			"Cursed Coin",
			"Damage",
			"Damage Reduction",
			"Deep Freeze",
			"Double Down",
			"Double Time",
			"Elite Guard",
			"Endurance Training",
			"Envenomed",
			"Extra Life",
			"Fair Fight",
			"Featherweight",
			"Fine Trophy",
			"Focused Mind",
			"Fog of War",
			"Forbidden Art",
			"Fortune",
			"Frenzy",
			"Glass Cannon",
			"Glass Floor",
			"Gold Rush",
			"Grand Trophy",
			"Greater Trophy",
			"Grounded",
			"Handoff",
			"Headhunter",
			"Heavy Air",
			"Heavy Hitter",
			"Hoarder",
			"Ignition",
			"Iron Discipline",
			"Iron Tower",
			"Jackpot Floor",
			"Last Rites",
			"Last Stand",
			"Lifeline",
			"Lights Out",
			"Loaded Dice",
			"Lone Wolf",
			"Long Night",
			"Lucky Draw",
			"Marathon",
			"Max Health",
			"Max Stamina",
			"Medic",
			"Momentum",
			"Move Speed",
			"Mulligan",
			"No Guard",
			"Pacifist",
			"Parting Gift",
			"Plague Bearer",
			"Prodigy",
			"Quartermaster",
			"Rally",
			"Reincarnated",
			"Reincarnation",
			"Reshuffle",
			"Respec",
			"Rush Hour",
			"Sacrifice",
			"Second Chance",
			"Second Skin",
			"Second Wind",
			"Skip",
			"Split the Take",
			"Stamina Regen",
			"Streak",
			"Supreme Trophy",
			"Tainted Edge",
			"Tectonic Shift",
			"The Horde",
			"Thick Blood",
			"Thick Skin",
			"Thin Air",
			"Ticket Pack",
			"Time Attack",
			"Toll Gate",
			"Tribute",
			"Trophy",
			"Twin Bosses",
			"Twin Souls",
			"Twin Weapons",
			"Vampiric",
			"Venom Fang",
			"Wager",
			"Warcry",
			"Weapon Master",
			"Wildfire",
		},
		Multi = true,
		Default = {},
		AllowNull = true,
		Searchable = true,
		Tooltip = "Blacklist these cards",
		Callback = function(cardBlacklist)
			local cardBlacklist2 = {}

			if type(cardBlacklist) == "table" then
				for k, v32 in pairs(cardBlacklist) do
					if v32 then
						cardBlacklist2[k:lower()] = true
					end
				end
			end

			tbl8.cardBlacklist = cardBlacklist2
		end,
	})

	v31:AddSlider("CardHealBelow", {
		Text = "Heal Below HP%",
		Default = 50,
		Min = 0,
		Max = 100,
		Rounding = 0,
		Suffix = "%",
		Tooltip = "Heal on low HP",
		Callback = function(value)
			tbl8.cardHealBelow = value
		end,
	})

	v31:AddToggle("AutoReroll", {
		Text = "Auto Reroll Bad",
		Default = false,
		Tooltip = "Spend ticket on low picks",
		Callback = function(autoRerollBad)
			tbl8.autoReroll = autoRerollBad
		end,
	})

	local rerollBelows = { UnCommon = 2, Rare = 3, Epic = 4, Legendary = 5 }

	v31:AddDropdown("AutoRerollMin", {
		Text = "Reroll Below",
		Values = { "UnCommon", "Rare", "Epic", "Legendary" },
		Default = "Epic",
		AllowNull = false,
		Tooltip = "Minimum tier to keep",
		Callback = function(rerollBelow)
			tbl8.autoRerollMin = rerollBelows[rerollBelow] or 4
		end,
	})

	local Teleport = tbl7.Dungeon:AddLeftGroupbox("Teleport")
	local vector = Vector3.new(-2299.30249, 1144.706299, -2634.999512)
	local cframe = nil
	local flag12 = false

	getConnection(localPlayer.CharacterAdded:Connect(function()
		cframe = nil
		flag12 = false
	end))

	Teleport:AddButton({
		Text = "Zeni Tp/Click To Return",
		Func = function()
			if game.PlaceId ~= 75556147183481 then
				lib:Notify({ Title = "Zeni", Description = "Only works inside Ouwigahara.", Time = 3 })
				return
			end
			local v32, v33, v34 = fn18()
			if not v34 then
				return
			end

			if flag12 and cframe then
				task.spawn(myhubGuardTP, cframe)
				cframe = nil
				flag12 = false
			else
				cframe = v34.CFrame
				task.spawn(myhubGuardTP, CFrame.new(vector))
				flag12 = true
			end
		end,
	})

	Teleport:AddButton({
		Text = "TP to Ouwigahara",
		Tooltip = "Enter Ouwigahara",
		Func = function()
			if game.PlaceId ~= 136406881576517 then
				lib:Notify({ Title = "Ouwigahara", Description = "Only works in Ouwland.", Time = 3 })
				return
			end
			local v32, v33, v34 = fn18()
			if not v34 then
				return
			end
			local vector2 = Vector3.new(-1606, 1011, 1143)

			task.spawn(function()
				myhubGuardTP(CFrame.new(vector2))

				for i = 1, 20 do
					task.wait(0.15)
					local ouwigaharaPromptPad = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("OuwigaharaPromptPad")
					local ouwigahara = ouwigaharaPromptPad and ouwigaharaPromptPad:FindFirstChild("Ouwigahara")

					if ouwigahara and ouwigahara:IsA("ProximityPrompt") then
						pcall(function()
							if fireproximityprompt then
								fireproximityprompt(ouwigahara)
							end
						end)

						pcall(function()
							ouwigahara:InputHoldBegin()
						end)

						task.delay(math.max(0.05, (ouwigahara.HoldDuration or 0) + 0.05), function()
							pcall(function()
								ouwigahara:InputHoldEnd()
							end)
						end)

						return
					end
				end

				lib:Notify({ Title = "Ouwigahara", Description = "Prompt didn't stream in.", Time = 3 })
			end)
		end,
	})

	local v32 = tbl7.Dungeon:AddRightGroupbox("Zeni Shop")
	local tbl12 = {}
	local tbl13 = {}
	local tbl14 = {}
	local minigamesPlace = game:GetService("ReplicatedStorage"):FindFirstChild("Minigames Place")
	local zeni = minigamesPlace and minigamesPlace:FindFirstChild("Content") and minigamesPlace.Content:FindFirstChild("Ouwigahara") and minigamesPlace.Content.Ouwigahara:FindFirstChild("Npcs") and minigamesPlace.Content.Ouwigahara.Npcs:FindFirstChild("Zeni")
	local result3 = nil
	local ok3 = false

	if zeni then
		ok3, result3 = pcall(require, zeni)
	end

	if ok3 and type(result3) == "table" and type(result3.Shop) == "table" then
		for k, v33 in pairs(result3.Shop) do
			local flag13 = type(v33) == "table" and type(v33.Price) == "table"
			local str4 = "—"

			if flag13 then
				local v34, v35, v36 = pairs(v33.Price)
				local str5 = "—"
				local v37 = table.pack(pcall(v34, v35, v36))

				if v37[1] then
					local v38 = v37[3]
					local str6 = tostring(v37[2])

					if str6 == "RunPoints" then
						tbl12[k] = tonumber(v38)
						str6 = "Points"
					end

					str5 = string.format("%s %s", tostring(v38), str6)
				end

				str4 = str5
			end

			local str5 = string.format("%s — %s", k, str4)
			table.insert(tbl13, str5)
			tbl14[str5] = k
		end
	end

	table.sort(tbl13)

	v32:AddDropdown("ZeniBuyItems", {
		Text = "Items",
		Values = tbl13,
		Multi = true,
		Default = {},
		AllowNull = true,
		Callback = function(items)
			local zeniBuyItems = {}

			if type(items) == "table" then
				for k, item in pairs(items) do
					if item and tbl14[k] then
						table.insert(zeniBuyItems, tbl14[k])
					end
				end
			end

			tbl8.zeniBuyItems = zeniBuyItems
		end,
	})

	v32:AddToggle("AutoBuyZeni", {
		Text = "Auto Buy from Zeni",
		Default = false,
		Tooltip = "Buy selected items",
		Callback = function(autoBuyFromZeni)
			tbl8.autoBuyZeni = autoBuyFromZeni
		end,
	})

	v32:AddSlider("ZeniBuyAmount", {
		Text = "Buy Amount",
		Default = 1,
		Min = 1,
		Max = 10,
		Rounding = 0,
		Tooltip = "Per item per cycle",
		Callback = function(buyAmount)
			tbl8.zeniBuyAmount = buyAmount
		end,
	})

	local v33 = nil

	local function fn37()
		if v33 then
			return v33
		end
		local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
		local signalEvent = ReplicatedStorage2:FindFirstChild("Communication") and ReplicatedStorage2.Communication:FindFirstChild("ServerAndClient") and ReplicatedStorage2.Communication.ServerAndClient:FindFirstChild("Signals") and ReplicatedStorage2.Communication.ServerAndClient.Signals:FindFirstChild("SignalEvent")
		if not signalEvent then
			return nil
		end
		local ok4, result4 = pcall(require, signalEvent)
		if ok4 and type(result4) == "table" and type(result4.ToServer) == "function" then
			v33 = result4
			return result4
		end
		return nil
	end

	local v34 = nil

	local function fn38()
		if v34 then
			return v34
		end
		local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
		local dialogue = ReplicatedStorage2:FindFirstChild("CAM") and ReplicatedStorage2.CAM:FindFirstChild("Client") and ReplicatedStorage2.CAM.Client:FindFirstChild("Modules") and ReplicatedStorage2.CAM.Client.Modules:FindFirstChild("GamePlay") and ReplicatedStorage2.CAM.Client.Modules.GamePlay:FindFirstChild("Dialogue")
		if not dialogue then
			return nil
		end
		local ok4, result4 = pcall(require, dialogue)
		if ok4 and type(result4) == "table" and result4.Functions and type(result4.Functions.ProceedWithCartPurchase) == "function" then
			v34 = result4
			return result4
		end
		return nil
	end

	task.spawn(function()
		while _G.MyHubSession == myHubSession do
			if tbl8.autoBuyZeni and game.PlaceId == 75556147183481 and tbl8.zeniBuyItems and #tbl8.zeniBuyItems > 0 then
				local v35, v36, v37 = fn18()

				if v37 then
					local n = tonumber(localPlayer:GetAttribute("RunPoints")) or 0
					local n10 = math.clamp(tonumber(tbl8.zeniBuyAmount) or 1, 1, 10)
					local zeniBuyItems = {}

					for _, zeniBuyItem in ipairs(tbl8.zeniBuyItems) do
						local v38 = tbl12[zeniBuyItem]

						if v38 and n >= v38 * n10 then
							table.insert(zeniBuyItems, zeniBuyItem)
						end
					end

					if #zeniBuyItems > 0 then
						local v38 = fn38()

						if v38 then
							local cframe2 = v37.CFrame
							myhubGuardTP(CFrame.new(vector + Vector3.new(0, 3, 0)))
							task.wait(0.2)

							for _, zeniBuyItem in ipairs(zeniBuyItems) do
								for i = 1, n10 do
									pcall(function()
										v38.Storage.BuySelection = { [zeniBuyItem] = 1 }
										v38.Storage.CartShopNode = "Changer Zeni"
										v38.Functions.ProceedWithCartPurchase("Deal", v38.Storage)
									end)

									task.wait(0.15)
								end
							end

							myhubGuardTP(cframe2)
						end
					end
				end
			end

			task.wait(1)
		end
	end)

	local v35 = tbl7.Dungeon:AddRightGroupbox("Tower Crystal Shop")
	local tbl15 = {}
	local tbl16 = {}
	local tbl17 = {}
	local tbl18 = {}
	local minigamesPlace2 = game:GetService("ReplicatedStorage"):FindFirstChild("Minigames Place")
	local crystal = minigamesPlace2 and minigamesPlace2:FindFirstChild("Content") and minigamesPlace2.Content:FindFirstChild("Ouwigahara") and minigamesPlace2.Content.Ouwigahara:FindFirstChild("Crystal")
	local ok4 = false
	local result4 = nil

	if crystal then
		ok4, result4 = pcall(require, crystal)
	end

	if ok4 and type(result4) == "table" and type(result4.Stock) == "table" then
		for k, v36 in pairs(result4.Stock) do
			local flag13 = type(v36) == "table" and type(v36.Price) == "table"
			local str4 = "—"

			if flag13 then
				local v37, v38, v39 = pairs(v36.Price)
				str4 = "—"
				local v40 = table.pack(pcall(v37, v38, v39))

				if v40[1] then
					local v41 = v40[3]
					local str5 = tostring(v40[2])

					if str5 == "RunPoints" then
						tbl15[k] = tonumber(v41)
						str5 = "Points"
					end

					str4 = string.format("%s %s", tostring(v41), str5)
				end
			end

			tbl16[k] = k:find(" Mastery$") and "Tower Crystal_Mastery" or "Tower Crystal"
			local str5 = string.format("%s — %s", k, str4)
			table.insert(tbl17, str5)
			tbl18[str5] = k
		end
	end

	table.sort(tbl17)

	v35:AddDropdown("CrystalBuyItems", {
		Text = "Items",
		Values = tbl17,
		Multi = true,
		Default = {},
		AllowNull = true,
		Callback = function(items)
			local crystalBuyItems = {}

			if type(items) == "table" then
				for k, item in pairs(items) do
					item = item and tbl18[k]

					if item then
						table.insert(crystalBuyItems, tbl18[k])
					end
				end
			end

			tbl8.crystalBuyItems = crystalBuyItems
		end,
	})

	v35:AddToggle("AutoBuyCrystal", {
		Text = "Auto Buy from Crystal",
		Default = false,
		Tooltip = "Buy selected items",
		Callback = function(autoBuyFromCrystal)
			tbl8.autoBuyCrystal = autoBuyFromCrystal
		end,
	})

	v35:AddSlider("CrystalBuyAmount", {
		Text = "Buy Amount",
		Default = 1,
		Min = 1,
		Max = 10,
		Rounding = 0,
		Tooltip = "Per item per cycle",
		Callback = function(buyAmount)
			tbl8.crystalBuyAmount = buyAmount
		end,
	})

	local vector2 = Vector3.new(-2366.914, 1148.534, -2686.362)

	local function fn39()
		local map = workspace:FindFirstChild("Map")
		local towerCrystal = map and map:FindFirstChild("Tower Crystal")

		if towerCrystal then
			if towerCrystal:IsA("Model") and towerCrystal.PrimaryPart then
				return towerCrystal.PrimaryPart.Position
			end

			if towerCrystal:IsA("Model") then
				local child = towerCrystal:FindFirstChildWhichIsA("BasePart", true)
				if child then
					return child.Position
				end
			end

			if towerCrystal:IsA("BasePart") then
				return towerCrystal.Position
			end
		end

		return vector2
	end

	task.spawn(function()
		while _G.MyHubSession == myHubSession do
			if tbl8.autoBuyCrystal and game.PlaceId == 75556147183481 and tbl8.crystalBuyItems and #tbl8.crystalBuyItems > 0 then
				local v36, v37, v38 = fn18()

				if v38 then
					local n = tonumber(localPlayer:GetAttribute("RunPoints")) or 0
					local n10 = math.clamp(tonumber(tbl8.crystalBuyAmount) or 1, 1, 10)
					local crystalBuyItems = {}

					for _, crystalBuyItem in ipairs(tbl8.crystalBuyItems) do
						local v39 = tbl15[crystalBuyItem]

						if v39 and n >= v39 * n10 then
							table.insert(crystalBuyItems, crystalBuyItem)
						end
					end

					if #crystalBuyItems > 0 then
						local v39 = fn38()

						if v39 then
							local cframe2 = v38.CFrame
							myhubGuardTP(CFrame.new(fn39() + Vector3.new(0, 3, 0)))
							task.wait(0.2)

							for _, crystalBuyItem in ipairs(crystalBuyItems) do
								for i = 1, n10 do
									pcall(function()
										v39.Storage.BuySelection = { [crystalBuyItem] = 1 }
										v39.Storage.CartShopNode = tbl16[crystalBuyItem] or "Tower Crystal"
										v39.Functions.ProceedWithCartPurchase("Deal", v39.Storage)
									end)

									task.wait(0.15)
								end
							end

							myhubGuardTP(cframe2)
						end
					end
				end
			end

			task.wait(1)
		end
	end)

	task.spawn(function()
		local readyUp2 = nil

		while _G.MyHubSession == myHubSession do
			if tbl8.autoReadyUp and game.PlaceId == 75556147183481 then
				local map = workspace:FindFirstChild("Map")
				local minigameMap = map and map:FindFirstChild("Minigame Map")
				local startPad = minigameMap and minigameMap:FindFirstChild("StartPad")
				local readyUp = startPad and startPad:FindFirstChild("ReadyUp")

				if readyUp and readyUp:IsA("ProximityPrompt") and startPad and startPad:IsA("BasePart") and readyUp ~= readyUp2 and readyUp.Enabled ~= false then
					local v36, v37, v38 = fn18()

					if v38 then
						myhubGuardTP(CFrame.new(startPad.Position + Vector3.new(0, 3, 0)))
					end

					task.wait(0.15)

					pcall(function()
						if fireproximityprompt then
							fireproximityprompt(readyUp)
						end
					end)

					pcall(function()
						readyUp:InputHoldBegin()
					end)

					task.delay(math.max(0.05, (readyUp.HoldDuration or 0) + 0.05), function()
						pcall(function()
							readyUp:InputHoldEnd()
						end)
					end)

					task.wait(1)

					if readyUp.Parent and readyUp.Enabled ~= false then
						readyUp2 = nil
					else
						readyUp2 = readyUp
					end
				end
			end

			task.wait(0.5)
		end
	end)

	task.spawn(function()
		while _G.MyHubSession == myHubSession do
			if tbl8.autoSkipWave and workspace:GetAttribute("MinigameWaveBreak") then
				local v36 = fn37()

				if v36 then
					pcall(function()
						v36.ToServer("OuwigaharaRequest", { action = "Skip" })
					end)
				end
			end

			task.wait(0.5)
		end
	end)

	task.spawn(function()
		local tbl19 = {
			common = 1,
			uncommon = 2,
			rare = 3,
			epic = 4,
			legendary = 5,
			mythic = 6,
			impossible = 7,
			limited = 8,
		}

		local tbl20 = {}

		local ok5, result5 = pcall(function()
			return game:GetService("ReplicatedStorage")
		end)

		local events = nil

		if ok5 then
			pcall(function()
				events = result5["Minigames Place"].Minigames.Ouwigahara.Events
			end)
		end

		if events then
			for _, child in ipairs(events:GetChildren()) do
				for _, child2 in ipairs(child:GetChildren()) do
					local ok6, result6 = pcall(require, child2)

					if ok6 and type(result6) == "table" and type(result6.Title) == "string" and type(result6.Rarity) == "number" then
						tbl20[result6.Title:gsub("%s*:.*$", ""):gsub("%s*,.*$", ""):lower()] = result6.Rarity
					end
				end
			end
		end

		local function fn40(instance)
			local texts = {}

			for _, descendant in ipairs(instance:GetDescendants()) do
				if descendant:IsA("TextLabel") and descendant.Text and descendant.Text ~= "" then
					table.insert(texts, descendant.Text)
				end
			end

			return table.concat(texts, " | "):lower()
		end

		local getCardBaseName = nil

		local tbl21 = {
			["0.875,0.902,0.800"] = 1,
			["0.498,0.839,0.467"] = 2,
			["0.310,0.725,1.000"] = 3,
			["0.851,0.302,0.851"] = 4,
			["1.000,0.792,0.173"] = 5,
			["0.631,0.000,0.000"] = 6,
			["0.000,0.000,0.000"] = 7,
			["1.000,0.431,0.078"] = 8,
		}

		if type(readfile) == "function" and type(isfile) == "function" and isfile("WinHub/GameName/rarity_palette.json") then
			local ok6, result6 = pcall(readfile, "WinHub/GameName/rarity_palette.json")

			if ok6 and type(result6) == "string" and #result6 > 0 then
				local ok7, result7 = pcall(function()
					return HttpService:JSONDecode(result6)
				end)

				if ok7 and type(result7) == "table" then
					for k, v36 in pairs(result7) do
						if type(k) == "string" and type(v36) == "number" then
							tbl21[k] = v36
						end
					end
				end
			end
		end

		local flag13 = false
		local now4 = 0

		local function fn41()
			if type(writefile) ~= "function" then
				return
			end
			local now3 = os.clock()
			if now3 - now4 < 1 then
				return
			end

			if pcall(function()
				writefile("WinHub/GameName/rarity_palette.json", HttpService:JSONEncode(tbl21))
			end) then
				flag13 = false
				now4 = now3
			end
		end

		local function fn42(color)
			return string.format("%.3f,%.3f,%.3f", color.R, color.G, color.B)
		end

		local function getColor(instance)
			local uiStroke = instance:FindFirstChildOfClass("UIStroke")
			if uiStroke then
				return uiStroke.Color
			end

			for _, descendant in ipairs(instance:GetDescendants()) do
				if descendant:IsA("UIStroke") then
					return descendant.Color
				end
			end
		end

		local function fn43(instance)
			local attribute = instance:GetAttribute("Rarity")
			if type(attribute) == "number" then
				return attribute
			end

			if type(attribute) == "string" and tbl19[attribute:lower()] then
				return tbl19[attribute:lower()]
			end
			local ok6, result6 = pcall(getCardBaseName, instance)

			if ok6 and type(result6) == "string" and result6 ~= "" then
				local v36 = tbl20[result6:lower()]

				if v36 then
					local color = getColor(instance)

					if color then
						local v37 = fn42(color)

						if tbl21[v37] ~= v36 then
							tbl21[v37] = v36
							flag13 = true
							fn41()
						end
					end

					return v36
				end
			end

			local color = getColor(instance)

			if color then
				local v36 = tbl21[fn42(color)]
				if v36 then
					return v36
				end
			end

			local v36 = fn40(instance)
			local v37 = nil

			for k, v38 in pairs(tbl19) do
				if v36:find(k, 1, true) and (not v37 or v38 > v37) then
					v37 = v38
				end
			end

			return v37 or 0
		end

		local function fn44(instance, arg)
			local str4 = arg:lower()
			local str5 = arg:gsub("%s+", ""):lower()
			local attribute = instance:GetAttribute("Type") or instance:GetAttribute("PerkType") or instance:GetAttribute("CardType")

			if type(attribute) == "string" then
				local attribute2 = attribute:lower()
				if attribute2 == str4 or attribute2 == str5 then
					return true
				end
			end

			for _, descendant in ipairs(instance:GetDescendants()) do
				if descendant:IsA("TextLabel") and (descendant.Name == "Type" or descendant.Name == "CardType") and type(descendant.Text) == "string" then
					local text = descendant.Text:lower()
					if text == str4 or text == str5 then
						return true
					end
				end
			end

			return fn40(instance):find(str4, 1, true) ~= nil
		end

		getCardBaseName = function(instance)
			local textSize2 = -1
			local text = nil

			for _, descendant in ipairs(instance:GetDescendants()) do
				if not (descendant:IsA("TextLabel") and descendant.Text and descendant.Text ~= "") then
					continue
				end

				if descendant.Name == "Title" or descendant.Name == "Header" or descendant.Name == "Name" or descendant.Name == "PerkName" then
					text = descendant.Text
					break
				end
				local textSize = descendant.TextSize or 0

				if textSize2 < textSize then
					text = descendant.Text
					textSize2 = textSize
				end
			end

			return _G._cardBaseName and _G._cardBaseName(text or "") or text or ""
		end

		local bbCards2 = nil

		while _G.MyHubSession == myHubSession do
			if tbl8.autoCard then
				local playerGui = localPlayer:FindFirstChild("PlayerGui")
				local componentsHolder = playerGui and playerGui:FindFirstChild("ComponentsHolder")
				local ouwigaharaOffers = componentsHolder and componentsHolder:FindFirstChild("MainNotificationFrame") and componentsHolder.MainNotificationFrame:FindFirstChild("OuwigaharaOffers")
				local bbCards = ouwigaharaOffers and ouwigaharaOffers:FindFirstChild("BBCards")
				local cards = bbCards and bbCards:FindFirstChild("Cards")

				if cards and bbCards ~= bbCards2 then
					task.wait(0.3)

					if cards.Parent then
						local children = {}

						for _, child in ipairs(cards:GetChildren()) do
							if child:IsA("Frame") and tonumber(child.Name) then
								table.insert(children, child)
							end
						end

						local children2

						if tbl8.cardBlacklist and next(tbl8.cardBlacklist) then
							children2 = {}

							for _, child in ipairs(children) do
								local text = nil
								local textSize2 = -1

								for _, descendant in ipairs(child:GetDescendants()) do
									if not (descendant:IsA("TextLabel") and descendant.Text and descendant.Text ~= "") then
										continue
									end

									if descendant.Name == "Title" or descendant.Name == "Header" or descendant.Name == "Name" or descendant.Name == "PerkName" then
										text = descendant.Text
										break
									end
									local textSize = descendant.TextSize or 0

									if textSize2 < textSize then
										text = descendant.Text
										textSize2 = textSize
									end
								end

								if not tbl8.cardBlacklist[(_G._cardBaseName and _G._cardBaseName(text or "") or text or ""):lower()] then
									table.insert(children2, child)
								end
							end
						else
							children2 = children
						end

						local name = nil

						if tbl8.cardHealBelow and tbl8.cardHealBelow > 0 then
							local character = localPlayer.Character
							local humanoid = character and character:FindFirstChildOfClass("Humanoid")

							if humanoid and humanoid.MaxHealth > 0 then
								if humanoid.Health / humanoid.MaxHealth * 100 <= tbl8.cardHealBelow then
									local v36 = nil
									local child2 = nil

									for _, child in ipairs(children2) do
										if fn40(child):find("full health", 1, true) then
											local v37 = fn43(child)

											if not v36 or v37 > v36 then
												v36 = v37
												child2 = child
											end
										end
									end

									if child2 then
										name = child2.Name
									end
								end
							end
						end

						if not name then
							local v36 = ipairs
							local cardPriority = tbl8.cardPriority or {}

							for _, v37 in v36(cardPriority) do
								local str4 = v37:lower()

								for _, child in ipairs(children2) do
									if getCardBaseName(child):lower() == str4 then
										name = child.Name
										break
									end
								end

								if name then
									break
								end
								local v38 = nil
								local child2 = nil

								for _, child in ipairs(children2) do
									if fn44(child, v37) then
										local v39 = fn43(child)

										if not v38 or v39 > v38 then
											v38 = v39
											child2 = child
										end
									end
								end

								if child2 then
									name = child2.Name
									break
								end
							end
						end

						local flag14 = false
						local n = 0

						if not name then
							local v36, v37, v38 = ipairs(children2)
							local v39 = nil
							local v40 = nil

							for _, v41 in v36, v37, v38 do
								local v42 = fn43(v41)

								if not v39 or v42 > v39 then
									v39 = v42
									v40 = v41
								end
							end

							if v40 then
								name = v40.Name
								flag14 = true
								n = v39 or n
							end
						end

						if name and flag14 and tbl8.autoReroll and (tbl8.autoRerollMin or 4) > n then
							local reroll = cards:FindFirstChild("Reroll")
							local disc = reroll and reroll:FindFirstChild("Disc")
							local count2 = disc and disc:FindFirstChild("Count")

							if (count2 and count2:IsA("TextLabel") and tonumber(count2.Text) or 0) > 0 then
								local v36 = fn37()

								if v36 then
									pcall(function()
										v36.ToServer("OuwigaharaRequest", { action = "Reroll" })
									end)

									name = nil
									bbCards2 = bbCards
								end
							end
						end

						if name then
							local v36 = fn37()

							if v36 then
								pcall(function()
									v36.ToServer("OuwigaharaRequest", { action = "Pick", id = name })
								end)

								bbCards2 = bbCards
							end
						end
					end
				elseif not cards then
					bbCards2 = nil
				end
			end

			task.wait(0.3)
		end
	end)

	local rootPart = nil

	local function getRootPart(position)
		local child = workspace:FindFirstChild("Humanoids")
		if not child then
			return nil
		end
		local dot2 = nil
		local rootPart3 = nil

		for _, descendant in ipairs(child:GetDescendants()) do
			if not (descendant:IsA("Humanoid") and descendant:GetState() ~= Enum.HumanoidStateType.Dead) then
				continue
			end
			local parent = descendant.Parent
			if not (parent and parent:IsA("Model") and parent ~= localPlayer.Character and not Players:GetPlayerFromCharacter(parent)) then
				continue
			end
			local rootPart2 = descendant.RootPart or parent:FindFirstChild("HumanoidRootPart") or parent:FindFirstChild("Head")

			if rootPart2 and rootPart2:IsA("BasePart") and not rootPart2.Anchored then
				local position2 = rootPart2.Position - position
				local dot = position2:Dot(position2)

				if not dot2 or dot < dot2 then
					dot2 = dot
					rootPart3 = rootPart2
				end
			end
		end

		return rootPart3
	end

	local function getVector()
		local farmDistance = tbl8.farmDistance or 6
		local vector3

		if tbl8.farmPosition == "Above" then
			vector3 = Vector3.new(0, farmDistance, 0)
		elseif tbl8.farmPosition == "Below" then
			vector3 = Vector3.new(0, -farmDistance, 0)
		elseif tbl8.farmPosition == "In Front" then
			vector3 = Vector3.new(0, 0, -farmDistance)
		else
			vector3 = Vector3.new(0, 0, farmDistance)
		end

		return vector3 + Vector3.new(tbl8.farmOffX or 0, tbl8.farmOffY or 0, tbl8.farmOffZ or 0)
	end

	local function fn40(instance)
		if not (instance and instance.Parent) then
			return false
		end
		local humanoid = instance.Parent:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return false
		end

		if humanoid:GetState() == Enum.HumanoidStateType.Dead then
			return false
		end
		return true
	end

	task.spawn(function()
		local deadline = 0

		while _G.MyHubSession == myHubSession do
			if tbl8.autoDungeon and game.PlaceId == 136406881576517 then
				local now3 = os.clock()

				if now3 >= deadline then
					deadline = now3 + 2
					local v36, v37, v38 = fn18()

					if v38 then
						local myhubGuardTP2 = myhubGuardTP
						local v39 = table.pack(CFrame.new(Vector3.new(-1606, 1011, 1143)))
						myhubGuardTP2(table.unpack(v39, 1, v39.n))

						for i = 1, 20 do
							task.wait(0.15)
							local ouwigaharaPromptPad = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("OuwigaharaPromptPad")
							local ouwigahara = ouwigaharaPromptPad and ouwigaharaPromptPad:FindFirstChild("Ouwigahara")
							if not (ouwigahara and ouwigahara:IsA("ProximityPrompt")) then
								continue
							end

							pcall(function()
								if fireproximityprompt then
									fireproximityprompt(ouwigahara)
								end
							end)

							pcall(function()
								ouwigahara:InputHoldBegin()
							end)

							task.delay(math.max(0.05, (ouwigahara.HoldDuration or 0) + 0.05), function()
								pcall(function()
									ouwigahara:InputHoldEnd()
								end)
							end)

							break
						end

						task.wait(3)

						if game.PlaceId == 136406881576517 then
							deadline = 0
						end
					end
				end
			end

			task.wait(0.5)
		end
	end)

	task.spawn(function()
		while _G.MyHubSession == myHubSession do
			if tbl8.autoDungeon and game.PlaceId == 75556147183481 then
				local v36, v37, v38 = fn18()

				if v38 then
					if not fn40(rootPart) then
						rootPart = getRootPart(v38.Position)
					end
				end
			else
				rootPart = nil
			end

			task.wait(0.2)
		end
	end)

	getConnection(RunService.Heartbeat:Connect(function()
		if not tbl8.autoDungeon then
			return
		end

		if game.PlaceId ~= 75556147183481 then
			return
		end

		if not fn40(rootPart) then
			rootPart = nil
			return
		end
		local E = rootPart.AssemblyLinearVelocity
		if E and (E.Magnitude > 400) then
			rootPart = nil
			return
		end
		E = localPlayer.Character
		local h, Q = E and (E:FindFirstChildOfClass("Humanoid")), E and (E:FindFirstChild("HumanoidRootPart"))
		if not Q then
			return
		end

		pcall(function()
			if h and h.PlatformStand then
				h.PlatformStand = false
			end

			local E, l = rootPart.Position, rootPart.CFrame.LookVector
			local B = Vector3.new(l.X, 0, l.Z)
			l = ((if B.Magnitude < 0.01 then (CFrame.new(E)) else (CFrame.lookAt(E, E + B.Unit))) * CFrame.new(getVector())).Position
			Q.CFrame = CFrame.lookAt(l, E)
			Q.AssemblyLinearVelocity = Vector3.zero
			Q.AssemblyAngularVelocity = Vector3.zero

			if h then
				l = h:GetState()

				if ((l == Enum.HumanoidStateType.Physics) or (l == Enum.HumanoidStateType.Ragdoll)) or (l == Enum.HumanoidStateType.FallingDown) then
					h:ChangeState(Enum.HumanoidStateType.Running)
				end
			end
		end)
	end))

	task.spawn(function()
		while _G.MyHubSession == myHubSession do
			if tbl8.autoDungeon and rootPart and rootPart.Parent then
				_G.__myhubDungeonTarget = rootPart
			else
				_G.__myhubDungeonTarget = nil
			end

			task.wait(0.1)
		end
	end)

	if not tbl6.isPremium then
		fn19(v31)
		fn19(Teleport)
		fn19(v32)
		fn19(v35)
	end
end

local esp = tbl7.Visuals:AddLeftGroupbox("ESP")

esp:AddToggle("PlayerESP", {
	Text = "Players",
	Default = false,
	Callback = function(players)
		tbl8.espPlayers = players
	end,
}):AddColorPicker("PlayerColor", {
	Default = tbl8.espPlayerColor,
	Title = "Players",
	Callback = function(players)
		tbl8.espPlayerColor = players
	end,
})

esp:AddToggle("NpcESP", {
	Text = "NPCs",
	Default = false,
	Callback = function(npCs)
		tbl8.espNpcs = npCs
	end,
}):AddColorPicker("NpcColorV2", {
	Default = tbl8.espNpcColor,
	Title = "NPCs",
	Callback = function(npCs)
		tbl8.espNpcColor = npCs
	end,
})

esp:AddToggle("MobESP", {
	Text = "Mobs",
	Default = false,
	Callback = function(mobs)
		tbl8.espMobs = mobs
	end,
}):AddColorPicker("MobColor", {
	Default = tbl8.espMobColor,
	Title = "Mobs",
	Callback = function(mobs)
		tbl8.espMobColor = mobs
	end,
})

esp:AddToggle("ItemESP", {
	Text = "Items",
	Default = false,
	Callback = function(items)
		tbl8.espItems = items
	end,
}):AddColorPicker("ItemColor", {
	Default = tbl8.espItemColor,
	Title = "Items",
	Callback = function(items)
		tbl8.espItemColor = items
	end,
})

esp:AddToggle("QuestItemESP", {
	Text = "Quest Items",
	Default = false,
	Tooltip = "Quest task pickups",
	Callback = function(questItems)
		tbl8.espQuestItems = questItems
	end,
}):AddColorPicker("QuestItemColor", {
	Default = tbl8.espQuestItemColor,
	Title = "Quest Items",
	Callback = function(questItems)
		tbl8.espQuestItemColor = questItems
	end,
})

esp:AddToggle("ChestESP", {
	Text = "Chests",
	Default = false,
	Tooltip = "Highlight chests",
	Callback = function(chests)
		tbl8.espChests = chests
	end,
}):AddColorPicker("ChestColor", {
	Default = tbl8.espChestColor,
	Title = "Chests",
	Callback = function(chests)
		tbl8.espChestColor = chests
	end,
})

local v23 = tbl7.Visuals:AddRightGroupbox("ESP Settings")

v23:AddToggle("EspShowHl", {
	Text = "Show Highlights",
	Default = true,
	Tooltip = "Outlines",
	Callback = function(showHighlights)
		tbl8.espShowHl = showHighlights
	end,
})

v23:AddToggle("EspShowHp", {
	Text = "Show Health",
	Default = true,
	Callback = function(showHealth)
		tbl8.espShowHp = showHealth
	end,
}):AddColorPicker("EspHpColor", {
	Default = tbl8.espHpColor,
	Title = "Health Text",
	Callback = function(healthText)
		tbl8.espHpColor = healthText
	end,
})

v23:AddToggle("EspShowDist", {
	Text = "Show Distance",
	Default = true,
	Callback = function(showDistance)
		tbl8.espShowDist = showDistance
	end,
}):AddColorPicker("EspDistColor", {
	Default = tbl8.espDistColor,
	Title = "Distance Text",
	Callback = function(distanceText)
		tbl8.espDistColor = distanceText
	end,
})

v23:AddDropdown("EspFont", {
	Text = "Font",
	Values = {
		"Gotham",
		"GothamMedium",
		"GothamBold",
		"GothamBlack",
		"SourceSans",
		"SourceSansBold",
		"SourceSansItalic",
		"SourceSansSemibold",
		"Code",
		"Legacy",
		"Arcade",
		"Bangers",
		"Cartoon",
		"Fantasy",
		"Highway",
		"Merriweather",
		"Michroma",
		"Nunito",
		"Oswald",
		"PatrickHand",
		"RobotoMono",
		"Roboto",
		"Sarpanch",
		"SciFi",
		"Ubuntu",
	},
	Default = "GothamBold",
	AllowNull = false,
	Callback = function(font)
		tbl8.espFont = font
	end,
})

v23:AddSlider("EspMaxDist", {
	Text = "Max Distance",
	Default = tbl8.espMaxDist,
	Min = 50,
	Max = 3000,
	Rounding = 0,
	Suffix = "",
	Callback = function(maxDistance)
		tbl8.espMaxDist = maxDistance
	end,
})

v23:AddSlider("EspTextSize", {
	Text = "Text Size",
	Default = tbl8.espTextSize,
	Min = 8,
	Max = 32,
	Rounding = 0,
	Suffix = "",
	Callback = function(textSize)
		tbl8.espTextSize = textSize
	end,
})

tbl7.Visuals:AddRightGroupbox("Map"):AddButton({
	Text = "Reveal Map",
	Tooltip = "Show hidden pins",
	Func = function()
		local playerGui = localPlayer:FindFirstChild("PlayerGui")
		local componentsHolder = playerGui and playerGui:FindFirstChild("ComponentsHolder")
		local minimap = componentsHolder and componentsHolder:FindFirstChild("Minimap")
		local pinsHolder = minimap and minimap:FindFirstChild("FadeMask") and minimap.FadeMask:FindFirstChild("PinsHolder")
		if not pinsHolder then
			lib:Notify({ Title = "Map", Description = "Open the map first.", Time = 3 })
			return
		end
		local v24 = 0
		local color = Color3.new(1, 1, 1)

		for _, child in ipairs(pinsHolder:GetChildren()) do
			for _, child2 in ipairs(child:GetChildren()) do
				local label = child2:FindFirstChild("Label")

				if label and label:IsA("TextLabel") and label.Text == "???" then
					pcall(function()
						label.Text = child2.Name
					end)

					v24 += 1
				end

				for _, name in ipairs({ "Bg", "Icon" }) do
					local child3 = child2:FindFirstChild(name)

					if child3 and child3:IsA("ImageLabel") then
						pcall(function()
							child3.ImageColor3 = color
						end)
					end
				end
			end
		end

		lib:Notify({ Title = "Map", Description = "Revealed " .. v24 .. " pin(s).", Time = 2 })
	end,
})

local function fn19(arg)

	if arg == "player" then
		return tbl8.espPlayerColor
	end

	if arg == "npc" then
		return tbl8.espNpcColor
	end

	if arg == "item" then
		return tbl8.espItemColor
	end

	if arg == "questitem" then
		return tbl8.espQuestItemColor
	end

	if arg == "chest" then
		return tbl8.espChestColor
	end
	return tbl8.espMobColor
end

do
	local function fn20()
		local tbl9 = {}
		local child = game:GetService("ReplicatedStorage"):FindFirstChild("Player_Service")
		local data = child and child:FindFirstChild("Data")
		local child2 = data and data:FindFirstChild(localPlayer.Name)
		local slot1 = child2 and child2:FindFirstChild("slots") and child2.slots:FindFirstChild("Slot1")
		local holder = slot1 and slot1:FindFirstChild("Quests") and slot1.Quests:FindFirstChild("Holder")
		if not holder then
			return tbl9
		end

		local function fn21(arg)
			if arg and #arg >= 4 then
				tbl9[arg] = true
			end
		end

		local function fn22(name)
			fn21(name)
			local v24 = fn21
			local str3 = name:gsub("s$", "")
			v24(str3)
		end

		for _, child3 in ipairs(holder:GetChildren()) do
			local tasks = child3:FindFirstChild("Tasks")
			if not tasks then
				continue
			end

			for _, child4 in ipairs(tasks:GetChildren()) do
				local name = child4.Name:lower()
				fn22(name)

				while true do
					name = name:match("^(.-)%s+%S+$")
					if not (name and not (#name < 4)) then
						break
					end
					fn22(name)
				end
			end
		end

		return tbl9
	end

	local tbl9 = {
		"bandit",
		"raider",
		"captain",
		"reaper",
		"grove",
		"raid",
		"demon",
		"hostile",
		"enemy",
		"boss",
		"trainee",
		"lancer",
		"born",
		"elite",
		"mini",
		"subordinate",
		"guard",
		"grunt",
		"minion",
		"acolyte",
		"cultist",
		"thug",
		"brigand",
		"outlaw",
		"assassin",
		"mercenary",
		"goon",
		"lackey",
		"henchman",
	}

	local tbl10 = nil

	local function fn21()
		tbl10 = {}
		local playerGui = localPlayer:FindFirstChild("PlayerGui")
		local componentsHolder = playerGui and playerGui:FindFirstChild("ComponentsHolder")
		local minimap = componentsHolder and componentsHolder:FindFirstChild("Minimap")
		local pinsHolder = minimap and minimap:FindFirstChild("FadeMask") and minimap.FadeMask:FindFirstChild("PinsHolder")
		local bosses = pinsHolder and pinsHolder:FindFirstChild("Bosses")

		if bosses then
			for _, child in ipairs(bosses:GetChildren()) do
				tbl10[child.Name:lower()] = true
			end
		end
	end

	local tbl11 = nil

	local function fn22()
		tbl11 = {}
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local npcs = ReplicatedStorage:FindFirstChild("Minigames Place") and ReplicatedStorage["Minigames Place"]:FindFirstChild("Content") and ReplicatedStorage["Minigames Place"].Content:FindFirstChild("Ouwigahara") and ReplicatedStorage["Minigames Place"].Content.Ouwigahara:FindFirstChild("Npcs")

		if npcs then
			for _, child in ipairs(npcs:GetChildren()) do
				tbl11[child.Name:lower()] = true
			end
		end
	end

	local function fn23(instance)
		if game.PlaceId == 75556147183481 then
			if not tbl11 then
				fn22()


			end

			if tbl11[instance.Name:lower()] then
				return "npc"
			end
			return "mob"
		end

		if not tbl10 then
			fn21()
		end

		local name = instance.Name:lower()
		if tbl10[name] then
			return "mob"
		end

		if name:find("*", 1, true) then
			return "mob"
		end

		for _, v24 in ipairs(tbl9) do
			if name:find(v24, 1, true) then
				return "mob"
			end
		end

		return "npc"
	end

	local currentCamera = workspace.CurrentCamera

	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		currentCamera = workspace.CurrentCamera
	end)

	local tbl12 = {}

	local function fn24()
		local ok, result = pcall(function()
			return Enum.Font[tbl8.espFont]
		end)

		if ok and result then
			return result
		end
		return Enum.Font.GothamBold
	end

	local function fn25(arg)
		local v24 = tbl12[arg]
		if not v24 then
			return
		end

		if v24.bg then
			pcall(function()
				v24.bg:Destroy()
			end)
		end

		if v24.hl then
			pcall(function()
				v24.hl:Destroy()
			end)
		end

		tbl12[arg] = nil
	end

	local function myhubESPTeardown()
		for k in pairs(tbl12) do
			fn25(k)
		end
	end

	_G.__myhubESPTeardown = myhubESPTeardown

	local function fn26(model, arg)
		if tbl12[model] then
			return
		end
		local humanoid = model:FindFirstChildOfClass("Humanoid")
		local head = model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("RootPart") or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
		if not head then
			return
		end
		local v24 = fn19(arg)
		local espTextSize = tbl8.espTextSize or 13
		local myHubESP = Instance.new("BillboardGui")
		myHubESP.Name = "MyHubESP"
		myHubESP.Adornee = head
		myHubESP.AlwaysOnTop = true
		myHubESP.LightInfluence = 0
		myHubESP.ClipsDescendants = false
		myHubESP.MaxDistance = tbl8.espMaxDist
		myHubESP.Size = UDim2.new(0, 200, 0, 60)
		myHubESP.StudsOffset = Vector3.new(0, 3.5, 0)
		myHubESP.Parent = head

		local frame = Instance.new("Frame")
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.fromScale(1, 1)
		frame.Parent = myHubESP

		local uiListLayout = Instance.new("UIListLayout")
		uiListLayout.FillDirection = Enum.FillDirection.Vertical
		uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
		uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiListLayout.Parent = frame

		local function createTextLabel(layoutOrder, textColor3, visible)
			local textLabel = Instance.new("TextLabel")
			textLabel.BackgroundTransparency = 1
			textLabel.Size = UDim2.new(1, 0, 0, espTextSize + 2)
			textLabel.LayoutOrder = layoutOrder
			textLabel.Font = fn24()
			textLabel.TextSize = espTextSize
			textLabel.TextColor3 = textColor3
			textLabel.TextStrokeTransparency = 0.5
			textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
			textLabel.TextYAlignment = Enum.TextYAlignment.Center
			textLabel.TextXAlignment = Enum.TextXAlignment.Center
			textLabel.RichText = false
			textLabel.AutoLocalize = false
			textLabel.Text = ""
			textLabel.Visible = visible
			textLabel.Parent = frame
			return textLabel
		end

		tbl12[model] = {
			bg = myHubESP,
			frame = frame,
			list = uiListLayout,
			lblName = createTextLabel(1, v24, true),
			lblHp = createTextLabel(2, tbl8.espHpColor, false),
			lblDist = createTextLabel(3, tbl8.espDistColor, false),
			hl = nil,
			head = head,
			hum = humanoid,
			category = arg,
			model = model,
			_lastName = "",
			_lastHp = "",
			_lastDist = "",
			_lastColor = v24,
			_lastFont = tbl8.espFont,
		}
	end

	local function fn27(arg)
		if arg.hl and arg.hl.Parent then
			return
		end
		local myHubESPHL = Instance.new("Highlight")
		myHubESPHL.Name = "MyHubESPHL"
		myHubESPHL.FillColor = arg._lastColor
		myHubESPHL.OutlineColor = arg._lastColor
		myHubESPHL.FillTransparency = 0.75
		myHubESPHL.OutlineTransparency = 0
		myHubESPHL.Adornee = arg.model
		myHubESPHL.Parent = arg.model
		arg.hl = myHubESPHL
	end

	local function fn28(arg)
		do
			if arg.hl then
				pcall(function()
					arg.hl:Destroy()
				end)

				arg.hl = nil
			end

			return
		end
	end

	local function getEspPlayers(arg)
		return arg == "player" and tbl8.espPlayers or arg == "npc" and tbl8.espNpcs or arg == "mob" and tbl8.espMobs or arg == "item" and tbl8.espItems or arg == "questitem" and tbl8.espQuestItems or arg == "chest" and tbl8.espChests
	end

	local tbl13 = { "lily", "chest", "drop", "loot", "pickup" }

	local function fn29(name)
		local name2 = name:lower()

		for _, v24 in ipairs(tbl13) do
			if name2:find(v24, 1, true) then
				return true
			end
		end

		return false
	end

	local function fn30(model, position, arg)
		if not position then
			return true
		end
		local humanoidRootPart = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head") or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
		if not humanoidRootPart then
			return true
		end
		local position2 = humanoidRootPart.Position
		local n = position2.X - position.X
		local n10 = position2.Y - position.Y
		local n11 = position2.Z - position.Z
		return n * n + n10 * n10 + n11 * n11 <= arg
	end

	local function fn31()
		local tbl14 = {}
		local v24, v25, v26 = fn18()
		local position = v26 and v26.Position
		local espMaxDist = tbl8.espMaxDist * 1.15
		local n = espMaxDist * espMaxDist

		if tbl8.espPlayers then
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= localPlayer and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
					tbl14[player.Character] = "player"
				end
			end
		end

		if tbl8.espItems then
			local lootDrops = workspace:FindFirstChild("LootDrops")

			if lootDrops then
				for _, descendant in ipairs(lootDrops:GetDescendants()) do
					if descendant:IsA("Model") and descendant:FindFirstChildWhichIsA("BasePart") and not tbl14[descendant] and fn30(descendant, position, n) then
						tbl14[descendant] = "item"
					end
				end
			end

			local debree = workspace:FindFirstChild("Debree")

			if debree then
				for _, child in ipairs(debree:GetChildren()) do
					if child:IsA("Model") and fn29(child.Name) and not tbl14[child] and fn30(child, position, n) then
						tbl14[child] = "item"
					end
				end
			end
		end

		if tbl8.espChests then
			local chests = workspace:FindFirstChild("Chests")

			if chests then
				for _, child in ipairs(chests:GetChildren()) do
					if child:IsA("Model") and not tbl14[child] and fn30(child, position, n) then
						tbl14[child] = "chest"
					end
				end
			end
		end

		if tbl8.espQuestItems then
			local v27 = fn20()

			if next(v27) then
				local function fn32(name)
					if not name or name == "" then
						return false
					end
					local name2 = name:lower()

					for k in pairs(v27) do
						if name2:find(k, 1, true) or k:find(name2, 1, true) then
							return true
						end
					end

					return false
				end

				for _, child in ipairs(workspace:GetChildren()) do
					if (child:IsA("Model") or child:IsA("Tool")) and not tbl14[child] and child:FindFirstChildWhichIsA("BasePart") and fn32(child.Name) and fn30(child, position, n) then
						tbl14[child] = "questitem"
					end
				end
			end
		end

		if not (tbl8.espNpcs or tbl8.espMobs) then
			return tbl14
		end

		local function fn32(instance)
			if not (instance and instance:IsA("Model")) then
				return
			end

			if instance == localPlayer.Character then
				return
			end

			if Players:GetPlayerFromCharacter(instance) then
				return
			end

			if tbl14[instance] then
				return
			end
			local child = instance:FindFirstChild("HumanoidRootPart") or instance:FindFirstChild("Head")
			local humanoid = instance:FindFirstChildOfClass("Humanoid") or instance:FindFirstChildOfClass("AnimationController")
			if not (child and humanoid) then
				return
			end

			if position then
				local position2 = child.Position
				local n10 = position2.X - position.X
				local n11 = position2.Y - position.Y
				local n12 = position2.Z - position.Z
				if n10 * n10 + n11 * n11 + n12 * n12 > n then
					return
				end
			end

			local v27 = fn23(instance)

			if getEspPlayers(v27) then
				tbl14[instance] = v27
			end
		end

		local humanoids = workspace:FindFirstChild("Humanoids")

		if humanoids then
			for _, descendant in ipairs(humanoids:GetDescendants()) do
				if descendant:IsA("Humanoid") or descendant:IsA("AnimationController") then
					fn32(descendant.Parent)
				end
			end
		end

		local debree = workspace:FindFirstChild("Debree")
		local regions = debree and debree:FindFirstChild("Regions")
		if not regions then
			return tbl14
		end

		for _, child in ipairs(regions:GetChildren()) do
			local stationaryNpcs = child:FindFirstChild("StationaryNpcs")
			if not stationaryNpcs then
				continue
			end

			for _, child2 in ipairs(stationaryNpcs:GetChildren()) do
				fn32(child2)

				if child2:IsA("Model") then
					for _, child3 in ipairs(child2:GetChildren()) do
						fn32(child3)
					end
				end
			end
		end

		return tbl14
	end

	local n10 = 0

	getConnection(RunService.Heartbeat:Connect(function(E)
		if not (((((tbl8.espPlayers or tbl8.espNpcs) or tbl8.espMobs) or tbl8.espItems) or tbl8.espQuestItems) or tbl8.espChests) then
			if next(tbl12) then
				myhubESPTeardown()
			end

			return
		end

		n10 += E

		if n10 >= 0.25 then
			n10 = 0
			E = fn31()

			for h, Q in pairs(E) do
				if not tbl12[h] then
					fn26(h, Q)
				end
			end

			for h in pairs(tbl12) do
				if not E[h] or not h.Parent then
					fn25(h)
				end
			end
		end
	end))

	local n11 = 0

	getConnection(RunService.Heartbeat:Connect(function(E)
		n11 += E
		if n11 < 0.1 then
			return
		end
		n11 = 0
		if not (((((tbl8.espPlayers or tbl8.espNpcs) or tbl8.espMobs) or tbl8.espItems) or tbl8.espQuestItems) or tbl8.espChests) then
			return
		end
		local h, h, h = fn18()
		if not h then
			return
		end
		local Q, l = h.Position, tbl8.espMaxDist
		local B = l * l
		local y = tbl8.espShowHl
		local C = tbl8.espShowHp
		local c = tbl8.espShowDist
		local I = tbl8.espTextSize or 13
		local r = tbl8.streamerMode

		for w, a in pairs(tbl12) do
			E = a.head

			if E and E.Parent then
				h = E.Position
				local E, K, n = h.X - Q.X, h.Y - Q.Y, h.Z - Q.Z
				local h = ((E * E) + (K * K)) + (n * n)

				if h > B then
					if a.bg and a.bg.Enabled then
						a.bg.Enabled = false
					end

					if a.hl and a.hl.Enabled then
						a.hl.Enabled = false
					end
				else
					if y then
						if not (a.hl and a.hl.Parent) then
							fn27(a)
						end

						if a.hl and not a.hl.Enabled then
							a.hl.Enabled = true
						end
					elseif a.hl then
						fn28(a)
					end

					local Q, B, y, m = fn19(a.category), if r and (a.category == "player") then "DISCORD.GG/WINHUB" else if a.category == "questitem" then (w.Name:gsub("%s*%d+$", "")) else w.Name, if ((C and a.hum) and (a.hum:IsA("Humanoid"))) and a.hum.Health then "HP " .. (math.floor(a.hum.Health) .. ("/" .. math.floor(a.hum.MaxHealth))) else nil, if c then "[" .. (math.floor(math.sqrt(h)) .. "m]") else nil

					if a.bg then
						if not a.bg.Enabled then
							a.bg.Enabled = true
						end

						if a.bg.MaxDistance ~= l then
							a.bg.MaxDistance = l
						end

						if Q ~= a._lastColor then
							a._lastColor = Q
							a.lblName.TextColor3 = Q

							if a.hl then
								a.hl.FillColor = Q
								a.hl.OutlineColor = Q
							end
						end

						if a.lblHp.TextColor3 ~= tbl8.espHpColor then
							a.lblHp.TextColor3 = tbl8.espHpColor
						end

						if a.lblDist.TextColor3 ~= tbl8.espDistColor then
							a.lblDist.TextColor3 = tbl8.espDistColor
						end

						if a._lastFont ~= tbl8.espFont then
							a._lastFont = tbl8.espFont
							E = fn24()
							a.lblName.Font = E
							a.lblHp.Font = E
							a.lblDist.Font = E
						end

						if a.lblName.TextSize ~= I then
							a.lblName.TextSize = I
							a.lblHp.TextSize = I
							a.lblDist.TextSize = I
						end

						if a._lastName ~= B then
							a._lastName = B
							a.lblName.Text = B
						end

						n = y or ""

						if a._lastHp ~= n then
							a._lastHp = n
							a.lblHp.Text = n
							K = n ~= ""

							if a.lblHp.Visible ~= K then
								a.lblHp.Visible = K
							end
						end

						local U = m or ""

						if a._lastDist ~= U then
							a._lastDist = U
							a.lblDist.Text = U
							local E = U ~= ""

							if a.lblDist.Visible ~= E then
								a.lblDist.Visible = E
							end
						end
					end
				end
			end
		end
	end))
end

local v24 = tbl7.Visuals:AddLeftGroupbox("World FX")

v24:AddToggle("FullBright", {
	Text = "FullBright",
	Default = false,
	Callback = function(fullBright)
		tbl8.fullBright = fullBright
	end,
})

v24:AddSlider("Brightness", {
	Text = "Brightness",
	Default = tbl8.brightness,
	Min = 0,
	Max = 5,
	Rounding = 1,
	Suffix = "",
	Callback = function(brightness)
		tbl8.brightness = brightness
	end,
})

v24:AddToggle("NoFog", {
	Text = "No Fog",
	Default = false,
	Callback = function(noFog)
		tbl8.noFog = noFog
	end,
})

v24:AddToggle("NoAtmosphere", {
	Text = "No Atmosphere",
	Default = false,
	Callback = function(noAtmosphere)
		tbl8.noAtmosphere = noAtmosphere
	end,
})

v24:AddToggle("NoShadows", {
	Text = "No Shadows",
	Default = false,
	Callback = function(noShadows)
		tbl8.noShadows = noShadows
	end,
})

v24:AddToggle("PerfMode", {
	Text = "Performance Mode",
	Default = false,
	Tooltip = "Max-FPS preset",
	Callback = function(performanceMode)
		tbl8.perfMode = performanceMode
	end,
})

v24:AddToggle("UnlockFPS", {
	Text = "Unlock FPS",
	Default = false,
	Callback = function(unlockFps)
		tbl8.unlockFPS = unlockFps
	end,
})

v24:AddToggle("LowWater", {
	Text = "Low Water Quality",
	Default = false,
	Callback = function(lowWaterQuality)
		tbl8.lowWater = lowWaterQuality
	end,
})

v24:AddToggle("NoPostFX", {
	Text = "No Post FX",
	Default = false,
	Tooltip = "Bloom / blur / color",
	Callback = function(noPostFx)
		tbl8.noPostFX = noPostFx
	end,
})

v24:AddToggle("NoParticles", {
	Text = "No Particles",
	Default = false,
	Tooltip = "Trails, beams, smoke",
	Callback = function(noParticles)
		tbl8.noParticles = noParticles
	end,
})

local tbl9 = { Start = myHubBaselines.fogStart, End = myHubBaselines.fogEnd }
local obj = setmetatable({}, { __mode = "k" })
local tbl10 = { Ambient = nil, Outdoor = nil, Brightness = nil, CST = nil, CSB = nil, GD = nil }
local tbl11 = nil
local obj2 = setmetatable({}, { __mode = "k" })
local obj3 = setmetatable({}, { __mode = "k" })
local tbl12 = nil
local flag10 = false
local flag11 = false
local flag12 = false
local flag13 = false
local flag14 = false
local flag15 = false
local flag16 = false
local flag17 = false
local classNames = { "ParticleEmitter", "Trail", "Beam", "Smoke", "Fire", "Sparkles", "Explosion" }

do
	do
		local classNames2 = {
			"BloomEffect",
			"BlurEffect",
			"SunRaysEffect",
			"DepthOfFieldEffect",
			"ColorCorrectionEffect",
		}

		local function fn20(E)
			for h, h in ipairs(classNames) do
				if E:IsA(h) then
					return true
				end
			end

			return false
		end

		local function fn21(E)
			for h, h in ipairs(classNames2) do
				if E:IsA(h) then
					return true
				end
			end

			return false
		end

		local function fn22()
			if tbl10.Ambient == nil then
				tbl10.Ambient = Lighting.Ambient
			end

			if tbl10.Outdoor == nil then
				tbl10.Outdoor = Lighting.OutdoorAmbient
			end

			if tbl10.Brightness == nil then
				tbl10.Brightness = Lighting.Brightness
			end

			if tbl10.CST == nil then
				tbl10.CST = Lighting.ColorShift_Top
			end

			if tbl10.CSB == nil then
				tbl10.CSB = Lighting.ColorShift_Bottom
			end

			if tbl10.GD == nil then


				tbl10.GD = Lighting.GlobalShadows
			end
		end

		local function fn23(terrain)
			if tbl11 or not terrain then
				return
			end


			tbl11 = {
				waveSize = terrain.WaterWaveSize,
				waveSpeed = terrain.WaterWaveSpeed,
				reflect = terrain.WaterReflectance,
				transp = terrain.WaterTransparency,
			}
		end

		local function fn24(terrain)
			if not (tbl11 and terrain) then
				return
			end

			pcall(function()
				terrain.WaterWaveSize = tbl11.waveSize
				terrain.WaterWaveSpeed = tbl11.waveSpeed
				terrain.WaterReflectance = tbl11.reflect
				terrain.WaterTransparency = tbl11.transp
			end)

			tbl11 = nil
		end

		getConnection(Lighting.ChildAdded:Connect(function(E)
			if tbl8.noAtmosphere and (E:IsA("Atmosphere")) then
				task.wait(0.05)

				if obj[E] == nil then
					obj[E] = {Density = E.Density, Haze = E.Haze, Glare = E.Glare}
				end

				pcall(function()
					E.Density = 0
					E.Haze = 0
					E.Glare = 0
				end)
			end

			if tbl8.noPostFX and (fn21(E)) then
				if obj3[E] == nil then
					obj3[E] = E.Enabled
				end

				pcall(function()
					E.Enabled = false
				end)
			end
		end))

		getConnection(workspace.DescendantAdded:Connect(function(E)
			if tbl8.noParticles and (fn20(E)) then
				if obj2[E] == nil then
					obj2[E] = E.Enabled
				end

				pcall(function()
					E.Enabled = false
				end)
			end
		end))

		getConnection(RunService.Heartbeat:Connect(function()
			if tbl8.noFog then
				if not flag10 then
					flag10 = true
					tbl9.Start = Lighting.FogStart
					tbl9.End = Lighting.FogEnd
				end

				if Lighting.FogEnd < 1000000 then
					pcall(function()
						Lighting.FogEnd = 1000000
					end)
				end

				if Lighting.FogStart < 1000000 then
					pcall(function()
						Lighting.FogStart = 1000000
					end)
				end
			elseif flag10 then
				flag10 = false

				pcall(function()
					Lighting.FogStart = tbl9.Start
					Lighting.FogEnd = tbl9.End
				end)
			end

			if tbl8.noAtmosphere then
				flag11 = true
				local E

				pcall(function()
					E = Lighting and (Lighting:GetChildren())
				end)

				if type(E) == "table" then
					for h, h in ipairs(E) do
						if h:IsA("Atmosphere") then
							if obj[h] == nil then
								obj[h] = {Density = h.Density, Haze = h.Haze, Glare = h.Glare}
							end

							if h.Density > 0 then
								pcall(function()
									h.Density = 0
								end)
							end

							if h.Haze > 0 then
								pcall(function()
									h.Haze = 0
								end)
							end

							if h.Glare > 0 then
								pcall(function()
									h.Glare = 0
								end)
							end
						end
					end
				end
			elseif flag11 then
				flag11 = false

				for E, h in pairs(obj) do
					if E and E.Parent then
						pcall(function()
							E.Density = h.Density
							E.Haze = h.Haze
							E.Glare = h.Glare
						end)
					end
				end

				table.clear(obj)
			end

			if tbl8.fullBright then
				if not flag12 then
					flag12 = true
					fn22()
				end

				pcall(function()
					Lighting.Ambient = Color3.new(1, 1, 1)
					Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
					Lighting.ColorShift_Top = Color3.new(1, 1, 1)
					Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
					Lighting.GlobalShadows = false
					Lighting.Brightness = tbl8.brightness
				end)
			elseif flag12 then
				flag12 = false

				pcall(function()
					Lighting.Ambient = tbl10.Ambient or myHubBaselines.ambient
					Lighting.OutdoorAmbient = tbl10.Outdoor or myHubBaselines.ambient
					Lighting.Brightness = tbl10.Brightness or myHubBaselines.brightness
					Lighting.ColorShift_Top = tbl10.CST or (Color3.new())
					Lighting.ColorShift_Bottom = tbl10.CSB or (Color3.new())

					if tbl10.GD ~= nil then
						Lighting.GlobalShadows = tbl10.GD
					end
				end)

				for E in pairs(tbl10) do
					tbl10[E] = nil
				end
			end

			if tbl8.noShadows then
				flag14 = true

				if Lighting.GlobalShadows then
					pcall(function()
						Lighting.GlobalShadows = false
					end)
				end
			elseif flag14 then
				flag14 = false

				pcall(function()
					Lighting.GlobalShadows = true
				end)
			end
		end))

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				if tbl8.noPostFX then
					if not flag15 then
						flag15 = true
						local children = nil

						pcall(function()
							children = Lighting and Lighting:GetChildren()
						end)

						if type(children) == "table" then
							for _, child in ipairs(children) do
								if fn21(child) then
									if obj3[child] == nil then
										obj3[child] = child.Enabled
									end

									pcall(function()
										child.Enabled = false
									end)
								end
							end
						end
					end
				elseif flag15 then
					flag15 = false

					for k, v25 in pairs(obj3) do
						if k and k.Parent then
							pcall(function()
								k.Enabled = v25
							end)
						end
					end

					table.clear(obj3)
				end

				if tbl8.noParticles then
					if not flag16 then
						flag16 = true

						for _, descendant in ipairs(workspace:GetDescendants()) do
							if fn20(descendant) then
								if obj2[descendant] == nil then
									obj2[descendant] = descendant.Enabled
								end

								pcall(function()
									descendant.Enabled = false
								end)
							end
						end
					end
				elseif flag16 then
					flag16 = false

					for k, v25 in pairs(obj2) do
						if k and k.Parent then
							pcall(function()
								k.Enabled = v25
							end)
						end
					end

					table.clear(obj2)
				end

				local terrain = workspace:FindFirstChildOfClass("Terrain")

				if tbl8.lowWater then
					if not flag13 then
						flag13 = true
						fn23(terrain)
					end

					if terrain then
						pcall(function()
							if terrain.WaterWaveSize ~= 0 then
								terrain.WaterWaveSize = 0
							end

							if terrain.WaterWaveSpeed ~= 0 then
								terrain.WaterWaveSpeed = 0
							end

							if terrain.WaterReflectance ~= 0 then
								terrain.WaterReflectance = 0
							end

							if terrain.WaterTransparency ~= 1 then
								terrain.WaterTransparency = 1
							end
						end)
					end
				elseif flag13 then
					flag13 = false
					fn24(terrain)
				end

				if tbl8.perfMode then
					if not flag17 then
						flag17 = true

						local ok, result = pcall(function()
							return settings():GetService("RenderSettings")
						end)

						if ok and result then
							tbl12 = { quality = result.QualityLevel, meshDetail = result.MeshPartDetailLevel }

							pcall(function()
								result.QualityLevel = Enum.QualityLevel.Level01
							end)

							pcall(function()
								result.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
							end)
						end
					end
				elseif flag17 then
					flag17 = false

					if tbl12 then
						local ok, result = pcall(function()
							return settings():GetService("RenderSettings")
						end)

						if ok and result then
							pcall(function()
								result.QualityLevel = tbl12.quality
							end)

							pcall(function()
								result.MeshPartDetailLevel = tbl12.meshDetail
							end)
						end

						tbl12 = nil
					end
				end

				task.wait(0.5)
			end
		end)

		local flag18 = false

		task.spawn(function()
			while _G.MyHubSession == myHubSession do
				if tbl8.unlockFPS then
					flag18 = true

					if type(setfpscap) == "function" then
						pcall(setfpscap, 999)
					end
				elseif flag18 then
					flag18 = false

					if type(setfpscap) == "function" then
						pcall(setfpscap, 240)
					end
				end

				task.wait(1)
			end
		end)

		_G.__myhubWorldTeardown = function()
			pcall(function()
				Lighting.FogStart = tbl9.Start
				Lighting.FogEnd = tbl9.End
			end)

			for k, v25 in pairs(obj) do
				if k and k.Parent then
					pcall(function()
						k.Density = v25.Density
						k.Haze = v25.Haze
						k.Glare = v25.Glare
					end)
				end
			end

			table.clear(obj)

			pcall(function()
				if tbl10.Ambient then
					Lighting.Ambient = tbl10.Ambient
				end

				if tbl10.Outdoor then
					Lighting.OutdoorAmbient = tbl10.Outdoor
				end

				if tbl10.Brightness then
					Lighting.Brightness = tbl10.Brightness
				end

				if tbl10.CST then
					Lighting.ColorShift_Top = tbl10.CST
				end

				if tbl10.CSB then
					Lighting.ColorShift_Bottom = tbl10.CSB
				end

				if tbl10.GD ~= nil then
					Lighting.GlobalShadows = tbl10.GD
				end
			end)

			for k, v25 in pairs(obj3) do
				if k and k.Parent then
					pcall(function()
						k.Enabled = v25
					end)
				end
			end

			table.clear(obj3)

			for k, v25 in pairs(obj2) do
				if k and k.Parent then
					pcall(function()
						k.Enabled = v25
					end)
				end
			end

			table.clear(obj2)
			fn24(workspace:FindFirstChildOfClass("Terrain"))

			if tbl12 then


				local ok, result = pcall(function()
					return settings():GetService("RenderSettings")
				end)

				if ok and result then
					pcall(function()
						result.QualityLevel = tbl12.quality
					end)

					pcall(function()
						result.MeshPartDetailLevel = tbl12.meshDetail
					end)
				end

				tbl12 = nil
			end

			if flag18 and type(setfpscap) == "function" then
				pcall(setfpscap, 240)
			end
		end
	end

	do
		local Players2 = tbl7.Teleport:AddLeftGroupbox("Players")

		local function getNames()
			local names = {}

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= localPlayer then
					table.insert(names, player.Name)
				end
			end

			table.sort(names)
			return names
		end

		local TPPlayer = Players2:AddDropdown("TPPlayer", { Text = "Player", Values = getNames(), AllowNull = true, Default = nil })

		local function fn20(player)
			local characters = {}

			if player.Character then
				table.insert(characters, player.Character)
			end

			local humanoids = workspace:FindFirstChild("Humanoids")

			if humanoids then
				for _, child in ipairs(humanoids:GetChildren()) do
					if child:IsA("Model") and child.Name == player.Name and child ~= player.Character then
						table.insert(characters, child)
					end
				end
			end

			for _, character in ipairs(characters) do
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				local rootPart = humanoid and humanoid.RootPart or character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
				if rootPart and rootPart:IsA("BasePart") then
					return rootPart.CFrame
				end
			end

			for _, character in ipairs(characters) do
				local ok, result = pcall(function()
					return character:GetPivot()
				end)

				if ok and result and result.Position.Magnitude > 0.001 then
					return result
				end
			end

			return nil
		end

		Players2:AddButton({
			Text = "Teleport to Player",
			Func = function()
				local value = lib.Options.TPPlayer and lib.Options.TPPlayer.Value
				if not value or value == "" then
					lib:Notify({ Title = "Teleport", Description = "Pick a player first.", Time = 3 })
					return
				end
				local child = Players:FindFirstChild(value)
				if not child then
					lib:Notify({ Title = "Teleport", Description = "Player not in server.", Time = 3 })
					return
				end
				local description = fn20(child)
				local v25, v26, v27 = fn18()

				if not (description and v27) then
					local lib4 = lib
					local notify = lib4.Notify
					local tbl13 = { Title = "Teleport" }
					description = description and "You have no HRP." or "Target has no known position (streamed out)."
					tbl13.Description = description
					tbl13.Time = 3
					notify(lib4, tbl13)
					return
				end

				task.spawn(myhubGuardTP, description * CFrame.new(0, 0, 5))
			end,
		})

		Players2:AddButton({
			Text = "Refresh Player List",
			Func = function()
				TPPlayer:SetValues(getNames())
			end,
		})

		getConnection(Players.PlayerAdded:Connect(function()
			task.defer(function()
				pcall(function()
					TPPlayer:SetValues(getNames())
				end)
			end)
		end))

		getConnection(Players.PlayerRemoving:Connect(function()
			task.defer(function()
				pcall(function()
					TPPlayer:SetValues(getNames())
				end)
			end)
		end))
	end

	local fn20

	do
		local NPCs = tbl7.Teleport:AddRightGroupbox("NPCs")

		local function getNames()
			local tbl13 = {}
			local names = {}
			local debree = workspace:FindFirstChild("Debree")
			local regions = debree and debree:FindFirstChild("Regions")

			if regions then
				for _, child in ipairs(regions:GetChildren()) do
					local stationaryNpcs = child:FindFirstChild("StationaryNpcs")
					if not stationaryNpcs then
						continue
					end

					for _, child2 in ipairs(stationaryNpcs:GetChildren()) do
						if child2:IsA("Model") and not tbl13[child2.Name] then
							tbl13[child2.Name] = true
							table.insert(names, child2.Name)
						end
					end
				end
			end

			table.sort(names)
			return names
		end

		fn20 = function(arg)
			local function fn21(instance)
				if not instance then
					return nil
				end

				for _, descendant in ipairs(instance:GetDescendants()) do
					if not (descendant:IsA("Model") and descendant.Name == arg) then
						continue
					end

					if descendant:FindFirstChildOfClass("Humanoid") or descendant:FindFirstChildOfClass("AnimationController") then
						local humanoidRootPart = descendant:FindFirstChild("HumanoidRootPart") or descendant:FindFirstChild("Head") or descendant.PrimaryPart
						if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
							return humanoidRootPart.CFrame
						end

						local ok, result = pcall(function()
							return descendant:GetPivot()
						end)

						if ok and result then
							return result
						end
					end
				end

				return nil
			end

			return fn21(workspace:FindFirstChild("Humanoids")) or fn21(workspace:FindFirstChild("Debree"))
		end

		local TPNpc = NPCs:AddDropdown("TPNpc", { Text = "NPC", Values = getNames(), AllowNull = true, Default = nil })

		NPCs:AddButton({
			Text = "Teleport to NPC",
			Func = function()
				local value = lib.Options.TPNpc and lib.Options.TPNpc.Value
				if not value or value == "" then
					lib:Notify({ Title = "Teleport", Description = "Pick an NPC.", Time = 3 })
					return
				end
				local v25 = fn20(value)
				local v26, v27, v28 = fn18()
				if not (v25 and v28) then
					lib:Notify({ Title = "Teleport", Description = "NPC not found.", Time = 3 })
					return
				end
				task.spawn(myhubGuardTP, v25 * CFrame.new(0, 0, 5))
			end,
		})

		NPCs:AddButton({
			Text = "Refresh NPCs",
			Func = function()
				pcall(function()
					TPNpc:SetValues(getNames())
				end)
			end,
		})
	end

	do
		local Areas = tbl7.Teleport:AddLeftGroupbox("Areas")

		local function getNames()
			local tbl13 = {}
			local names = {}
			local instance = workspace
			local findFirstChild = instance.FindFirstChild

			for _, instance2 in ipairs({ workspace:FindFirstChild("Humanoids"), findFirstChild(instance, "Debree") }) do
				instance2 = instance2 and instance2:FindFirstChild("Regions")
				if not instance2 then
					continue
				end

				for _, child in ipairs(instance2:GetChildren()) do
					if not tbl13[child.Name] then
						tbl13[child.Name] = true
						table.insert(names, child.Name)
					end
				end
			end

			table.sort(names)
			return names
		end

		local function fn21(name)
			local debree = workspace:FindFirstChild("Debree")
			local regions = debree and debree:FindFirstChild("Regions")
			if not regions then
				return nil
			end
			local child = regions:FindFirstChild(name)
			if not child then
				return nil
			end

			for _, child2 in ipairs(child:GetChildren()) do
				if not (child2:IsA("Model") and child2.Name:find("SpawnCrystal", 1, true)) then
					continue
				end

				if child2.PrimaryPart then
					return child2.PrimaryPart.CFrame
				end

				local ok, result = pcall(function()
					return child2:GetPivot()
				end)

				if ok and result and result.Position.Magnitude > 0.001 then
					return result
				end

				for _, descendant in ipairs(child2:GetDescendants()) do
					if descendant:IsA("BasePart") then
						return descendant.CFrame
					end
				end
			end

			local stationaryNpcs = child:FindFirstChild("StationaryNpcs")

			if stationaryNpcs then
				for _, child2 in ipairs(stationaryNpcs:GetChildren()) do
					local humanoidRootPart = child2:FindFirstChild("HumanoidRootPart") or child2:FindFirstChild("Head")
					if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
						return humanoidRootPart.CFrame
					end
				end
			end

			for _, descendant in ipairs(child:GetDescendants()) do
				if descendant:IsA("BasePart") then
					return descendant.CFrame
				end
			end

			return nil
		end

		local TPArea = Areas:AddDropdown("TPArea", { Text = "Area", Values = getNames(), AllowNull = true, Default = nil })

		Areas:AddButton({
			Text = "Teleport to Area",
			Func = function()
				local value = lib.Options.TPArea and lib.Options.TPArea.Value
				if not value or value == "" then
					lib:Notify({ Title = "Teleport", Description = "Pick an area.", Time = 3 })
					return
				end
				local v25 = fn21(value)
				local v26, v27, v28 = fn18()

				if not (v25 and v28) then
					lib:Notify({ Title = "Teleport", Description = "Area has no spawn point.", Time = 3 })
					return
				end

				task.spawn(myhubGuardTP, v25 * CFrame.new(0, 3, 0))
			end,
		})

		Areas:AddButton({
			Text = "Refresh Areas",
			Func = function()
				pcall(function()
					TPArea:SetValues(getNames())
				end)
			end,
		})
	end

	local Misc = tbl7.Misc:AddLeftGroupbox("Misc")

	Misc:AddToggle("ShowOwnership", {
		Text = "Show Network Ownership",
		Default = false,
		Tooltip = "Show ownership",
		Callback = function(showNetworkOwnership)
			tbl8.showOwnership = showNetworkOwnership
		end,
	})

	Misc:AddToggle("AntiAFK", {
		Text = "Anti AFK",
		Default = true,
		Callback = function(antiAfk)
			tbl8.antiAFK = antiAfk
		end,
	})

	getConnection(localPlayer.Idled:Connect(function()
		if not tbl8.antiAFK then
			return
		end
		local VirtualUser = game:GetService("VirtualUser")

		pcall(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end)
	end))

	task.spawn(function()
		local CoreGui = game:GetService("CoreGui")

		while _G.MyHubSession == myHubSession do
			local robloxNetworkPauseNotification = CoreGui:FindFirstChild("RobloxNetworkPauseNotification")

			if robloxNetworkPauseNotification and robloxNetworkPauseNotification.Enabled then
				pcall(function()
					robloxNetworkPauseNotification.Enabled = false
				end)
			end

			task.wait(0.25)
		end
	end)

	do
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Webhook = tbl7.Main:AddRightGroupbox("Webhook")
		tbl8.webhookEnabled = false
		tbl8.webhookUrl = ""
		tbl8.webhookMinR = 5

		Webhook:AddToggle("WebhookEnabled", {
			Text = "Enable",
			Default = false,
			Tooltip = "Post to Discord",
			Callback = function(enable)
				tbl8.webhookEnabled = enable
			end,
		})

		Webhook:AddInput("WebhookUrl", {
			Text = "Webhook URL",
			Default = "",
			Placeholder = "discord.com/api/webhooks/...",
			Tooltip = "Paste Discord webhook",
			Callback = function(webhookUrl)
				tbl8.webhookUrl = (webhookUrl or ""):gsub("^%s+", ""):gsub("%s+$", "")
			end,
		})

		local tbl13 = { "Common", "UnCommon", "Rare", "Epic", "Legendary", "Mythic" }
		local tbl14 = {}

		for i, v25 in ipairs(tbl13) do
			tbl14[v25] = i
		end

		Webhook:AddDropdown("WebhookMinR", {
			Text = "Min Rarity",
			Values = tbl13,
			Default = "Legendary",
			AllowNull = false,
			Tooltip = "Only at or above",
			Callback = function(minRarity)
				tbl8.webhookMinR = tbl14[minRarity] or 5


			end,
		})

		local tbl15 = {}
		local items = ReplicatedStorage:FindFirstChild("Items")

		if items then
			for _, child in ipairs(items:GetChildren()) do
				if not child:IsA("Folder") then
					continue
				end

				for _, child2 in ipairs(child:GetChildren()) do
					if child2:IsA("ModuleScript") then
						local ok, result = pcall(require, child2)

						if ok and type(result) == "table" and type(result.Rarity) == "number" then
							tbl15[child2.Name:lower()] = { rarity = result.Rarity, folder = child.Name }
						end
					end
				end
			end
		end

		local rarities = { 14673612, 8377975, 5224959, 14241241, 16763436, 10551296, 0, 16739860 }

		local function fn21(webhookUrl, json)
			local request_ = syn and syn.request or http and http.request or fluxus and fluxus.request or request or http_request
			if not request_ then
				return false, "no http request api"
			end
			local ok, result = pcall(request_, { Url = webhookUrl, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = json })
			return ok, result
		end

		local tbl16 = { name = nil, time = 0 }

		task.spawn(function()
			local bossUi = localPlayer:WaitForChild("PlayerGui"):WaitForChild("ComponentsHolder"):WaitForChild("BossUi")
			local text2 = nil
			local now2 = 0

			while _G.MyHubSession == myHubSession do
				local text = nil

				if bossUi.Visible ~= false then
					text = nil

					for _, descendant in ipairs(bossUi:GetDescendants()) do
						if descendant:IsA("TextLabel") and descendant.Name == "Name" and descendant.Text and descendant.Text ~= "" then
							text = descendant.Text
							break
						end
						text = nil
					end
				end

				if text then
					now2 = os.clock()
					text2 = text
				elseif text2 and os.clock() - now2 < 8 then
					tbl16 = { name = text2, time = os.clock() }
					text2 = nil
				end

				task.wait(0.5)
			end
		end)

		local rarities2 = { "Common", "UnCommon", "Rare", "Epic", "Legendary", "Mythic", "Impossible", "Limited" }

		local rarities3 = {
			"⚪",
			[2] = "🟢",
			[3] = "🔵",
			[4] = "🟣",
			[5] = "🟡",
			[6] = "🔴",
			[7] = "⚫",
			[8] = "🟠",
		}

		local function fn22(userId)
			return string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=150&height=150&format=png", userId or 0)
		end

		local function fn23(name, name2)
			local items2 = ReplicatedStorage:FindFirstChild("Items")
			local child = items2 and items2:FindFirstChild(name)
			local child2 = child and child:FindFirstChild(name2)
			if not child2 then
				return nil
			end
			local ok, result = pcall(require, child2)
			if not (ok and type(result) == "table" and type(result.Icon) == "string") then
				return nil
			end
			local match = result.Icon:match("(%d+)")
			if not match then
				return nil
			end
			return string.format("https://www.roblox.com/asset-thumbnail/image?assetId=%s&width=150&height=150&format=png", match)
		end

		local function fn24(name, rarity, folder)
			if tbl8.webhookUrl == "" then
				return
			end
			local rarity2 = rarities2[rarity] or "R" .. rarity
			local rarity3 = rarities3[rarity] or "◾"
			local rarity4 = rarities[rarity] or 8421504
			local tbl17 = {}
			local tbl18 = { name = "Rarity", value = rarity3 .. " " .. rarity2, inline = true }
			local tbl19 = { name = "Type", value = folder or "?", inline = true }
			tbl17[1] = tbl18
			tbl17[2] = tbl19

			if tbl16.name and os.clock() - tbl16.time < 5 then
				table.insert(tbl17, { name = "Dropped By", value = "⚔️ " .. tbl16.name, inline = true })
			end

			local tbl20 = {
				author = { name = localPlayer.DisplayName or localPlayer.Name, icon_url = fn22(localPlayer.UserId) },
				title = name,
				color = rarity4,
				fields = tbl17,
				thumbnail = { url = fn23(folder, name) or "" },
				footer = { text = "Project Slayers 2 · DISCORD.GG/WINHUB" },
				timestamp = DateTime.now():ToIsoDate(),
			}

			if tbl20.thumbnail.url == "" then
				tbl20.thumbnail = nil
			end

			local json = HttpService:JSONEncode({ username = "WinHub Pickup", embeds = { tbl20 } })
			fn21(tbl8.webhookUrl, json)
		end

		task.spawn(function()
			local tbl17 = {}

			getConnection(localPlayer:WaitForChild("PlayerGui"):WaitForChild("ComponentsHolder"):WaitForChild("Frame").ChildAdded:Connect(function(child)
				do
					if not tbl8.webhookEnabled then
						return
					end
					local v25 = tbl15[child.Name:lower()]

					if not v25 then
						do
							return
						end
					end

					if v25.rarity < (tbl8.webhookMinR or 5) then
						return
					end
					local now2 = os.clock()
					if tbl17[child.Name] and now2 - tbl17[child.Name] < 2 then
						return
					end
					tbl17[child.Name] = now2
					fn24(child.Name, v25.rarity, v25.folder)
				end
			end))
		end)
	end

	do
		local Muzan = tbl7.Main:AddRightGroupbox("Muzan")

		local tbl13 = {
			Vector3.new(55, 826.5, 781.5),
			Vector3.new(1920.59, 599.05, -880.99),
			Vector3.new(-687, 1380.5, -2606.5),
		}

		Muzan:AddButton({
			Text = "Find Muzan",
			Func = function()
				local v25, v26, v27 = fn18()
				if not v27 then
					return
				end
				local Muzan2 = fn20("Muzan")

				if Muzan2 then
					pcall(function()
						localPlayer:RequestStreamAroundAsync(Muzan2.Position)
					end)

					myhubPinTP(Muzan2 * CFrame.new(0, 0, 5))
					return
				end

				for i, v28 in ipairs(tbl13) do
					pcall(function()
						localPlayer:RequestStreamAroundAsync(v28)
					end)

					myhubPinTP(CFrame.new(v28 + Vector3.new(0, 5, 5)))
					task.wait(0.5)
					local Muzan3 = fn20("Muzan")

					if Muzan3 then
						pcall(function()
							localPlayer:RequestStreamAroundAsync(Muzan3.Position)
						end)

						myhubPinTP(Muzan3 * CFrame.new(0, 0, 5))
						lib:Notify({ Title = "Muzan", Description = "Found on Route " .. i, Time = 4 })
						return
					end
				end

				lib:Notify({ Title = "Muzan", Description = "Not in this server (swept all 3 routes)", Time = 4 })
			end,
		})
	end

	do
		local v25 = tbl7.Main:AddRightGroupbox("Black Market")

		local tbl13 = {
			Vector3.new(-132.676, 804, 101.24),
			Vector3.new(2161.963, 823.459, -900.676),
			Vector3.new(1795.511, 659.399, -523.103),
			Vector3.new(-464.862, 1356.974, -3497.761),
			Vector3.new(-2089.845, 62.241, -408.465),
			Vector3.new(-864.695, 1389, -1639.538),
			Vector3.new(-118.712, 1379.275, -1861.278),
			Vector3.new(-1045.371, 1282, -1312.49),
			Vector3.new(-1775.234, 141.75, 1297.076),
			Vector3.new(-2736.262, 143.75, 833.486),
			Vector3.new(-1946.007, 311.5, -282.891),
		}

		local function getChild(model)
			return model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head") or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
		end

		local function getDescendant()
			local instance = workspace
			local findFirstChild = instance.FindFirstChild

			for _, instance2 in ipairs({ workspace:FindFirstChild("Humanoids"), findFirstChild(instance, "Debree") }) do
				if instance2 then
					for _, descendant in ipairs(instance2:GetDescendants()) do
						if descendant:IsA("Model") and descendant.Name == "Black Marketer" then
							return descendant
						end
					end
				end
			end

			return nil
		end

		v25:AddButton({
			Text = "Find Black Marketer",
			Func = function()
				local v26, v27, v28 = fn18()
				if not v28 then
					return
				end
				local descendant = getDescendant()

				if descendant then
					local child = getChild(descendant)

					if child then
						pcall(function()
							localPlayer:RequestStreamAroundAsync(child.Position)
						end)

						myhubPinTP(child.CFrame * CFrame.new(0, 0, 5))
					end

					return
				end

				for i, v29 in ipairs(tbl13) do
					pcall(function()
						localPlayer:RequestStreamAroundAsync(v29)
					end)

					myhubPinTP(CFrame.new(v29 + Vector3.new(0, 5, 5)))
					task.wait(0.5)
					local descendant2 = getDescendant()

					if descendant2 then
						local child = getChild(descendant2)

						if child then
							pcall(function()
								localPlayer:RequestStreamAroundAsync(child.Position)
							end)

							myhubPinTP(child.CFrame * CFrame.new(0, 0, 5))
						end

						lib:Notify({ Title = "Black Market", Description = "Found at Spawn #" .. i, Time = 4 })
						return
					end
				end

				lib:Notify({ Title = "Black Market", Description = "Not in this server (swept all 11 spawns)", Time = 4 })
			end,
		})
	end

	do
		local Schematics = tbl7.Main:AddLeftGroupbox("Schematics")
		local CollectionService = game:GetService("CollectionService")

		local tbl13 = {
			{ item = "Firstlight Mask", pos = Vector3.new(2232, 607, -509) },
			{ item = "Nightfall Mask", pos = Vector3.new(-1628, 1230, 1143) },
			{ item = "Nightfall Axe and Mace", pos = Vector3.new(1082, 1584, -809) },
			{ item = "Nightfall Katana", pos = Vector3.new(-568, 821, 112) },
			{ item = "Nightfall Scythe", pos = Vector3.new(-1207, 987, -3185) },
			{ item = "Firstlight Insect Katana", pos = Vector3.new(-698, 864, 74) },
			{ item = "Firstlight Spear", pos = Vector3.new(-888, 995, -3963) },
			{ item = "Firstlight Katana", pos = Vector3.new(-1267, 992, -3347) },
			{ item = "Nightfall Claws", pos = Vector3.new(-1817, -40, 438) },
		}

		local vector = Vector3.new(-1021, 825, 632)

		local function getInventory()
			local ok, result = pcall(function()
				return require(game.ReplicatedStorage.CAM.Global.Utility).GetData(localPlayer, true)
			end)

			if not ok or not result then
				return nil
			end
			local inventory = result:FindFirstChild("Inventory")
			return inventory and inventory:FindFirstChild("Inventory")
		end

		local function getInstance(arg)
			for _, instance in ipairs(CollectionService:GetTagged("StudyProp")) do
				if instance:GetAttribute("Item") == arg then
					return instance
				end
			end

			return nil
		end

		local function fn21(arg, arg2)
			local v25, v26, v27 = fn18()
			if not v27 then
				return "no character"
			end
			local inventory = getInventory()
			if inventory and inventory:FindFirstChild(arg .. " Schematic") then
				return "already owned"
			end
			myhubPinTP(CFrame.new(arg2 + Vector3.new(0, 5, 3)))
			local child = nil

			for i = 1, 40 do
				local instance = getInstance(arg)

				if instance then
					if instance:GetAttribute("Locked") then
						return "locked (solve unlock puzzle first)"
					end
					child = instance:FindFirstChildWhichIsA("ProximityPrompt", true)
					if child and child.Enabled then
						break
					end
				end

				task.wait(0.1)
			end

			if not child then
				return "prompt never streamed"
			end

			if not child.Enabled then
				return "prompt disabled (owned or locked)"
			end

			if not fireproximityprompt then
				return "executor missing fireproximityprompt"
			end
			task.wait(1.5)
			fireproximityprompt(child, child.HoldDuration)

			for i = 1, 30 do
				task.wait(0.1)
				local inventory2 = getInventory()
				if inventory2 and inventory2:FindFirstChild(arg .. " Schematic") then
					return "collected"
				end
			end

			return "fired but no schematic added"
		end

		local tbl14 = {
			Vector3.new(1868.4, 690.3, -733.5),
			Vector3.new(653.9, 1051.5, -2165),
			Vector3.new(1052.8, 1552.3, -786.9),
			Vector3.new(757.8, 927.7, -364.7),
			Vector3.new(-1419.8, 159.2, 522.9),
			Vector3.new(-1249, 1383.2, -1762.4),
			Vector3.new(2754.9, 970.4, -821),
			Vector3.new(1941.4, 1322.9, -225),
			Vector3.new(859.2, 1230, 476.6),
			Vector3.new(-1692.5, 125, 602.8),
		}

		local vector2 = Vector3.new(899, 879, 739)

		local function fn22(arg, arg2, arg3)
			local v25, v26, v27 = fn18()
			if not v27 then
				return "no character"
			end
			myhubPinTP(CFrame.new(arg + Vector3.new(0, 5, 3)))
			local instance = nil

			for i = 1, 40 do
				instance = arg2()
				if instance then
					break
				end
				task.wait(0.1)
			end

			if not instance then
				return "prompt never streamed"
			end
			task.wait(arg3 or 1.5)

			if not instance.Enabled then
				instance.Enabled = true
			end

			if firesignal then
				pcall(function()
					firesignal(instance.PromptButtonHoldBegan, instance.Parent)
				end)

				if instance.HoldDuration > 0 then
					task.wait(instance.HoldDuration + 0.15)
				end

				pcall(function()
					firesignal(instance.Triggered, instance.Parent)
				end)
			end

			if fireproximityprompt then
				fireproximityprompt(instance, instance.HoldDuration)
			end

			return "fired"
		end

		local function getChild(arg)
			for _, instance in ipairs(CollectionService:GetTagged("SicklesLever")) do
				local a = instance:FindFirstChild("A_")
				local leverMain = a and a:FindFirstChild("LeverMain")
				if leverMain and (leverMain.Position - arg).Magnitude < 30 then
					return leverMain:FindFirstChildWhichIsA("ProximityPrompt", true)
				end
			end

			return nil
		end

		local function fn23()
			return _G.__myhubSweepAbort == true
		end

		Schematics:AddButton({
			Text = "Study All Schematics",
			Func = function()
				_G.__myhubSweepAbort = false
				local count2 = 0
				local n = 0
				local count3 = 0

				for _, v25 in ipairs(tbl13) do
					if fn23() then
						break
					end
					local v26 = fn21(v25.item, v25.pos)

					if v26 == "collected" then
						count2 += 1
					elseif v26 == "already owned" then
						n += 1
					else
						count3 += 1
					end
				end

				lib:Notify({
					Title = "Schematics",
					Description = string.format("Collected %d · Owned %d · Other %d", count2, n, count3),
					Time = 5,
				})
			end,
		})

		Schematics:AddButton({
			Text = "Study Nightfall Sickles",
			Func = function()
				_G.__myhubSweepAbort = false
				local inventory = getInventory()
				if inventory and inventory:FindFirstChild("Nightfall Sickles Schematic") then
					lib:Notify({ Title = "Sickles", Description = "Already own the schematic", Time = 3 })
					return
				end

				if not localPlayer:GetAttribute("SicklesSewerOpen") then
					for _, v25 in ipairs(tbl14) do
						if fn23() then
							return
						end

						fn22(v25, function()
							return getChild(v25)
						end)
					end

					for i = 1, 40 do
						if localPlayer:GetAttribute("SicklesSewerOpen") then
							break
						end
						task.wait(0.1)
					end

					if not localPlayer:GetAttribute("SicklesSewerOpen") then
						lib:Notify({ Title = "Sickles", Description = "Levers pulled — server didn't flip open", Time = 5 })
						return
					end
				end

				if fn23() then
					return
				end
				lib:Notify({ Title = "Sickles", Description = fn21("Nightfall Sickles", vector), Time = 5 })
			end,
		})

		Schematics:AddButton({
			Text = "Study Nightfall Gauntlet",
			Func = function()
				_G.__myhubSweepAbort = false
				local SignalEvent = require(game.ReplicatedStorage.Communication.ServerAndClient.Signals.SignalEvent)
				local inventory = getInventory()
				if inventory and inventory:FindFirstChild("Nightfall Gauntlet Schematic") then
					lib:Notify({ Title = "Gauntlet", Description = "Already own the schematic", Time = 3 })
					return
				end
				local GauntletStatuesController = nil

				pcall(function()
					GauntletStatuesController = require(game.ReplicatedStorage.CAM.Client.Controllers.GauntletStatuesController)
				end)

				if GauntletStatuesController and GauntletStatuesController.Done() then
					lib:Notify({ Title = "Gauntlet", Description = "All 3 done — heading to Tobei", Time = 3 })
					local v25, v26, v27 = fn18()

					if v27 then
						myhubPinTP(CFrame.new(1876, 662, -204))
						task.wait(1)
						local descendant2 = nil

						for _, descendant in ipairs(workspace:GetDescendants()) do
							if descendant.Name == "Stonemason Tobei" and descendant:IsA("Model") then
								descendant2 = descendant
								break
							end
							descendant2 = nil
						end

						if descendant2 then
							local proximityPrompt = descendant2:FindFirstChildWhichIsA("ProximityPrompt", true)

							if proximityPrompt and fireproximityprompt then
								task.wait(0.6)

								pcall(function()
									fireproximityprompt(proximityPrompt, proximityPrompt.HoldDuration)
								end)

								local Dialogue = nil
								local DialogueUtility = nil

								pcall(function()
									Dialogue = require(game.ReplicatedStorage.CAM.Client.Modules.GamePlay.Dialogue)
									DialogueUtility = require(game.ReplicatedStorage.CAM.Client.Components.Client.DialogueComponent.DialogueUtility)
								end)

								local function fn24()
									return Dialogue and Dialogue.CurrentDialogue and Dialogue.CurrentDialogue.Current ~= nil
								end

								for i = 1, 60 do
									if fn23() or fn24() then
										break
									end
									task.wait(0.1)
								end

								task.wait(1.2)

								pcall(function()
									if DialogueUtility and DialogueUtility.DoAll then
										DialogueUtility.DoAll("GauntletTakeSchematic", Dialogue.Storage)
									end
								end)

								task.wait(1.6)

								pcall(function()
									if DialogueUtility and DialogueUtility.Close then
										DialogueUtility.Close()
									end
								end)
							end
						end
					end

					task.wait(1.5)
					local inventory2 = getInventory()

					lib:Notify({
						Title = "Gauntlet",
						Description = inventory2 and inventory2:FindFirstChild("Nightfall Gauntlet Schematic") and "Schematic collected from Tobei" or "Tobei visit finished but schematic didn't land",
						Time = 5,
					})

					return
				end

				local data = require(game.ReplicatedStorage.CAM.Global.Utility).GetData(localPlayer, true)
				local worldEvents = data and data:FindFirstChild("WorldEvents")
				local gauntletStatuesHeard = worldEvents and worldEvents:FindFirstChild("GauntletStatues_Heard")

				if not (gauntletStatuesHeard and gauntletStatuesHeard.Value) then
					local v25, v26, v27 = fn18()

					if v27 then
						myhubPinTP(CFrame.new(1876, 662, -204))
						task.wait(1)
						local descendant2 = nil

						for _, descendant in ipairs(workspace:GetDescendants()) do
							if descendant.Name == "Stonemason Tobei" and descendant:IsA("Model") then
								descendant2 = descendant
								break
							end
							descendant2 = nil
						end

						if descendant2 then
							local proximityPrompt = descendant2:FindFirstChildWhichIsA("ProximityPrompt", true)

							if proximityPrompt and fireproximityprompt then
								task.wait(0.8)

								pcall(function()
									fireproximityprompt(proximityPrompt, proximityPrompt.HoldDuration)
								end)

								local Dialogue = nil
								local DialogueUtility = nil

								pcall(function()
									Dialogue = require(game.ReplicatedStorage.CAM.Client.Modules.GamePlay.Dialogue)
									DialogueUtility = require(game.ReplicatedStorage.CAM.Client.Components.Client.DialogueComponent.DialogueUtility)
								end)

								local function fn24()
									return Dialogue and Dialogue.CurrentDialogue and Dialogue.CurrentDialogue.Current ~= nil
								end

								for i = 1, 60 do
									if fn23() or fn24() then
										break
									end
									task.wait(0.1)
								end

								for _, v28 in ipairs({ "Statues_2", "Statues_3", "StatuesHeard" }) do
									if fn23() then
										break
									end
									task.wait(1.4)

									pcall(function()
										if DialogueUtility and DialogueUtility.DoAll then
											DialogueUtility.DoAll(v28, Dialogue.Storage)
										elseif Dialogue and Dialogue.AttemptDialogue then
											Dialogue.AttemptDialogue:Fire(v28)
										end
									end)
								end

								task.wait(1.2)

								pcall(function()
									if DialogueUtility and DialogueUtility.Close then
										DialogueUtility.Close()
									end
								end)
							end
						end
					end

					if fn23() then
						return
					end

					pcall(function()
						SignalEvent.ToServer("GauntletStatuesBegin")
					end)

					task.wait(1.5)
				end

				local ok, result = pcall(function()
					return require(game.ReplicatedStorage.Communication.ServerAndClient.Signals.SignalEvent)
				end)

				ok = ok and type(result) == "table" and type(result.ToServer) == "function"
				local toServer = nil

				if ok then
					toServer = result.ToServer
				end

				local myhubGetStyle = _G.__myhub_getStyle and _G.__myhub_getStyle() or "Sickles"

				local tbl15 = {
					{
						type = "Fighting",
						style = "Combat",
						equipSlot = 0,
						cf = CFrame.new(Vector3.new(2076.772, 1542.472, -215.737), Vector3.new(2076.772, 1542.472, -215.737) + Vector3.new(0.991, 0, -0.133)),
					},
					{
						type = "Weapon",
						style = myhubGetStyle,
						equipSlot = 1,
						cf = CFrame.new(Vector3.new(-1382.032, 1005.745, 1116.46), Vector3.new(-1382.032, 1005.745, 1116.46) + Vector3.new(-0.026, 0, -1)),
					},
				}

				local cframe = CFrame.new(Vector3.new(-703.351, 1384.574, -1914.271), Vector3.new(-703.351, 1384.574, -1914.271) + Vector3.new(0.999, 0, -0.034))

				local function fn24(instance)
					instance = instance and instance:FindFirstChild("Eyes", true)
					return instance and instance.Material == Enum.Material.Neon
				end

				local function getInstance2(arg)
					for _, instance in ipairs(CollectionService:GetTagged("GauntletStatue")) do
						if instance:GetAttribute("type") == arg then
							return instance
						end
					end
				end

				for _, v25 in ipairs(tbl15) do
					if fn23() then
						break
					end
					local v26, v27, part = fn18()
					if not part then
						break
					end

					pcall(function()
						local itemsConfig = localPlayer:FindFirstChild("Items_Config")

						if itemsConfig and itemsConfig:FindFirstChild("Equipped") and itemsConfig.Equipped.Value ~= v25.equipSlot then
							itemsConfig.Equipped.Value = v25.equipSlot
							task.wait(0.6)
						end
					end)

					myhubPinTP(v25.cf)
					task.wait(1.5)
					local instance = getInstance2(v25.type)

					if not instance then
					else
						local humanoid = instance:FindFirstChildOfClass("Humanoid")

						if not humanoid then
						else
							local primaryPart = instance.PrimaryPart or instance:FindFirstChild("HumanoidRootPart") or instance:FindFirstChildWhichIsA("BasePart")

							if primaryPart then
								local position = primaryPart.Position
								myhubPinTP(CFrame.new(position + primaryPart.CFrame.LookVector * 4 + Vector3.new(0, 2, 0), position))
								task.wait(0.4)
							end

							local anchored = part.Anchored

							pcall(function()
								part.Anchored = true
							end)

							local n = 0

							for i = 1, 1200 do
								if not (not (fn23() or fn24(instance)) and humanoid.Parent) then
									break
								end
								n = n % 5 + 1

								if toServer then
									pcall(toServer, "Combat_Service", v25.style, n, true, 0, true, nil)
								end

								task.wait(0.05)
							end

							pcall(function()
								part.Anchored = anchored
							end)
						end
					end
				end

				local GauntletStatuesController2 = nil

				pcall(function()
					GauntletStatuesController2 = require(game.ReplicatedStorage.CAM.Client.Controllers.GauntletStatuesController)
				end)

				if not fn23() and GauntletStatuesController2 and not GauntletStatuesController2.Done() then
					local Power = getInstance2("Power")

					if not (Power and fn24(Power)) then
						local v25, v26, parent = fn18()

						if parent then
							myhubPinTP(cframe)
							task.wait(1.5)
							local Power2 = getInstance2("Power")
							local primaryPart = Power2 and (Power2.PrimaryPart or Power2:FindFirstChild("HumanoidRootPart") or Power2:FindFirstChildWhichIsA("BasePart"))
							local cframe2 = nil

							if primaryPart then
								local position = primaryPart.Position
								cframe2 = CFrame.new(position + primaryPart.CFrame.LookVector * 4 + Vector3.new(0, 2, 0), position)
								myhubPinTP(cframe2)
								task.wait(0.4)
							end

							local character = localPlayer.Character
							local humanoid = character and character:FindFirstChildOfClass("Humanoid")
							local autoRotate = humanoid and humanoid.AutoRotate

							if humanoid then
							end

							if humanoid then


								pcall(function()
									humanoid.AutoRotate = false
								end)
							end

							local myHubGauntletLockRef = nil
							local myHubGauntletLockAtt = nil
							local attachment = nil
							local alignPosition = nil
							local alignOrientation = nil

							local function fn25()
								if not cframe2 or not parent or not parent.Parent then
									return
								end
								myHubGauntletLockRef = Instance.new("Part")
								myHubGauntletLockRef.Name = "MyHub_GauntletLockRef"
								myHubGauntletLockRef.Size = Vector3.new(0.1, 0.1, 0.1)
								myHubGauntletLockRef.Transparency = 1
								local myHubGauntletLockRef2 = myHubGauntletLockRef
								local myHubGauntletLockRef3 = myHubGauntletLockRef
								myHubGauntletLockRef.CanCollide = false
								myHubGauntletLockRef2.CanQuery = false
								myHubGauntletLockRef3.CanTouch = false
								myHubGauntletLockRef.Massless = true
								myHubGauntletLockRef.Anchored = true
								myHubGauntletLockRef.CFrame = cframe2
								myHubGauntletLockRef.Parent = workspace
								attachment = Instance.new("Attachment", myHubGauntletLockRef)
								myHubGauntletLockAtt = Instance.new("Attachment", parent)
								myHubGauntletLockAtt.Name = "MyHub_GauntletLockAtt"
								alignPosition = Instance.new("AlignPosition")
								alignPosition.Attachment0 = myHubGauntletLockAtt
								alignPosition.Attachment1 = attachment
								alignPosition.RigidityEnabled = true
								alignPosition.Parent = parent
								alignOrientation = Instance.new("AlignOrientation")
								alignOrientation.Attachment0 = myHubGauntletLockAtt
								alignOrientation.Attachment1 = attachment
								alignOrientation.RigidityEnabled = true
								alignOrientation.Parent = parent
							end

							local function fn26()

								for _, v27 in ipairs({ alignPosition, alignOrientation, myHubGauntletLockAtt, attachment, myHubGauntletLockRef }) do
									if v27 then
										pcall(function()
											v27:Destroy()
										end)
									end
								end

								alignPosition = nil
								alignOrientation = nil
								myHubGauntletLockAtt = nil
								attachment = nil
								myHubGauntletLockRef = nil
							end

							fn25()

							lib:Notify({
								Title = "Gauntlet — Power",
								Description = "Click into the game — spamming Z/X/C/V/B for you",
								Time = 5,
							})

							local VirtualInputManager = game:GetService("VirtualInputManager")
							local tbl16 = { Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V, Enum.KeyCode.B }
							local n = 0

							for i = 1, 450 do
								if fn23() then
									break
								end

								if GauntletStatuesController2.Done() then
									break
								end
								n = n % #tbl16 + 1
								local v27 = tbl16[n]

								pcall(function()
									VirtualInputManager:SendKeyEvent(true, v27, false, game)
								end)

								task.wait(0.4)

								pcall(function()
									VirtualInputManager:SendKeyEvent(false, v27, false, game)
								end)

								task.wait(0.4)
							end

							fn26()

							if humanoid and autoRotate ~= nil then
								pcall(function()
									humanoid.AutoRotate = autoRotate
								end)
							end
						end
					end
				end

				if fn23() then
					return
				end

				if not (GauntletStatuesController2 and GauntletStatuesController2.Done()) then
					lib:Notify({
						Title = "Gauntlet",
						Description = "Not all 3 statues glowing yet — try again",
						Time = 5,
					})

					return
				end

				local v25, v26, v27 = fn18()

				if v27 then
					myhubPinTP(CFrame.new(1876, 662, -204))
					task.wait(1)
					local descendant2 = nil

					for _, descendant in ipairs(workspace:GetDescendants()) do
						if descendant.Name == "Stonemason Tobei" and descendant:IsA("Model") then
							descendant2 = descendant
							break
						end
						descendant2 = nil
					end

					if descendant2 then
						local proximityPrompt = descendant2:FindFirstChildWhichIsA("ProximityPrompt", true)

						if proximityPrompt and fireproximityprompt then
							task.wait(0.6)

							pcall(function()
								fireproximityprompt(proximityPrompt, proximityPrompt.HoldDuration)
							end)

							local Dialogue = nil
							local DialogueUtility = nil

							pcall(function()
								Dialogue = require(game.ReplicatedStorage.CAM.Client.Modules.GamePlay.Dialogue)
								DialogueUtility = require(game.ReplicatedStorage.CAM.Client.Components.Client.DialogueComponent.DialogueUtility)
							end)

							local function fn25()
								return Dialogue and Dialogue.CurrentDialogue and Dialogue.CurrentDialogue.Current ~= nil
							end

							for i = 1, 60 do
								if fn23() or fn25() then
									break
								end
								task.wait(0.1)
							end

							task.wait(1.2)

							pcall(function()
								if DialogueUtility and DialogueUtility.DoAll then
									DialogueUtility.DoAll("GauntletTakeSchematic", Dialogue.Storage)
								end
							end)

							task.wait(1.6)

							pcall(function()
								if DialogueUtility and DialogueUtility.Close then
									DialogueUtility.Close()
								end
							end)
						end
					end
				end

				task.wait(1.5)
				local inventory2 = getInventory()

				lib:Notify({
					Title = "Gauntlet",
					Description = inventory2 and inventory2:FindFirstChild("Nightfall Gauntlet Schematic") and "Schematic collected from Tobei" or "Tobei visit finished but schematic didn't land",
					Time = 6,
				})
			end,
		})

		Schematics:AddButton({
			Text = "Study Nightfall Serpent Katana",
			Func = function()
				_G.__myhubSweepAbort = false

				local function fn24()
					local inventory = getInventory()
					return inventory and inventory:FindFirstChild("Nightfall Serpent Katana Schematic") ~= nil
				end

				local function fn25()
					local inventory = getInventory()
					return inventory and inventory:FindFirstChild("Serpent Key") ~= nil
				end

				local function getChild2()
					for _, instance in ipairs(CollectionService:GetTagged("SerpentBox")) do
						local child = instance:FindFirstChildWhichIsA("ProximityPrompt", true)
						if child then
							return child
						end
					end
				end

				if fn24() then
					lib:Notify({ Title = "Serpent Box", Description = "Already own the schematic", Time = 3 })
					return
				end
				local vector3 = Vector3.new(-500, 745, 600)

				local function fn26()
					local v25, v26, v27 = fn18()
					if not v27 then
						return
					end
					myhubPinTP(CFrame.new(vector3 + Vector3.new(0, 5, 0)))

					for i = 1, 30 do
						if 0 < #CollectionService:GetTagged("SerpentKey") then
							return
						end
						task.wait(0.1)
					end
				end

				local tbl15 = {}

				for i = 1, 30 do
					if fn23() then
						break
					end

					if fn24() then
						break
					end

					if not fn25() then
						fn26()
						local flag18 = false

						for _, instance in ipairs(CollectionService:GetTagged("SerpentKey")) do
							if not (instance:IsA("BasePart") and not tbl15[instance.Name]) then
								continue
							end
							tbl15[instance.Name] = true

							fn22(instance.Position, function()
								return instance:FindFirstChildWhichIsA("ProximityPrompt", true)
							end)

							for i2 = 1, 15 do
								task.wait(0.1)
								if fn25() then
									break
								end
							end

							if fn25() then
								flag18 = true
								break
							end
						end

						if not flag18 then
							break
						end
					end

					fn22(vector2, getChild2)

					for i2 = 1, 20 do
						task.wait(0.1)
						if not (not fn24() and fn25()) then
							break
						end
					end
				end

				lib:Notify({
					Title = "Serpent Box",
					Description = fn24() and "Schematic collected" or "Exhausted keys — server didn't fit any",
					Time = 5,
				})
			end,
		})
	end

	local Menu = tbl7.Settings:AddRightGroupbox("Menu")

	Menu:AddButton({
		Text = "Unload WinHub",
		Func = function()
			pcall(function()
				lib:Unload()
			end)
		end,
	})

	Menu:AddLabel("Menu bind"):AddKeyPicker("MenuBind", { Default = "RightShift", NoUI = true, Text = "Menu bind" })

	if lib.Options and lib.Options.MenuBind then
		lib.ToggleKeybind = lib.Options.MenuBind
	end

	local v25 = tbl7.Settings:AddLeftGroupbox("Custom Theme")
	local tbl13 = nil
	local font = nil

	local function fn21()
		if tbl13 then
			return
		end
		tbl13 = {}

		for k, v26 in pairs(lib.Scheme) do
			tbl13[k] = v26
		end

		font = lib.Scheme.Font
	end

	local tbl14 = {
		MainColor = Color3.fromRGB(0, 0, 128),
		AccentColor = Color3.fromRGB(0, 0, 128),
		BackgroundColor = Color3.fromRGB(192, 192, 192),
		OutlineColor = Color3.fromRGB(128, 128, 128),
		DarkColor = Color3.fromRGB(64, 64, 64),
		WhiteColor = Color3.fromRGB(255, 255, 255),
		FontColor = Color3.fromRGB(0, 0, 0),
		RedColor = Color3.fromRGB(170, 0, 0),
		DestructiveColor = Color3.fromRGB(170, 0, 0),
	}

	local font2 = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

	local function fn22(arg, font3)
		for k, v26 in pairs(arg) do
			lib.Scheme[k] = v26
		end

		if font3 then
			lib.Scheme.Font = font3

			pcall(function()
				lib:SetFont(font3)
			end)
		end

		pcall(function()
			lib:UpdateColorsUsingRegistry()
		end)
	end

	local tbl15 = {
		corner = setmetatable({}, { __mode = "k" }),
		textColor = setmetatable({}, { __mode = "k" }),
		bgColor = setmetatable({}, { __mode = "k" }),
		stroke = setmetatable({}, { __mode = "k" }),
		uistroke = setmetatable({}, { __mode = "k" }),
		padding = setmetatable({}, { __mode = "k" }),
		visible = setmetatable({}, { __mode = "k" }),
		position = setmetatable({}, { __mode = "k" }),
		bgTransparency = setmetatable({}, { __mode = "k" }),
		size = setmetatable({}, { __mode = "k" }),
		strokeColor = setmetatable({}, { __mode = "k" }),
	}

	local toggles = {}
	local color = Color3.fromRGB(192, 192, 192)
	local color2 = Color3.fromRGB(255, 255, 255)
	local color3 = Color3.fromRGB(64, 64, 64)

	local function fn23(parent)
		if parent:FindFirstChild("MyHubWin95Bevel") then
			return
		end

		if parent.AbsoluteSize.X < 40 or parent.AbsoluteSize.Y < 20 then
			return
		end
		local myHubWin95Bevel = Instance.new("Folder")
		myHubWin95Bevel.Name = "MyHubWin95Bevel"
		myHubWin95Bevel.Parent = parent

		for _, v26 in ipairs({
			{
				Size = UDim2.new(1, 0, 0, 1),
				Position = UDim2.new(0, 0, 0, 0),
				Color = color2,
			},
			{
				Size = UDim2.new(0, 1, 1, 0),
				Position = UDim2.new(0, 0, 0, 0),
				Color = color2,
			},
			{ Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1), Color = color3 },
			{
				Size = UDim2.new(0, 1, 1, 0),
				Position = UDim2.new(1, -1, 0, 0),
				Color = color3,
			},
		}) do
			local frame = Instance.new("Frame")
			frame.Size = v26.Size
			frame.Position = v26.Position
			frame.BackgroundColor3 = v26.Color
			frame.BorderSizePixel = 0
			frame.ZIndex = math.max(1, parent.ZIndex + 5)
			frame.Parent = myHubWin95Bevel
		end
	end

	local tbl16 = {
		DropdownList = true,
		DropdownScroll = true,
		MultiDropdownList = true,
		DropdownHolderFrame = true,
		DropdownFrame = true,
	}

	local function fn24(instance)
		local overlay = lib.Overlay
		local floats = lib.Floats
		local parent = instance.Parent

		for i = 1, 12 do
			if not parent then
				return false
			end

			if tbl16[parent.Name] then
				return true
			end

			if parent == overlay or parent == floats then
				return true
			end
			parent = parent.Parent
		end

		return false
	end

	local function getBackgroundColor3(guiObject)
		while guiObject do
			if guiObject:IsA("GuiObject") and guiObject.BackgroundTransparency < 0.9 then
				return guiObject.BackgroundColor3
			end
			guiObject = guiObject.Parent
		end

		return nil
	end

	local function fn25(backgroundColor3)
		if not backgroundColor3 then
			return false
		end
		return 0.2126 * backgroundColor3.R + 0.7152 * backgroundColor3.G + 0.0722 * backgroundColor3.B < 0.35
	end

	local function fn26()
		local screenGui = lib.ScreenGui
		if not screenGui then
			return
		end

		for _, descendant in ipairs(screenGui:GetDescendants()) do
			if not (descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox")) then
				continue
			end

			if descendant:FindFirstChild("MyHubSliderGradient") then
				continue
			end

			if tbl15.textColor[descendant] == nil then
				tbl15.textColor[descendant] = descendant.TextColor3
			end

			local backgroundColor3 = getBackgroundColor3(descendant)
			descendant.TextColor3 = fn25(backgroundColor3) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)

			if tbl15.stroke[descendant] == nil then
				tbl15.stroke[descendant] = descendant.TextStrokeTransparency
			end

			descendant.TextStrokeTransparency = 1
			local uiStroke = descendant:FindFirstChildOfClass("UIStroke")

			if uiStroke then
				if tbl15.uistroke[uiStroke] == nil then
					tbl15.uistroke[uiStroke] = uiStroke.Transparency
				end

				uiStroke.Transparency = 1
			end
		end
	end

	local function fn27(parent)
		if parent:FindFirstChild("MyHubWin95SunkenBevel") then
			return
		end

		if parent.AbsoluteSize.X < 4 or parent.AbsoluteSize.Y < 4 then
			return
		end
		local uiPadding = parent:FindFirstChildOfClass("UIPadding")
		local offset = uiPadding and uiPadding.PaddingLeft.Offset or 0
		local offset2 = uiPadding and uiPadding.PaddingRight.Offset or 0
		local offset3 = uiPadding and uiPadding.PaddingTop.Offset or 0
		local offset4 = uiPadding and uiPadding.PaddingBottom.Offset or 0

		local myHubWin95SunkenBevel = Instance.new("Folder")
		myHubWin95SunkenBevel.Name = "MyHubWin95SunkenBevel"
		myHubWin95SunkenBevel.Parent = parent

		for _, v26 in ipairs({
			{ Size = UDim2.new(1, offset + offset2, 0, 1), Position = UDim2.new(0, -offset, 0, -offset3), Color = color3 },
			{
				Size = UDim2.new(0, 1, 1, offset3 + offset4),
				Position = UDim2.new(0, -offset, 0, -offset3),
				Color = color3,
			},
			{
				Size = UDim2.new(1, offset + offset2, 0, 1),
				Position = UDim2.new(0, -offset, 1, offset4 - 1),
				Color = color2,
			},
			{ Size = UDim2.new(0, 1, 1, offset3 + offset4), Position = UDim2.new(1, offset2 - 1, 0, -offset3), Color = color2 },
		}) do
			local frame = Instance.new("Frame")
			frame.Size = v26.Size
			frame.Position = v26.Position
			frame.BackgroundColor3 = v26.Color
			frame.BorderSizePixel = 0
			frame.ZIndex = math.max(1, parent.ZIndex + 5)
			frame.Parent = myHubWin95SunkenBevel
		end
	end

	local function fn28(parent, arg, arg2)
		if parent:FindFirstChild("MyHubWin95WideBevel") then
			return
		end

		if parent.AbsoluteSize.X < 20 or parent.AbsoluteSize.Y < 20 then
			return
		end
		local yOffset = arg or 3
		local myHubWin95WideBevel = Instance.new("Folder")
		myHubWin95WideBevel.Name = "MyHubWin95WideBevel"
		myHubWin95WideBevel.Parent = parent

		local tbl17 = {
			{ Size = UDim2.new(1, 0, 0, yOffset), Position = UDim2.new(0, 0, 0, 0), Color = color2 },
			{ Size = UDim2.new(0, yOffset, 1, 0), Position = UDim2.new(0, 0, 0, 0), Color = color2 },
			{
				Size = UDim2.new(0, yOffset, 1, 0),
				Position = UDim2.new(1, -yOffset, 0, 0),
				Color = color3,
			},
		}

		if not arg2 then
			table.insert(tbl17, {
				Size = UDim2.new(1, 0, 0, yOffset),
				Position = UDim2.new(0, 0, 1, -yOffset),
				Color = color3,
			})
		end

		for _, v26 in ipairs(tbl17) do
			local frame = Instance.new("Frame")
			frame.Size = v26.Size
			frame.Position = v26.Position
			frame.BackgroundColor3 = v26.Color
			frame.BorderSizePixel = 0
			frame.ZIndex = math.max(1, parent.ZIndex + 5)
			frame.Parent = myHubWin95WideBevel
		end
	end

	local function fn29(parent)
		if parent:FindFirstChild("MyHubWin95Bevel") then
			return
		end

		if parent.AbsoluteSize.X < 6 or parent.AbsoluteSize.Y < 6 then
			return
		end
		local uiPadding = parent:FindFirstChildOfClass("UIPadding")
		local offset = uiPadding and uiPadding.PaddingLeft.Offset or 0
		local offset2 = uiPadding and uiPadding.PaddingRight.Offset or 0
		local offset3 = uiPadding and uiPadding.PaddingTop.Offset or 0
		local offset4 = uiPadding and uiPadding.PaddingBottom.Offset or 0

		local myHubWin95Bevel = Instance.new("Folder")
		myHubWin95Bevel.Name = "MyHubWin95Bevel"
		myHubWin95Bevel.Parent = parent

		for _, v26 in ipairs({
			{
				Size = UDim2.new(1, offset + offset2, 0, 1),
				Position = UDim2.new(0, -offset, 0, -offset3),
				Color = color2,
			},
			{ Size = UDim2.new(0, 1, 1, offset3 + offset4), Position = UDim2.new(0, -offset, 0, -offset3), Color = color2 },
			{ Size = UDim2.new(1, offset + offset2, 0, 1), Position = UDim2.new(0, -offset, 1, offset4 - 1), Color = color3 },
			{
				Size = UDim2.new(0, 1, 1, offset3 + offset4),
				Position = UDim2.new(1, offset2 - 1, 0, -offset3),
				Color = color3,
			},
		}) do
			local frame = Instance.new("Frame")
			frame.Size = v26.Size
			frame.Position = v26.Position
			frame.BackgroundColor3 = v26.Color
			frame.BorderSizePixel = 0
			frame.ZIndex = math.max(1, parent.ZIndex + 5)
			frame.Parent = myHubWin95Bevel
		end
	end

	local function fn30(guiObject)
		if not guiObject:IsA("Frame") then
			return false
		end

		if guiObject.Parent and (guiObject.Parent.Name == "MyHubWin95Bevel" or guiObject.Parent.Name == "MyHubWin95SunkenBevel") then
			return false
		end
		local size = guiObject.Size
		if not (size.X.Offset == 1 or size.Y.Offset == 1) then
			return false
		end
		local backgroundColor3 = guiObject.BackgroundColor3
		return (backgroundColor3.R > 0.9 and backgroundColor3.G > 0.9 and backgroundColor3.B > 0.9 or backgroundColor3.R < 0.3 and backgroundColor3.G < 0.3 and backgroundColor3.B < 0.3) and guiObject.BackgroundTransparency < 0.5
	end

	local function fn31()
		if not lib.Options then
			return
		end

		for _, option in pairs(lib.Options) do
			if type(option) ~= "table" or option.Type ~= "Dropdown" and option.Type ~= "MultiDropdown" or typeof(option.Holder) ~= "Instance" then
				continue
			end
			local child2 = nil
			local child3 = nil

			for _, child in ipairs(option.Holder:GetChildren()) do
				if child:IsA("TextButton") and child.BackgroundTransparency < 0.5 then
					if not child2 or child.AbsoluteSize.X >= child2.AbsoluteSize.X then
						child2 = child
					end
				elseif child:IsA("ImageLabel") and child.Image ~= "" then
					child3 = child
				end
			end

			for _, descendant in ipairs(option.Holder:GetDescendants()) do
				if fn30(descendant) then
					if tbl15.visible[descendant] == nil then
						tbl15.visible[descendant] = descendant.Visible
					end

					descendant.Visible = false
				end
			end

			for _, descendant in ipairs(option.Holder:GetDescendants()) do
				if descendant:IsA("ImageLabel") and descendant.Image ~= "" then
					if tbl15.position[descendant] == nil then
						tbl15.position[descendant] = descendant.Position
					end

					descendant.Position = UDim2.new(1, 18, 0.5, 0)
					break
				end
			end

			if child2 then
				local myHubWin95Bevel = child2:FindFirstChild("MyHubWin95Bevel")

				if myHubWin95Bevel then
					pcall(function()
						myHubWin95Bevel:Destroy()
					end)
				end

				if tbl15.bgColor[child2] == nil then
					tbl15.bgColor[child2] = child2.BackgroundColor3
				end

				child2.BackgroundColor3 = color
				local uiPadding = child2:FindFirstChildOfClass("UIPadding")

				if uiPadding then
					if tbl15.padding[uiPadding] == nil then
						tbl15.padding[uiPadding] = { L = uiPadding.PaddingLeft, R = uiPadding.PaddingRight }
					end

					uiPadding.PaddingLeft = UDim.new(0, 6)
					uiPadding.PaddingRight = UDim.new(0, 22)
				end

				fn27(child2)
			end

			if child3 then
				if not option.Holder:FindFirstChild("MyHubWin95ArrowBevel") then
					local myHubWin95ArrowBevel = Instance.new("Frame")
					myHubWin95ArrowBevel.Name = "MyHubWin95ArrowBevel"
					myHubWin95ArrowBevel.AnchorPoint = child3.AnchorPoint
					myHubWin95ArrowBevel.Position = child3.Position
					myHubWin95ArrowBevel.Size = child3.Size
					myHubWin95ArrowBevel.BackgroundColor3 = color
					myHubWin95ArrowBevel.BackgroundTransparency = 0
					myHubWin95ArrowBevel.BorderSizePixel = 0
					myHubWin95ArrowBevel.ZIndex = math.max(1, child3.ZIndex) - 1
					myHubWin95ArrowBevel.Parent = option.Holder
					fn23(myHubWin95ArrowBevel)
				end
			end
		end
	end

	local fn32, fn33

	do
		local color4 = Color3.fromRGB(0, 128, 0)
		local color5 = Color3.fromRGB(96, 96, 96)
		local obj4 = setmetatable({}, { __mode = "k" })

		local function fn34(instance)
			local v26 = obj4[instance]

			if v26 then
				local instance2 = v26[1]
				local instance3 = v26[2]
				if (not instance2 or instance2.Parent) and (not instance3 or instance3.Parent) then
					return instance2, instance3
				end
			end

			local descendant2 = nil
			local descendant3 = nil

			for _, descendant in ipairs(instance:GetDescendants()) do
				if not (descendant:IsA("Frame") and descendant.BackgroundTransparency < 0.5) then
					continue
				end
				local absoluteSize = descendant.AbsoluteSize

				if absoluteSize.X > 25 and absoluteSize.X < 40 and absoluteSize.Y > 14 and absoluteSize.Y < 22 then
					descendant2 = descendant
				elseif absoluteSize.X > 10 and absoluteSize.X < 18 and absoluteSize.Y > 10 and absoluteSize.Y < 18 then
					descendant3 = descendant
				end
			end

			if descendant2 or descendant3 then
				obj4[instance] = { descendant2, descendant3 }
			end

			return descendant2, descendant3
		end

		local function fn35(instance)
			if not instance then
				return
			end

			for _, child in ipairs(instance:GetChildren()) do
				if child:IsA("UIStroke") then
					if tbl15.uistroke[child] == nil then
						tbl15.uistroke[child] = child.Transparency
					end

					if child.Transparency ~= 1 then
						child.Transparency = 1
					end
				end
			end
		end

		fn32 = function(E)
			if not ((type(E) == "table") and (typeof(E.Holder) == "Instance")) then
				return
			end
			local h, Q = fn34(E.Holder)

			if h then
				if tbl15.bgColor[h] == nil then
					tbl15.bgColor[h] = h.BackgroundColor3
				end

				local l = (E.Value and color4) or color5

				if h.BackgroundColor3 ~= l then
					h.BackgroundColor3 = l
				end

				fn35(h)
			end

			if Q then
				if tbl15.bgColor[Q] == nil then
					tbl15.bgColor[Q] = Q.BackgroundColor3
				end

				if Q.BackgroundColor3 ~= color then
					Q.BackgroundColor3 = color
				end

				fn35(Q)
			end
		end

		local function fn36(toggle)
			if toggles[toggle] then
				return
			end
			local instance, instance2 = fn34(toggle.Holder)
			if not (instance or instance2) then
				return
			end
			local flag18 = false
			local connections = {}

			if instance then
				table.insert(connections, instance:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
					if flag18 then
						return
					end
					flag18 = true
					fn32(toggle)
					flag18 = false
				end))
			end

			if instance2 then
				table.insert(connections, instance2:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
					if flag18 then
						return
					end
					flag18 = true
					fn32(toggle)
					flag18 = false
				end))
			end

			toggles[toggle] = connections
		end

		fn33 = function()
			if not lib.Toggles then
				return
			end

			for _, toggle in pairs(lib.Toggles) do
				if type(toggle) ~= "table" or toggle.Type ~= "Toggle" or typeof(toggle.Holder) ~= "Instance" then
					continue
				end
				fn32(toggle)
				fn36(toggle)
				local v26, v27 = fn34(toggle.Holder)

				for _, instance in ipairs({ v26, v27 }) do
					if not instance then
						continue
					end

					for _, child in ipairs(instance:GetChildren()) do
						if child:IsA("UIStroke") then
							if tbl15.uistroke[child] == nil then
								tbl15.uistroke[child] = child.Transparency
							end

							child.Transparency = 1
						end
					end
				end

				if v26 then
					fn27(v26)
				end
			end
		end
	end

	local function fn34()
		if not lib.Tabs then
			return
		end

		for _, tab in pairs(lib.Tabs) do
			if type(tab) ~= "table" or typeof(tab.Container) ~= "Instance" then
				continue
			end

			for _, child in ipairs(tab.Container:GetChildren()) do
				if not child:IsA("ScrollingFrame") then
					continue
				end

				for _, child2 in ipairs(child:GetChildren()) do
					if not (child2:IsA("Frame") and child2.AbsoluteSize.X > 100 and child2.AbsoluteSize.Y > 8) then
						continue
					end

					for _, child3 in ipairs(child2:GetChildren()) do
						if not (child3:IsA("Frame") and child3.BackgroundTransparency < 0.5 and not child3:FindFirstChild("MyHubWin95SunkenBevel")) then
							continue
						end

						for _, child4 in ipairs(child3:GetChildren()) do
							if child4:IsA("UIStroke") then
								if tbl15.uistroke[child4] == nil then
									tbl15.uistroke[child4] = child4.Transparency
								end

								child4.Transparency = 1
							end
						end

						fn27(child3)
					end
				end
			end
		end
	end

	local function fn35(guiObject)
		if not guiObject:IsA("TextButton") then
			return false
		end

		if guiObject.AbsoluteSize.X < 8 or guiObject.AbsoluteSize.X > 60 then
			return false
		end

		if guiObject.AbsoluteSize.Y < 14 or guiObject.AbsoluteSize.Y > 24 then
			return false
		end

		if guiObject.Text == "" then
			return false
		end

		if 8 < guiObject.Text:len() then
			return false
		end

		return true
	end

	local function fn36()


		local screenGui = lib.ScreenGui
		if not screenGui then
			return
		end

		do
			for _, descendant in ipairs(screenGui:GetDescendants()) do
				if not fn35(descendant) then
					continue
				end

				if tbl15.bgColor[descendant] == nil then
					tbl15.bgColor[descendant] = descendant.BackgroundColor3
				end

				if tbl15.bgTransparency[descendant] == nil then
					tbl15.bgTransparency[descendant] = descendant.BackgroundTransparency
				end

				descendant.BackgroundColor3 = color

				if 0.5 < descendant.BackgroundTransparency then
					descendant.BackgroundTransparency = 0
				end

				fn29(descendant)
			end

			return
		end
	end

	local fn37, fn38

	do
		local color4 = Color3.fromRGB(255, 255, 255)

		local function getInstance(text, arg, backgroundColor3)
			local instance = Instance.new("TextButton")
			instance.Size = UDim2.new(0, 22, 0, 20)
			instance.BackgroundColor3 = color
			instance.BackgroundTransparency = 0
			instance.BorderSizePixel = 0
			instance.Text = text
			instance.Font = Enum.Font.SourceSansBold
			instance.TextSize = 14
			instance.TextColor3 = Color3.fromRGB(0, 0, 0)
			instance.AutoButtonColor = false
			instance.Active = true
			instance.ZIndex = 10

			if backgroundColor3 then
				instance.MouseEnter:Connect(function()
					instance.BackgroundColor3 = backgroundColor3
				end)

				instance.MouseLeave:Connect(function()
					instance.BackgroundColor3 = color
				end)
			end

			return instance
		end

		local color5 = Color3.fromRGB(0, 0, 128)

		fn37 = function(arg)
			if arg then
				tbl14.MainColor = Color3.fromRGB(70, 90, 170)
				tbl14.AccentColor = Color3.fromRGB(70, 90, 170)
				tbl14.BackgroundColor = Color3.fromRGB(55, 55, 60)
				tbl14.OutlineColor = Color3.fromRGB(30, 30, 33)
				tbl14.DarkColor = Color3.fromRGB(20, 20, 22)
				tbl14.WhiteColor = Color3.fromRGB(220, 220, 225)
				tbl14.FontColor = Color3.fromRGB(235, 235, 240)
				tbl14.RedColor = Color3.fromRGB(200, 80, 80)
				tbl14.DestructiveColor = Color3.fromRGB(200, 80, 80)
				color = Color3.fromRGB(55, 55, 60)
				color2 = Color3.fromRGB(105, 105, 115)
				color3 = Color3.fromRGB(15, 15, 15)
				color4 = Color3.fromRGB(30, 30, 33)
				color5 = Color3.fromRGB(15, 15, 60)
			else
				tbl14.MainColor = Color3.fromRGB(0, 0, 128)
				tbl14.AccentColor = Color3.fromRGB(0, 0, 128)
				tbl14.BackgroundColor = Color3.fromRGB(192, 192, 192)
				tbl14.OutlineColor = Color3.fromRGB(128, 128, 128)
				tbl14.DarkColor = Color3.fromRGB(64, 64, 64)
				tbl14.WhiteColor = Color3.fromRGB(255, 255, 255)
				tbl14.FontColor = Color3.fromRGB(0, 0, 0)
				tbl14.RedColor = Color3.fromRGB(170, 0, 0)
				tbl14.DestructiveColor = Color3.fromRGB(170, 0, 0)
				color = Color3.fromRGB(192, 192, 192)
				color2 = Color3.fromRGB(255, 255, 255)
				color3 = Color3.fromRGB(64, 64, 64)
				color4 = Color3.fromRGB(255, 255, 255)
				color5 = Color3.fromRGB(0, 0, 128)
			end
		end

		local function fn39()
			if not lib.ScreenGui then
				return
			end
			local windowContainer = getgenv().Library and getgenv().Library.WindowContainer

			if windowContainer then
				while windowContainer and windowContainer.Name ~= "Main" and windowContainer.Parent do
					windowContainer = windowContainer.Parent
				end
			end

			if not (windowContainer and windowContainer:IsA("GuiObject")) then
				return
			end

			if windowContainer:FindFirstChild("MyHubWin95TitleBar") then
				return
			end
			local myHubWin95TitleBar = Instance.new("Frame")
			myHubWin95TitleBar.Name = "MyHubWin95TitleBar"
			myHubWin95TitleBar.AnchorPoint = Vector2.new(0, 1)
			myHubWin95TitleBar.Position = UDim2.new(0, 0, 0, 0)
			myHubWin95TitleBar.Size = UDim2.new(1, 0, 0, 22)
			myHubWin95TitleBar.BackgroundColor3 = color5
			myHubWin95TitleBar.BackgroundTransparency = 0
			myHubWin95TitleBar.BorderSizePixel = 0
			myHubWin95TitleBar.ZIndex = 20
			myHubWin95TitleBar.Parent = windowContainer
			fn28(myHubWin95TitleBar, 3, true)
			local imageLabel = Instance.new("ImageLabel")
			imageLabel.Size = UDim2.new(0, 16, 0, 16)
			imageLabel.Position = UDim2.new(0, 4, 0.5, 0)
			imageLabel.AnchorPoint = Vector2.new(0, 0.5)
			imageLabel.BackgroundTransparency = 1
			imageLabel.ZIndex = 21
			imageLabel.ScaleType = Enum.ScaleType.Fit
			imageLabel.Parent = myHubWin95TitleBar

			task.spawn(function()
				if type(getcustomasset) ~= "function" then
					return
				end
				local v26 = 0

				while imageLabel.Parent and v26 < 15 do
					if type(isfile) == "function" and isfile("WinHub/GameName/logo.png") then
						local ok, image = pcall(getcustomasset, "WinHub/GameName/logo.png")
						if ok and image then
							imageLabel.Image = image
							return
						end
					end

					task.wait(0.25)
					v26 += 0.25
				end
			end)

			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(1, -110, 1, 0)
			textLabel.Position = UDim2.new(0, 24, 0, 0)
			textLabel.BackgroundTransparency = 1
			textLabel.Font = Enum.Font.SourceSansBold
			textLabel.TextSize = 14
			textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			textLabel.TextStrokeTransparency = 1
			textLabel.TextXAlignment = Enum.TextXAlignment.Left
			textLabel.TextYAlignment = Enum.TextYAlignment.Center
			textLabel.Text = title
			textLabel.ZIndex = 21
			textLabel.Parent = myHubWin95TitleBar

			local myHubWin95TitleButtons = Instance.new("Frame")
			myHubWin95TitleButtons.Name = "MyHubWin95TitleButtons"
			myHubWin95TitleButtons.AnchorPoint = Vector2.new(1, 0.5)
			myHubWin95TitleButtons.Position = UDim2.new(1, -4, 0.5, 0)
			myHubWin95TitleButtons.BackgroundTransparency = 1
			myHubWin95TitleButtons.ZIndex = 21
			myHubWin95TitleButtons.Parent = myHubWin95TitleBar
			myHubWin95TitleButtons.Size = UDim2.new(0, 52, 0, 14)

			local instance = getInstance("_", "Minimize")
			instance.Size = UDim2.new(0, 16, 0, 14)
			instance.Position = UDim2.new(0, 0, 0, 0)
			instance.TextSize = 11
			instance.TextYAlignment = Enum.TextYAlignment.Bottom
			instance.ZIndex = 22
			instance.Parent = myHubWin95TitleButtons

			local uiPadding = Instance.new("UIPadding")
			uiPadding.PaddingBottom = UDim.new(0, 3)
			uiPadding.Parent = instance
			fn29(instance)

			instance.MouseButton1Click:Connect(function()
				pcall(function()
					lib:Toggle()
				end)
			end)

			local instance2 = getInstance("□", "Maximize")
			instance2.Size = UDim2.new(0, 16, 0, 14)
			instance2.Position = UDim2.new(0, 18, 0, 0)
			instance2.TextSize = 11
			instance2.ZIndex = 22
			instance2.Parent = myHubWin95TitleButtons
			fn29(instance2)

			instance2.MouseButton1Click:Connect(function()
				pcall(function()
					lib:Toggle()
				end)
			end)

			local instance3 = getInstance("✕", "Close", Color3.fromRGB(232, 17, 35))
			instance3.Size = UDim2.new(0, 16, 0, 14)
			instance3.Position = UDim2.new(0, 36, 0, 0)
			instance3.TextSize = 11
			instance3.ZIndex = 22
			instance3.Parent = myHubWin95TitleButtons
			fn29(instance3)

			instance3.MouseButton1Click:Connect(function()
				pcall(function()
					lib:Unload()
				end)
			end)

			local UserInputService = game:GetService("UserInputService")
			local flag18 = nil
			local position = nil
			local position2 = nil

			myHubWin95TitleBar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					flag18 = true
					position = input.Position
					position2 = windowContainer.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							flag18 = false
						end
					end)
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if flag18 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					local position3 = input.Position - position
					windowContainer.Position = UDim2.new(position2.X.Scale, position2.X.Offset + position3.X, position2.Y.Scale, position2.Y.Offset + position3.Y)
				end
			end)
		end

		local function fn40(guiObject)
			if not guiObject:IsA("TextBox") then
				return false
			end

			if guiObject.PlaceholderText == "Search" then
				return true
			end
			local absoluteSize = guiObject.AbsoluteSize
			if absoluteSize.X < 150 or absoluteSize.Y > 40 then
				return false
			end

			if guiObject.Parent and guiObject.Parent:IsA("TextButton") then
				return false
			end
			return true
		end

		local function fn41()
			local screenGui = lib.ScreenGui
			if not screenGui then
				return
			end

			for _, descendant in ipairs(screenGui:GetDescendants()) do
				if fn40(descendant) then
					local myHubWin95Bevel = descendant:FindFirstChild("MyHubWin95Bevel")

					if myHubWin95Bevel then
						pcall(function()
							myHubWin95Bevel:Destroy()
						end)
					end

					if tbl15.bgColor[descendant] == nil then
						tbl15.bgColor[descendant] = descendant.BackgroundColor3
					end

					descendant.BackgroundColor3 = color4
					fn27(descendant)
				end
			end
		end

		local function fn42(child, parent)
			if not parent:FindFirstChild("MyHubSliderGradient") then
				local myHubSliderGradient = Instance.new("StringValue")
				myHubSliderGradient.Name = "MyHubSliderGradient"
				myHubSliderGradient.Parent = parent
			end

			if tbl15.textColor[parent] == nil then
				tbl15.textColor[parent] = parent.TextColor3
			end

			if tbl15.stroke[parent] == nil then
				tbl15.stroke[parent] = parent.TextStrokeTransparency
			end

			if tbl15.strokeColor[parent] == nil then
				tbl15.strokeColor[parent] = parent.TextStrokeColor3
			end

			parent.TextColor3 = Color3.fromRGB(255, 255, 255)
			parent.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
			parent.TextStrokeTransparency = 0
		end

		local function fn43()
			if not lib.Options then
				return
			end

			for _, option in pairs(lib.Options) do
				if type(option) ~= "table" or option.Type ~= "Slider" or typeof(option.Holder) ~= "Instance" then
					continue
				end
				local child2 = nil

				for _, child in ipairs(option.Holder:GetChildren()) do
					if child:IsA("TextButton") then
						if tbl15.bgColor[child] == nil then
							tbl15.bgColor[child] = child.BackgroundColor3
						end

						child.BackgroundColor3 = color
						fn27(child)
						child2 = child
					end

					if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
						if tbl15.stroke[child] == nil then
							tbl15.stroke[child] = child.TextStrokeTransparency
						end

						child.TextStrokeTransparency = 1
					end
				end

				if not child2 then
					continue
				end
				local children = {}
				local child3 = nil

				for _, child in ipairs(child2:GetChildren()) do
					if child:IsA("Frame") and child.BackgroundTransparency < 0.5 then
						child3 = child
					elseif child:IsA("TextLabel") or child:IsA("TextBox") then
						table.insert(children, child)
					end
				end

				if child3 then
					for _, child in ipairs(children) do
						fn42(child3, child)
					end
				end
			end
		end

		local obj4 = setmetatable({}, { __mode = "k" })

		local function fn44(E, h)
			if not E or not E.Parent then
				return
			end

			if (E:IsA("TextLabel") or (E:IsA("TextButton"))) or (E:IsA("TextBox")) then
				if E:FindFirstChild("MyHubSliderGradient") then
					return
				end
				E.TextColor3 = (fn25(h or (getBackgroundColor3(E))) and (Color3.fromRGB(255, 255, 255))) or (Color3.fromRGB(0, 0, 0))
			elseif E:IsA("ImageLabel") or (E:IsA("ImageButton")) then
				if E.Name == "MyHubWin95Icon" then
					return
				end

				if obj4[E] == nil then
					obj4[E] = E.ImageColor3
				end

				E.ImageColor3 = (fn25(h or (getBackgroundColor3(E))) and (Color3.fromRGB(255, 255, 255))) or (Color3.fromRGB(0, 0, 0))
			end
		end

		local fn45 = nil
		local fn46 = nil
		local connection = nil

		local function fn47()
			if not connection then
				local screenGui = lib.ScreenGui

				if not screenGui then
					do
						return
					end
				end

				connection = screenGui.DescendantAdded:Connect(function(E)
					if fn30(E) then
						if tbl15.visible[E] == nil then
							tbl15.visible[E] = E.Visible
						end

						E.Visible = false
						return
					end

					if E:IsA("GuiObject") then
						fn45(E)
						task.defer(fn44, E)
					end
				end)

				return
			end

			do
				return
			end
		end

		local function fn48()
			if connection then
				pcall(function()
					connection:Disconnect()
				end)

				connection = nil
			end
		end

		local v26 = 0

		fn46 = function(E, h)
			if not (E and (E:IsA("GuiObject"))) then
				return
			end
			local Q = if E.BackgroundTransparency < 0.9 then E.BackgroundColor3 else h or (getBackgroundColor3(E))
			fn44(E, Q)

			for h, h in ipairs(E:GetChildren()) do
				if h:IsA("GuiObject") then
					fn46(h, Q)
				end
			end
		end

		local obj5 = setmetatable({}, { __mode = "k" })

		fn45 = function(E)
			if not E or obj5[E] then
				return
			end

			if not E:IsA("GuiObject") then
				return
			end
			obj5[E] = true

			E:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
				fn46(E)
			end)

			E:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
				fn46(E)
			end)
		end

		local function fn49()
			v26 += 1
			local screenGui = lib.ScreenGui
			if not screenGui then
				return
			end

			for _, descendant in ipairs(screenGui:GetDescendants()) do
				if descendant:IsA("GuiObject") then
					fn45(descendant)
				end
			end

			for _, child in ipairs(screenGui:GetChildren()) do
				if child:IsA("GuiObject") then
					fn46(child)
				end
			end

			if lib.Toggles then
				for _, toggle in pairs(lib.Toggles) do
					if type(toggle) == "table" and toggle.Type == "Toggle" then
						fn32(toggle)
					end
				end
			end
		end

		local function fn50()
			v26 += 1
		end

		local function fn51()
			local screenGui = lib.ScreenGui
			if not screenGui then
				return
			end

			for _, descendant in ipairs(screenGui:GetDescendants()) do
				if descendant:IsA("UICorner") then
					if tbl15.corner[descendant] == nil then
						tbl15.corner[descendant] = descendant.CornerRadius
					end

					descendant.CornerRadius = UDim.new(0, 0)
				elseif descendant:IsA("TextButton") then
					local isTextButton = descendant.Parent and descendant.Parent:IsA("TextButton")

					if not fn24(descendant) and not isTextButton then
						fn23(descendant)
					end
				end
			end

			pcall(fn43)
			pcall(fn31)
			pcall(fn34)
			pcall(fn36)
			pcall(fn33)
			pcall(fn41)
			pcall(fn39)
			pcall(fn26)
			fn49()
			fn47()

			if getgenv().Library then
				local windowContainer = getgenv().Library.WindowContainer

				while windowContainer and windowContainer.Name ~= "Main" and windowContainer.Parent do
					windowContainer = windowContainer.Parent
				end

				if windowContainer and windowContainer:IsA("GuiObject") then
					for _, child in ipairs(windowContainer:GetChildren()) do
						if child:IsA("UIStroke") then
							if tbl15.uistroke[child] == nil then
								tbl15.uistroke[child] = child.Transparency
							end

							child.Transparency = 1
						elseif child:IsA("Frame") and child.BackgroundTransparency < 0.5 and child.AbsoluteSize.Y <= 3 and child.AbsoluteSize.X > 100 then
							if tbl15.visible[child] == nil then
								tbl15.visible[child] = child.Visible
							end

							child.Visible = false
						end
					end

					if not windowContainer:FindFirstChild("MyHubWin95BevelWrapper") then
						local myHubWin95BevelWrapper = Instance.new("Frame")
						myHubWin95BevelWrapper.Name = "MyHubWin95BevelWrapper"
						myHubWin95BevelWrapper.BackgroundTransparency = 1
						myHubWin95BevelWrapper.BorderSizePixel = 0
						myHubWin95BevelWrapper.Position = UDim2.new(0, 0, 0, -22)
						myHubWin95BevelWrapper.Size = UDim2.new(1, 0, 1, 22)
						myHubWin95BevelWrapper.ZIndex = 15
						myHubWin95BevelWrapper.Parent = windowContainer
						fn28(myHubWin95BevelWrapper, 3)
					end
				end
			end

			local windowContainer = getgenv().Library and getgenv().Library.WindowContainer

			while windowContainer and windowContainer.Name ~= "Main" and windowContainer.Parent do
				windowContainer = windowContainer.Parent
			end

			if windowContainer and windowContainer:IsA("GuiObject") then
				for _, child in ipairs(windowContainer:GetChildren()) do
					if not (child:IsA("Frame") and child.BackgroundTransparency < 0.5 and child.AbsoluteSize.X <= 3 and child.AbsoluteSize.Y > 100) then
						continue
					end

					if tbl15.position[child] == nil then
						tbl15.position[child] = child.Position
					end

					if tbl15.size[child] == nil then
						tbl15.size[child] = child.Size
					end

					local position = child.Position
					local size = child.Size
					child.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset + 48)
					child.Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset - 48)
				end
			end

			for _, descendant in ipairs(screenGui:GetDescendants()) do
				if not (descendant:IsA("TextLabel") and descendant.Parent and descendant.Parent.Name ~= "MyHubWin95TitleBar" and (descendant.Text == "WinHub" or descendant.Text == title)) then
					continue
				end
				local parent = descendant.Parent

				if parent and parent:IsA("GuiObject") then
					if tbl15.visible[parent] == nil then
						tbl15.visible[parent] = parent.Visible
					end

					parent.Visible = false
				end
			end

			for _, descendant in ipairs(screenGui:GetDescendants()) do
				if not (descendant:IsA("TextBox") and descendant.PlaceholderText == "Search") then
					continue
				end

				if tbl15.size[descendant] == nil then
					tbl15.size[descendant] = descendant.Size
				end

				descendant.Size = UDim2.new(1, -12, 0, math.max(descendant.AbsoluteSize.Y, 32))
				local parent = descendant.Parent

				if parent and parent:IsA("GuiObject") then
					if tbl15.size[parent] == nil then
						tbl15.size[parent] = parent.Size
					end

					parent.Size = UDim2.new(1, -60, 0, parent.AbsoluteSize.Y)
				end
			end

			for _, instance in ipairs({ lib.Overlay, lib.Floats }) do
				if typeof(instance) ~= "Instance" then
					continue
				end

				for _, descendant in ipairs(instance:GetDescendants()) do
					if descendant.Name == "MyHubWin95Bevel" or descendant.Name == "MyHubWin95SunkenBevel" then
						pcall(function()
							descendant:Destroy()
						end)
					end
				end
			end
		end

		fn38 = function()
			local screenGui = lib.ScreenGui
			if not screenGui then
				return
			end

			local function fn52(arg, arg2)
				for k, v27 in pairs(arg) do
					if k and k.Parent then
						pcall(arg2, k, v27)
					end
				end
			end

			fn52(tbl15.corner, function(arg, cornerRadius)
				arg.CornerRadius = cornerRadius
			end)

			fn52(tbl15.textColor, function(guiObject, textColor3)
				guiObject.TextColor3 = textColor3
			end)

			fn52(tbl15.bgColor, function(guiObject, backgroundColor3)
				do
					guiObject.BackgroundColor3 = backgroundColor3
					return
				end
			end)

			fn52(tbl15.stroke, function(arg, textStrokeTransparency)
				arg.TextStrokeTransparency = textStrokeTransparency
			end)

			fn52(tbl15.strokeColor, function(arg, textStrokeColor3)
				arg.TextStrokeColor3 = textStrokeColor3
			end)

			fn52(tbl15.uistroke, function(arg, transparency)
				arg.Transparency = transparency
			end)

			fn52(tbl15.padding, function(arg, arg2)
				arg.PaddingLeft = arg2.L
				arg.PaddingRight = arg2.R
			end)

			fn52(tbl15.visible, function(arg, visible)
				arg.Visible = visible
			end)

			fn52(tbl15.position, function(arg, position)
				arg.Position = position
			end)

			fn52(obj4, function(arg, imageColor3)
				arg.ImageColor3 = imageColor3
			end)

			fn52(tbl15.bgTransparency, function(guiObject, backgroundTransparency)
				guiObject.BackgroundTransparency = backgroundTransparency
			end)

			fn52(tbl15.size, function(arg, size)
				arg.Size = size
			end)

			tbl15.corner = setmetatable({}, { __mode = "k" })
			tbl15.textColor = setmetatable({}, { __mode = "k" })
			tbl15.bgColor = setmetatable({}, { __mode = "k" })
			tbl15.stroke = setmetatable({}, { __mode = "k" })
			tbl15.strokeColor = setmetatable({}, { __mode = "k" })
			tbl15.uistroke = setmetatable({}, { __mode = "k" })
			tbl15.padding = setmetatable({}, { __mode = "k" })
			tbl15.visible = setmetatable({}, { __mode = "k" })
			tbl15.position = setmetatable({}, { __mode = "k" })
			obj4 = setmetatable({}, { __mode = "k" })
			tbl15.bgTransparency = setmetatable({}, { __mode = "k" })
			tbl15.size = setmetatable({}, { __mode = "k" })

			pcall(function()
				for _, toggle in pairs(toggles) do
					if type(toggle) == "table" then
						for _, connection2 in ipairs(toggle) do
							pcall(function()
								connection2:Disconnect()
							end)
						end
					end
				end
			end)

			toggles = {}
			pcall(fn50)
			pcall(fn48)

			local tbl17 = {
				MyHubWin95Bevel = true,
				MyHubWin95SunkenBevel = true,
				MyHubWin95ArrowBevel = true,
				MyHubWin95Icon = true,
				MyHubSliderGradient = true,
				MyHubWin95TitleButtons = true,
				MyHubWin95TitleBar = true,
				MyHubWin95WideBevel = true,
				MyHubWin95BevelWrapper = true,
				MyHubStatsSquared = true,
				MyHubStatsBevelTop = true,
				MyHubStatsBevelLeft = true,
				MyHubStatsBevelRight = true,
				MyHubStatsBevelBottom = true,
			}

			for _, descendant in ipairs(screenGui:GetDescendants()) do
				if tbl17[descendant.Name] then
					pcall(function()
						descendant:Destroy()
					end)
				end
			end
		end

		local function fn52()
			if type(getcustomasset) ~= "function" then
				return
			end
			local screenGui = lib and lib.ScreenGui
			if not screenGui then
				return
			end
			local descendant2 = nil

			for _, descendant in ipairs(screenGui:GetDescendants()) do
				if descendant:IsA("TextLabel") and descendant.Text == title then
					descendant2 = descendant
					break
				end
				descendant2 = nil
			end

			if not descendant2 or not descendant2.Parent then
				return
			end
			local parent = descendant2.Parent
			if parent:FindFirstChild("MyHubDefaultTitleLogo") then
				return
			end
			local myHubDefaultTitleLogo = Instance.new("ImageLabel")
			myHubDefaultTitleLogo.Name = "MyHubDefaultTitleLogo"
			myHubDefaultTitleLogo.Size = UDim2.new(0, 16, 0, 16)
			myHubDefaultTitleLogo.BackgroundTransparency = 1
			myHubDefaultTitleLogo.ScaleType = Enum.ScaleType.Fit
			myHubDefaultTitleLogo.ZIndex = (descendant2.ZIndex or 1) + 1
			myHubDefaultTitleLogo.LayoutOrder = -999
			myHubDefaultTitleLogo.Parent = parent

			task.spawn(function()
				local n = 0

				while myHubDefaultTitleLogo.Parent and n < 15 do
					if type(isfile) == "function" and isfile("WinHub/GameName/logo.png") then
						local ok, image = pcall(getcustomasset, "WinHub/GameName/logo.png")
						if ok and image then
							myHubDefaultTitleLogo.Image = image
							return
						end
					end

					task.wait(0.25)
					n += 0.25
				end
			end)
		end

		local function fn53()
			local screenGui = lib and lib.ScreenGui
			if not screenGui then
				return
			end

			for _, descendant in ipairs(screenGui:GetDescendants()) do
				if descendant.Name == "MyHubDefaultTitleLogo" then
					pcall(function()
						descendant:Destroy()
					end)
				end
			end
		end

		v25:AddToggle("Win95Theme", {
			Text = "Windows 95 Theme",
			Default = true,
			Callback = function(windows95Theme)
				fn21()

				if windows95Theme then
					fn37(tbl8.win95Dark)
					fn22(tbl14, font2)
					fn51()
					fn53()
				else
					fn38()
					fn22(tbl13, font)
					fn52()
				end

				if _G.__myhubStatsLabel then
					local win95Theme = lib.Toggles and lib.Toggles.Win95Theme

					if win95Theme then
						win95Theme.Value = windows95Theme
					end

					local showStats = lib.Toggles and lib.Toggles.ShowStats

					if showStats and showStats.Value and type(showStats.Callback) == "function" then
						pcall(showStats.Callback, showStats.Value)
					end
				end
			end,
		})

		v25:AddToggle("Win95Dark", {
			Text = "Dark Mode",
			Default = false,
			Tooltip = "Dark palette variant of the Win95 theme",
			Callback = function(darkMode)
				tbl8.win95Dark = darkMode
				local win95Theme = lib.Toggles and lib.Toggles.Win95Theme
				if not (win95Theme and win95Theme.Value) then
					return
				end
				fn21()
				fn38()
				fn37(darkMode)
				fn22(tbl14, font2)
				fn51()
				fn53()

				if _G.__myhubStatsLabel then
					local showStats = lib.Toggles and lib.Toggles.ShowStats



					if showStats and showStats.Value and type(showStats.Callback) == "function" then
						pcall(showStats.Callback, showStats.Value)
					end
				end
			end,
		})

		v25:AddButton({
			Text = "Reset to Obsidian Default",
			Func = function()
				fn21()
				fn38()
				fn22(tbl13, font)
				fn52()

				pcall(function()
					lib.Toggles.Win95Theme:SetValue(false)
				end)
			end,
		})
	end

	if _G.__myhubStatsConn then
		pcall(function()
			_G.__myhubStatsConn:Disconnect()
		end)

		_G.__myhubStatsConn = nil
	end

	if _G.__myhubStatsLabel then
		pcall(function()
			_G.__myhubStatsLabel:Destroy()
		end)

		_G.__myhubStatsLabel = nil
	end

	pcall(function()
		lib.SetWatermark = function()
		end
	end)

	pcall(function()
		lib.SetWatermarkVisibility = function()
		end
	end)

	if type(hookfunction) == "function" then
		pcall(function()
			hookfunction(lib.SetWatermark, function()
			end)
		end)

		pcall(function()
			hookfunction(lib.SetWatermarkVisibility, function()
			end)
		end)
	end

	if type(hookfunction) == "function" and not _G.__myhubWarnHooked then
		pcall(function()
			local myhubOrigWarn = nil

			local function fn39(...)
				local v26 = table.pack(...)

				for _, v27 in ipairs({ ... }) do
					if type(v27) == "string" and v27:find("Watermark is deprecated", 1, true) then
						return
					end
				end

				return myhubOrigWarn(table.unpack(v26, 1, v26.n))
			end

			myhubOrigWarn = hookfunction
			myhubOrigWarn = myhubOrigWarn(warn, fn39)
			_G.__myhubOrigWarn = myhubOrigWarn
			_G.__myhubWarnHooked = true
		end)
	end

	local connection = nil
	local myhubStatsLabel2 = nil

	do
		local v26 = nil

		task.spawn(function()
			if type(getcustomasset) ~= "function" then
				return
			end
			local n = 0

			while type(isfile) == "function" and not isfile("WinHub/GameName/logo.png") and n < 10 do
				task.wait(0.25)
				n += 0.25
			end

			if type(isfile) == "function" and not isfile("WinHub/GameName/logo.png") then
				return
			end
			local ok, result = pcall(getcustomasset, "WinHub/GameName/logo.png")

			if ok then
				v26 = result
			end

			if myhubStatsLabel2 and v26 and _G.__myhubApplyStatsIcon then
				_G.__myhubApplyStatsIcon(myhubStatsLabel2, v26)
			end
		end)

		local function myhubApplyStatsIcon(arg, arg2)
			if not (arg and arg2 and arg.SetIcon) then
				return
			end

			pcall(function()
				arg:SetIcon(arg2)
			end)

			task.defer(function()
				local label = arg.Label
				if not label then
					return
				end

				for _, descendant in ipairs(label:GetDescendants()) do
					if descendant:IsA("ImageLabel") and descendant.Image == arg2 then
						pcall(function()
							descendant.ImageColor3 = Color3.new(1, 1, 1)
						end)

						descendant:GetPropertyChangedSignal("ImageColor3"):Connect(function()
							if descendant.ImageColor3 ~= Color3.new(1, 1, 1) then
								descendant.ImageColor3 = Color3.new(1, 1, 1)
							end
						end)
					end
				end
			end)
		end

		_G.__myhubApplyStatsIcon = myhubApplyStatsIcon

		Menu:AddToggle("ShowStats", {
			Text = "Show Watermark",
			Default = true,
			Tooltip = "FPS / ping",
			Callback = function(showWatermark)
				local function fn39(arg)
					if not (arg and arg.Label) then
						return
					end
					local label = arg.Label
					if label:FindFirstChild("MyHubStatsSquared") then
						return
					end
					local myHubStatsSquared = Instance.new("Folder")
					myHubStatsSquared.Name = "MyHubStatsSquared"
					myHubStatsSquared.Parent = label

					for _, name in ipairs({ "MyHubStatsBevelTop", "MyHubStatsBevelLeft", "MyHubStatsBevelRight", "MyHubStatsBevelBottom" }) do
						local child = label:FindFirstChild(name)

						if child then
							pcall(function()
								child:Destroy()
							end)
						end
					end

					pcall(function()
						label.BackgroundTransparency = 0
						label.BackgroundColor3 = color
						label.BorderSizePixel = 0
						label.ClipsDescendants = false
						label.TextColor3 = Color3.fromRGB(0, 0, 0)
						label.TextStrokeTransparency = 1
					end)

					label:GetPropertyChangedSignal("TextColor3"):Connect(function()
						if label.TextColor3 ~= Color3.fromRGB(0, 0, 0) then
							pcall(function()
								label.TextColor3 = Color3.fromRGB(0, 0, 0)
							end)
						end
					end)

					for _, descendant in ipairs(label:GetDescendants()) do
						if descendant:IsA("UIStroke") then
							pcall(function()
								descendant:Destroy()
							end)
						end
					end

					for _, descendant in ipairs(label:GetDescendants()) do
						if descendant:IsA("UICorner") then
							pcall(function()
								descendant.CornerRadius = UDim.new(0, 0)
							end)
						end
					end

					for _, child in ipairs(label:GetChildren()) do
						if child:IsA("UIPadding") then
							pcall(function()
								child.PaddingTop = UDim.new(0, 3)
								child.PaddingBottom = UDim.new(0, 3)
								child.PaddingLeft = UDim.new(0, 6)
								child.PaddingRight = UDim.new(0, 6)
							end)
						end
					end

					label.DescendantAdded:Connect(function(descendant)
						if descendant:IsA("UIStroke") then
							pcall(function()
								descendant:Destroy()
							end)
						elseif descendant:IsA("UICorner") then
							pcall(function()
								descendant.CornerRadius = UDim.new(0, 0)
							end)
						end
					end)

					label:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
						if label.BackgroundTransparency ~= 0 then
							pcall(function()
								label.BackgroundTransparency = 0
							end)
						end
					end)

					local parent = label.Parent
					if not parent then
						return
					end

					local function createFrame(name, backgroundColor3)
						local frame = Instance.new("Frame")
						frame.Name = name
						frame.BackgroundColor3 = backgroundColor3
						frame.BorderSizePixel = 0
						frame.BackgroundTransparency = 0
						frame.ZIndex = (label.ZIndex or 1) + 10
						frame.Parent = parent
						return frame
					end

					local MyHubStatsBevelTop = createFrame("MyHubStatsBevelTop", color2)
					local MyHubStatsBevelLeft = createFrame("MyHubStatsBevelLeft", color2)
					local MyHubStatsBevelRight = createFrame("MyHubStatsBevelRight", color3)
					local MyHubStatsBevelBottom = createFrame("MyHubStatsBevelBottom", color3)

					local function fn40()
						local offset = label.AbsolutePosition - parent.AbsolutePosition
						local absoluteSize = label.AbsoluteSize
						MyHubStatsBevelTop.Position = UDim2.fromOffset(offset.X, offset.Y)
						MyHubStatsBevelTop.Size = UDim2.fromOffset(absoluteSize.X, 2)
						MyHubStatsBevelLeft.Position = UDim2.fromOffset(offset.X, offset.Y)
						MyHubStatsBevelLeft.Size = UDim2.fromOffset(2, absoluteSize.Y)
						MyHubStatsBevelRight.Position = UDim2.fromOffset(offset.X + absoluteSize.X - 2, offset.Y)
						MyHubStatsBevelRight.Size = UDim2.fromOffset(2, absoluteSize.Y)
						MyHubStatsBevelBottom.Position = UDim2.fromOffset(offset.X, offset.Y + absoluteSize.Y - 2)
						MyHubStatsBevelBottom.Size = UDim2.fromOffset(absoluteSize.X, 2)
					end

					fn40()
					label:GetPropertyChangedSignal("AbsoluteSize"):Connect(fn40)
					label:GetPropertyChangedSignal("AbsolutePosition"):Connect(fn40)
					parent:GetPropertyChangedSignal("AbsolutePosition"):Connect(fn40)
					task.defer(fn40)
					task.delay(0.05, fn40)
					task.delay(0.2, fn40)
				end

				if connection then
					connection:Disconnect()
					connection = nil
				end

				_G.__myhubStatsConn = nil

				if myhubStatsLabel2 then
					pcall(function()
						myhubStatsLabel2:Destroy()
					end)

					myhubStatsLabel2 = nil
				end

				_G.__myhubStatsLabel = nil

				if lib.ScreenGui then
					local tbl17 = {
						MyHubStatsSquared = true,
						MyHubStatsBevelTop = true,
						MyHubStatsBevelLeft = true,
						MyHubStatsBevelRight = true,
						MyHubStatsBevelBottom = true,
					}

					for _, descendant in ipairs(lib.ScreenGui:GetDescendants()) do
						if tbl17[descendant.Name] then
							pcall(function()
								descendant:Destroy()
							end)
						end
					end
				end

				if not showWatermark then
					return
				end

				local ok, myhubStatsLabel = pcall(function()
					return lib:AddDraggableLabel(title .. " · 0 fps · 0 ms")
				end)

				if ok and myhubStatsLabel then
					myhubStatsLabel2 = myhubStatsLabel
					_G.__myhubStatsLabel = myhubStatsLabel
					local win95Theme = lib.Toggles and lib.Toggles.Win95Theme

					if win95Theme and win95Theme.Value then
						task.defer(function()
							pcall(fn39, myhubStatsLabel)
						end)
					end

					if v26 then
						task.defer(function()
							myhubApplyStatsIcon(myhubStatsLabel, v26)
						end)
					end

					local count2 = 0
					local n = 0

					connection = RunService.RenderStepped:Connect(function(E)
						count2 += 1
						n += E
						if n < 0.5 then
							return
						end
						local E = math.floor((count2 / n) + 0.5)
						local h = math.floor(((localPlayer:GetNetworkPing() or 0) * 1000) + 0.5)

						if myhubStatsLabel and myhubStatsLabel.SetText then
							pcall(function()
								myhubStatsLabel:SetText(string.format("%s \194\183 %d fps \194\183 %d ms", title, E, h))
							end)
						end

						count2, n = 0, 0
					end)

					_G.__myhubStatsConn = connection
					return
				end

				do
					return
				end
			end,
		})
	end

	local connection2 = nil

	local function fn39()
		local value = rawget(lib, "KeybindFrame")
		if not value then
			return
		end

		for _, descendant in ipairs(value:GetDescendants()) do
			if descendant:IsA("TextButton") then
				local textLabel = descendant:FindFirstChildWhichIsA("TextLabel")
				local text = textLabel and textLabel.Text or ""

				if text ~= "" then
					descendant.Visible = not text:find("^%[None%]")
				end
			end
		end
	end

	Menu:AddToggle("ShowKeybinds", {
		Text = "Show Keybinds",
		Default = false,
		Tooltip = "Show keybinds",
		Callback = function(showKeybinds)
			for _, v26 in ipairs({ "KeybindContainer", "KeybindFrame", "KeybindsFrame" }) do
				local value = rawget(lib, v26)

				if value then
					pcall(function()
						value.Visible = showKeybinds
					end)
				end
			end

			if connection2 then


				connection2:Disconnect()
				connection2 = nil
			end

			if showKeybinds then
				fn39()
				local n = 0

				connection2 = RunService.Heartbeat:Connect(function(E)
					n += E
					if n < 0.5 then
						return
					end
					n = 0
					fn39()
				end)
			end
		end,
	})

	lib2:SetLibrary(lib)
	lib3:SetLibrary(lib)
	lib3:IgnoreThemeSettings()
	lib3:SetIgnoreIndexes({})
	lib2:SetFolder("WinHub")
	lib3:SetFolder("WinHub/GameName")
	lib3:BuildConfigSection(tbl7.Settings)
	lib2:ApplyToTab(tbl7.Settings)
	lib3:LoadAutoloadConfig()

	if not tbl6.isPremium then
		fn17()
	end

	local function fn40(arg)
		local toggle = lib.Toggles and lib.Toggles[arg]

		if toggle and type(toggle.Callback) == "function" then
			pcall(toggle.Callback, toggle.Value)
		end
	end

	fn40("Win95Theme")
	fn40("ShowStats")
	fn40("ShowKeybinds")

	pcall(function()
		local function toggleCollapsed()
		end

		local v26 = pairs
		local tabs = lib.Tabs or {}

		for _, tab in v26(tabs) do
			for _, v27 in ipairs({ tab.Groupboxes, tab.Tabboxes }) do
				local v28 = pairs
				v27 = v27 or {}

				for _, v29 in v28(v27) do
					v29.ToggleCollapsed = toggleCollapsed
					v29.SetCollapsed = toggleCollapsed

					if v29.BoxHolder then
						local imageButton = v29.BoxHolder:FindFirstChildWhichIsA("ImageButton", true)

						if imageButton then
							imageButton.Visible = false
							imageButton.Active = false
						end
					end
				end
			end
		end
	end)

	local function fn41()
		if not Utility then
			return
		end

		local function fn42()
			return {
				{
					AnimationId = "rbxassetid://138187609517964",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 12.5 },
					cachedSize = { x = 9, y = 12, z = 12.5 },
				},
				{
					AnimationId = "rbxassetid://108769504845464",
					Delay = 0.19,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://127025454567487",
					Delay = 0.15,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 18, Y = 12, Z = 85.5 },
					cachedSize = { x = 18, y = 12, z = 85.5 },
				},
				{
					AnimationId = "rbxassetid://87575637427122",
					Delay = 0.35,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 18, Y = 13, Z = 29.5 },
					cachedSize = { x = 18, y = 13, z = 29.5 },
				},
				{
					AnimationId = "rbxassetid://71495079165969",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = "Right",
					Protected = true,
					hitbox = { X = 18, Y = 13, Z = 25.5 },
					cachedSize = { x = 18, y = 13, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://96774824071451",
					Delay = 0.13,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 15, Y = 13, Z = 20.5 },
					cachedSize = { x = 15, y = 13, z = 20.5 },
				},
				{
					AnimationId = "rbxassetid://86960348347455",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 15, Y = 13, Z = 20.5 },
					cachedSize = { x = 15, y = 13, z = 20.5 },
				},
				{
					AnimationId = "rbxassetid://129668957378628",
					Delay = 0.35,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 18, Y = 13, Z = 29.5 },
					cachedSize = { x = 18, y = 13, z = 29.5 },
				},
				{
					AnimationId = "rbxassetid://76263146641339",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://139482439079822",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://128092752811004",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://17808082908",
					Delay = 0.23,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 18.5 },
					cachedSize = { x = 9, y = 12, z = 18.5 },
				},
				{
					AnimationId = "rbxassetid://16533681590",
					Delay = 0.06,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 25.5 },
					cachedSize = { x = 9, y = 12, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://90024551634697",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://73930578770661",
					Delay = 0.26,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 25.5 },
					cachedSize = { x = 9, y = 12, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://16533641026",
					Delay = 0.3,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 15.5 },
					cachedSize = { x = 9, y = 12, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://128011435623937",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 12.5 },
					cachedSize = { x = 9, y = 12, z = 12.5 },
				},
				{
					AnimationId = "rbxassetid://117989400565423",
					Delay = 0.14,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://112506159811206",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://82697249356744",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://94269697535512",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://95263713118697",
					Delay = 0.07,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 18.5 },
					cachedSize = { x = 9, y = 12, z = 18.5 },
				},
				{
					AnimationId = "rbxassetid://122637417128576",
					Delay = 0.15,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://81068731814520",
					Delay = 0.31,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://125121294098394",
					Delay = 0.27,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 16.5 },
					cachedSize = { x = 9, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://111830222401038",
					Delay = 0.167,
					Distance = 85.9,
					imxd = 85.9,
					hso = 7,
					Dodge = false,
					Protected = true,
					ParryOnRelease = true,
					ReleaseDelay = 0.167,
					ReleaseTimeout = 10,
					hitbox = { X = 16, Y = 16, Z = 22 },
					cachedSize = { x = 16, y = 16, z = 22 },
				},
				{
					AnimationId = "rbxassetid://116731220145034",
					Delay = 0.3,
					Distance = 85.9,
					imxd = 85.9,
					hso = 2,
					Dodge = false,
					Protected = true,
					ParryOnRelease = true,
					ReleaseDelay = 0.48,
					ReleaseHold = 0.45,
					ReleaseSkipTo = 0.5,
					ReleaseTimeout = 10,
					hitbox = { X = 27, Y = 15, Z = 45 },
					cachedSize = { x = 27, y = 15, z = 45 },
				},
				{
					AnimationId = "rbxassetid://118254940165346",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					HoldNear = 32,
					HoldTime = 8,
					HoldUntilAnim = "78756501646161",
					hitbox = { X = 35, Y = 19.5, Z = 35 },
					cachedSize = { x = 35, y = 19.5, z = 35 },
				},
				{
					AnimationId = "rbxassetid://78037132715647",
					Delay = 0.1,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					ParryOnRelease = true,
					ReleaseDelay = 0.1,
					ReleaseHold = 0.9,
					ReleaseSkipTo = 3.4,
					ReleaseTimeout = 10,
					hitbox = { X = 15, Y = 15, Z = 55.5 },
					cachedSize = { x = 15, y = 15, z = 55.5 },
				},
				{
					AnimationId = "rbxassetid://134062592123662",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 15,
					Dodge = false,
					Protected = true,
					HoldNear = 60,
					HoldTail = 0.6,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 20, Y = 10, Z = 85 },
					cachedSize = { x = 20, y = 10, z = 85 },
				},
				{
					AnimationId = "rbxassetid://88047994826674",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 0,
					Dodge = false,
					Protected = true,
					HoldNear = 85,
					HoldTail = 0.5,
					HoldTime = 12,
					HoldUntilAnimEnd = true,
					hitbox = { X = 45, Y = 30, Z = 45 },
					cachedSize = { x = 45, y = 30, z = 45 },
				},
				{
					AnimationId = "rbxassetid://103205757233732",
					Delay = 0,
					Distance = 85.9,
					imxd = 30,
					hso = 6,
					Dodge = false,
					Protected = true,
					HoldNear = 30,
					HoldTail = 0.3,
					HoldTime = 3,
					HoldUntilAnimEnd = true,
					hitbox = { X = 15, Y = 10, Z = 16 },
					cachedSize = { x = 15, y = 10, z = 16 },
				},
				{
					AnimationId = "rbxassetid://126425025274592",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 6,
					Dodge = false,
					Protected = true,
					HoldNear = 25,
					HoldTail = 0.6,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 14, Y = 8, Z = 14 },
					cachedSize = { x = 14, y = 8, z = 14 },
				},
				{
					AnimationId = "rbxassetid://139068968352061",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 6,
					Dodge = false,
					Protected = true,
					HoldNear = 25,
					HoldTail = 0.6,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 14, Y = 8, Z = 14 },
					cachedSize = { x = 14, y = 8, z = 14 },
				},
				{
					AnimationId = "rbxassetid://75932054498460",
					Delay = 0.05,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = "Backward",
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 35.5 },
					cachedSize = { x = 9, y = 12, z = 35.5 },
				},
				{
					AnimationId = "rbxassetid://126295165730083",
					Delay = 0.33,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://116318693372219",
					Delay = 0.4,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://82325555702374",
					Delay = 0.4,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://126295165730083",
					Delay = 0.33,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://116318693372219",
					Delay = 0.4,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://79422866396194",
					Delay = 0.33,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://117073227702391",
					Delay = 0.4,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://135826060145848",
					Delay = 0.4,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 11.5 },
					cachedSize = { x = 9, y = 12, z = 11.5 },
				},
				{
					AnimationId = "rbxassetid://106827944722297",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = "Right",
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 35.5 },
					cachedSize = { x = 9, y = 12, z = 35.5 },
				},
				{
					AnimationId = "rbxassetid://17639263244",
					Delay = 0.26,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 9, Y = 12, Z = 18.5 },
					cachedSize = { x = 9, y = 12, z = 18.5 },
				},
				{
					AnimationId = "rbxassetid://120860086169740",
					Delay = 1.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 15, Y = 19, Z = 18.5 },
					cachedSize = { x = 15, y = 19, z = 18.5 },
				},
				{
					AnimationId = "rbxassetid://125749506147728",
					Delay = 0,
					Distance = 105,
					imxd = 105,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 105,
					HoldTail = 0.6,
					HoldTime = 7,
					HoldUntilAnimEnd = true,
					hitbox = { X = 25.5, Y = 25.5, Z = 25.5 },
					cachedSize = { x = 25.5, y = 25.5, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://122085609348746",
					Delay = 0.79,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					ParryOnRelease = true,
					ReleaseDelay = 0.79,
					ReleaseHold = 0.55,
					ReleaseTimeout = 10,
					hitbox = { X = 12, Y = 12, Z = 22 },
					cachedSize = { x = 12, y = 12, z = 22 },
				},
				{
					AnimationId = "rbxassetid://83006270417051",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 2.7,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 32, Y = 35, Z = 32 },
					cachedSize = { x = 32, y = 35, z = 32 },
				},
				{
					AnimationId = "rbxassetid://128313208507114",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 2.7,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 32, Y = 35, Z = 32 },
					cachedSize = { x = 32, y = 35, z = 32 },
				},
				{
					AnimationId = "rbxassetid://116457793603317",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 2.7,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 32, Y = 35, Z = 32 },
					cachedSize = { x = 32, y = 35, z = 32 },
				},
				{
					AnimationId = "rbxassetid://122714754226838",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 0.7,
					HoldTime = 4,
					HoldUntilAnimEnd = true,
					hitbox = { X = 20, Y = 20, Z = 20 },
					cachedSize = { x = 20, y = 20, z = 20 },
				},
				{
					AnimationId = "rbxassetid://83424622659422",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					FullHoldBlock = true,
					HoldTime = 0.4,
					ignoreAnimationEnd = true,
					hitbox = { X = 12, Y = 12, Z = 60 },
					cachedSize = { x = 12, y = 12, z = 60 },
				},
				{
					AnimationId = "rbxassetid://17819985894",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					FullHoldBlock = true,
					HoldTime = 0.5,
					MovingAttack = true,
					MovingTimeout = 3,
					StartDelay = 0,
					TriggerDistance = 20,
					ignoreAnimationEnd = true,
					hitbox = { X = 12, Y = 12, Z = 24 },
					cachedSize = { x = 12, y = 12, z = 24 },
				},
				{
					AnimationId = "rbxassetid://140160309808317",
					Delay = 0.5,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					FullHoldBlock = true,
					HoldTail = 0.4,
					HoldTime = 1,
					ignoreAnimationEnd = true,
					hitbox = { X = 26, Y = 30, Z = 31 },
					cachedSize = { x = 26, y = 30, z = 31 },
				},
				{
					AnimationId = "rbxassetid://17814230226",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 12.5 },
					cachedSize = { x = 10, y = 12, z = 12.5 },
				},
				{
					AnimationId = "rbxassetid://17588851823",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 10,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 2,
					HoldTime = 10,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 31.3, Y = 20.5, Z = 36.6 },
					cachedSize = { x = 31.3, y = 20.5, z = 36.6 },
				},
				{
					AnimationId = "rbxassetid://17814228936",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 12.5 },
					cachedSize = { x = 10, y = 12, z = 12.5 },
				},
				{
					AnimationId = "rbxassetid://104485035085311",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldBlock = true,
					HoldTime = 1.5,
					MovingAttack = true,
					MovingTimeout = 4,
					StartDelay = 0,
					TriggerDistance = 10,
					ignoreAnimationEnd = true,
					hitbox = { X = 12, Y = 12, Z = 60 },
					cachedSize = { x = 12, y = 12, z = 60 },
				},
				{
					AnimationId = "rbxassetid://17608982811",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 42,
					HoldTail = 1,
					HoldTime = 8,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 71.5, Y = 66, Z = 71.5 },
					cachedSize = { x = 71.5, y = 66, z = 71.5 },
				},
				{
					AnimationId = "rbxassetid://17720070877",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 13,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 45,
					HoldTail = 1.6,
					HoldTime = 8,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 29.6, Y = 27.8, Z = 50 },
					cachedSize = { x = 29.6, y = 27.8, z = 50 },
				},
				{
					AnimationId = "rbxassetid://17720074578",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 13,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 45,
					HoldTail = 1.6,
					HoldTime = 8,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 29.6, Y = 27.8, Z = 50 },
					cachedSize = { x = 29.6, y = 27.8, z = 50 },
				},
				{
					AnimationId = "rbxassetid://17736182425",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 30,
					HoldTail = 0.8,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 14, Y = 14, Z = 30 },
					cachedSize = { x = 14, y = 14, z = 30 },
				},
				{
					AnimationId = "rbxassetid://17814226779",
					Delay = 0.19,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 12.5 },
					cachedSize = { x = 10, y = 12, z = 12.5 },
				},
				{
					AnimationId = "rbxassetid://17814348667",
					Delay = 0.17,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 12.5 },
					cachedSize = { x = 10, y = 12, z = 12.5 },
				},
				{
					AnimationId = "rbxassetid://17814351687",
					Delay = 0.22,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 12.5 },
					cachedSize = { x = 10, y = 12, z = 12.5 },
				},
				{
					AnimationId = "rbxassetid://17814223662",
					Delay = 0.13,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 14.5 },
					cachedSize = { x = 10, y = 12, z = 14.5 },
				},
				{
					AnimationId = "rbxassetid://17814212452",
					Delay = 0.14,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 14.5 },
					cachedSize = { x = 10, y = 12, z = 14.5 },
				},
				{
					AnimationId = "rbxassetid://117442277293444",
					Delay = 0.26,
					Distance = 14,
					imxd = 14,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 14 },
					cachedSize = { x = 11, y = 10, z = 14 },
				},
				{
					AnimationId = "rbxassetid://95220938020402",
					Delay = 0.08,
					Distance = 11,
					imxd = 11,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 11 },
					cachedSize = { x = 11, y = 10, z = 11 },
				},
				{
					AnimationId = "rbxassetid://109584411193604",
					Delay = 0.11,
					Distance = 11,
					imxd = 11,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 12 },
					cachedSize = { x = 11, y = 10, z = 12 },
				},
				{
					AnimationId = "rbxassetid://94968175496827",
					Delay = 0.12,
					Distance = 12,
					imxd = 12,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 12 },
					cachedSize = { x = 11, y = 10, z = 12 },
				},
				{
					AnimationId = "rbxassetid://75977052397058",
					Delay = 0.26,
					Distance = 13,
					imxd = 13,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 13 },
					cachedSize = { x = 11, y = 10, z = 13 },
				},
				{
					AnimationId = "rbxassetid://119640051519647",
					Delay = 0.24,
					Distance = 10,
					imxd = 10,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 10 },
					cachedSize = { x = 11, y = 10, z = 10 },
				},
				{
					AnimationId = "rbxassetid://95598466829193",
					Delay = 0,
					Distance = 10,
					imxd = 10,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 10 },
					cachedSize = { x = 11, y = 10, z = 10 },
				},
				{
					AnimationId = "rbxassetid://107255800783573",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 0.8,
					HoldTime = 4.2,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 12, Y = 10, Z = 60 },
					cachedSize = { x = 12, y = 10, z = 60 },
				},
				{
					AnimationId = "rbxassetid://78998265684226",
					Delay = 0.42,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 14, Y = 12, Z = 25.5 },
					cachedSize = { x = 14, y = 12, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://120067859338407",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 25.5 },
					cachedSize = { x = 10, y = 12, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://131912326446793",
					Delay = 0.1,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = "Backward",
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 25.5 },
					cachedSize = { x = 10, y = 12, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://120067859338407",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 25.5 },
					cachedSize = { x = 10, y = 12, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://96864587008208",
					Delay = 0.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://108514533376393",
					Delay = 0.12,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 24.5 },
					cachedSize = { x = 10, y = 12, z = 24.5 },
				},
				{
					AnimationId = "rbxassetid://115394155986759",
					Delay = 0.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://96864587008208",
					Delay = 0.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://99231467339286",
					Delay = 0.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://71341100309667",
					Delay = 0.4,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://89308977011788",
					Delay = 0.17,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://70812193726657",
					Delay = 0.4,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://124850446144779",
					Delay = 0.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://83233240381407",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://74234320075901",
					Delay = 0.27,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://133641420235053",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://123322977586775",
					Delay = 0.23,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://133222057983317",
					Delay = 0.23,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 25.5 },
					cachedSize = { x = 10, y = 12, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://105600890523049",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://124569811997691",
					Delay = 0.24,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://105997682042435",
					Delay = 0.24,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://73046946314044",
					Delay = 0.35,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://95594425377219",
					Delay = 0.22,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://95021918342324",
					Delay = 0.24,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://121305902163711",
					Delay = 0.03,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://83897821591981",
					Delay = 0.06,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://133256369064028",
					Delay = 0.06,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://124390202971976",
					Delay = 0.08,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://115352569600099",
					Delay = 0.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://92631022159177",
					Delay = 0.05,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://74968827683072",
					Delay = 0.38,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					FullHoldBlock = true,
					HoldTime = 0.8,
					hitbox = { X = 15, Y = 15, Z = 35.5 },
					cachedSize = { x = 15, y = 15, z = 35.5 },
				},
				{
					AnimationId = "rbxassetid://117250295606698",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 6,
					Dodge = false,
					Protected = true,
					HoldNear = 40,
					HoldTail = 1.5,
					HoldTime = 13,
					HoldUntilAnimEnd = true,
					hitbox = { X = 15, Y = 18.75, Z = 22.5 },
					cachedSize = { x = 15, y = 18.75, z = 22.5 },
				},
				{
					AnimationId = "rbxassetid://88308616545789",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 0.5,
					HoldTime = 4,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 42, Y = 28, Z = 42 },
					cachedSize = { x = 42, y = 28, z = 42 },
				},
				{
					AnimationId = "rbxassetid://102943889962415",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 0.5,
					HoldTime = 4,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 42, Y = 28, Z = 42 },
					cachedSize = { x = 42, y = 28, z = 42 },
				},
				{
					AnimationId = "rbxassetid://98105559548332",
					Delay = 0,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 15, Y = 15, Z = 85.5 },
					cachedSize = { x = 15, y = 15, z = 85.5 },
				},
				{
					AnimationId = "rbxassetid://72391036322031",
					Delay = 0,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					FullHoldBlock = true,
					HoldTime = 1.35,
					ignoreAnimationEnd = true,
					hitbox = { X = 12, Y = 12, Z = 20 },
					cachedSize = { x = 12, y = 12, z = 20 },
				},
				{
					AnimationId = "rbxassetid://137987631798109",
					Delay = 0,
					Distance = 60,
					imxd = 60,
					hso = 0,
					Dodge = false,
					Protected = true,
					HoldNear = 30,
					HoldTail = 0.9,
					HoldTime = 13,
					HoldUntilAnimEnd = true,
					hitbox = { X = 50, Y = 50, Z = 50 },
					cachedSize = { x = 50, y = 50, z = 50 },
				},
				{
					AnimationId = "rbxassetid://17109491447",
					Delay = 0.23,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://132949809859968",
					Delay = 0,
					Distance = 60,
					imxd = 60,
					hso = 6.5,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 0.6,
					HoldTime = 2.2,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 20, Y = 12, Z = 50 },
					cachedSize = { x = 20, y = 12, z = 50 },
				},
				{
					AnimationId = "rbxassetid://17109502490",
					Delay = 0.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://17109500451",
					Delay = 0.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://17109498320",
					Delay = 0.23,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://17109495269",
					Delay = 0.22,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 13.5 },
					cachedSize = { x = 10, y = 12, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://17109512162",
					Delay = 0.19,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 17.5 },
					cachedSize = { x = 10, y = 12, z = 17.5 },
				},
				{
					AnimationId = "rbxassetid://17109505330",
					Delay = 0.14,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 15.5 },
					cachedSize = { x = 10, y = 12, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://75358454211907",
					Delay = 0.1,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = "Backward",
					Protected = true,
					hitbox = { X = 15, Y = 15, Z = 75.5 },
					cachedSize = { x = 15, y = 15, z = 75.5 },
				},
				{
					AnimationId = "rbxassetid://83466764365987",
					Delay = 0.55,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = "Backward",
					Protected = true,
					hitbox = { X = 15, Y = 15, Z = 75.5 },
					cachedSize = { x = 15, y = 15, z = 75.5 },
				},
				{
					AnimationId = "rbxassetid://89160646763033",
					Delay = 0.3,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://105329772618736",
					Delay = 0.33,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://112604629805483",
					Delay = 0.26,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://74255707285849",
					Delay = 0.3,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://82539713863675",
					Delay = 0.33,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://118047568660299",
					Delay = 0.29,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 17.5 },
					cachedSize = { x = 10, y = 12, z = 17.5 },
				},
				{
					AnimationId = "rbxassetid://102756019588795",
					Delay = 0.35,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://80924779480850",
					Delay = 0.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://124878937379897",
					Delay = 0.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://103442050601696",
					Delay = 0.22,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://123097080943795",
					Delay = 0.21,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://134863307088982",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://134863307088982",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://123057599927100",
					Delay = 0.2,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://128498383551440",
					Delay = 0.22,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://18776380001",
					Delay = 0.33,
					Distance = 85.9,
					imxd = 85.9,
					hso = 7,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					MovingAttack = true,
					MovingTimeout = 3,
					StartDelay = 0,
					TriggerDistance = 22,
					ignoreAnimationEnd = true,
					hitbox = { X = 8.4, Y = 8.4, Z = 55.4 },
					cachedSize = { x = 8.4, y = 8.4, z = 55.4 },
				},
				{
					AnimationId = "rbxassetid://18805455132",
					Delay = 0.15,
					Distance = 85.9,
					imxd = 85.9,
					hso = 10,
					Dodge = false,
					Protected = true,
					hitbox = { X = 18.2, Y = 18.2, Z = 35.3 },
					cachedSize = { x = 18.2, y = 18.2, z = 35.3 },
				},
				{
					AnimationId = "rbxassetid://18790510489",
					Delay = 0,
					Distance = 30,
					imxd = 30,
					hso = 2,
					Dodge = "Backward",
					Protected = true,
					BlockAfterDodge = 1,
					DodgeDirection = "Backward",
					ignoreAnimationEnd = true,
					hitbox = { X = 10, Y = 10, Z = 35 },
					cachedSize = { x = 10, y = 10, z = 35 },
				},
				{
					AnimationId = "rbxassetid://18800481095",
					Delay = 0,
					Distance = 30,
					imxd = 30,
					hso = 2,
					Dodge = "Backward",
					Protected = true,
					BlockAfterDodge = 1,
					DodgeDirection = "Backward",
					ignoreAnimationEnd = true,
					hitbox = { X = 10, Y = 10, Z = 15 },
					cachedSize = { x = 10, y = 10, z = 15 },
				},
				{
					AnimationId = "rbxassetid://18823290984",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 9,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					FullHoldBlock = true,
					HoldTime = 1.5,
					MovingAttack = true,
					MovingTimeout = 4,
					StartDelay = 0,
					TriggerDistance = 26,
					ignoreAnimationEnd = true,
					hitbox = { X = 7, Y = 7, Z = 65 },
					cachedSize = { x = 7, y = 7, z = 65 },
				},
				{
					AnimationId = "rbxassetid://18805448389",
					Delay = 0.58,
					Distance = 85.9,
					imxd = 85.9,
					hso = 10,
					Dodge = false,
					Protected = true,
					ParryOnRelease = true,
					ReleaseDelay = 0.58,
					ReleaseTimeout = 10,
					hitbox = { X = 18.2, Y = 18.2, Z = 27.3 },
					cachedSize = { x = 18.2, y = 18.2, z = 27.3 },
				},
				{
					AnimationId = "rbxassetid://18757956175",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 35,
					Dodge = false,
					Protected = true,
					HoldNear = 55,
					HoldTail = 1,
					HoldTime = 5,
					HoldUntilAnimEnd = true,
					hitbox = { X = 20, Y = 30, Z = 35 },
					cachedSize = { x = 20, y = 30, z = 35 },
				},
				{
					AnimationId = "rbxassetid://103618673123030",
					Delay = 0.05,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					FullHoldBlock = true,
					HoldTime = 0.5,
					hitbox = { X = 15, Y = 15, Z = 35.5 },
					cachedSize = { x = 15, y = 15, z = 35.5 },
				},
				{
					AnimationId = "rbxassetid://133805070044910",
					Delay = 0.22,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 25.5 },
					cachedSize = { x = 10, y = 12, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://86879779755850",
					Delay = 0.23,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://131248750243452",
					Delay = 0.23,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://131248750243452",
					Delay = 0.23,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://99369635649254",
					Delay = 0.24,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://96992896299976",
					Delay = 0.22,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://128334790400342",
					Delay = 0.22,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://134039799293800",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://137189305072392",
					Delay = 0.24,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://122588914365916",
					Delay = 0.9,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 12, Z = 25.5 },
					cachedSize = { x = 12, y = 12, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://139051537809432",
					Delay = 0.45,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 10, Y = 12, Z = 16.5 },
					cachedSize = { x = 10, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://81604871624923",
					Delay = 0.36,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 25, Y = 25, Z = 25.5 },
					cachedSize = { x = 25, y = 25, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://75138454096460",
					Delay = 0.41,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 25, Y = 25, Z = 25.5 },
					cachedSize = { x = 25, y = 25, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://86674391061762",
					Delay = 0.4,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 25, Y = 25, Z = 25.5 },
					cachedSize = { x = 25, y = 25, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://100314891814706",
					Delay = 0.85,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					FullHoldBlock = true,
					HoldTime = 0.8,
					hitbox = { X = 25, Y = 25, Z = 25.5 },
					cachedSize = { x = 25, y = 25, z = 25.5 },
				},
				{
					AnimationId = "rbxassetid://107418008127424",
					Delay = 1.1,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = "Backward",
					Protected = true,
					hitbox = { X = 25, Y = 25, Z = 35.5 },
					cachedSize = { x = 25, y = 25, z = 35.5 },
				},
				{
					AnimationId = "rbxassetid://86181954682796",
					Delay = 0.31,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 15, Y = 15, Z = 20.5 },
					cachedSize = { x = 15, y = 15, z = 20.5 },
				},
				{
					AnimationId = "rbxassetid://109634595009368",
					Delay = 0.31,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 15, Y = 15, Z = 20.5 },
					cachedSize = { x = 15, y = 15, z = 20.5 },
				},
				{
					AnimationId = "rbxassetid://116467954566521",
					Delay = 0.31,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 15, Y = 15, Z = 20.5 },
					cachedSize = { x = 15, y = 15, z = 20.5 },
				},
				{
					AnimationId = "rbxassetid://107026892584247",
					Delay = 0.35,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = "Backward",
					Protected = true,
					hitbox = { X = 25, Y = 25, Z = 45.5 },
					cachedSize = { x = 25, y = 25, z = 45.5 },
				},
				{
					AnimationId = "rbxassetid://129907472716879",
					Delay = 0.28,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://104216069548945",
					Delay = 0.23,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://121465390667275",
					Delay = 0.23,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://94140151741865",
					Delay = 0.86,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://121481347968807",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://78193930875003",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://73552780200823",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://132651043332034",
					Delay = 0.27,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://105367607095326",
					Delay = 0.26,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://91125603052828",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 17.5 },
					cachedSize = { x = 12, y = 10, z = 17.5 },
				},
				{
					AnimationId = "rbxassetid://75033597137350",
					Delay = 0.24,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://107245181444093",
					Delay = 0.24,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://78851732979110",
					Delay = 0.24,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://138361031021704",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://98850704661244",
					Delay = 0.27,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 10, Z = 15.5 },
					cachedSize = { x = 12, y = 10, z = 15.5 },
				},
				{
					AnimationId = "rbxassetid://70399921157089",
					Delay = 0,
					Distance = 60,
					imxd = 60,
					hso = 11,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 0.5,
					HoldTime = 5.5,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 12, Y = 12, Z = 28 },
					cachedSize = { x = 12, y = 12, z = 28 },
				},
				{
					AnimationId = "rbxassetid://112854625626596",
					Delay = 0,
					Distance = 60,
					imxd = 60,
					hso = 11,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 0.5,
					HoldTime = 5.5,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 12, Y = 12, Z = 28 },
					cachedSize = { x = 12, y = 12, z = 28 },
				},
				{
					AnimationId = "rbxassetid://123730965639857",
					Delay = 0,
					Distance = 60,
					imxd = 60,
					hso = 11,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 0.5,
					HoldTime = 5.5,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 12, Y = 12, Z = 28 },
					cachedSize = { x = 12, y = 12, z = 28 },
				},
				{
					AnimationId = "rbxassetid://125459869907645",
					Delay = 0,
					Distance = 60,
					imxd = 60,
					hso = 11,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 0.5,
					HoldTime = 5.5,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 12, Y = 12, Z = 28 },
					cachedSize = { x = 12, y = 12, z = 28 },
				},
				{
					AnimationId = "rbxassetid://77143059542728",
					Delay = 0,
					Distance = 65,
					imxd = 65,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					ParryOnRelease = true,
					ReleaseImpactLead = 0.05,
					ReleaseMinPos = 0.25,
					ReleaseProximity = 13,
					ReleaseTimeout = 5,
					ReleaseTravelMax = 1.8,
					ignoreAnimationEnd = true,
					hitbox = { X = 24, Y = 12, Z = 24 },
					cachedSize = { x = 24, y = 12, z = 24 },
				},
				{
					AnimationId = "rbxassetid://119598203491043",
					Delay = 0,
					Distance = 65,
					imxd = 65,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 65,
					HoldTail = 0.5,
					HoldTime = 2.2,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 24, Y = 12, Z = 24 },
					cachedSize = { x = 24, y = 12, z = 24 },
				},
				{
					AnimationId = "rbxassetid://110953947640031",
					Delay = 0,
					Distance = 35,
					imxd = 35,
					hso = 7,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 32,
					HoldTail = 1.3,
					HoldTime = 4.5,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 30, Y = 25, Z = 30 },
					cachedSize = { x = 30, y = 25, z = 30 },
				},
				{
					AnimationId = "rbxassetid://18935924722",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 0,
					Dodge = false,
					Protected = true,
					HoldNear = 50,
					HoldTail = 0.5,
					HoldTime = 13,
					HoldUntilAnimEnd = true,
					hitbox = { X = 96, Y = 96, Z = 96 },
					cachedSize = { x = 96, y = 96, z = 96 },
				},
				{
					AnimationId = "rbxassetid://18904070948",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 10,
					Dodge = false,
					Protected = true,
					HoldNear = 35,
					HoldTime = 13,
					HoldUntilAnim = "18904068244",
					HoldWait = 13,
					hitbox = { X = 15, Y = 15, Z = 22 },
					cachedSize = { x = 15, y = 15, z = 22 },
				},
				{
					AnimationId = "rbxassetid://18904068244",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 14,
					Dodge = false,
					Protected = true,
					HoldNear = 35,
					HoldTail = 0.3,
					HoldTime = 3,
					HoldUntilAnimEnd = true,
					hitbox = { X = 16, Y = 16, Z = 27 },
					cachedSize = { x = 16, y = 16, z = 27 },
				},
				{
					AnimationId = "rbxassetid://18909805186",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 13,
					Dodge = false,
					Protected = true,
					HoldNear = 35,
					HoldTail = 0.4,
					HoldTime = 13,
					HoldUntilAnimEnd = true,
					hitbox = { X = 17, Y = 12, Z = 25 },
					cachedSize = { x = 17, y = 12, z = 25 },
				},
				{
					AnimationId = "rbxassetid://18922446579",
					Delay = 0,
					Distance = 25,
					imxd = 25,
					hso = 2,
					Dodge = false,
					Protected = true,
					HoldNear = 18,
					HoldTail = 0.55,
					HoldTime = 13,
					HoldUntilAnimEnd = true,
					hitbox = { X = 14, Y = 17, Z = 23 },
					cachedSize = { x = 14, y = 17, z = 23 },
				},
				{
					AnimationId = "rbxassetid://133274645043140",
					Delay = 0.17,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 17.5 },
					cachedSize = { x = 11, y = 12, z = 17.5 },
				},
				{
					AnimationId = "rbxassetid://117187850045858",
					Delay = 0.15,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 17.5 },
					cachedSize = { x = 11, y = 12, z = 17.5 },
				},
				{
					AnimationId = "rbxassetid://73952697868112",
					Delay = 0.69,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 17.5 },
					cachedSize = { x = 11, y = 12, z = 17.5 },
				},
				{
					AnimationId = "rbxassetid://133780337136102",
					Delay = 0.14,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 16.5 },
					cachedSize = { x = 11, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://124949233130530",
					Delay = 0.12,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 19.5 },
					cachedSize = { x = 11, y = 12, z = 19.5 },
				},
				{
					AnimationId = "rbxassetid://110203810055867",
					Delay = 0.13,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 16.5 },
					cachedSize = { x = 11, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://100906753774640",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 16.5 },
					cachedSize = { x = 11, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://114548248191159",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 14.5 },
					cachedSize = { x = 11, y = 12, z = 14.5 },
				},
				{
					AnimationId = "rbxassetid://106376283986175",
					Delay = 0.18,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 16.5 },
					cachedSize = { x = 11, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://130217919003999",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 16.5 },
					cachedSize = { x = 11, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://94984634005535",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 16.5 },
					cachedSize = { x = 11, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://122510033710854",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 16.5 },
					cachedSize = { x = 11, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://99248485706215",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 16.5 },
					cachedSize = { x = 11, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://91111141132507",
					Delay = 0.21,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 16.5 },
					cachedSize = { x = 11, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://93313374702794",
					Delay = 0.25,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 16.5 },
					cachedSize = { x = 11, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://71058893915493",
					Delay = 0.23,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 12, Z = 16.5 },
					cachedSize = { x = 11, y = 12, z = 16.5 },
				},
				{
					AnimationId = "rbxassetid://101836548002360",
					Delay = 0.52,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 21, Y = 35, Z = 147.5 },
					cachedSize = { x = 21, y = 35, z = 147.5 },
				},
				{
					AnimationId = "rbxassetid://98373678466489",
					Delay = 0.7,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 25, Y = 55, Z = 95.5 },
					cachedSize = { x = 25, y = 55, z = 95.5 },
				},
				{
					AnimationId = "rbxassetid://122882932784519",
					Delay = 0.36,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 25, Y = 55, Z = 55.5 },
					cachedSize = { x = 25, y = 55, z = 55.5 },
				},
				{
					AnimationId = "rbxassetid://73479442571448",
					Delay = 0.32,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 25, Y = 55, Z = 55.5 },
					cachedSize = { x = 25, y = 55, z = 55.5 },
				},
				{
					AnimationId = "rbxassetid://97840200661482",
					Delay = 0,
					Distance = 145.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 15, Y = 25, Z = 145.5 },
					cachedSize = { x = 15, y = 25, z = 145.5 },
				},
				{
					AnimationId = "rbxassetid://109727740503057",
					Delay = 0.48,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 15, Z = 35.5 },
					cachedSize = { x = 12, y = 15, z = 35.5 },
				},
				{
					AnimationId = "rbxassetid://102856379236807",
					Delay = 0,
					Distance = 255.9,
					imxd = 255.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 25, Y = 25, Z = 175.5 },
					cachedSize = { x = 25, y = 25, z = 175.5 },
				},
				{
					AnimationId = "rbxassetid://78202112128779",
					Delay = 0.16,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 15, Z = 21.5 },
					cachedSize = { x = 12, y = 15, z = 21.5 },
				},
				{
					AnimationId = "rbxassetid://95219473638946",
					Delay = 0.2,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 15, Z = 13.5 },
					cachedSize = { x = 12, y = 15, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://128400536346284",
					Delay = 0.15,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 15, Z = 13.5 },
					cachedSize = { x = 12, y = 15, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://139412087249533",
					Delay = 0.18,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 15, Z = 13.5 },
					cachedSize = { x = 12, y = 15, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://75413050413648",
					Delay = 0.23,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 15, Z = 13.5 },
					cachedSize = { x = 12, y = 15, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://111099974187175",
					Delay = 0.17,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 15, Z = 13.5 },
					cachedSize = { x = 12, y = 15, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://130499653523462",
					Delay = 0.23,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 12, Y = 15, Z = 13.5 },
					cachedSize = { x = 12, y = 15, z = 13.5 },
				},
				{
					AnimationId = "rbxassetid://101725026630026",
					Delay = 0,
					Distance = 155.9,
					imxd = 155.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					HoldNear = 30,
					HoldTail = 0.45,
					HoldTime = 3,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					isProjectileAnimation = true,
					hitbox = { X = 15, Y = 15, Z = 20.5 },
					cachedSize = { x = 15, y = 15, z = 20.5 },
				},
				{
					AnimationId = "rbxassetid://105822776866328",
					Delay = 0.85,
					Distance = 155.9,
					imxd = 155.9,
					hso = 22.5,
					Dodge = "Forward",
					Protected = true,
					BlockAfterDodge = 0.6,
					DodgeDirection = "Forward",
					ignoreAnimationEnd = true,
					hitbox = { X = 30, Y = 21, Z = 15 },
					cachedSize = { x = 30, y = 21, z = 15 },
				},
				{
					AnimationId = "rbxassetid://90465443058890",
					Delay = 0.12,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					DodgeDirection = "None",
					hitbox = { X = 11, Y = 10, Z = 13 },
					cachedSize = { x = 11, y = 10, z = 13 },
				},
				{
					AnimationId = "rbxassetid://138556534587246",
					Delay = 0.15,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					DodgeDirection = "None",
					hitbox = { X = 11, Y = 10, Z = 13 },
					cachedSize = { x = 11, y = 10, z = 13 },
				},
				{
					AnimationId = "rbxassetid://104241412353167",
					Delay = 0.16,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					DodgeDirection = "None",
					hitbox = { X = 11, Y = 10, Z = 13 },
					cachedSize = { x = 11, y = 10, z = 13 },
				},
				{
					AnimationId = "rbxassetid://86012074663621",
					Delay = 0.1,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					DodgeDirection = "None",
					hitbox = { X = 11, Y = 10, Z = 13 },
					cachedSize = { x = 11, y = 10, z = 13 },
				},
				{
					AnimationId = "rbxassetid://113786229079875",
					Delay = 0.48,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					DodgeDirection = "None",
					hitbox = { X = 11, Y = 10, Z = 15 },
					cachedSize = { x = 11, y = 10, z = 15 },
				},
				{
					AnimationId = "rbxassetid://99599242309619",
					Delay = 0.19,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					DodgeDirection = "None",
					hitbox = { X = 11, Y = 10, Z = 13 },
					cachedSize = { x = 11, y = 10, z = 13 },
				},
				{
					AnimationId = "rbxassetid://128805686785108",
					Delay = 0.15,
					Distance = 85.9,
					imxd = 85.9,
					hso = 3,
					Dodge = false,
					Protected = true,
					DodgeDirection = "None",
					FullHoldBlock = true,
					HoldTime = 0.22,
					hitbox = { X = 11, Y = 10, Z = 18 },
					cachedSize = { x = 11, y = 10, z = 18 },
				},
				{
					AnimationId = "rbxassetid://17610278095",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 6,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 1.5,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 22.4, Y = 22.4, Z = 22.4 },
					cachedSize = { x = 22.4, y = 22.4, z = 22.4 },
				},
				{
					AnimationId = "rbxassetid://17610371826",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 6,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 1.5,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 22.4, Y = 22.4, Z = 22.4 },
					cachedSize = { x = 22.4, y = 22.4, z = 22.4 },
				},
				{
					AnimationId = "rbxassetid://17610296890",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 6,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 1.5,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					hitbox = { X = 22.4, Y = 22.4, Z = 22.4 },
					cachedSize = { x = 22.4, y = 22.4, z = 22.4 },
				},
				{
					AnimationId = "rbxassetid://123422568373700",
					Delay = 0.14,
					Distance = 11,
					imxd = 11,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 13 },
					cachedSize = { x = 11, y = 10, z = 13 },
				},
				{
					AnimationId = "rbxassetid://119593191514373",
					Delay = 0.16,
					Distance = 11,
					imxd = 11,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 14 },
					cachedSize = { x = 11, y = 10, z = 14 },
				},
				{
					AnimationId = "rbxassetid://133173788284171",
					Delay = 0.14,
					Distance = 11,
					imxd = 11,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 13 },
					cachedSize = { x = 11, y = 10, z = 13 },
				},
				{
					AnimationId = "rbxassetid://138507484189371",
					Delay = 0.19,
					Distance = 12,
					imxd = 12,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 13 },
					cachedSize = { x = 11, y = 10, z = 13 },
				},
				{
					AnimationId = "rbxassetid://120481670494753",
					Delay = 0.14,
					Distance = 14,
					imxd = 14,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 14 },
					cachedSize = { x = 11, y = 10, z = 14 },
				},
				{
					AnimationId = "rbxassetid://127680987414988",
					Delay = 0.16,
					Distance = 14,
					imxd = 16,
					hso = 3,
					Dodge = false,
					Protected = true,
					hitbox = { X = 11, Y = 10, Z = 14 },
					cachedSize = { x = 11, y = 10, z = 14 },
				},
				{
					AnimationId = "rbxassetid://127157694959472",
					Delay = 0,
					Distance = 21,
					imxd = 30,
					hso = 3,
					Dodge = false,
					Protected = true,
					FullHoldBlock = true,
					HoldTime = 0.8,
					ignoreAnimationEnd = true,
					hitbox = { X = 11, Y = 10, Z = 23 },
					cachedSize = { x = 11, y = 10, z = 23 },
				},
				{
					AnimationId = "rbxassetid://83067279562786",
					Delay = 0,
					Distance = 20,
					imxd = 20,
					hso = 5,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					FullHoldBlock = true,
					HoldTime = 0.6,
					ignoreAnimationEnd = true,
					hitbox = { X = 20, Y = 12, Z = 22 },
					cachedSize = { x = 20, y = 12, z = 22 },
				},
				{
					AnimationId = "rbxassetid://106773160329628",
					Delay = 0,
					Distance = 20,
					imxd = 20,
					hso = 5,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					FullHoldBlock = true,
					HoldTime = 0.6,
					ignoreAnimationEnd = true,
					hitbox = { X = 20, Y = 12, Z = 22 },
					cachedSize = { x = 20, y = 12, z = 22 },
				},
				{
					AnimationId = "rbxassetid://98260254214211",
					Delay = 0,
					Distance = 60,
					imxd = 60,
					hso = 6.5,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 0.5,
					HoldTime = 6,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 20, Y = 12, Z = 50 },
					cachedSize = { x = 20, y = 12, z = 50 },
				},
				{
					AnimationId = "rbxassetid://74825463449450",
					Delay = 0,
					Distance = 85.9,
					imxd = 85.9,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					ParryOnRelease = true,
					ReleaseDelay = 0.25,
					ReleaseHold = 1.35,
					ReleaseMinPos = 0.77,
					ReleaseTimeout = 6,
					ignoreAnimationEnd = true,
					hitbox = { X = 50, Y = 44, Z = 70 },
					cachedSize = { x = 50, y = 44, z = 70 },
				},
				{
					AnimationId = "rbxassetid://105243717622567",
					Delay = 0,
					Distance = 20,
					imxd = 20,
					hso = 2,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 1.8,
					HoldTime = 3,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 15, Y = 10, Z = 20 },
					cachedSize = { x = 15, y = 10, z = 20 },
				},
				{
					AnimationId = "rbxassetid://87714114474624",
					Delay = 0,
					Distance = 20,
					imxd = 20,
					hso = 2,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 85,
					HoldTail = 1.8,
					HoldTime = 3,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 15, Y = 10, Z = 20 },
					cachedSize = { x = 15, y = 10, z = 20 },
				},
				{
					AnimationId = "rbxassetid://124539237767128",
					Delay = 0,
					Distance = 110,
					imxd = 110,
					hso = 7,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 110,
					HoldTail = 0.5,
					HoldTime = 2,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 15, Y = 7, Z = 110 },
					cachedSize = { x = 15, y = 7, z = 110 },
				},
				{
					AnimationId = "rbxassetid://104556467625623",
					Delay = 0,
					Distance = 110,
					imxd = 110,
					hso = 7,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 110,
					HoldTail = 0.5,
					HoldTime = 2,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 15, Y = 7, Z = 110 },
					cachedSize = { x = 15, y = 7, z = 110 },
				},
				{
					AnimationId = "rbxassetid://118799068645618",
					Delay = 0,
					Distance = 30,
					imxd = 30,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 30,
					HoldTail = 0.3,
					HoldTime = 1.2,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 50, Y = 50, Z = 50 },
					cachedSize = { x = 50, y = 50, z = 50 },
				},
				{
					AnimationId = "rbxassetid://78868372202228",
					Delay = 0,
					Distance = 30,
					imxd = 30,
					hso = 0,
					Dodge = false,
					Protected = true,
					Full360Block = true,
					HoldNear = 30,
					HoldTail = 0.3,
					HoldTime = 1.2,
					HoldUntilAnimEnd = true,
					ignoreAnimationEnd = true,
					hitbox = { X = 50, Y = 50, Z = 50 },
					cachedSize = { x = 50, y = 50, z = 50 },
				},
			}
		end

		local v26 = fn42()
		local animationIds = {}

		for _, v27 in ipairs(v26) do
			local animationId = animationIds[v27.AnimationId]

			if not animationId then
				animationId = {}
				animationIds[v27.AnimationId] = animationId
			end

			table.insert(animationId, v27)
		end

		tbl8.autoParry = false
		tbl8.autoParryBlockKey = Enum.KeyCode.F
		tbl8.autoParryUseSignal = true

		local VirtualInputManager = game:FindService("VirtualInputManager") or game:GetService("VirtualInputManager")
		local flag18 = false
		local instance = nil

		local function getInstance()
			if instance and instance.Parent then
				return instance
			end

			local ok, result = pcall(function()
				return game:GetService("ReplicatedStorage"):WaitForChild("Communication", 5):WaitForChild("ServerAndClient", 5):WaitForChild("Signals", 5):WaitForChild("SignalEvent", 5):WaitForChild("Event", 5)
			end)

			if ok then
				instance = result
			end

			do
				return instance
			end
		end

		local function fn43(arg)
			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			local instance2 = getInstance()
			if not (instance2 and humanoidRootPart) then
				return
			end

			pcall(function()
				instance2:FireServer("server_skill_controller_signaler", "Blocking", arg, humanoidRootPart.Position)
			end)
		end

		local function fn44()
			fn43("Hold")
		end

		local function fn45()
			fn43("UnHold")
		end

		local v27 = nil
		local name2 = nil

		local function getName()
			local character = localPlayer.Character
			if not character then
				return nil
			end
			local toolAccessories = character:FindFirstChild("Tool_Accessories")
			if not toolAccessories then
				return nil
			end

			for _, child in ipairs(toolAccessories:GetChildren()) do
				if not child.Name:find("Sheathed") then
					return child.Name
				end
			end

			return nil
		end

		local function createAnimation(name)
			local ReplicatedStorage = game:GetService("ReplicatedStorage")

			if name then
				local assets = ReplicatedStorage:FindFirstChild("Assets")
				local defaultCore = assets and assets:FindFirstChild("Animations") and assets.Animations:FindFirstChild("Default_Core")
				local child = defaultCore and defaultCore:FindFirstChild("Toolbar_" .. name)
				local block = child and child:FindFirstChild("block")
				if block then
					return block
				end
			end

			local skills = ReplicatedStorage:FindFirstChild("Skills")
			local child = skills and skills:FindFirstChild("Misc")
			local blocking = child and child:FindFirstChild("Blocking")
			local block = blocking and blocking:FindFirstChild("block")
			if block then
				return block
			end
			local animation = Instance.new("Animation")
			animation.AnimationId = "rbxassetid://11696233185"
			return animation
		end

		local function fn46()
			local name = getName()
			if v27 and name2 == name then
				return v27
			end

			if v27 then
				pcall(function()
					v27:Stop(0)
				end)

				v27 = nil
			end

			name2 = name
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")

			if animator then
				local animation = createAnimation(name)

				local ok, result = pcall(function()
					return animator:LoadAnimation(animation)
				end)

				if ok and result then
					v27 = result
				end

				return v27
			end

			do
				return nil
			end
		end

		local function fn47()
			local v28 = fn46()
			if not v28 then
				return
			end

			pcall(function()
				v28:Play(0.1, 1, 1)
			end)
		end

		local function fn48()
			if v27 then
				pcall(function()
					v27:Stop(0.1)
				end)
			end
		end

		table.insert(_G.MyHubConns, localPlayer.CharacterAdded:Connect(function()
			v27 = nil
			name2 = nil
		end))

		local function fn49()
			if flag18 then
				return
			end

			flag18 = true
			fn44()
			fn47()

			task.delay(0.15, function()
				fn45()

				do
					fn48()
					flag18 = false
					return
				end
			end)
		end

		local function fn50(arg)
			if arg == "UnHold" or arg == "Release" then
				fn45()
			end
		end

		local dodges = {
			Forward = Enum.KeyCode.W,
			Backward = Enum.KeyCode.S,
			Left = Enum.KeyCode.A,
			Right = Enum.KeyCode.D,
		}

		local function fn51(dodge, arg)
			if not (VirtualInputManager and dodge) then
				return
			end

			pcall(function()
				VirtualInputManager:SendKeyEvent(true, dodge, false, game)
			end)

			task.wait(arg or 0.04)

			pcall(function()
				VirtualInputManager:SendKeyEvent(false, dodge, false, game)
			end)
		end

		local function fn52(dodge)
			local dodge2 = dodges[dodge]
			if not dodge2 then
				return
			end
			fn51(dodge2, 0.04)
			task.wait(0.02)
			fn51(dodge2, 0.04)
		end

		local function fn53(arg, child)
			local character = localPlayer.Character
			if not character then
				return false
			end
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if not (humanoidRootPart and child) then
				return false
			end
			return (humanoidRootPart.Position - child.Position).Magnitude <= (arg.imxd or arg.Distance or 85.9)
		end

		tbl8.autoParryHitboxPredict = true

		local function fn54(arg, child)
			if not tbl8.autoParryHitboxPredict then
				return true
			end

			if arg.Full360Block then
				return true
			end

			if not arg.hitbox then
				return true
			end
			local character = localPlayer.Character
			if not character then
				return true
			end
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if not (humanoidRootPart and child) then
				return true
			end
			local hitbox = arg.hitbox
			local n = (hitbox.X or hitbox[1] or 5) + (arg.hso or 0)
			local y = hitbox.Y or hitbox[2] or 5
			local z = hitbox.Z or hitbox[3] or 5
			local v28 = child.CFrame:PointToObjectSpace(humanoidRootPart.Position)
			local n10 = v28.Z + z * 0.5
			return math.abs(v28.X) <= n * 0.5 and math.abs(v28.Y) <= y * 0.5 and math.abs(n10) <= z * 0.5
		end

		tbl8.autoParryHealthScanner = false
		tbl8.autoParrySoundBlock = false
		tbl8.autoParryEffectBlock = false

		local tbl17 = {
			HITCH_DT_MIN = 0.03,
			HITCH_DT_MULT = 2.5,
			SPIKE_PING_MIN = 0.04,
			SPIKE_PING_MULT = 1.8,
			avgFrameDt = 0.016666666666666666,
			avgPing = 0.05,
			maxRecords = 120,
			records = {},
		}

		local function getOk()
			local ok, result = pcall(function()
				local Stats = game:GetService("Stats")
				local performanceStats = Stats and Stats:FindFirstChild("PerformanceStats")
				local ping = performanceStats and performanceStats:FindFirstChild("Ping")
				if ping and ping:GetValue() then
					return ping:GetValue() / 1000
				end
				local dataPing = Stats and Stats.Network and Stats.Network.ServerStatsItem and Stats.Network.ServerStatsItem["Data Ping"]
				return dataPing and dataPing:GetValueString():match("(%d+)") and tonumber(dataPing:GetValueString():match("(%d+)")) / 1000 or 0.05
			end)

			return ok and result or 0.05
		end

		task.spawn(function()
			local now2 = os.clock()

			while _G.MyHubSession == myHubSession do
				local now3 = os.clock()
				tbl17.avgFrameDt = tbl17.avgFrameDt * 0.9 + (now3 - now2) * 0.1

				if now3 % 1 < 0.1 then
					tbl17.avgPing = tbl17.avgPing * 0.9 + getOk() * 0.1
				end

				task.wait(0.1)
				now2 = now3
			end
		end)

		local function fn55()
			if not tbl8.autoParryHealthScanner then
				return 0
			end
			return math.max(0, tbl17.avgFrameDt - tbl17.HITCH_DT_MIN * tbl17.HITCH_DT_MULT) + math.max(0, tbl17.avgPing - tbl17.SPIKE_PING_MIN * tbl17.SPIKE_PING_MULT) * 0.5
		end

		local obj4 = setmetatable({}, { __mode = "k" })
		local obj5 = setmetatable({}, { __mode = "k" })

		local function fn56(instance2)
			if not instance2 then
				return true
			end
			local character = localPlayer.Character
			if instance2 == character then
				return true
			end
			local v28 = ipairs
			local Players2 = game:GetService("Players")

			for _, player in v28(Players2:GetPlayers()) do
				if instance2 == player.Character then
					return true
				end
			end

			if instance2:FindFirstChildOfClass("Humanoid") ~= nil then
				return false
			end

			if character and instance2:IsDescendantOf(character) then
				return true
			end
			local v29 = ipairs
			local Players3 = game:GetService("Players")

			for _, player in v29(Players3:GetPlayers()) do
				local character2 = player.Character
				if character2 and instance2:IsDescendantOf(character2) then
					return true
				end
			end

			return false
		end

		tbl8.autoParryHitboxViz = false
		local tbl18 = {}
		local autoParryHitboxViz = Instance.new("Folder")
		autoParryHitboxViz.Name = "AutoParryHitboxViz"
		autoParryHitboxViz.Parent = workspace

		local function fn57(arg, adornee)
			if not arg.hitbox and not arg.cachedSize then
				return
			end
			local cachedSize = arg.cachedSize

			if typeof(cachedSize) ~= "Vector3" then
				if type(cachedSize) == "table" then
					cachedSize = Vector3.new(cachedSize.x or cachedSize.X or cachedSize[1] or 5, cachedSize.y or cachedSize.Y or cachedSize[2] or 5, cachedSize.z or cachedSize.Z or cachedSize[3] or 5)
				else
					cachedSize = nil

					if arg.hitbox then
						local hitbox = arg.hitbox
						cachedSize = Vector3.new(hitbox.X or hitbox.x or hitbox[1] or 5, hitbox.Y or hitbox.y or hitbox[2] or 5, hitbox.Z or hitbox.z or hitbox[3] or 5)
					end
				end
			end

			if not cachedSize then
				return
			end
			local boxHandleAdornment = Instance.new("BoxHandleAdornment")
			boxHandleAdornment.Adornee = adornee
			boxHandleAdornment.AlwaysOnTop = true
			boxHandleAdornment.ZIndex = 5
			boxHandleAdornment.Size = cachedSize + Vector3.new(arg.hso or 0, 0, 0)
			boxHandleAdornment.CFrame = CFrame.new(0, 0, -cachedSize.Z * 0.5)
			boxHandleAdornment.Color3 = Color3.fromRGB(255, 80, 80)
			boxHandleAdornment.Transparency = 0.75
			boxHandleAdornment.Parent = autoParryHitboxViz
			table.insert(tbl18, { adorn = boxHandleAdornment, expire = os.clock() + math.max(0.35, (arg.Delay or 0) + 0.25) })
		end

		table.insert(_G.MyHubConns, game:GetService("RunService").Heartbeat:Connect(function()
			if #tbl18 == 0 then
				return
			end
			local now2 = os.clock()

			for i = #tbl18, 1, -1 do
				if now2 >= tbl18[i].expire then
					pcall(function()
						tbl18[i].adorn:Destroy()
					end)

					table.remove(tbl18, i)
				end
			end
		end))

		local function fn58(track, instance2)

			if not (track and track.Animation) then
				return
			end
			local animationId = track.Animation.AnimationId
			if not animationId or animationId == "" then
				return
			end
			local animationId2 = animationIds[animationId]
			if not animationId2 then
				return
			end
			local parent = instance2.Parent
			if not parent then
				return
			end

			if fn56(parent) then
				return
			end
			local child = parent:FindFirstChild("HumanoidRootPart") or parent:FindFirstChild("RootPart") or parent.PrimaryPart
			if not child then
				return
			end
			local v28, v29, v30 = ipairs(animationId2)
			local v31 = nil

			for _, v32 in v28, v29, v30 do
				if fn53(v32, child) then
					if not v31 or (v32.Delay or 0) < (v31.Delay or 0) then
						v31 = v32
					end
				end
			end

			if not v31 then
				return
			end

			if tbl8.autoParryHitboxViz then
				fn57(v31, child)
			end

			if not tbl8.autoParry then
				return
			end

			if not fn54(v31, child) then
				return
			end
			local dodge = nil

			if v31.Dodge and v31.Dodge ~= false and dodges[v31.Dodge] then
				dodge = v31.Dodge
			end

			task.delay(math.max(0, (v31.Delay or 0) - 0.04 + fn55()), function()
				if not tbl8.autoParry then
					return
				end

				if dodge then
					fn52(dodge)
				else
					fn49()
				end
			end)
		end

		local function fn59(arg, humanoid)
			if not (arg and humanoid) then
				return
			end

			if obj4[arg] then
				return
			end
			obj4[arg] = true

			local connection3 = arg.AnimationPlayed:Connect(function(E)
				fn58(E, humanoid)
			end)

			table.insert(_G.MyHubConns, connection3)
		end

		local matches = { ["120090130872460"] = true, ["100743915293786"] = true, ["110124980886364"] = true }
		local matches2 = { ["137950546316468"] = true }
		local matches3 = { ["110124980886364"] = 2 }
		local deadline2 = 0
		local thread = nil

		local function getMatch(soundId)
			return (tostring(soundId or ""):match("(%d+)"))
		end

		local function fn60(match)
			local match2 = match or 2
			local deadline = os.clock() + match2

			if deadline2 < deadline then
				deadline2 = deadline
			end

			if thread then
				return
			end

			thread = task.spawn(function()
				fn44()

				while os.clock() < deadline2 and tbl8.autoParry do
					task.wait(0.5)

					if os.clock() < deadline2 and tbl8.autoParry then
						fn44()
					end
				end

				fn45()
				thread = nil
				deadline2 = 0
			end)
		end

		local function fn61()
			deadline2 = 0
		end

		local function fn62(sound, instance2)
			if not tbl8.autoParry or not tbl8.autoParrySoundBlock then
				return
			end
			local match = getMatch(sound.SoundId)
			if not match then
				return
			end
			local parent = instance2.Parent
			if not parent then
				return
			end

			if fn56(parent) then
				return
			end
			local child = parent:FindFirstChild("HumanoidRootPart") or parent:FindFirstChild("RootPart") or parent.PrimaryPart
			local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not (child and humanoidRootPart) then
				return
			end

			if not ((child.Position - humanoidRootPart.Position).Magnitude > 12) then
				if matches2[match] then
					fn61()
					return
				end

				if matches[match] then
					fn60(matches3[match] or 2)
				end

				return
			end

			do
				return
			end
		end

		local obj6 = setmetatable({}, { __mode = "k" })

		local function fn63(descendant, humanoid)
			if obj6[descendant] then
				return
			end
			obj6[descendant] = true

			local connection3 = descendant.Played:Connect(function()
				fn62(descendant, humanoid)
			end)

			table.insert(_G.MyHubConns, connection3)
		end

		local tbl19 = { ["Sonido SurgeVFX"] = { Start = 2 } }
		local deadline3 = 0
		local thread2 = nil

		local function fn64(start)
			local start2 = start or 2
			local deadline = os.clock() + start2

			if deadline3 < deadline then
				deadline3 = deadline
			end

			if thread2 then
				return
			end

			thread2 = task.spawn(function()
				fn44()

				while os.clock() < deadline3 and tbl8.autoParry do
					task.wait(0.5)

					if os.clock() < deadline3 and tbl8.autoParry then
						fn44()
					end
				end

				fn45()
				thread2 = nil
				deadline3 = 0
			end)
		end

		local function fn65(model)
			if not tbl8.autoParry or not tbl8.autoParryEffectBlock then
				return
			end
			local v28 = tbl19[model.Name]
			if not v28 then
				return
			end
			local child = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not child then
				return
			end
			local position

			if model:IsA("BasePart") then
				position = model.Position
			else
				if not (model:IsA("Model") and model.PrimaryPart) then
					do
						return
					end
				end

				position = model.PrimaryPart.Position
			end

			if 25 < (position - child.Position).Magnitude then
				return
			end
			fn64(v28.Start or 2)
		end

		local function fn66(instance2)
			if not instance2 or obj5[instance2] then
				return
			end

			if fn56(instance2) then
				return
			end
			local humanoid = instance2:FindFirstChildOfClass("Humanoid") or instance2:FindFirstChildOfClass("AnimationController")
			if not humanoid then
				return
			end
			obj5[instance2] = true
			local animator = humanoid:FindFirstChildOfClass("Animator")

			if animator then
				fn59(animator, humanoid)
			end

			local connection3 = humanoid.ChildAdded:Connect(function(child)
				do
					if child:IsA("Animator") then
						fn59(child, humanoid)
					end

					return
				end
			end)

			table.insert(_G.MyHubConns, connection3)

			for _, descendant in ipairs(instance2:GetDescendants()) do
				if descendant:IsA("Sound") then
					fn63(descendant, humanoid)
				end
			end

			local connection4 = instance2.DescendantAdded:Connect(function(descendant)
				if descendant:IsA("Sound") then
					fn63(descendant, humanoid)
				end
			end)

			table.insert(_G.MyHubConns, connection4)
		end

		for _, descendant in ipairs(workspace:GetDescendants()) do
			if descendant:IsA("Model") then
				fn66(descendant)
			end
		end

		table.insert(_G.MyHubConns, workspace.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("Model") then


				fn66(descendant)
			end

			if descendant:IsA("BasePart") or descendant:IsA("Model") then
				fn65(descendant)
			end
		end))

		table.insert(_G.MyHubConns, localPlayer.CharacterAdded:Connect(function()
			task.wait(0.4)

			for _, descendant in ipairs(workspace:GetDescendants()) do
				if descendant:IsA("Model") then
					fn66(descendant)
				end
			end
		end))

		_G.__myhubAutoParryTeardown = function()
			tbl8.autoParry = false
			deadline2 = 0
			deadline3 = 0

			if flag18 then
				pcall(fn50, "UnHold")

				if VirtualInputManager then
					pcall(function()
						VirtualInputManager:SendKeyEvent(false, tbl8.autoParryBlockKey or Enum.KeyCode.F, false, game)
					end)
				end

				flag18 = false
			end

			if v27 then
				pcall(function()
					v27:Stop(0)
				end)

				v27 = nil
			end

			obj4 = setmetatable({}, { __mode = "k" })
			obj5 = setmetatable({}, { __mode = "k" })
			obj6 = setmetatable({}, { __mode = "k" })

			for _, v28 in ipairs(tbl18) do
				pcall(function()
					v28.adorn:Destroy()
				end)
			end

			tbl18 = {}

			if autoParryHitboxViz and autoParryHitboxViz.Parent then
				pcall(function()
					autoParryHitboxViz:Destroy()
				end)
			end
		end

		_G.__myhubApHandler = function(autoParry)
			tbl8.autoParry = autoParry

			if not autoParry then
				deadline2 = 0
				deadline3 = 0

				if flag18 then
					pcall(fn50, "UnHold")

					if VirtualInputManager then
						pcall(function()
							VirtualInputManager:SendKeyEvent(false, tbl8.autoParryBlockKey or Enum.KeyCode.F, false, game)
						end)
					end

					flag18 = false
				end
			end
		end

		local apEnabled = lib and lib.Toggles and lib.Toggles.apEnabled

		if apEnabled and apEnabled.Value ~= nil then
			pcall(_G.__myhubApHandler, apEnabled.Value)
		end
	end

	fn41()

	local AutoPath = tbl7.Leveling:AddLeftGroupbox("Auto Level 1-MAX"):AddToggle("AutoPath", {
		Text = "Auto Progression",
		Default = false,
		Tooltip = "AFK TILL MAX",
		Callback = function(autoProgression)
			tbl8.autoPath = autoProgression
		end,
	})

	if not tbl6.isPremium then
		fn16(AutoPath)
	end

	local service = game:GetService("ReplicatedStorage")
	local v26 = nil

	local function fn42()
		if v26 then
			return v26
		end
		local ok, result = pcall(require, service.CAM.Global.Subsets.Gameplay.Quests)

		if ok then
			v26 = result
		end

		return v26
	end

	local v27 = nil

	local function fn43()
		if v27 then
			return v27
		end
		local ok, result = pcall(require, service.Communication.ServerAndClient.Signals.SignalEvent)

		if ok then
			v27 = result
		end

		return v27
	end

	local localPlayer2 = game:GetService("Players").LocalPlayer

	local function getOk()
		local ok, result = pcall(function()
			local v28 = service.Player_Service.Data[localPlayer2.Name]
			return v28.slots:FindFirstChild("Slot" .. v28.slotEquipped.Value)
		end)

		return ok and result or nil
	end

	local function myhubPathGetLevel()
		local playerGui = localPlayer2:FindFirstChild("PlayerGui")
		if not playerGui then
			return 0
		end
		local level = playerGui:FindFirstChild("ComponentsHolder") and playerGui.ComponentsHolder:FindFirstChild("LeftHudPortion") and playerGui.ComponentsHolder.LeftHudPortion:FindFirstChild("ExpFrame") and playerGui.ComponentsHolder.LeftHudPortion.ExpFrame:FindFirstChild("Context") and playerGui.ComponentsHolder.LeftHudPortion.ExpFrame.Context:FindFirstChild("Level")
		if not (level and level:IsA("TextLabel")) then
			return 0
		end
		return tonumber(level.Text:match("(%d+)")) or 0
	end

	local function myhubPathGetSide()
		local ok = getOk()
		if not ok then
			return "Human"
		end
		local race = ok:FindFirstChild("Race")
		return race and type(race.Value) == "string" and race.Value or "Human"
	end

	_G.__myhubPathGetLevel = myhubPathGetLevel
	_G.__myhubPathGetSide = myhubPathGetSide
	_G.__myhubPathActiveSlot = getOk
	local fn44, myhubPathRankQuests

	do
		local categories = { Combat = true }
		local tbl17 = {}

		local function fn45(arg)
			local v28 = tbl17[arg]
			return not v28 or tick() >= v28
		end

		fn44 = function(arg)
			tbl17[arg] = tick() + 90
		end

		local tbl18 = { ["Ill see you to Windy Peak(Lv 105)"] = true }

		myhubPathRankQuests = function(arg)
			local v28 = fn42()
			if not v28 or not v28.Holder then
				return {}
			end
			local ok = getOk()
			local tbl19 = {}
			local tbl20 = {}

			if ok and ok:FindFirstChild("Quests") then
				local holder = ok.Quests:FindFirstChild("Holder")

				if holder then
					for _, child in ipairs(holder:GetChildren()) do
						tbl19[child.Name] = true
					end
				end

				local completed = ok.Quests:FindFirstChild("Completed")

				if completed then
					for _, child in ipairs(completed:GetChildren()) do
						tbl20[child.Name] = true
					end
				end
			end

			local tbl21 = {}

			for k, v29 in pairs(v28.Holder) do
				local level = v29.Requirements and v29.Requirements.Level or 0
				local exp = v29.Rewards and v29.Rewards.Exp or 0
				local category = v29.Category or ""
				local ok2

				if k:find("^Ill learn") == nil then
					local result
					ok2, result = pcall(v28.CanAddQuest, k)
					ok2 = ok2 and result == true
				else
					ok2 = false
				end

				ok2 = level <= arg and exp > 0 and categories[category] and ok2

				if ok2 and not tbl19[k] and not tbl20[k] and fn45(k) and not tbl18[k] then
					table.insert(tbl21, { name = k, xp = exp, req = level, def = v29 })
				end
			end

			table.sort(tbl21, function(arg2, arg3)
				return arg2.xp > arg3.xp
			end)

			return tbl21
		end
	end

	local Dialogue = nil
	local DialogueUtility = nil

	local function fn45()
		if Dialogue and DialogueUtility then
			return Dialogue, DialogueUtility
		end

		pcall(function()
			Dialogue = require(service.CAM.Client.Modules.GamePlay.Dialogue)
			DialogueUtility = require(service.CAM.Client.Components.Client.DialogueComponent.DialogueUtility)
		end)

		return Dialogue, DialogueUtility
	end

	local offerNpcs = {
		["Angler Runo"] = Vector3.new(-561.1, 798.87, 683.7),
		Betty = Vector3.new(714, 1123.7, -808),
		["Blacksmith Togane"] = Vector3.new(1732.07, 696.53, -764.55),
		Chaka = Vector3.new(471, 1148.5, -1260),
		["Demon Delroy"] = Vector3.new(139.61, 1256.72, -1911.3),
		["Demon Mokuro"] = Vector3.new(-1948.43, 30.71, 374.31),
		["Demon Slayer Goro"] = Vector3.new(-871.97, 237.25, 318.47),
		["Demon Slayer Mitsu"] = Vector3.new(-824.3, 1384, -2537.85),
		["Dock Master Sofen"] = Vector3.new(-160.81, 798.75, 703.29),
		["Estate Worker Niko"] = Vector3.new(341.07, 938.9, 580.59),
		["Flame Trainer Rengu"] = Vector3.new(-967.64, 1025.71, 1188.22),
		Ginzo = Vector3.new(273.8, 944, 528.19),
		["Harvester of Souls Zurinyz"] = Vector3.new(-1212.57, 1384.61, -2371.56),
		["Iceveil Guard Shiro"] = Vector3.new(-106.78, 1351.5, -2498.56),
		["Insect Trainer Shinora"] = Vector3.new(-1798.94, 350.17, -189.34),
		Kazu = Vector3.new(-626, 1245, -1138),
		Kona = Vector3.new(-791.6, 1262.57, -1130.91),
		Krue = Vector3.new(-425.49, 1243.5, -952.49),
		["Lamplighter Isamu"] = Vector3.new(1082.21, 1425.67, -749.03),
		Lucy = Vector3.new(-615.5, 1261, -1177.5),
		MoldySugar = Vector3.new(-701.6, 1245.69, -982.73),
		Noote = Vector3.new(-515.55, 1245.4, -1251.24),
		Ren = Vector3.new(-1649.09, 289, 42.79),
		["Serpent Trainer Obari"] = Vector3.new(36.96, 1307.5, -1179.5),
		["Shady Individual Rooyi"] = Vector3.new(-772.94, 967.07, -8.56),
		Shiori = Vector3.new(-1814.34, 314.31, -101.07),
		["Shrine Messenger Akio"] = Vector3.new(-207.07, 1352.19, -2423),
		["Soryu Expert Kazuma"] = Vector3.new(-769.46, 907.25, 303.35),
		["Sound Trainer Tengai"] = Vector3.new(464.88, 1487.8, -3272.8),
		["Stone Trainer Gyorei"] = Vector3.new(2578.58, 1091.5, -828.4),
		["Tai Chi Expert Renjiro"] = Vector3.new(1883.13, 687.25, -761.04),
		["Thunder Trainer Zentaro"] = Vector3.new(1970.18, 1662.5, -609.81),
		Tom = Vector3.new(507.2, 1123.92, -970.3),
		Wagwan = Vector3.new(723.76, 1021.7, -801.98),
		["Water Trainer Urokodaki"] = Vector3.new(667.17, 1021, -228.24),
		["Wind Trainer Saneri"] = Vector3.new(-275.58, 1189.99, -3436.65),
		["Wounded Slayer Tomoi"] = Vector3.new(485.34, 1225.07, -1813),
	}

	local tbl17 = {
		BearCub = Vector3.new(456.04, 1120.73, -1057.56),
		FireProfoundDemon = Vector3.new(-1132.68, 1382.51, -2226.17),
		FlameTrainee = Vector3.new(-1129.55, 1029.55, 992.2),
		HighDemon = Vector3.new(314.37, 1223.05, -1780.08),
		Hoyuzo = Vector3.new(746.45, 1001.49, -1410.03),
		IceProfoundDemon = Vector3.new(-1096.16, 1382.43, -2204.33),
		InsectTrainee = Vector3.new(-1396.94, 261.99, 70.6),
		Kaiden = Vector3.new(582.59, 1149, -1313.86),
		KanoeDemonSlayer = Vector3.new(206.6, 1254.15, -1783.7),
		MizunoeDemonSlayer = Vector3.new(-1805.28, 29.46, 510.64),
		MotherBear = Vector3.new(554.95, 1121.5, -1037.42),
		SerpentTrainee = Vector3.new(-273.27, 1292.49, -1537.05),
		SoundTrainee = Vector3.new(192.16, 1349.49, -2583.71),
		StoneTrainee = Vector3.new(2684.31, 1073.92, -565.69),
		ThunderTrainee = Vector3.new(2426.92, 1074.07, -554.9),
		WindTrainee = Vector3.new(-938.62, 1381.49, -2633.75),
		Zuko = Vector3.new(-288.54, 1224.23, -1037.44),
		Akazo = Vector3.new(-1130.99, 1381.31, -1745.2),
		Bandit = Vector3.new(-358.31, 1223.54, -1059.17),
		BeastBornDemon = Vector3.new(409.89, 874.04, 980.29),
		BloodHoundedDemon = Vector3.new(743.21, 823.99, 992.36),
		CacheLancer = Vector3.new(776.02, 1227.95, 412.2),
		CacheProwler = Vector3.new(305.84, 1222.8, -1781.47),
		Datai = Vector3.new(-167.6, 1043.49, -1135.55),
		Domae = Vector3.new(-296.28, 1350.99, -3450.91),
		Enru = Vector3.new(822.18, 796.06, 546.76),
		Giyen = Vector3.new(390.24, 1018.49, -84.38),
		GreaterDemon = Vector3.new(-403.13, 288.26, 514.7),
		GroveRaider = Vector3.new(596.94, 1146.85, -1214.38),
		Gyutai = Vector3.new(-267.91, 1043.72, -1144.4),
		HoyuzoSubordinate = Vector3.new(533.16, 1001.49, -1388.5),
		KaidenSubordinate = Vector3.new(568.29, 1146.79, -1323.36),
		LancerCaptain = Vector3.new(798.74, 1228.02, 415.88),
		LesserDemon = Vector3.new(-692.45, 221.16, 339.55),
		Mizunoto = Vector3.new(-895.63, 964.49, -59.33),
		Nezura = Vector3.new(-1458.57, 276.45, 937.44),
		Obari = Vector3.new(773.35, 1121.49, -1044.13),
		ProwlerCaptain = Vector3.new(-76.84, 1349.52, -2256.17),
		RaidCaptain = Vector3.new(588.85, 1147.08, -1233.7),
		Reaper = Vector3.new(95.5, 1043.49, -572.05),
		ReaperTraineeKuzan = Vector3.new(-1220.61, 1374.62, -3031.54),
		Rengu = Vector3.new(-711.08, 965.49, 885.11),
		Saneri = Vector3.new(-376.6, 1093.82, -426),
		Shinora = Vector3.new(-449.77, 964.99, -2.96),
		SoryuTraineeGoki = Vector3.new(-425.74, 289.21, 541.94),
		Sumari = Vector3.new(399.43, 1018.49, -618.59),
		Tengai = Vector3.new(-133.08, 1349.49, -2630.29),
		WaterTraineeSabito = Vector3.new(814.28, 1018.62, 101.08),
		Yahari = Vector3.new(824.39, 1019.69, -641.23),
		Zentaro = Vector3.new(1333.77, 821.5, -1020.41),
	}

	local function myhubPathFireQuest(arg)
		local v28 = fn45()
		if not (v28 and v28.Functions and v28.Functions.AddQuest) then
			return false, "DlgMod.Functions.AddQuest missing"
		end
		local character = localPlayer2.Character
		if not (character and character:FindFirstChild("HumanoidRootPart")) then
			return false, "no HRP"
		end
		local offerNpc = arg.def.OfferNpc
		if not offerNpc then
			return false, "quest missing OfferNpc"
		end
		local offerNpc2 = offerNpcs[offerNpc]
		if not offerNpc2 then
			return false, "no coord for NPC: " .. offerNpc
		end
		myhubGuardTP(CFrame.new(offerNpc2 + Vector3.new(0, 3, 0)))
		task.wait(1.2)

		return (pcall(function()
			v28.Functions.AddQuest(arg.name)
		end))
	end

	local function fn46(arg)
		if type(arg) ~= "string" then
			return arg
		end
		return (arg:gsub("(%l)(%u)", "%1 %2"))
	end

	_G.__myhubPathQuestTargetCodes = function(arg)
		local ok = getOk()
		if not ok or not ok.Quests or not ok.Quests.Holder then
			return {}
		end
		local tbl18 = {}

		for _, child in ipairs(ok.Quests.Holder:GetChildren()) do
			local questString = child:FindFirstChild("QuestString")
			if not (questString and questString.Value == arg) then
				continue
			end
			local tasks = child:FindFirstChild("Tasks")
			if not tasks then
				continue
			end

			for _, child2 in ipairs(tasks:GetChildren()) do
				local code = child2:FindFirstChild("Code")

				if code and type(code.Value) == "string" and code.Value ~= "" then
					tbl18[code.Value] = true
					local v28 = fn46(code.Value)

					if v28 ~= code.Value then
						tbl18[v28] = true
					end
				end
			end
		end

		return tbl18
	end

	_G.__myhubPathRankQuests = myhubPathRankQuests
	_G.__myhubPathFireQuest = myhubPathFireQuest
	local v28 = nil

	local function fn47(arg)
		if arg ~= v28 then
			v28 = arg
			lib:Notify({ Title = "Path", Description = arg, Time = 4 })
		end
	end

	local function fn48()
		local ok = getOk()
		if not ok then
			return false
		end
		local holder = ok:FindFirstChild("Quests") and ok.Quests:FindFirstChild("Holder")
		if not holder then
			return false
		end
		return #holder:GetChildren() > 0
	end

	local flag18 = false
	local parent2 = nil
	local connection3 = nil

	local function getParent(arg)
		local humanoids = workspace:FindFirstChild("Humanoids")
		if not humanoids then
			return nil
		end
		local str3 = arg:gsub("(%l)(%u)", "%1 %2")

		for _, descendant in ipairs(humanoids:GetDescendants()) do
			if descendant:IsA("Humanoid") and descendant.Health > 0 then
				local parent = descendant.Parent
				if parent and (parent.Name == arg or parent.Name == str3) then
					return parent
				end
			end
		end
	end

	local function getVector()
		local farmDistance = tbl8.farmDistance or 3
		local vector

		if tbl8.farmPosition == "Above" then
			vector = Vector3.new(0, farmDistance, 0)
		elseif tbl8.farmPosition == "Below" then
			vector = Vector3.new(0, -farmDistance, 0)
		elseif tbl8.farmPosition == "In Front" then
			vector = Vector3.new(0, 0, -farmDistance)
		else
			vector = Vector3.new(0, 0, farmDistance)
		end

		return vector + Vector3.new(tbl8.farmOffX or 0, tbl8.farmOffY or 0, tbl8.farmOffZ or 0)
	end

	local function fn49()
		if connection3 then
			pcall(function()
				connection3:Disconnect()
			end)
		end

		connection3 = nil
		getgenv()._myhubPathHoverConn = nil
		parent2 = nil
	end

	local function fn50()
		if connection3 then
			return
		end
		local UserInputService = game:GetService("UserInputService")

		connection3 = game:GetService("RunService").Heartbeat:Connect(function()
			if not tbl8.autoPath then
				fn49()
				return
			end
			local parent = parent2
			if not parent or not parent.Parent then
				return
			end
			local humanoid = parent:FindFirstChildOfClass("Humanoid")
			if not humanoid or humanoid.Health <= 0 then
				parent2 = nil
				return
			end

			if _G.__myhubLootDwell then
				return
			end
			local humanoidRootPart = parent:FindFirstChild("HumanoidRootPart") or parent:FindFirstChildWhichIsA("BasePart")
			if not humanoidRootPart then
				return
			end
			local character = localPlayer2.Character
			local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
			local humanoid2 = character and character:FindFirstChildOfClass("Humanoid")
			if not (humanoidRootPart2 and humanoid2) then
				return
			end

			pcall(function()
				if humanoid2.PlatformStand then
					humanoid2.PlatformStand = false
				end

				local position = humanoidRootPart.Position
				local lookVector = humanoidRootPart.CFrame.LookVector
				local vector = Vector3.new(lookVector.X, 0, lookVector.Z)
				local cframe

				if vector.Magnitude < 0.01 then
					cframe = CFrame.new(position)
				else
					cframe = CFrame.lookAt(position, position + vector.Unit)
				end

				humanoidRootPart2.CFrame = CFrame.lookAt((cframe * CFrame.new(getVector())).Position, position)
				humanoidRootPart2.AssemblyLinearVelocity = Vector3.zero
				humanoidRootPart2.AssemblyAngularVelocity = Vector3.zero
				local state = humanoid2:GetState()

				if state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.Ragdoll or state == Enum.HumanoidStateType.FallingDown then
					humanoid2:ChangeState(Enum.HumanoidStateType.Running)
				end

				if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				end
			end)
		end)

		getgenv()._myhubPathHoverConn = connection3
	end

	local function fn51()
		if flag18 then
			return
		end
		local ok = getOk()
		if not ok or not ok.Quests or not ok.Quests.Holder then
			return
		end
		local v29 = fn42()
		local tbl18 = {}
		local position = nil

		for _, child in ipairs(ok.Quests.Holder:GetChildren()) do
			local questString = child:FindFirstChild("QuestString")

			if questString and v29 and v29.Holder and v29.Holder[questString.Value] then
				position = position or v29.Holder[questString.Value].Position
			end

			local tasks = child:FindFirstChild("Tasks")
			if not tasks then
				continue
			end

			for _, child2 in ipairs(tasks:GetChildren()) do
				local code = child2:FindFirstChild("Code")

				if code and type(code.Value) == "string" and code.Value ~= "" then
					tbl18[code.Value] = true
					local str3 = code.Value:gsub("(%l)(%u)", "%1 %2")

					if str3 ~= code.Value then
						tbl18[str3] = true
					end

					position = tbl17[code.Value] or position
				end
			end
		end

		if not next(tbl18) then
			return
		end

		if position then
			if localPlayer2.Character and localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
				myhubGuardTP(CFrame.new(position + Vector3.new(0, 5, 0)))
				task.wait(1.5)
			end
		end

		if _G.__myhubFarmEquip then
			pcall(function()
				_G.__myhubFarmEquip(tbl8.farmHotbarSlot or "Best")
			end)

			task.wait(0.5)
		end

		flag18 = true
		fn50()

		task.spawn(function()
			local ok2 = getOk()
			local value

			if ok2 and ok2.Quests and ok2.Quests.Holder then
				for _, child in ipairs(ok2.Quests.Holder:GetChildren()) do
					local questString = child:FindFirstChild("QuestString")
					if questString then
						value = questString.Value
						break
					end
				end
			end

			local now2 = nil

			while tbl8.autoPath and fn48() do
				if not parent2 or not parent2.Parent or parent2:FindFirstChildOfClass("Humanoid") and parent2:FindFirstChildOfClass("Humanoid").Health <= 0 then
					for k in pairs(tbl18) do
						local parent = getParent(k)
						if parent then
							parent2 = parent
							break
						end
					end
				end

				if parent2 then
					now2 = now2 or tick()
					_G.__myhubPathTarget = parent2:FindFirstChild("HumanoidRootPart") or parent2:FindFirstChildWhichIsA("BasePart")
				else
					_G.__myhubPathTarget = nil
					now2 = now2 or tick()

					if tick() - now2 > 15 then
						if value then
							fn44(value)
							local v30 = fn43()

							if v30 and v30.ToServer then
								pcall(function()
									v30.ToServer("RemoveQuest", value)
								end)

								local ok3 = getOk()

								if ok3 and ok3.Quests and ok3.Quests.Holder then
									for _, child in ipairs(ok3.Quests.Holder:GetChildren()) do
										pcall(function()
											v30.ToServer("RemoveQuest", child.Name)
										end)
									end
								end
							end
						end

						fn47("No target — cooling " .. tostring(value or "quest") .. " (90s), picking next")
						fn49()
						_G.__myhubPathTarget = nil
						flag18 = false
						return
					end
				end

				task.wait(0.25)
			end

			fn49()
			_G.__myhubPathTarget = nil
			flag18 = false
		end)
	end

	local function fn52(arg)
		if fn48() then
			fn51()
			fn47("Lv " .. arg .. " — hunting active quest target")
			return
		end

		local v29 = myhubPathRankQuests(arg)
		if #v29 == 0 then
			fn47("Lv " .. arg .. " — no eligible quests")
			return
		end
		local v30 = v29[1]
		fn47(string.format("Lv %d → %s (%d XP)", arg, v30.name, v30.xp))
		if not myhubPathFireQuest(v30) then
			return
		end
		task.wait(1.2)

		if v30.def.Category == "Combat" then
			fn51()
		end
	end

	task.spawn(function()
		while _G.MyHubSession == myHubSession do
			if tbl8.autoPath then
				local v29 = myhubPathGetLevel()
				local v30 = myhubPathGetSide()

				if v30 == "Human" then
					fn52(v29)
				elseif v30 == "Slayer" then
					if tbl8.pathBreath ~= "None" and v29 >= 25 then
						fn47("Slayer Lv " .. v29 .. " — learn " .. tbl8.pathBreath .. " (TBD)")
					else
						fn52(v29)
					end
				elseif v30 == "Demon" then
					if tbl8.pathArt ~= "None" then
						fn47("Demon Lv " .. v29 .. " — hunt " .. tbl8.pathArt .. " orb (TBD)")
					else
						fn52(v29)
					end
				end
			else
				v28 = nil
			end

			task.wait(5)
		end
	end)

	local function onOnUnload()
		tbl8.flyEnabled = false
		tbl8.noclip = false
		tbl8.speedEnabled = false
		local humanoid
		humanoid, humanoid = fn18()

		if humanoid then
			pcall(function()
				humanoid.WalkSpeed = myHubBaselines.walkSpeed
			end)
		end

		tbl8.espPlayers = false
		tbl8.espNpcs = false
		tbl8.espMobs = false
		tbl8.espItems = false

		if type(_G.__myhubFlyTeardown) == "function" then
			pcall(_G.__myhubFlyTeardown)
			_G.__myhubFlyTeardown = nil
		end

		if type(_G.__myhubFarmTeardown) == "function" then
			pcall(_G.__myhubFarmTeardown)
			_G.__myhubFarmTeardown = nil
		end

		tbl8.farmMob = false
		tbl8.farmBoss = false
		tbl8.farmPlayer = false
		tbl8.farmYeti = false
		tbl8.spiderLily = false

		if type(_G.__myhubCombatHookTeardown) == "function" then
			pcall(_G.__myhubCombatHookTeardown)
			_G.__myhubCombatHookTeardown = nil
		end

		if type(_G.__myhubAutoParryTeardown) == "function" then
			pcall(_G.__myhubAutoParryTeardown)
			_G.__myhubAutoParryTeardown = nil
		end

		tbl8.autoParry = false

		if type(_G.__myhubESPTeardown) == "function" then
			pcall(_G.__myhubESPTeardown)
			_G.__myhubESPTeardown = nil
		end

		if type(_G.__myhubWorldTeardown) == "function" then
			pcall(_G.__myhubWorldTeardown)
			_G.__myhubWorldTeardown = nil
		end

		if type(_G.__myhubStreamerTeardown) == "function" then
			pcall(_G.__myhubStreamerTeardown)
			_G.__myhubStreamerTeardown = nil
		end

		if type(_G.__myhubOwnershipTeardown) == "function" then
			pcall(_G.__myhubOwnershipTeardown)
			_G.__myhubOwnershipTeardown = nil
		end

		tbl8.noFog = false
		tbl8.noAtmosphere = false
		tbl8.fullBright = false
		tbl8.unlockFPS = false
		tbl8.streamerMode = false
		tbl8.staffDetect = false

		if connection then
			pcall(function()
				connection:Disconnect()
			end)

			connection = nil
		end

		if connection2 then
			pcall(function()
				connection2:Disconnect()
			end)

			connection2 = nil
		end

		if myhubStatsLabel2 then
			pcall(function()


				myhubStatsLabel2:Destroy()
			end)

			myhubStatsLabel2 = nil
		end

		_G.__myhubStatsConn = nil
		_G.__myhubStatsLabel = nil
		pcall(fn38)

		if getgenv()._myhubPathHoverConn then
			pcall(function()
				getgenv()._myhubPathHoverConn:Disconnect()
			end)

			getgenv()._myhubPathHoverConn = nil
		end

		_G.__myhubPathTarget = nil
		tbl8.autoPath = false
		_G.__myhubKillAura = false
		fn15()
	end

	if type(lib.OnUnload) == "table" and lib.OnUnload.Connect then


		lib.OnUnload:Connect(onOnUnload)
	elseif type(lib.OnUnload) == "function" then
		lib:OnUnload(onOnUnload)
	else
		task.spawn(function()
			while not lib.Unloaded do
				task.wait(0.5)
			end

			onOnUnload()
		end)
	end

	return
end
