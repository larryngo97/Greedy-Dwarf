extends KinematicBody2D

onready var player = get_node("/root/World/Dwarf")
const Dwarf = preload("res://Scripts/Actors/Dwarf.gd")
onready var music1 = get_node("/root/World/Dwarf/music/normal")
onready var music2 = get_node("/root/World/Dwarf/music/boss")
var minimap_icon = "dragon"
var timer = null

var velocity = Vector2()
export var speed = 1200

func _ready():
	timer = Timer.new()
	add_child(timer)
	
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.set_wait_time(0.5)
	timer.set_one_shot(false)
	timer.start()

func _process(delta):
	if player.position.x > position.x:
		$Sprite.flip_h = true
		velocity.x += speed
	if player.position.x < position.x:
		$Sprite.flip_h = false
		velocity.x -= speed
	if player.position.y > position.y:
		velocity.y += speed
	if player.position.y < position.y:
		velocity.y -= speed
	


func _physics_process(delta):
	velocity = move_and_slide(velocity * delta)


func _on_Area2D_body_entered(body):
	if body is Dwarf:
		get_tree().reload_current_scene()
	pass # Replace with function body.



func _on_Timer_timeout():
	if $visibility.is_on_screen():
		music1.stop()
		if !music2.playing:
			music2.play()
	else:
		music2.stop()
		if !music1.playing:
			music1.play()
