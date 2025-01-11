--[[
		 ___    ____ _____   __   ___   ____   ___        __ __  _____   ___  ____  
		|   \  |    / ___/  /  ] /   \ |    \ |   \      |  |  |/ ___/  /  _]|    \ 
		|    \  |  (   \_  /  / |     ||  D  )|    \     |  |  (   \_  /  [_ |  D  )
		|  D  | |  |\__  |/  /  |  O  ||    / |  D  |    |  |  |\__  ||    _]|    / 
		|     | |  |/  \ /   \_ |     ||    \ |     |    |  :  |/  \ ||   [_ |    \ 
		|     | |  |\    \     ||     ||  .  \|     |    |     |\    ||     ||  .  \
		|_____||____|\___|\____| \___/ |__|\_||_____|     \__,_| \___||_____||__|\_|
	                                                                                                                                 
	 ____    ____  ____    ___   __ __  ______  ______   ____  __ __  _____   ___  ____  
	|    \  /    ||    \  /   \ |  |  ||      ||      | /    ||  |  |/ ___/  /  _]|    \ 
	|  D  )|  o  ||  _  ||     ||  |  ||      ||      ||  o  ||  |  (   \_  /  [_ |  D  )
	|    / |     ||  |  ||  O  ||  |  ||_|  |_||_|  |_||     ||  |  |\__  ||    _]|    / 
	|    \ |  _  ||  |  ||     ||  :  |  |  |    |  |  |  _  ||  :  |/  \ ||   [_ |    \ 
	|  .  \|  |  ||  |  ||     ||     |  |  |    |  |  |  |  ||     |\    ||     ||  .  \
	|__|\_||__|__||__|__| \___/  \__,_|  |__|    |__|  |__|__| \__,_| \___||_____||__|\_|
	                                                                                     
]]


--------------------------------------------------------------
-------------------------- Services --------------------------
--------------------------------------------------------------
local ReplicatedStorage = game:GetService(`ReplicatedStorage`)
--------------------------------------------------------------

local Config = {}
Config.__index = Config

------------------------------
-- Toggles Print Statements --
------------------------------
Config.DebugPrint = false
------------------------------
-------- Splits Lines --------
--- Wouldnt Suggest To Use ---
------------------------------
Config.Prettify = false
------------------------------

local AllConfigs = {}

--[[
	 __ __   ___   __    __      ______   ___       __ __  _____   ___ 
	|  |  | /   \ |  |__|  |    |      | /   \     |  |  |/ ___/  /  _]
	|  |  ||     ||  |  |  |    |      ||     |    |  |  (   \_  /  [_ 
	|  _  ||  O  ||  |  |  |    |_|  |_||  O  |    |  |  |\__  ||    _]
	|  |  ||     ||  `  '  |      |  |  |     |    |  :  |/  \ ||   [_ 
	|  |  ||     | \      /       |  |  |     |    |     |\    ||     |
	|__|__| \___/   \_/\_/        |__|   \___/      \__,_| \___||_____|
                                                                   
	* Config:New(Name)
		Called with local.
		Creates a new config with a desired name and returns it.
		Can use everything else except :Find().

	* Config:Find(Name)
		Called with local.
		Will return with the config if it exists.

	* Config:Set(Key, Value)
		Adds a new key with a desired value to the config.

	* Config:Remove(Key)
		Removes the desired key from the config.

	* Config:Get(Key)
		Called with local.
		Returns the value of the desired key.

	* Config:GetAll()
		Called with local.
		Returns all keys and values in the desired config.
	
	* Config:Clear()
		Clears the config.
		
	THE BYTE BLOX SECTION
	
	* Config:Add(Amount)
		Adds Amount to all values.
	
	* Config:Subtract(Amount)
		Subtracts Amount to all values.
	
	* Config:Multiply(Amount)
		Multiplies Amount to all values.
	
	* Config:Divide(Amount)
		Divides Amount to all values.
	
	* Config:Power(Amount)
		Powers Amount to all values.
	
	* Config:SquareRoot(Amount)
		Square Roots Amount to all values.
]]

-----------------------------------------------------
--------------------- Functions ---------------------
-----------------------------------------------------
local function Debug(Message, State)
	State = string.lower(State)
	
	
	if Config.DebugPrint == true then
		if State == `default` then
			if Config.Prettify then
				print(`\n[SERVER_OUTPUT] | {Message}\n`)
			else
				print(`[SERVER_OUTPUT] | {Message}`)
			end
		elseif State == `warn` then
			if Config.Prettify then
				warn(`\n[SERVER_WARN] | {Message}\n`)
			else
				warn(`[SERVER_WARN] | {Message}`)
			end
		elseif State == `error` then
			if Config.Prettify then
				error(`\n[SERVER_ERROR] | {Message}\n`)
			else
				error(`[SERVER_ERROR] | {Message}`)
			end
		else
			warn(`{State} is not a valid state.`)
		end
	end
end
-----------------------------------------------------


-----------------------------------------------------
--------------------- Main Code ---------------------
-----------------------------------------------------
function Config:New(Name: string)	
	local self = setmetatable({}, Config)
	
	self.Name = Name
	self.Configs = {}
	
	AllConfigs[Name] = self
	
	Debug(`Created New Config: {Name}`, `Default`)
	return self
end

function Config:Find(Name: string)
	task.wait(0.1)
	
	if AllConfigs[Name] then
		Debug(`Found Config: {Name}`, `Default`)
		return AllConfigs[Name]
	else
		Debug(`Couldn't Find Config: {Name}`, `Warn`)
		return false
	end
end

function Config:Set(Key: string, Value: ValueBase)
	local Configuration = self.Configs
	Configuration[Key] = Value
	Debug(`Set {Key} in {self.Name} to {Value}`, `Default`)
end

function Config:Remove(Key: string)
	local Configuration = self.Configs
	if Configuration[Key] then
		Configuration[Key] = nil
		Debug(`Removed {Key} from {self.Name}`, `Default`)
	else
		Debug(`{Key} not found in {Config}`, `Warn`)
	end
end

function Config:Get(Key: string)
	local Configuration = self.Configs
	if Configuration[Key] then
		Debug(`Found {Key} in config {self.Name}`, `Default`)
		return Configuration[Key]
	else
		Debug(`{Key} not found in {Config}`, `Warn`)
	end
end

function Config:GetAll()
	local Configuration = self.Configs
	Debug(`Found {self.Name}`, `Default`)
	return Configuration
end

function Config:Clear()
	local Configuration = self.Configs
	Configuration = {}
	Debug(`Cleared {self.Name}`, `Default`)
end

-- ByteBlox Inspired Section

function Config:Add(Amount: number)
	local Configuration = self.Configs
	
	for Key, Value in pairs(Configuration) do
		if type(Value) == 'number' then
			local LoggedValue = Value
			Configuration[Key] = Value + Amount
			Debug(`Changed {LoggedValue} in {self.Name} to {Configuration[Key]}`, `Default`)
		end
	end
end

function Config:Subtract(Amount: number)
	local Configuration = self.Configs

	for Key, Value in pairs(Configuration) do
		if type(Value) == 'number' then
			local LoggedValue = Value
			Configuration[Key] = Value - Amount
			Debug(`Changed {LoggedValue} in {self.Name} to {Configuration[Key]}`, `Default`)
		end
	end
end

function Config:Multiply(Amount: number)
	local Configuration = self.Configs

	for Key, Value in pairs(Configuration) do
		if type(Value) == 'number' then
			local LoggedValue = Value
			Configuration[Key] = Value * Amount
			Debug(`Changed {LoggedValue} in {self.Name} to {Configuration[Key]}`, `Default`)
		end
	end
end

function Config:Divide(Amount: number)
	local Configuration = self.Configs

	for Key, Value in pairs(Configuration) do
		if type(Value) == 'number' then
			local LoggedValue = Value
			Configuration[Key] = Value / Amount
			Debug(`Changed {LoggedValue} in {self.Name} to {Configuration[Key]}`, `Default`)
		end
	end
end

function Config:Power(Amount: number)
	local Configuration = self.Configs

	for Key, Value in pairs(Configuration) do
		if type(Value) == 'number' then
			local LoggedValue = Value
			Configuration[Key] = math.pow(Value, Amount)
			Debug(`Changed {LoggedValue} in {self.Name} to {Configuration[Key]}`, `Default`)
		end
	end
end

function Config:SquareRoot(Amount: number)
	local Configuration = self.Configs

	for Key, Value in pairs(Configuration) do
		if type(Value) == 'number' then
			local LoggedValue = Value
			Configuration[Key] = math.sqrt(Value, Amount)
			Debug(`Changed {LoggedValue} in {self.Name} to {Configuration[Key]}`, `Default`)
		end
	end
end
-----------------------------------------------------

return Config
