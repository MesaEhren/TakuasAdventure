class_name AnimationManager
extends Node

@export var actor: CharacterBody2D
@export var animation_tree: AnimationTree

@onready var animation_state = animation_tree.get("parameters/playback")

@onready var idle_blend_position: String = "parameters/idle/blend_position"
@onready var walk_blend_position: String = "parameters/walk/blend_position"
@onready var jump_blend_position: String = "parameters/Jump/blend_position"

func _process(delta: float) -> void:
	
	if actor.direction.length() > 0:
		animation_state.travel("walk")
		update_blend_spaces() #only update blend spaces WHILE moving! Prevents direction reset on idle.
		
	else:
		animation_state.travel("idle")
	


func update_blend_spaces() -> void:
	animation_tree.set(idle_blend_position, actor.direction)
	animation_tree.set(walk_blend_position, actor.direction)
	#animation_tree.set(jump_blend_position, actor.direction)
