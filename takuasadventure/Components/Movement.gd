class_name Movement
extends Node

signal walking
signal idled

@export var actor: CharacterBody2D
@export var min_slide_angle = 0.0

#set the character body to use top-down settings instead of platformer. 
func _ready():
	actor.wall_min_slide_angle = min_slide_angle
	actor.motion_mode = actor.MOTION_MODE_FLOATING

func _physics_process(_delta):
	if actor.direction.length() > 0:
		actor.velocity = actor.velocity.move_toward(actor.direction * actor.current_speed, actor.acceleration)
		if actor.get_current_animation() != "walk": #this just prevents it from emitting constantly
			walking.emit()
	else:
		actor.velocity = actor.velocity.move_toward(Vector2.ZERO, actor.friction)
		if actor.get_current_animation() != "idle": #this just prevents it from emitting constantly
			idled.emit()
	
	actor.move_and_slide()
