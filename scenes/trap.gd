extends StaticBody2D
@export  var cooded = false;
@export  var on = false;
var adjust_return = false;
@export var return_normal = false;
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if cooded == true:
		if on == true:
			animation_player.play("on")
			stop_sprite_at_frame(7)
			print("s")
			adjust_return = true
			
			
		else:
			collision_shape_2d.set_deferred("disabled",true)
			stop_sprite_at_frame(0)
			animation_player.play("off")
			adjust_return = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if return_normal == true:
		if adjust_return == true:
			stop_sprite_at_frame(0)
			animated_sprite.play();
			adjust_return = false;
		animation_player.play("RESET")
		
		

func stop_sprite_at_frame(frame_number: int):
		animated_sprite.stop()
		animated_sprite.frame = frame_number
		
