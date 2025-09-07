extends Node

@onready var player: CharacterBody2D = $Player
@onready var under_brideg_left_blocker: CollisionShape2D = $under_bridge_area/StaticBody2D/CollisionShape2D
@onready var under_brideg_right_blocker: CollisionShape2D = $under_bridge_area/StaticBody2D2/CollisionShape2D
@onready var u_b_area: CollisionShape2D = $under_bridge_area/CollisionShape2D
@onready var o_b_area: CollisionShape2D = $over_bridge_area/CollisionShape2D
@onready var o_b_under_blocker: CollisionShape2D = $over_bridge_area/StaticBody2D/CollisionShape2D
@onready var o_b_upper_blocker: CollisionShape2D = $over_bridge_area/StaticBody2D2/CollisionShape2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass




func _on_area_2d_area_exited(_area: Area2D) -> void:
	player.z_index = 4;
	print("out")
	under_brideg_left_blocker.set_deferred("disabled",true)
	under_brideg_right_blocker.set_deferred("disabled",true)
	o_b_area.set_deferred("disabled",false);


func _on_area_2d_area_entred(area: Area2D) -> void:
	player.z_index = 0;
	print("enter")
	under_brideg_left_blocker.set_deferred("disabled",false)
	under_brideg_right_blocker.set_deferred("disabled",false)
	o_b_area.set_deferred("disabled",true)
	o_b_under_blocker.set_deferred("disabled",true)
	o_b_upper_blocker.set_deferred("disabled",true)


func _on_over_bridge_area_area_entered(area: Area2D) -> void:
	u_b_area.set_deferred("disabled",true)
	o_b_under_blocker.set_deferred("disabled",false)
	o_b_upper_blocker.set_deferred("disabled",false)
	under_brideg_left_blocker.set_deferred("disabled",true)
	under_brideg_right_blocker.set_deferred("disabled",true)
	print("yes")




func _on_over_bridge_area_area_exited(area: Area2D) -> void:
	u_b_area.set_deferred("disabled",false)
	o_b_under_blocker.set_deferred("disabled",true)
	o_b_upper_blocker.set_deferred("disabled",true)
	print("no")
