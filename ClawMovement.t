setscreen ("graphics:600;900")
View.Set ("offscreenonly")
%declare variables
var direction : array char of boolean
var x := 0

loop
    Input.KeyDown (direction)
    if direction (KEY_RIGHT_ARROW) then
	x += 10
    elsif direction (KEY_LEFT_ARROW) then
	x += -10
    end if

    if x >= maxx-75 then
	x := maxx-75
    elsif  x <= 0 then
	x := 0
    end if

    cls
    drawfillbox (x, maxy - 50, x + 75, maxy, 16)
    View.Update
    delay (20)
end loop
