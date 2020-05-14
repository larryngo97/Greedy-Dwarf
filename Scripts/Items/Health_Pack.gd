extends "res://Scripts/Items/Item_Base.gd"

"""
This class is meant to be used for health packs that will be placed around
the dragon's lair and increase the player's current health by the 
_health_boost_value, but to no more than the Player's max health
"""
const _health_boost_value = 50



# Called when the node enters the scene tree for the first time.
func _ready():
	_set_data(1,0,"Health Pack")

# apply_to_player implemented to grant one-time health boost to player
func apply_to_dwarf(the_player : Dwarf) -> void:
	the_player.add_health(_health_boost_value)

# because Health_Pack does not provide a continuous buff to the player,
# this method is left empty and implemented only for sake of consistency
func unapply_to_dwarf(the_player : Dwarf) -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Health_Pack_body_entered(body):
	if body is Dwarf:
		apply_to_dwarf(body)
		emit_signal("removed", self)
		queue_free()
