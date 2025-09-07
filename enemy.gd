extends CharacterBody2D

@export var speed := 55.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
<<<<<<< HEAD
 
=======

>>>>>>> e1e473d5ac04893df454a6ce5aeb597f2778e088
var player = null 
var player_chase = false
var player_inattack_range = false

<<<<<<< HEAD
func _physics_process(delta):
	if player_inattack_range:
=======
@export var HP: int = MaxHP : set = set_hp, get = get_hp
var is_alive = true
@export var MaxHP: int = 3

var  knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var is_hurt: bool = false 
var is_attacking: bool = false



func get_hp():
	return HP

func set_hp(value) :
	if value != HP :
		HP = clamp(value, 0 ,MaxHP)

func _physics_process(delta):
	
	if is_hurt:
		animated_sprite.play("HURT")
		return
	
	if is_attacking:
		return
	
	if knockback_timer > 0.0 :
		velocity = knockback
		knockback_timer -= delta
		move_and_slide()
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
		return
	
	if player_inattack_range:
		is_attacking = true
>>>>>>> e1e473d5ac04893df454a6ce5aeb597f2778e088
		animation_player.play("Attack")
		return
	elif player_chase:
		
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		animated_sprite.play("RUN")
	else:
		animated_sprite.play("IDLE")
		


<<<<<<< HEAD
=======

>>>>>>> e1e473d5ac04893df454a6ce5aeb597f2778e088
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null 
	player_chase = false

<<<<<<< HEAD
func enemy():
	pass

=======
>>>>>>> e1e473d5ac04893df454a6ce5aeb597f2778e088

func _on_attack_range_body_entered(body: Node2D) -> void:
	print("Something entered attack range: ", body.name)
	player_inattack_range = true


func _on_attack_range_body_exited(body: Node2D) -> void:
	player_inattack_range = false 
<<<<<<< HEAD
=======



func take_damage(damage):
	if !is_alive :
		return
	self.HP -= damage
	print ("Enemy took", damage, "damage !", "Health = ", HP)
	
	if HP <= 0:
		is_alive = false
		is_hurt = false
		print("Enemy Died!")
		queue_free()



func _on_enemy_hurt_box_area_entered(hitbox: Area2D) -> void:
	is_hurt = true
	take_damage(1)
	var knockback_direction = (global_position - player.global_position).normalized()
	apply_knockback(knockback_direction, 25.0, 0.12)
	

func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void :
	knockback = direction * force
	knockback_timer = knockback_duration




func _on_enemy_hurt_box_area_exited(area: Area2D) -> void:
	is_hurt = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name.begins_with("Attack"):
		is_attacking = false
>>>>>>> e1e473d5ac04893df454a6ce5aeb597f2778e088
