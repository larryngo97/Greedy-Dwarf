extends "res://Scripts/Items/item_Base.gd"

"""
The Two Ring is a powerful item. It subtracts 200 points from the player,
however it grants a significant strength buff, minor flat speed buff, and also
raises the max health of the player, making it a question of whether the player
wants to get the points or the buff that will help get more points
"""

var health_buff :int = 50
var strength_buff :int = 100
var speed_buff :int = 25



# Called when the node enters the scene tree for the first time.
func _ready():
	_set_data(1,-200,"Two Ring")
	
func apply_to_dwarf(the_player : Dwarf) -> void:
	the_player.add_strength_and_speed(strength_buff, speed_buff)
	the_player.raise_max_health(health_buff)

func unapply_to_dwarf(the_player : Dwarf) -> void:
	the_player.sub_strength_and_speed(strength_buff, speed_buff)
	the_player.lower_max_health(health_buff)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_true_player_detector_body_entered(body):
	apply_to_dwarf(body)
	pass # Replace with function body.
