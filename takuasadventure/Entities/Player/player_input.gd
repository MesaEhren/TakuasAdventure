class_name PlayerInput
extends Node

@export var actor: CharacterBody2D
var direction: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_west", "move_east", "move_north", "move_south")

	#Send the direction info to the centralizd player_body script.
	actor.direction = direction
