extends CharacterBody2D #In extends CharacterBody2D I'm basically saying that this script is a custom version of a CharacterBody2D node. And that I want to build on its features. So now I will gain access to all its features like velocity, and move_and_slide().


@export var speed := 100.0 # @export makes a variable editable in the Godot editor. While := is the typed assignment operator, I can use it when I'm fine with Godot figuring out the type automatically.
@onready var animated_sprite = $AnimatedSprite2D # @onready tells Godot to wait until the scene is fully loaded before assigning this variable. While $ is used to quickly reference a child node by its name. we just store a reference to that child node so we can easily access and use it.
@onready var animation_player = $AnimationPlayer


enum Direction {DOWN, UP, LEFT, RIGHT} #Short for enumeration, this line creates a custom 'type' called Direction with named values. Direction.DOWN == 0 | Direction.UP == 1 | Direction.LEFT == 2 | Direction.RIGHT == 3 |
enum State {IDLE, WALK, ATTACK}


var current_direction = Direction.DOWN
var current_state = State.IDLE
var is_attacking := false
var enemy_inattack_range = false 
var enemy_attack_cooldown = true
var health = 100
var player_alive = true 



func _physics_process(delta): #MOVEMENT | physics_process runs every frame.
	enemy_attack()
	if is_attacking:
		return  # Skip movement and state changes during attack
	
	if health <= 0 :
		player_alive = false #add Death screen
		health = 0
		print("player has been killed")
		self.queue_free()
	
	var input_vector = Vector2(Input.get_action_strength("move_right")- Input.get_action_strength("move_left"),
	Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).normalized()
	velocity = input_vector * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("attack") and current_state != State.ATTACK:
		current_state = State.ATTACK
		is_attacking = true
		_play_animation()
		return
	
	
	if input_vector != Vector2.ZERO and current_state != State.ATTACK :
		if abs(input_vector.x) >= abs(input_vector.y):
			current_direction = Direction.RIGHT if input_vector.x > 0 else Direction.LEFT
		else:
			current_direction = Direction.DOWN if input_vector.y > 0 else Direction.UP
		current_state = State.WALK
	else:
		current_state = State.IDLE
	_play_animation()
 
func _play_animation():
	match current_state:
		State.IDLE:
			match current_direction:
				Direction.DOWN: animated_sprite.play("IDLE_down")
				Direction.UP: animated_sprite.play("IDLE_up")
				Direction.RIGHT: animated_sprite.play("IDLE_right")
				Direction.LEFT: animated_sprite.play("IDLE_left")
		State.WALK:
			match current_direction:
				Direction.DOWN: animated_sprite.play("WALK_down")
				Direction.UP: animated_sprite.play("WALK_up")
				Direction.RIGHT: animated_sprite.play("WALK_right")
				Direction.LEFT: animated_sprite.play("WALK_left")
		State.ATTACK:
			animated_sprite.stop()
			match current_direction:
				Direction.DOWN: animation_player.play("Attack_down")
				Direction.UP: animation_player.play("Attack_up")
				Direction.RIGHT: animation_player.play("Attack_right")
				Direction.LEFT: animation_player.play("Attack_left")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name.begins_with("Attack"):
		is_attacking = false
		current_state = State.IDLE
		_play_animation()


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true :
		enemy_attack_cooldown = false
		health -= 10
		print(health)
		$AttackCooldown.start()
		


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true
