class_name Movement
extends Node

signal walking
signal idled
signal carry_walking
signal carry_idled

@export var actor: CharacterBody2D
@export var min_slide_angle = 0.0

#set the character body to use top-down settings instead of platformer. 
func _ready():
	actor.wall_min_slide_angle = min_slide_angle
	actor.motion_mode = actor.MOTION_MODE_FLOATING

func _physics_process(_delta):
	if actor.direction.length() > 0:
		actor.velocity = actor.velocity.move_toward(actor.direction * actor.current_speed, actor.acceleration)
		match actor.get_current_animation():
			"idle":
				walking.emit() #only transition from idle to walking.
			"throw":
				actor.velocity = Vector2.ZERO #if we're throwing, halt the movement!
			"carry_idle": #if we're in carry idle and then start moving, move to carry_walk.
				carry_walking.emit()
				
		
		#if actor.get_current_animation() != "walk" and actor.get_current_animation() != "carry_walk": #this just prevents it from emitting constantly
			#walking.emit()
	else:
		actor.velocity = actor.velocity.move_toward(Vector2.ZERO, actor.friction)
		match actor.get_current_animation():
			"walk":
				idled.emit() #only transition from idle to walking.
			"carry_walk": #if we're in carry idle and then start moving, move to carry_walk.
				carry_idled.emit()
		
		
		#if actor.get_current_animation() != "idle" and actor.get_current_animation() != "carry_idle": #this just prevents it from emitting constantly
			#idled.emit()
	
	actor.move_and_slide()
