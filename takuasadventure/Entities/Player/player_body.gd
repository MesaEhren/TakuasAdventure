extends CharacterBody2D

#central component, serve as message bus, status holder, and ultimate 
#source-of-truth for the character.

#TODO: add animation player, blendspace strings, etc, and create the update function
var idle_blend_position: String = "parameters/Idle/blend_position"
var walk_blend_position: String = "parameters/Walk/blend_position"
var jump_blend_position: String = "parameters/Jump/blend_position"

#basic movement stats for the player.
@export var walk_speed: int = 90
@export var acceleration: int = 10
@export var friction: int = 8
@export var jump_speed: int = 80
@export var carry_speed: int = 70
@export var throw_speed: int = 100
@export var throw_strength: int = 1100


var is_moving: bool 
var is_jumping: bool
var is_carrying: bool


var current_speed: int = 90 #TODO remove that 1

var direction: Vector2
