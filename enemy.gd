extends CharacterBody2D

@export var speed := 55.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
 
var player = null 
var player_chase = false
var player_inattack_range = false

func _physics_process(delta):
	if player_inattack_range:
		animation_player.play("Attack")
		return
	elif player_chase:
		
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		animated_sprite.play("RUN")
	else:
		animated_sprite.play("IDLE")
		


func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null 
	player_chase = false

func enemy():
	pass


func _on_attack_range_body_entered(body: Node2D) -> void:
	print("Something entered attack range: ", body.name)
	player_inattack_range = true


func _on_attack_range_body_exited(body: Node2D) -> void:
	player_inattack_range = false 
