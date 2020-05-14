extends MarginContainer

export (NodePath) var player
export var zoom = 1

onready var grid = $MarginContainer/Grid
onready var player_marker = $MarginContainer/Grid/PlayerIcon
onready var dragon_marker = $MarginContainer/Grid/DragonIcon
onready var item_marker = $MarginContainer/Grid/ItemIcon

onready var icons = {"dragon": dragon_marker, "item": item_marker}

var grid_scale
var markers = {}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	player_marker.position = grid.rect_size / 2
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)
	
func _process(delta):
	if !player:
		return
	player_marker.rotation = get_node(player).rotation + PI / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
