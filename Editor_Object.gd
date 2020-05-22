extends Node2D

var can_place = true
var is_panning = true;
onready var level = get_node("/root/main/Level")
onready var editor = get_node("/root/main/cam_container")
onready var editor_cam = editor.get_node("Camera2D")

onready var tile_map : TileMap = level.get_node("TileMap")

export var cam_spd = 10
var current_item

func _ready():
	editor_cam.current = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_global_mouse_position()
	
	if !Global.place_tile:
		if(current_item != null and can_place and Input.is_action_just_pressed("mb_left")):
			var new_item = current_item.instance()
			level.add_child(new_item)
			new_item.global_position = get_global_mouse_position()
	else:
		if(can_place):
			if Input.is_action_pressed("mb_left"):
				place_tile()
			if Input.is_action_pressed("mb_right"):
				remove_tile()
	
	move_editor()
	
	is_panning = Input.is_action_pressed("mb_middle")
	pass
	
func place_tile():
	var mousepos = tile_map.world_to_map(get_global_mouse_position())
	tile_map.set_cell(mousepos.x,mousepos.y,Global.current_tile)

func remove_tile():
	var mousepos = tile_map.world_to_map(get_global_mouse_position())
	tile_map.set_cell(mousepos.x,mousepos.y,-1)
	
func move_editor():
	if Input.is_action_pressed("w"):
		editor.global_position.y -= cam_spd
	if Input.is_action_pressed("a"):
		editor.global_position.x -= cam_spd
	if Input.is_action_pressed("s"):
		editor.global_position.y += cam_spd
	if Input.is_action_pressed("d"):
		editor.global_position.x += cam_spd
	pass

func _unhandled_input(event):
	if(event is InputEventMouseButton):
		if(event.is_pressed()):
			if(event.button_index == BUTTON_WHEEL_UP):
				editor_cam.zoom -= Vector2(0.1,0.1)
			if(event.button_index == BUTTON_WHEEL_DOWN):
				editor_cam.zoom += Vector2(0.1,0.1)
	if(event is InputEventMouseMotion):
		if(is_panning):
			editor.global_position -= event.relative * editor_cam.zoom
	pass
