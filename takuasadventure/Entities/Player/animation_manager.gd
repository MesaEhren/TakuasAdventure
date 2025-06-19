class_name AnimationManager
extends Node

@export var actor: CharacterBody2D
@export var animation_tree: AnimationTree

@onready var animation_state = animation_tree.get("parameters/playback")

@onready var idle_blend_position: String = "parameters/idle/blend_position"
@onready var walk_blend_position: String = "parameters/walk/blend_position"
@onready var jump_blend_position: String = "parameters/jump/blend_position"
@onready var carry_idle_blend_position: String = "parameters/carry_idle/blend_position"
@onready var carry_walk_blend_position: String = "parameters/carry_walk/blend_position"
@onready var throw_blend_position: String = "parameters/throw/blend_position"


var current_animation: String = "idle"
var anim_from_state

func _process(_delta: float) -> void:
	anim_from_state = get_current_animation()
	
	match anim_from_state:
		"idle":
			#This is an edge-case check. Sometimes the animation will not switch
			#to carrying, but no other glitches occur.
			if GlobalVariables.carried_object != null:
				animation_state.travel("carry_idle")
		"walk":
			if actor.direction.length() > 0:
				update_blend_spaces()
			
			#This is an edge-case check. Sometimes the animation will not switch
			#to carrying, but no other glitches occur.
			if GlobalVariables.carried_object != null:
				animation_state.travel("carry_walk")
				
		"jump":
			pass
		"carry_walk":
			if actor.direction.length() > 0:
				update_blend_spaces()
			
			#Edge case check to return to non-carrying animations.
			if GlobalVariables.carried_object == null:
				animation_state.travel("walk")
				
		"carry_idle":
			#Edge case check to return to non-carrying animations.
			if GlobalVariables.carried_object == null:
				animation_state.travel("idle")


func update_blend_spaces() -> void:
	animation_tree.set(idle_blend_position, actor.direction)
	animation_tree.set(walk_blend_position, actor.direction)
	animation_tree.set(jump_blend_position, actor.direction)
	animation_tree.set(carry_idle_blend_position, actor.direction)
	animation_tree.set(carry_walk_blend_position, actor.direction)
	animation_tree.set(throw_blend_position, actor.direction)

func get_current_animation():
	return animation_state.get_current_node()

func _on_jump_jumped() -> void:
	animation_state.travel("jump")
	
func _on_movement_idled() -> void:
	animation_state.travel("idle")

func _on_movement_walking() -> void:
	animation_state.travel("walk")

func _on_carry_carried() -> void:
	animation_state.travel("carry_idle")

func _on_movement_carry_walking() -> void:
	animation_state.travel("carry_walk")

func _on_movement_carry_idled() -> void:
	animation_state.travel("carry_idle")
	
func _on_carry_thrown() -> void:
	animation_state.travel("throw")

func _on_carry_dropped_to_idle() -> void:
	animation_state.travel("idle")
