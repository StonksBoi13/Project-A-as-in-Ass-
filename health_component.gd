# health_component.gd
class_name Health
extends Node

signal died  # Emit this when health reaches zero

@export var max_health := 3
var current_health: int
var is_alive := true

func _ready():
	current_health = max_health

func take_damage(amount: int):
	if !is_alive: 
		return  # Already dead
	
	current_health -= amount
	print("Enemy took damage! Health: ", current_health)
	
	if current_health <= 0:
		die()

func die():
	is_alive = false
	died.emit()  # Notify other nodes
	print("Enemy died!")
