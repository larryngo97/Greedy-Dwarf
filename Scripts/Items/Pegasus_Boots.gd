extends "res://Scripts/Items/Item_Base.gd"

"""
Pegasus Boots are a usuable item that increases the speed of the player
when in the player's inventory.
"""
const _speed_bonus = 40 # constant for the spped bonus these boots offer


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_data(1,0,"Pegasus Boots")

# implement the abstract method to increase player's spped
func apply_to_dwarf(the_player : Dwarf) -> void:
	the_player.add_speed(_speed_bonus)

# when removed, pegasus boots remove speed bonus
func unapply_to_dwarf(the_player : Dwarf) -> void:
	the_player.add_speed(_speed_bonus)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Pegasus_Boots_body_entered(body):
	if body is Dwarf:
		apply_to_dwarf(body)
		emit_signal("removed", self)
		queue_free()
