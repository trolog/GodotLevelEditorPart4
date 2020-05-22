extends Area2D

var start_pos = Vector2(0,0)
var init = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !init:
		start_pos = global_position
		init = true
		
	if(Global.playing):
		global_position.x += 3
	else:
		global_position = start_pos
	
	pass
