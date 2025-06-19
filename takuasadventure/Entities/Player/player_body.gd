extends CharacterBody2D

#central component, serve as message bus, status holder, and ultimate 
#source-of-truth for the character.

#TODO: add animation player, blendspace strings, etc, and create the update function
var idle_blend_position: String = "parameters/Idle/blend_position"
var walk_blend_position: String = "parameters/Walk/blend_position"
var jump_blend_position: String = "parameters/Jump/blend_position"
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree["parameters/playback"]

#basic movement stats for the player.
@export var walk_speed: int = 90
@export var acceleration: int = 10
@export var friction: int = 8
@export var jump_speed: int = 80
@export var carry_speed: int = 70
@export var throw_speed: int = 100
@export var throw_strength: int = 1100

var current_player_animation: String = "idle"
var current_speed: int = 90 #TODO remove that 1
var direction: Vector2
var aim_direction: Vector2
var terrain_below_player: String = "ground"
var last_safe_position: Vector2

func _physics_process(_delta: float) -> void:
	GlobalVariables.player_position_reference = self.global_position
	
	#for index in get_slide_collision_count():
		#var collision := get_slide_collision(index)
		#var body := collision.get_collider()
		#print("Collided with: ", body.name)
	#print(terrain_below_player)

func get_current_animation():
	return animation_state.get_current_node()
