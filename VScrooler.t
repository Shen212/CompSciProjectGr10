% Sidescroller

setscreen ("graphics:600;950")
View.Set ("offscreenonly")
var y, xChar, yChar, count, loopCount, delayTimer, font1, scrollerBG : int
var obstacL1, obstacR1, obstacY1, obstacL2, obstacR2, obstacY2, obstacL3, obstacR3, obstacY3, obstacL4, obstacR4, obstacY4, obstacI1, obstacI2, obstacI3, obstacI4 : int
var arrow : array char of boolean
font1 := Font.New ("MS Serif:20:bold")
y := 0
xChar := 0
yChar := 0
loopCount := 0
count := 3
delayTimer := 5


% Background Creation$$$$$$$$$$$$$$$$$$Background Creation
scrollerBG := Pic.FileNew ("wardog5.jpg")
scrollerBG := Pic.Scale (scrollerBG, 600, 900)
Pic.Draw (scrollerBG, 0, 0, picMerge)
% Background Creation$$$$$$$$$$$$$$$$$$$Background Creation


%Obstacle Presets++++++++++++++++++++++++++++++++++++++++++++++++Obstacle Presets
%obstacle 1
obstacL1 := 0
obstacR1 := 300
obstacY1 := 900
% obstacle 2
obstacL2 := 250
obstacR2 := 500
obstacY2 := 700
% obstacle 3
obstacL3 := 0
obstacR3 := 300
obstacY3 := 500
% obstacle 4
obstacL4 := 400
obstacR4 := 600
obstacY4 := 300
%Obstacle Presets++++++++++++++++++++++++++++++++++++++++++++++++Obstacle Presets


% game loop ***********************************************************************************
loop

    %Top Bar-----------------------------------------------top Bar
    drawfillbox (0, 900, 600, 950, brightred)
    Font.Draw ("Score " + intstr (loopCount div 40), maxx div 2 - 30, 910, font1, 0)
    Font.Draw ("Lives " + intstr (count), 100, 910, font1, 0)
    %Top Bar------------------------------------------------top Bar


    % Draws boxes---------------------------------------------------------------------- obstacles
    % opbstacle
    drawfillbox (obstacL1, obstacY1 - 50, obstacR1, obstacY1, blue)
    obstacY1 -= 2
    if obstacY1 = 0 then
	obstacY1 := 900
	obstacI1 := Rand.Int (1, 3)
	if obstacI1 = 1 then
	    obstacL1 := 0
	    obstacR1 := 300
	elsif obstacI1 = 2 then
	    obstacL1 := 100
	    obstacR1 := 400
	elsif obstacI1 = 3 then
	    obstacL1 := 0
	    obstacR1 := 150
	end if
    end if

    % opbstacle 2---------------------------------------------------
    drawfillbox (obstacL2, obstacY2 - 50, obstacR2, obstacY2, blue)
    obstacY2 -= 2
    if obstacY2 = 0 then
	obstacY2 := 900
	obstacI2 := Rand.Int (1, 3)
	if obstacI2 = 1 then
	    obstacL2 := 250
	    obstacR2 := 500
	elsif obstacI2 = 2 then
	    obstacL2 := 280
	    obstacR2 := 550
	elsif obstacI2 = 3 then
	    obstacL2 := 250
	    obstacR2 := 450
	end if
    end if

    % opbstacle 3-------------------------------------------------
    drawfillbox (obstacL3, obstacY3 - 50, obstacR3, obstacY3, blue)
    obstacY3 -= 2
    if obstacY3 = 0 then
	obstacY3 := 900
	obstacI3 := Rand.Int (1, 3)
	if obstacI3 = 1 then
	    obstacL3 := 0
	    obstacR3 := 350
	elsif obstacI3 = 2 then
	    obstacL3 := 20
	    obstacR3 := 400
	elsif obstacI3 = 3 then
	    obstacL3 := 300
	    obstacR3 := 500
	end if
    end if

    % opbstacle 4 -------------------------------------------------
    drawfillbox (obstacL4, obstacY4 - 50, obstacR4, obstacY4, blue)
    obstacY4 -= 2
    if obstacY4 = 0 then
	obstacY4 := 900
	obstacI4 := Rand.Int (1, 3)
	if obstacI4 = 1 then
	    obstacL4 := 300
	    obstacR4 := 600
	elsif obstacI4 = 2 then
	    obstacL4 := 400
	    obstacR4 := 600
	elsif obstacI4 = 3 then
	    obstacL4 := 350
	    obstacR4 := 550
	end if
    end if

    View.Update
    %---------------------------------------------------------------------------------- obstacles


    %character movement---------------------------------------------- char movement
    delay (delayTimer)
    cls
    Input.KeyDown (arrow)
    if arrow (KEY_LEFT_ARROW) then
	xChar -= 4
    elsif arrow (KEY_RIGHT_ARROW) then
	xChar += 4
    elsif arrow (KEY_UP_ARROW) then
	yChar += 4
    elsif arrow (KEY_DOWN_ARROW) then
	yChar -= 4
    end if


    if xChar < 0 then
	xChar := 0
    elsif xChar + 50 > maxx then
	xChar := maxx - 50

    elsif yChar < 0 then
	yChar := 0
    elsif yChar + 50 > maxy then
	yChar := maxy - 50
    end if


    Pic.Draw (scrollerBG, 0, 0, picMerge)
    drawfillbox (0 + xChar, 0 + yChar, 50 + xChar, 50 + yChar, black)

    %----------------------------------------------------------------- char movement

    % Colision ===============================================================================================colision
    if yChar + 50 >= obstacY1 - 50 and yChar + 50 <= obstacY1 and xChar + 50 >= obstacL1 and xChar <= obstacR1 then
	count -= 1
	obstacL1 := 610
	obstacR1 := 620
    elsif yChar + 50 >= obstacY2 - 50 and yChar + 50 <= obstacY2 and xChar + 50 >= obstacL2 and xChar <= obstacR2 then
	count -= 1
	obstacL2 := 610
	obstacR2 := 620
    elsif yChar + 50 >= obstacY3 - 50 and yChar + 50 <= obstacY3 and xChar + 50 >= obstacL3 and xChar <= obstacR3 then
	count -= 1
	obstacL3 := 610
	obstacR3 := 620
    elsif yChar + 50 >= obstacY4 - 50 and yChar + 50 <= obstacY4 and xChar + 50 >= obstacL4 and xChar <= obstacR4 then
	count -= 1
	obstacL4 := 610
	obstacR4 := 620
    end if
    exit when count = 0
    % Colision ===============================================================================================colision


    % timer ^&^%&%&%&&%^%$&&$^&&$&$^&^&$&$&^&^&$^&$^#&#&$^&$^&&^&$%^&
    
    loopCount += 1
    if loopCount = 1000 then
	delayTimer := 4
    elsif loopCount = 2000 then
	delayTimer := 3
    elsif loopCount = 2500 then
	delayTimer := 2
    elsif loopCount = 3000 then
	delayTimer := 1
    end if
    % timer ^&^%&%&%&&%^%$&&$^&&$&$^&^&$&$&^&^&$^&$^#&#&$^&$^&&^&$%^&
    
end loop
% end game loop ***********************************************************************************


cls
put "Game Over"

