extends Area2D

@export var player: CharacterBody2D

func _physics_process(delta: float) -> void:
	if player.direction.length() > 0:
		self.rotation = player.direction.angle()
