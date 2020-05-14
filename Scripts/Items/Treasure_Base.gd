extends Node2D
const Dwarf = preload("res://Scripts/Actors/Dwarf.gd")
onready var sound = get_node("/root/World/Dwarf/sound/collect")

export var _weight : int
export var _value : int
export var _name : String
signal removed
export var minimap_icon = "chest"

# getter methods
func weight() -> int:
	return _weight
func value() -> int:
	return _value
func name() -> String:
	return _name

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# method to get all the variable setting in one easy place
func _set_data(the_weight : int, the_value : int, the_name: String) -> void:
	_weight = the_weight
	_value = the_value
	_name = the_name
"""
# abstract method for what happens when teh player picks this up
# possibility that this will just contain a dequeue() and go to the player 
# implemented here due to similarities, but passing for now
func _on_player_entered(area : Area2D) -> void :
	pass
"""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_parent().get_parent().get_node("Dwarf")
	var scoreNode = get_parent().get_parent().get_node("UI/Score/text")
	scoreNode.text = "Score: %s" % player.getScore()

#func _test_application_of_score(player :Dwarf) -> void:
#	player.score += _value

func apply_weight_and_value(the_player :Dwarf) -> void:
	the_player.score += _value
	the_player.current_weight_carried += _weight
	the_player.calculate_speed()

func deapply_weight_and_value(the_player :Dwarf) -> void:
	the_player.score -= _value
	the_player.current_weight_carried -= _weight
	the_player.calculate_speed()


func _on_Treasure_Base_body_entered(body):
	if body is Dwarf:
		sound.play()
		apply_weight_and_value(body)
		emit_signal("removed", self)
		queue_free()
