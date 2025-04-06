extends Node

@onready var targeted_object = null
@onready var carried_object = null

var player_position_reference: Vector2 

var DEVELOPER_MODE: bool = false

func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_F1):
		if !DEVELOPER_MODE:
			DEVELOPER_MODE = true
			print("Developer mode on.")
		else:
			DEVELOPER_MODE = false
			print("Developer mode off.")
