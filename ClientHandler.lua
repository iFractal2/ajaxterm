local Event = workspace.ScreenModule.ConstructorEvent :: RemoteEvent
local CAS = game:GetService("ContextActionService")
local InputMap = require(workspace.ScreenModule.InputMap)

Event.OnClientEvent:Connect(function()
	Screen = require(workspace.ScreenModule).new(Vector2.new(100, 30), game.Players.LocalPlayer);
	Screen:stdout('Hello World!')
	Screen:stdout('\nHello Again!')
	--Screen:ShiftUp(8)
	Screen:AllowInput()
end)

local printInput = function(_, inputState: Enum.UserInputState, io: InputObject)
	if inputState ~= Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Pass
	end
	
	local Code = io.KeyCode.Value
	if InputMap[Code] and InputMap[Code][2] == false then
		Screen:stdout(InputMap[Code][1])
	end
	
end

CAS:BindActionAtPriority(
	"InputHandler",
	printInput,
	false,
	Enum.ContextActionPriority.High.Value + 10,
	Enum.UserInputType.Keyboard
)