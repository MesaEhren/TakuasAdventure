extends Area2D
@export var player: CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("water"):
		player.terrain_below_player = "water"
	elif body.is_in_group("lava"):
		player.terrain_below_player = "lava"

	print(player.terrain_below_player)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("water"):
		player.terrain_below_player = "ground"
	elif body.is_in_group("lava"):
		player.terrain_below_player = "ground"
		
	print(player.terrain_below_player)
