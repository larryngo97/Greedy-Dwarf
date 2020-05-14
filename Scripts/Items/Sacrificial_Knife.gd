extends "res://Scripts/Items/item_Base.gd"

"""
The Sacrificial Knife lowers a player's health in exchange for a speed and 
strength bonus that is percentile. Note that it will remove more speed/strength
than it gives if equipped, fitting in with its sacrificial nature.
"""
var health_damage :int = 50
var max_health_debuff :int = 25
var strength_percent :int = 20
var speed_percent :int = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func apply_to_dwarf(the_player : Dwarf) -> void:
	the_player.sub_health(health_damage)
	the_player.lower_max_health(max_health_debuff)
	the_player.add_strength_and_speed(the_player.strength/strength_percent, the_player.base_speed/speed_percent)

func unapply_to_dwarf(the_player : Dwarf) -> void:
	the_player.raise_max_health_no_heal(max_health_debuff)
	the_player.sub_strength_and_speed(the_player.strength/strength_percent, the_player.base_speed/speed_percent)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
