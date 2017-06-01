setscreen ("graphics:600;900")
View.Set ("offscreenonly")
%declare variables
var direction : array char of boolean
var xClaw := 0
var x1 := 100
var x2 := 300
var x3 := 500
var xMove1 := Rand.Int (3, 8)
var xMove2 := Rand.Int (3, 8)
var xMove3 := Rand.Int (3, 8)
var count := 0
var grab : boolean
var grabberclawopen, grabberclawclosed, astronaut, pinball, ghost1, ghost2, ghost3, ghost4, ghost, hotdog : int
var ghostColour := Rand.Int (1, 4)

%Sprite shenanigans =============================================================================
grabberclawclosed := Pic.FileNew ("grabberclawclosed.bmp")
grabberclawclosed := Sprite.New (grabberclawclosed)
grabberclawopen := Pic.FileNew ("grabberclawopen.bmp")
grabberclawopen := Sprite.New (grabberclawopen)
hotdog := Pic.FileNew ("hotdawg.bmp")
hotdog := Sprite.New (hotdog)
astronaut := Pic.FileNew ("astronaut.bmp")
astronaut := Pic.Scale (astronaut, 81, 154)
astronaut := Sprite.New (astronaut)
if ghostColour = 1 then
    ghost := Pic.FileNew ("ghost_pink.bmp")
elsif ghostColour = 2 then
    ghost := Pic.FileNew ("ghost_green.bmp")
elsif ghostColour = 3 then
    ghost := Pic.FileNew ("ghost_blue.bmp")
elsif ghostColour = 4 then
    ghost := Pic.FileNew ("ghost_yellow.bmp")
end if
ghost := Sprite.New (ghost)

%================================================================================================

%Character Movement procedure ===================================================================
procedure characters
    x1 += xMove1
    x2 += xMove2
    x3 += xMove3

    if x1 > maxx - 147 then
	x1 := maxx - 147
	xMove1 := -xMove1
    elsif x1 < 0 then
	x1 := 0
	xMove1 := -xMove1
    end if
    if x2 > maxx - 81 then
	x2 := maxx - 81
	xMove2 := -xMove2
    elsif x2 < 0 then
	x2 := 0
	xMove2 := -xMove2
    end if
    if x3 > maxx - 60 then
	x3 := maxx - 60
	xMove3 := -xMove3
    elsif x3 < 0 then
	x3 := 0
	xMove3 := -xMove3
    end if

    Sprite.SetPosition (hotdog, x1, 0, false)
    Sprite.Show (hotdog)
    Sprite.SetPosition (astronaut, x2, 0, false)
    Sprite.Show (astronaut)
    Sprite.SetPosition (ghost, x3, 0, false)
    Sprite.Show (ghost)
    %drawfilloval (x1, 50, 50, 50, 64)
    %drawfilloval (x2, 50, 50, 50, 63)
    %drawfilloval (x3, 50, 50, 50, 62)
end characters
%==========================================================================================


loop

    %Key Inputs============================================================================

    Input.KeyDown (direction)
    if direction (KEY_RIGHT_ARROW) then
	xClaw += 10
    elsif direction (KEY_LEFT_ARROW) then
	xClaw += -10
    elsif direction ('d') or direction ('D') then
	%Claw moving sequence -------------------------------------------------------------
	var down := 0
	var yMove1, yMove2, yMove3 := 0
	var y1, y2, y3 := 0
	grab := false
	Sprite.Hide (grabberclawclosed)
	%Moving Down Loop ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	loop
	    down += 20
	    drawline (xClaw, maxy, xClaw, maxy - down, 16)
	    %drawfillbox (xClaw, maxy - 50 - down, xClaw + 75, maxy - down, 16)
	    Sprite.SetPosition (grabberclawopen, xClaw, maxy - 25 - down, true)
	    Sprite.Show (grabberclawopen)
	    characters
	    exit when down > 800
	    View.Update
	    delay (20)
	    cls
	end loop
	%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

	%Collision detection ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	if xClaw > x1 and xClaw < x1 + 90 then
	    yMove1 := 1
	    x1 := xClaw - 74
	    count += 1
	    grab := true
	elsif xClaw > x2 and xClaw < x2 + 81then
	    yMove2 := 1
	    x2 := xClaw - 40
	    count += 1
	    grab := true
	elsif xClaw > x3 and xClaw < x3 + 60 then
	    yMove3 := 1
	    x3 := xClaw - 30
	    count += 1
	    grab := true
	end if
	Sprite.Hide (grabberclawopen)
	%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

	%Up Movement^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	if grab = true then
	    loop
		cls
		down -= 1
		y1 += yMove1
		y2 += yMove2
		y3 += yMove3

		Sprite.SetPosition (hotdog, x1, y1, false)
		Sprite.Show (hotdog)
		Sprite.SetPosition (astronaut, x2, y2, false)
		Sprite.Show (astronaut)
		Sprite.SetPosition (ghost, x3, y3, false)
		Sprite.Show (ghost)
		%drawfilloval (x1, y1, 50, 50, 64)
		%drawfilloval (x2, y2, 50, 50, 63)
		%drawfilloval (x3, y3, 50, 50, 62)

		drawline (xClaw, maxy, xClaw, maxy - down, 16)
		Sprite.SetPosition (grabberclawclosed, xClaw, maxy - 25 - down, true)
		Sprite.Show (grabberclawclosed)

		exit when down = 0
		View.Update
		delay (3)
	    end loop
	elsif grab = false then
	    loop
		cls
		down -= 10
		drawline (xClaw, maxy, xClaw, maxy - down, 16)
		% drawfillbox (xClaw, maxy - 50 - down, xClaw + 75, maxy - down, 16)
		Sprite.SetPosition (grabberclawclosed, xClaw, maxy - 25 - down, true)
		Sprite.Show (grabberclawclosed)
		characters
		exit when down <= 0
		View.Update
		delay (20)
	    end loop
	end if
	%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    end if

    %-------------------------------------------------------------------------------

    %==============================================================================
    %Prevent claw from exiting screen ==============================================
    if xClaw >= maxx - 25 then
	xClaw := maxx - 25
    elsif xClaw <= 25 then
	xClaw := 25
    end if
    %==============================================================================

    %Draw objects =================================================================
    cls
    % drawfillbox (xClaw, maxy - 50, xClaw + 75, maxy, 16)
    Sprite.SetPosition (grabberclawclosed, xClaw, maxy - 25, true)
    Sprite.Show (grabberclawclosed)
    characters
    View.Update
    delay (20)
    %==============================================================================

end loop

Sprite.Free (grabberclawopen)
Sprite.Free (grabberclawclosed)
