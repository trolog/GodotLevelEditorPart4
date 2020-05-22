extends TextureRect

export(PackedScene) var this_scene
onready var object_cursor = get_node("/root/main/Editor_Object")

onready var cursor_sprite = object_cursor.get_node("Sprite")

export(bool) var tile = false
export var tile_id = 0

func _ready():
	connect("gui_input",self,"_item_clicked")
	pass # Replace with function body.


func _item_clicked(event):
	if(event is InputEvent):
		if(!tile):
			if(event.is_action_pressed("mb_left")):
				object_cursor.current_item = this_scene
				cursor_sprite.texture = texture
				Global.place_tile = false
		else:
			if(event.is_action_pressed("mb_left")):
				Global.place_tile = true
				Global.current_tile = tile_id
				#cursor_sprite.texture = null
				cursor_sprite.texture = texture
	pass
