extends Control

@export var player: CharacterBody2D

#TEST CODE DELETE THIS LATER PLS
func _input(_event: InputEvent) -> void:
	if GlobalVariables.DEVELOPER_MODE == true:
		if Input.is_key_label_pressed(KEY_O):
			$TextureProgressBar.value += 1
		if Input.is_key_label_pressed(KEY_P):
			$TextureProgressBar.value -= 1


func _ready() -> void:
	await player.ready #wait until the player is ready, since otherwise this loads zeroes.
	$TextureProgressBar.value = float(player.health)
	print(player.health)
	print($TextureProgressBar.value)

func _on_player_body_health_changed(new_value: Variant) -> void:
	$TextureProgressBar.value = float(new_value)
