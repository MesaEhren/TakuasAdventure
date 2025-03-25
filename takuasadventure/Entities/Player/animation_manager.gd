class_name AnimationManager
extends Node

@export var actor: CharacterBody2D
@export var animation_tree: AnimationTree

@onready var animation_state = animation_tree.get("parameters/playback")

@onready var idle_blend_position: String = "parameters/idle/blend_position"
@onready var walk_blend_position: String = "parameters/walk/blend_position"
@onready var jump_blend_position: String = "parameters/jump/blend_position"

var current_animation: String = "idle"
var anim_from_state

func _process(_delta: float) -> void:
	anim_from_state = get_current_animation()
	
	match anim_from_state:
		"idle":
			pass
		"walk":
			if actor.direction.length() > 0:
				update_blend_spaces()
		"jump":
			pass
		"carry_walk":
			if actor.direction.length() > 0:
				update_blend_spaces()


func update_blend_spaces() -> void:
	animation_tree.set(idle_blend_position, actor.direction)
	animation_tree.set(walk_blend_position, actor.direction)
	animation_tree.set(jump_blend_position, actor.direction)

func get_current_animation():
	return animation_state.get_current_node()

func _on_jump_jumped() -> void:
	animation_state.travel("jump")
	
func _on_movement_idled() -> void:
	animation_state.travel("idle")

func _on_movement_walking() -> void:
	animation_state.travel("walk")

func _on_test_timer_delete_timeout() -> void:
	print(anim_from_state)
