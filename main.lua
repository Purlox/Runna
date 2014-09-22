screenHeight = love.graphics.getHeight()
screenWidth = love.graphics.getWidth()

floorX = 0
floorY = screenHeight - 150

playerX = 250
playerY = screenHeight - 100 - 150

moveSpeed = 250

-- 0 = not jumping  1 = jumping and falling  2 = end of jump
jumpPhase = 0
-- these two you can tinker with however you want to get what you want
jumpHeight = 100
jumpTimeLength = 0.5

-- these are currently set to be relative to the given height and jump time
jumpVelocityStart = 4 * jumpHeight / jumpTimeLength
jumpVelocityCurrent = jumpVelocityStart
jumpGravity = 2 * jumpVelocityStart  / jumpTimeLength


function love.load()
	player = love.graphics.newImage("images/player.png")
	floor = love.graphics.newImage("images/floor.png")
end


function love.draw()
    love.graphics.print("This is modern art!", 10, 10)
	
	love.graphics.setColor(0, 0, 200)
	love.graphics.draw(player, playerX, playerY)
	love.graphics.setColor(255, 255, 255)
	
	love.graphics.draw(floor, floorX, floorY)
	love.graphics.draw(floor, floorX + 1024, floorY)
	if floorX + 2048 < screenWidth then
		love.graphics.draw(floor, floorX + 2048, floorY)
	end
end


function love.update(dt)
	jump(dt)
	mooove(dt)
end


function love.keypressed(key, isrepeat)
	if key == " " and jumpPhase == 0 then
		jumpPhase = 1
	end
end


function jump(deltaTime)
	if jumpPhase == 0 then
		return
	end
	
	-- Jumping and Falling
	if jumpPhase == 1 then		
		jumpVelocityCurrent = jumpVelocityCurrent - jumpGravity * deltaTime
		playerY = playerY - jumpVelocityCurrent * deltaTime
		
		if playerY >= floorY - 100 then
			jumpPhase = 2
			playerY = floorY - 100
		end
	end
	
	-- Recovering/Ending jump
	if jumpPhase == 2 then
		if love.keyboard.isDown(" ") then
			jumpPhase = 1
		else
			jumpPhase = 0
		end
		
		jumpVelocityCurrent = jumpVelocityStart
	end
end


function mooove(deltaTime)
	floorX = floorX - moveSpeed * deltaTime
	
	if -floorX > 1024 then
		floorX = floorX + 1024
	end
end	
