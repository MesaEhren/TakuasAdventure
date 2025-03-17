class_name Jump
extends Node

signal jumped
@export var player: CharacterBody2D
@export var animation_manager: AnimationManager

func _on_player_input_jumped() -> void:
	print("jumped was pressed, signal worked!")
	var current_anim = player.get_current_animation()
	if current_anim == "idle" or current_anim == "walk":
		jumped.emit()
