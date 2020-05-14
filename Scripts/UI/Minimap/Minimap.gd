extends MarginContainer

export (NodePath) var player
export var zoom = 1.5

onready var grid = $MarginContainer/Grid
onready var player_marker = $MarginContainer/Grid/PlayerIcon
onready var dragon_marker = $MarginContainer/Grid/DragonIcon
onready var chest_marker = $MarginContainer/Grid/ChestIcon
onready var buff_marker = $MarginContainer/Grid/BuffIcon

onready var icons = {"dragon": dragon_marker, "chest": chest_marker, "buff": buff_marker}

var grid_scale
var markers = {}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
		
# Called when the node enters the scene tree for the first time.
func _ready():
	player_marker.position = grid.rect_size / 2
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		var new_marker = icons[item.minimap_icon].duplicate()
		grid.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker
	
func _process(delta):
	if !player:
		return
	player_marker.rotation = get_node(player).rotation + PI / 2
	for item in markers:
		var obj_pos = (item.position - get_node(player).position) * grid_scale + grid.rect_size / 2
		if grid.get_rect().has_point(obj_pos + grid.rect_position):
			markers[item].scale = Vector2(0.05,0.05)
		else:
			markers[item].scale = Vector2(0.03, 0.03)
		obj_pos.x = clamp(obj_pos.x, 0, grid.rect_size.x)
		obj_pos.y = clamp(obj_pos.y, 0, grid.rect_size.y)
		markers[item].position = obj_pos
		
func _on_object_removed(object):
	# Removes a marker from the map. Connect to object's "removed" signal.
	if object in markers:
		markers[object].queue_free()
		markers.erase(object)


	

