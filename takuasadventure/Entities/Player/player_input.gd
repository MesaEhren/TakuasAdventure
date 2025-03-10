class_name PlayerInput
extends Node

signal jumped

@export var actor: CharacterBody2D
var direction: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("move_west", "move_east", "move_north", "move_south")

	#Send the direction info to the centralizd player_body script.
	actor.direction = direction

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		jumped.emit()
		
