class_name Jump
extends Node

signal jumped
@export var player: CharacterBody2D
@export var animation_manager: AnimationManager

func _on_player_input_jumped() -> void:
	var current_anim = player.get_current_animation()
	
	#TODO: Change this to a state machine check!
	if current_anim == "carry_idle" or current_anim == "carry_walk" or current_anim == "throw":
		return
	
	#TODO: Change this to a state machine check! Jun 7th, Done a
	#if GlobalVariables.carried_object != null:
		#return
	
	if current_anim == "idle" or current_anim == "walk":
		jumped.emit()
