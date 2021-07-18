local StopMove = {}
StopMove.optionEnable = Menu.AddOption({"Awareness", "BreakDance","On/Off"}, "Activate", "")
StopMove.optionKey = Menu.AddKeyOption({"Awareness", "BreakDance","Button"},"Key for activate",Enum.ButtonCode.KEY_D)
local tick = 0

function StopMove.OnGameStart()
  local tick = 0
end

function StopMove.OnUpdate()
  if not Menu.IsEnabled(StopMove.optionEnable) then return end
  local myHero = Heroes.GetLocal()
  if not myHero then return end 
  local degree = 180 
  local timign = 0.15  
  if Menu.IsKeyDown(StopMove.optionKey) then
    if tick <= GameRules.GetGameTime() then
      local angle = Entity.GetRotation(myHero)
      local angleOffset = Angle(0, 45+degree, 0)
      angle:SetYaw(angle:GetYaw() + angleOffset:GetYaw())
      local x,y,z = angle:GetVectors()
      local direction = x + y + z
      direction:SetZ(0)
      direction:Normalize()
      direction:Scale(1)
      local origin = NPC.GetAbsOrigin(myHero)
      tohere = origin + direction
      StopMove.NeedMove(myHero , tohere)
      tick = GameRules.GetGameTime() + timign
    end
  end
end

function StopMove.NeedMove(npc , vectore)
  Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, npc, vectore, nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY)
end

return StopMove