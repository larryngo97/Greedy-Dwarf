extends KinematicBody2D
#const Treasure_Base = preload("res://Scripts/Items/Treasure_Base.gd")

export (int) var base_speed = 200
export (int) var speed = base_speed
export (int) var max_health = 100
export (int) var health = 100
export (int) var strength = 50
export (int) var score = 0
export (int) var chests = 0
export (int) var current_weight_carried = 0

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$Sprite.flip_h = false
		$Sprite.play("Run")
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$Sprite.flip_h = true
		$Sprite.play("Run")
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$Sprite.play("Run")
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		$Sprite.play("Run")
	if(!Input.is_action_pressed("move_up") && !Input.is_action_pressed("move_down") && !Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left")):
		$Sprite.play("Idle")
	velocity = velocity.normalized() * speed
		
func add_speed(addedSpeed :int) -> void:
	base_speed += addedSpeed
	calculate_speed()

func sub_speed(subbedSpeed :int) -> void:
	base_speed -= subbedSpeed
	calculate_speed()

func add_strength(addedStrength :int) -> void:
	strength += addedStrength
	calculate_speed()

func sub_strength(subbedStrength :int) -> void:
	strength -= subbedStrength
	calculate_speed()

func add_strength_and_speed(addedStrength :int, addedSpeed :int) -> void:
	strength += addedStrength
	base_speed += addedSpeed
	calculate_speed()

func sub_strength_and_speed(subbedStrength :int, subbedSpeed :int) -> void:
	strength -= subbedStrength
	base_speed -= subbedSpeed
	calculate_speed()

func add_health(addedHealth : int) -> void:
	health += addedHealth
	if health > max_health:
		health = max_health

func sub_health(subbedHealth : int) -> void:
	health -= subbedHealth
	if health <= 0:
		queue_free() #TODO: full death

# used when raising max health and also giving the bonus health
func raise_max_health(addedMax :int) -> void:
	max_health += addedMax
	add_health(addedMax)

#used when health max should be raised without adding the extra health
func raise_max_health_no_heal(addedMax :int) -> void:
	max_health += addedMax

func lower_max_health(subbedMax :int) -> void:
	max_health -= subbedMax
	sub_health(0) # don't want to kill player if their health is low, so just sub 0 to fix any overflow
	
func getScore() -> int:
	return score

"""
func add_treasure(treasure : Treasure_Base) -> void:
	score += treasure.value()
	current_weight_carried += treasure.weight()
	calculate_speed()


func remove_treasure(treasure : Treasure_Base) -> void:
	score -= treasure.value()
	current_weight_carried -= treasure.weight()
	calculate_speed()
"""
	
func calculate_speed() -> void:
	speed = base_speed - (current_weight_carried / strength)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _on_Item_Detector_body_entered(body):
	# speed += 50 removed plus speed from hitting walls
	# should eventually be useful with the inventory though
	pass
