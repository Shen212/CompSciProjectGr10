setscreen ("graphics:600;900")
View.Set ("offscreenonly")
%declare variables
var direction : array char of boolean
var xClaw := 0
var x1 := 100
var x2 := 300
var x3 := 500
var move1 := Rand.Int (3, 8)
var move2 := Rand.Int (3, 8)
var move3 := Rand.Int (3, 8)
var count : int
count := 0
loop
    x1 += move1
    x2 += move2
    x3 += move3

    if x1 > maxx then
	x1 := maxx
	move1 := -move1
    elsif x1 < 0 then
	x1 := 0
	move1 := -move1
    end if
    if x2 > maxx then
	x2 := maxx
	move2 := -move2
    elsif x2 < 0 then
	x2 := 0
	move2 := -move2
    end if
    if x3 > maxx then
	x3 := maxx
	move3 := -move3
    elsif x3 < 0 then
	x3 := 0
	move3 := -move3
    end if




    Input.KeyDown (direction)
    if direction (KEY_RIGHT_ARROW) then
	xClaw += 10
    elsif direction (KEY_LEFT_ARROW) then
	xClaw += -10
    elsif direction ('d') or direction ('D') then
	var down := 0
	var yMovement1, yMovement2, yMovement3 := 0
	var y1, y2, y3 := 0
	loop
	    drawfillbox (xClaw, maxy - 50 - down, xClaw + 75, maxy - down, white)
	    down += 1
	    drawline (xClaw + 37, maxy, xClaw + 37, maxy - down, 16)
	    drawfillbox (xClaw, maxy - 50 - down, xClaw + 75, maxy - down, 16)
	    exit when down = 850
	    View.Update
	    delay (1)
	end loop

	if xClaw + 37 > x1 - 50 and xClaw + 37 < x1 + 50 then
	    yMovement1 := 1
	    x1 := xClaw + 37
	    count += 1
	elsif xClaw + 37 > x2 - 50 and xClaw + 37 < x2 + 50 then
	    yMovement2 := 1
	    x2 := xClaw + 37
	    count += 1
	elsif xClaw + 37 > x3 - 50 and xClaw + 37 < x3 + 50 then
	    yMovement3 := 1
	    x3 := xClaw + 37
	    count += 1
	end if

	loop
	    cls
	    down -= 1
	    y1 += yMovement1
	    y2 += yMovement2
	    y3 += yMovement3

	    drawfilloval (x1, y1 + 50, 50, 50, 64)
	    drawfilloval (x2, y2 + 50, 50, 50, 63)
	    drawfilloval (x3, y3 + 50, 50, 50, 62)

	    drawline (xClaw + 37, maxy, xClaw + 37, maxy - down, 16)
	    drawfillbox (xClaw, maxy - 50 - down, xClaw + 75, maxy - down, 16)

	    exit when down = 0
	    View.Update
	    delay (3)
	end loop
    end if

    if xClaw >= maxx - 75 then
	xClaw := maxx - 75
    elsif xClaw <= 0 then
	xClaw := 0
    end if

    cls
    drawfillbox (xClaw, maxy - 50, xClaw + 75, maxy, 16)

    drawfilloval (x1, 50, 50, 50, 64)
    drawfilloval (x2, 50, 50, 50, 63)
    drawfilloval (x3, 50, 50, 50, 62)

    View.Update
    delay (20)
end loop
