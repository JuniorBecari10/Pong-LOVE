windowWidth = 240 * 3
windowHeight = 160 * 3

paddleWidth = 150
paddleHeight = 15

ballSize = 20

paddleSpeed = 5
ballSpeed = 6

playerX = (windowWidth / 2) - (paddleWidth / 2)
enemyX = (windowWidth / 2) - (paddleWidth / 2)

playerY = windowHeight - paddleHeight
enemyY = 0

ballX = (windowWidth / 2) - (ballSize / 2)
ballY = (windowHeight / 2) - (ballSize / 2)

dx = 0
dy = 0

playerPoints = 0
enemyPoints = 0

-- aabb
function collided(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
           x1 + w1 > x2 and
           y1 < y2 + h2 and
           y1 + h1 > y2
end

function reset()
    playerX = (windowWidth / 2) - (paddleWidth / 2)
    enemyX = (windowWidth / 2) - (paddleWidth / 2)
    
    playerY = windowHeight - paddleHeight
    enemyY = 0
    
    ballX = (windowWidth / 2) - (ballSize / 2)
    ballY = (windowHeight / 2) - (ballSize / 2)
    
    dx = math.random() + math.random(-1, 1)
    dy = math.random() + math.random(-1, 1)
end

function love.load()
    love.window.setMode(windowWidth, windowHeight, {})
    love.window.setTitle("Pong")
    
    dx = math.random() + math.random(-1, 1)
    dy = math.random() + math.random(-1, 1)
    
    font = love.graphics.newImageFont("font.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
    
    love.graphics.setFont(font)
end

function love.update(dt)
    if (love.keyboard.isDown("left", "d")) then
        if (playerX < 0) then return end
        
        playerX = playerX - paddleSpeed
    elseif (love.keyboard.isDown("right", "a")) then
        if (playerX + paddleWidth > windowWidth) then return end
        
        playerX = playerX + paddleSpeed
    end
    
    if (love.keyboard.isDown("f")) then
        reset()
    end
    
    if (love.keyboard.isDown("r")) then
        playerPoints = 0
        enemyPoints = 0
        
        reset()
    end
    
    ballX = ballX + (dx * ballSpeed)
    ballY = ballY + (dy * ballSpeed)
    
    if collided(playerX, playerY, paddleWidth, paddleHeight, ballX, ballY, ballSize, ballSize) or collided(enemyX, enemyY, paddleWidth, paddleHeight, ballX, ballY, ballSize, ballSize) then
        dy = dy * -1
    end
    
    if ballX < 0 or ballX + ballSize > windowWidth then
        dx = dx * -1
    end
    
    if ballY < 0 or ballY + ballSize > windowHeight then
        if ballY < 0 then
            playerPoints = playerPoints + 1
        elseif ballY + ballSize > windowHeight then
            enemyPoints = enemyPoints + 1
        end
        
        reset()
    end
    
    if enemyX + paddleWidth / 2 < ballX + ballSize / 2 then
        enemyX = enemyX + 1 -- 1 hardcoded
    end
    
    if enemyX + paddleWidth / 2 > ballX + ballSize / 2 then
        enemyX = enemyX - 1
    end
end

function love.draw()
    -- draw player
    love.graphics.setColor(255, 255, 255) -- white
    love.graphics.rectangle("fill", playerX, playerY, paddleWidth, paddleHeight)
    
    -- draw enemy
    love.graphics.setColor(255, 0, 0) -- red
    love.graphics.rectangle("fill", enemyX, enemyY, paddleWidth, paddleHeight)
    
    -- draw ball
    love.graphics.setColor(255, 255, 255) -- white
    love.graphics.rectangle("fill", ballX, ballY, ballSize, ballSize)
    
    -- draw points
    love.graphics.print("Player: " .. playerPoints .. "\n" .. "Enemy: " .. enemyPoints, 10, 30) -- 20
    --love.graphics.print("Enemy: " .. enemyPoints, 10, 50)
end
