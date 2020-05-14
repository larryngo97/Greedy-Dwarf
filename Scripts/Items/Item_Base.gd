extends "res://Scripts/Items/Treasure_Base.gd"

"""
Item_Base is meant to be use as an abstract class extended by different
types of usuable items. The apply_to_dwarf and unapply_to_dwarf
methods should be implemented in each child of Item_Base 
to apply and unapply the item's effect to the player
"""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# used for different implementations of each type of item
func apply_to_dwarf(the_player : Dwarf) -> void:
	the_player.speed += 500
	pass

func unapply_to_dwarf(the_player : Dwarf) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Item_Base_body_entered(body):
	if body is Dwarf:
		emit_signal("removed", self)
		queue_free()
