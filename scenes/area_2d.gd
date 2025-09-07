extends Area2D

@onready var player: CharacterBody2D = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("touched")
	player.z_index = 0;


func _on_area_2d_area_exited(area: Area2D) -> void:
	player.z_index = 4;
	print("out")
