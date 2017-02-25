-- Lua's typical OO style is a hack on top of 
-- tables and metatables.  This file is just to 
-- remind me how to do it.

-- ----------------------------------------------------
-- Base class, set defaults..
Animal = { 
   type = "n/a",
   says = "n/a",
}
-- ... and set __index to itself, so this table can be used as
-- the metatable for all instances.
Animal.__index=Animal

function Animal.new(t,s)
  a = setmetatable({ type=t, says=s },  Animal )
  return a
end

function Animal:greet()
  return string.format("I'm a %s who says '%s'!",self.type, self.says)
end

function Animal:walk()
   return "tip toe" .. self:greet()
end

-- ----------------------------------------------------
-- derived class... metatable is parent class
BigAnimal = setmetatable({ }, Animal)

-- set its own index to itself
BigAnimal.__index = BigAnimal

function BigAnimal.new(t,s)
  a = setmetatable({ type=t, says=s }, BigAnimal)
  return a
end

function BigAnimal:why()
  return "Because I'm HUGE!"
end

function BigAnimal:greet() 
  return string.format("I'm a LARGE %s who says '%s'!", self.type, self.says)
end


cat = Animal.new('cat','meow')
lion = BigAnimal.new('lion','roar')



   
