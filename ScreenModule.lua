


--[[

TODO: 

1: Make screen scrollable
2: Complete Input handling/Input map
3: Double-check to see if anything can be shortened, or made more efficient
4: Create a Command map/Parsing
5: Create Error code map/Parsing



]]










-- Screen.lua
local Screen = {}
local ScreenMethods = {};

-- Static variables
local CharacterMap = {
	[" "] = '0020:00000000000000000000000000000000',
	["a"] = '0061:0000000000003C42023E4242463A0000',
	["b"] = '0062:0000004040405C6242424242625C0000',
	["c"] = '0063:0000000000003C4240404040423C0000',
	["d"] = '0064:0000000202023A4642424242463A0000',
	["e"] = '0065:0000000000003C42427E4040423C0000',
	["f"] = '0066:0000000C1010107C1010101010100000',
	["g"] = '0067:0000000000023A44444438203C42423C',
	["h"] = '0068:0000004040405C624242424242420000',
	["i"] = '0069:000000080800180808080808083E0000',
	["j"] = '006A:0000000404000C040404040404044830',
	["k"] = '006B:00000040404044485060504844420000',
	["l"] = '006C:000000180808080808080808083E0000',
	["m"] = '006D:00000000000076494949494949490000',
	["n"] = '006E:0000000000005C624242424242420000',
	["o"] = '006F:0000000000003C4242424242423C0000',
	["p"] = '0070:0000000000005C6242424242625C4040',
	["q"] = '0071:0000000000003A4642424242463A0202',
	["r"] = '0072:0000000000005C624240404040400000',
	["s"] = '0073:0000000000003C4240300C02423C0000',
	["t"] = '0074:000000001010107C10101010100C0000',
	["u"] = '0075:000000000000424242424242463A0000',
	["v"] = '0076:00000000000042424224242418180000',
	["w"] = '0077:00000000000041494949494949360000',
	["x"] = '0078:00000000000042422418182442420000',
	["y"] = '0079:0000000000004242424242261A02023C',
	["z"] = '007A:0000000000007E0204081020407E0000',
	["A"] = '0041:0000000018242442427E424242420000',
	["B"] = '0042:000000007C4242427C424242427C0000',
	["C"] ='0043:000000003C42424040404042423C0000',
	["D"] ='0044:00000000784442424242424244780000',
	["E"] ='0045:000000007E4040407C404040407E0000',
	["F"] ='0046:000000007E4040407C40404040400000',
	["G"] ='0047:000000003C424240404E4242463A0000',
	["H"] ='0048:00000000424242427E42424242420000',
	["I"] ='0049:000000003E08080808080808083E0000',
	["J"] ='004A:000000001F0404040404044444380000',
	["K"] ='004B:00000000424448506060504844420000',
	["L"] ='004C:000000004040404040404040407E0000',
	["M"] =	'004D:00000000424266665A5A424242420000',
	["N"] =	'004E:0000000042626252524A4A4646420000',
	["O"] =	'004F:000000003C42424242424242423C0000',
	["P"] =	'0050:000000007C4242427C40404040400000',
	["Q"] =	'0051:000000003C4242424242425A663C0300',
	["R"] =	'0052:000000007C4242427C48444442420000',
	["S"] =	'0053:000000003C424240300C0242423C0000',
	["T"] =	'0054:000000007F0808080808080808080000',
	["U"] =	'0055:000000004242424242424242423C0000',
	["V"] =	'0056:00000000414141222222141408080000',
	["W"] =	'0057:00000000424242425A5A666642420000',
	["X"] =	'0058:00000000424224241818242442420000',
	["Y"] =	'0059:00000000414122221408080808080000',
	["Z"] =	'005A:000000007E02020408102040407E0000',
	["0"] = '0030:00000000182442464A52624224180000',
	["1"] = '0031:000000000818280808080808083E0000',
	["2"] = '0032:000000003C4242020C102040407E0000',
	["3"] = '0033:000000003C4242021C020242423C0000',
	["4"] = '0034:00000000040C142444447E0404040000',
	["5"] = '0035:000000007E4040407C020202423C0000',
	["6"] = '0036:000000001C2040407C424242423C0000',
	["7"] = '0037:000000007E0202040404080808080000',
	["8"] = '0038:000000003C4242423C424242423C0000',
	["9"] = '0039:000000003C4242423E02020204380000',
	["!"] = '0021:00000000080808080808080008080000',
	["?"] = '003F:000000003C4242020408080008080000',
	['"'] = '0022:00002222222200000000000000000000',
	["'"] = '0027:00000808080800000000000000000000',
	["."] = '002E:00000000000000000000000018180000',
	[":"] = '003A:00000000000018180000001818000000',
	[";"] = '003B:00000000000018180000001808081000',
	[">"] = '003E:00000000004020100804081020400000',
	["<"] = '003C:00000000000204081020100804020000',
	[","] = '002C:00000000000000000000000018080810',
	["-"] = '002D:0000000000000000003C000000000000',
	["_"] = '005F:00000000000000000000000000007F00',
	["="] = '003D:000000000000007E0000007E00000000',
	["/"] = '002F:00000000020204080810102040400000',
	["\\"] = '005C:00000000404020101008080402020000',
	["["] = '005B:0000000E080808080808080808080E00',
	["]"] = '005D:00000070101010101010101010107000',
	["+"] = '002B:0000000000000808087F080808000000',
	["{"] = '007B:0000000C10100808102010080810100C',
	["}"] = '007D:00000030080810100804081010080830',
	["("] = '0028:00000004080810101010101008080400',
	[")"] = '0029:00000020101008080808080810102000',
	["`"] = '0060:00201008000000000000000000000000',
	["@"] = '0040:000000001C224A565252524E201E0000',
	['#'] = '0023:000000001212127E24247E4848480000',
	['$'] = '0024:00000000083E4948380E09493E080000',
	["%"] = '0025:00000000314A4A340808162929460000',
	["^"] = '005E:00001824420000000000000000000000',
	['&'] = '0026:000000001C2222141829454246390000',
	['*'] = '002A:00000000000008492A1C2A4908000000',
	['|'] = '007C:00000808080808080808080808080808'
}

local CharactersOnScreen = {};

local StateFlags = {
	["e"] = BrickColor.new("Bright red").Color,
	["w"] = BrickColor.new("Deep orange").Color,
	["s"] = BrickColor.new("Bright green").Color
}
local function CreateBuffer(width,height)
	local buffer = table.create(width * height * 4,0)
	for i = 4,#buffer, 4 do
		buffer[i] = 1
	end
	return buffer
end

function FillCell(R: number, G: number, B: number, A: number)
	local pixels = Screen.Canvas:ReadPixels(Vector2.zero, Vector2.new(Screen.CursorObject.Size.X.Offset, Screen.CursorObject.Size.Y.Offset))
	for i = 1, Screen.CursorObject.Size.X.Offset * Screen.CursorObject.Size.Y.Offset do
		local pixelIndex = 1 + ((i - 1) * 4)
		pixels[pixelIndex] = R
		pixels[pixelIndex + 1] = G
		pixels[pixelIndex + 2] = B
		pixels[pixelIndex + 3] = A

	end
end

local function RenderCodepointAt(Screen, letter, color : Color3)

	-------------- Create buffer --------------- 
	local line = letter
	local codepoint = string.sub(line, 1, 4)
	local codepointBase16: number = tonumber(codepoint, 16) or 0


	--print( string.format("Codepoint: (%s) %d", codepoint, codepointBase16) )

	local len = #line - 5
	--print(" hex length ", len)
		local dummyBuffer = buffer.create(len // 2)
	
	
	for i = 1, len, 8 do
		local number = tonumber(string.sub(line, i+5, i+5+7), 16) or 0
		buffer.writeu32(dummyBuffer, i // 2, number)

		--print( string.format("Number: %d", number) )
	end

	--print("buffer size ", buffer.len(dummyBuffer))


	-------------- RENDERING --------------


	len = buffer.len(dummyBuffer)

	local width = (len == 32) and 16 or 8

	--print("width ", width)

	local bg = { 0,0,0,1 }
	local fg = { color.R, color.G, color.B, 1 }


	for byteIndex = 0, len - 1, 4 do
		-- print ("byteIndex", byteIndex)
		local num = buffer.readu32(dummyBuffer, byteIndex)

		for bitIndex = 0, 31 do
			local output = ""

			local function appendToOutput(...)
				for i = 1, select("#", ...) do
					output = output .. " " .. select(i, ...)
				end
			end

			local color = bit32.extract(num, 31 - bitIndex) ~= 0 and fg or bg
			appendToOutput("clr", color == fg and "fg" or "bg")

			local idx = byteIndex * 8 + bitIndex
			appendToOutput("idx", idx)

			local x1, y1 = (Screen.Cursor.X * 8) + idx % width, (Screen.Cursor.Y * 16) + idx // width
			appendToOutput("x1", x1)
			appendToOutput("y1", y1)

			if x1 >= Screen.Constants.cvwidth then -- Prevent overdraw
				continue
			end

			local pos = (x1 + y1 * Screen.Constants.cvwidth) * 4

			appendToOutput("pos", pos)

			--print(output)

			Screen.Constants.cvbuffer[pos + 1] = color[1]
			Screen.Constants.cvbuffer[pos + 2] = color[2]
			Screen.Constants.cvbuffer[pos + 3] = color[3]
		end
	end
	Screen.Cursor += Vector2.new(1,0)
	if Screen.Cursor.X >= Screen.Canvas.Size.X/8 then
		Screen.Cursor = Vector2.new(0,Screen.Cursor.Y + 1)
	end
	Screen:UpdateCursor()
	Screen:Draw(Vector2.zero, Vector2.new(Screen.Constants.cvwidth, Screen.Constants.cvheight), Screen.Constants.cvbuffer)
end

function ScreenMethods:Resize(Size: Vector2)
	self.Canvas:Resize(Size)
end
function ScreenMethods:UpdateCursor()
	self.CursorObject.Position = UDim2.fromOffset(self.Cursor.X * 8, self.Cursor.Y * 16)
end
function ScreenMethods:Draw(ImagePosition: Vector2, ImageSize: Vector2, ImageData: {number})
	self.Canvas:WritePixels(ImagePosition, ImageSize, ImageData)
end
function ScreenMethods:Backspace()
	--[[if self.Cursor.X < 1 then
		self.Cursor = Vector2.new((self.Canvas.Size.X/8) - 1, self.Cursor.Y - 1)
		self:UpdateCursor()
	end]]--
		local pixels = self.Canvas:ReadPixels(Vector2.zero, Vector2.new(self.CursorObject.Size.X.Offset, self.CursorObject.Size.Y.Offset))
		local x, y = self.Cursor.X, self.Cursor.Y
		local pos = x + y * self.CanvasSize.X
		if pos > 0 then
			pos -= 1
		end
		if CharactersOnScreen[pos] == nil then
			while (CharactersOnScreen[pos] == nil) and pos > 0 do
				pos -= 1
			end
			if pos > 0 then
				pos += 1
			end
		end
		CharactersOnScreen[pos] = nil
		local px, py = pos % self.CanvasSize.X, pos // self.CanvasSize.X
		self.Cursor = Vector2.new(px,py)
		self:UpdateCursor()
		for i = 1, self.CursorObject.Size.X.Offset * self.CursorObject.Size.Y.Offset do
			local pixelIndex = 1 + ((i - 1) * 4)
			pixels[pixelIndex] = 0
			pixels[pixelIndex + 1] = 0
			pixels[pixelIndex + 2] = 0
		
		end
		self:Draw(Vector2.new(self.CursorObject.Position.X.Offset, self.CursorObject.Position.Y.Offset), Vector2.new(self.CursorObject.Size.X.Offset, self.CursorObject.Size.Y.Offset), pixels)
end
function ScreenMethods:ClearScreen()
	self.Cursor = Vector2.zero
	self.CursorObject.Position = UDim2.fromOffset(self.Cursor.X * 8, self.Cursor.Y * 16)
	self.Constants.cvbuffer = CreateBuffer(self.Constants.cvwidth, self.Constants.cvheight)
	self:Draw(Vector2.zero, Vector2.new(self.Constants.cvwidth, self.Constants.cvheight), self.Constants.cvbuffer)
end


function ScreenMethods:AllowInput()
	self.Cursor = Vector2.new(0,self.Cursor.Y + 2)
	self:UpdateCursor()
	RenderCodepointAt(self, CharacterMap[">"],Color3.new(1,1,1))
end

function ScreenMethods:GetScreenPixelData()
	local pixels = self.Canvas:ReadPixels(Vector2.zero, Vector2.new(self.Canvas.Size.X, self.Canvas.Size.Y))
	return pixels
end
function ScreenMethods:ShiftUp(lines: number)
	local PixelData = self:GetScreenPixelData()
	local width = self.CanvasSize.X
	local line = math.clamp(lines, 1, self.CanvasSize.Y)
	local height = line * 8 * 2
	local startIndex = width * height * 4 + 1
	local endIndex = width * self.CanvasSize.Y * 8 * 2 * 4
	table.move(PixelData, startIndex, endIndex, 1)
	self.Constants.cvbuffer = PixelData
	self:Draw(Vector2.zero, Vector2.new(self.Constants.cvwidth, self.Constants.cvheight), PixelData)
	local x, y = self.Cursor.X, self.Cursor.Y
	local pos = x + y * self.CanvasSize.X
	if pos > 0 then
		pos -= 1
	end
	if PixelData[pos] == nil then
		while (PixelData[pos] == nil) and pos > 0 do
			pos -= 1
		end
		if pos > 0 then
			pos += 1
		end
	end
	local px, py = pos % self.CanvasSize.X + 1, pos // self.CanvasSize.X - 1
	self.Cursor = Vector2.new(px,py)
	self:UpdateCursor()
end

function ScreenMethods:stdout(str,color)
	local chars = string.split(str,"")
	local flag = false
	local Color = Color3.new(1,1,1)
	for i, char in chars do 
		if flag == true then
			flag = false
			if StateFlags[char] then
			Color = StateFlags[char]
			continue
			end
		end
		if char:byte() == 10 then
			self.Cursor = Vector2.new(0,self.Cursor.Y + 1)
			self:UpdateCursor()
			--RenderCodepointAt(self, CharacterMap[">"],Color3.new(1,1,1))
			continue
		end
		if char == "^" then
			flag = true
			continue
		end
		
		
		local x,y = self.Cursor.X, self.Cursor.Y
		local pos = x + y * self.CanvasSize.X
		CharactersOnScreen[pos] = char
		RenderCodepointAt(self, CharacterMap[char],Color)
		task.wait()
	end
end




function Screen.new(CanvasSize: Vector2, Parent: Player)

	local Constants = {};

	Constants.cvwidth = CanvasSize.X * 8
	Constants.cvheight = CanvasSize.Y * 16
	Constants.cvbuffer = CreateBuffer(Constants.cvwidth, Constants.cvheight)

	-- Populate cvbuffer first 4 elements with 1


	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = Parent.PlayerGui

	local ScreenFrame = Instance.new("Frame")
	ScreenFrame.Parent = ScreenGui
	ScreenFrame.Position = UDim2.fromScale(0.5, 0.5)
	ScreenFrame.Size = UDim2.fromOffset(Constants.cvwidth,Constants.cvheight)
	ScreenFrame.BackgroundColor = BrickColor.new("Really black")
	ScreenFrame.AnchorPoint = Vector2.new(0.5,0.5)

	local Cursor = Instance.new("Frame")
	Cursor.Parent = ScreenFrame
	Cursor.Size = UDim2.new(0,8,0,16)
	Cursor.BorderSizePixel = 0
	Cursor.BackgroundColor3 = BrickColor.new("Institutional white").Color
	Cursor.ZIndex = 2

	local CanvasContainer = Instance.new("ImageLabel")
	CanvasContainer.Size = UDim2.new(1, 0, 1, 0)
	CanvasContainer.BackgroundTransparency = 1
	CanvasContainer.Name = "Container"
	CanvasContainer.Parent = ScreenFrame

	local Canvas = Instance.new("EditableImage")
	Canvas:Resize(Vector2.new(Constants.cvwidth, Constants.cvheight));
	Canvas.Parent = CanvasContainer
	assert(#Constants.cvbuffer == #Canvas:ReadPixels(Vector2.zero, Vector2.new(Constants.cvwidth, Constants.cvheight)))
	
	
	return setmetatable({
		Canvas = Canvas,
		CursorObject = Cursor,
		Cursor = Vector2.zero,
		Constants = Constants,
		CanvasSize = CanvasSize
	}, 
	{
		__index = ScreenMethods
	})
end

return Screen;