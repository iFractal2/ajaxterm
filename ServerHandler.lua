local CE = script.Parent.ConstructorEvent
script.Parent:FindFirstChild("ClientHandler").Parent = game:GetService("StarterPack")
task.wait(3)
CE:FireAllClients()
