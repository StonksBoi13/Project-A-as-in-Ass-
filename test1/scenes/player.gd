# Attach this script to your Player (CharacterBody2D)
extends CharacterBody2D

# Movement speed
@export var speed: float = 200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var directions = ["up","right","down","left"]
var char_dir = "down"


func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO


	if Input.is_action_pressed("ui_up"):
		if Input.is_action_pressed("ui_right"):
			animated_sprite.animation = "run_up"
			direction.y -= 1*speed
			direction.x += 1*speed
			char_dir = directions[0]
		elif Input.is_action_pressed("ui_left"):
			animated_sprite.animation = "run_up"
			direction.y -= 1*speed
			direction.x -= 1*speed
			char_dir = directions[0]
		else:
			animated_sprite.animation = "run_up"
			direction.y -= 1*speed
			char_dir = directions[0]
		
	if Input.is_action_just_released("ui_up"):
		animated_sprite.animation="idle_up"
		
		
	if Input.is_action_pressed("ui_down"):
		if Input.is_action_pressed("ui_right"):
			animated_sprite.animation = "run_down"
			direction.y += 1*speed
			direction.x += 1*speed
			char_dir = directions[2]
		elif Input.is_action_pressed("ui_left"):
			animated_sprite.animation = "run_down"
			direction.y += 1*speed
			direction.x -= 1*speed
			char_dir = directions[2]
		else:
			animated_sprite.animation = "run_down"
			direction.y += 1*speed
			char_dir = directions[2]
	if Input.is_action_just_released("ui_down"):
		animated_sprite.animation="idle_down"
		
		
	if Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_down"):
		animated_sprite.animation = "run_left"
		direction.x -= 1*speed
		char_dir = directions[3]
	if Input.is_action_just_released("ui_left"):
		animated_sprite.animation="idle_left"
		
		
		
	if Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_down"):
		animated_sprite.animation = "run_right"
		direction.x += 1*speed
		char_dir = directions[1]
	if Input.is_action_just_released("ui_right"):
		animated_sprite.animation="idle_right"
		
	
	
	if Input.is_action_pressed("ui_hit"):
		if char_dir == directions[0]:
			animated_sprite.animation = "attack_up"
		elif char_dir == directions[1]:
			animated_sprite.animation = "attack_right"
		elif char_dir ==directions[2]:
			animated_sprite.animation = "attack_down"
		elif char_dir == directions[3]:
			animated_sprite.animation = "attack_left"
		
		
	
	


	# Normalize so diagonal movement isn't faster
	direction = direction.normalized()

	# Apply velocity
	velocity = direction * speed
	move_and_slide()
	
	


func _on_animated_sprite_2d_animation_looped() -> void:
	if animated_sprite.animation == "attack_up":
		animated_sprite.animation = "idle_up"
	elif animated_sprite.animation == "attack_left":
		animated_sprite.animation="idle_left"
	elif animated_sprite.animation == "attack_down":
		animated_sprite.animation = "idle_down"
	elif animated_sprite.animation == "attack_right":
		animated_sprite.animation = "idle_right"
	else:
		pass
		
		
		#u r donkey
