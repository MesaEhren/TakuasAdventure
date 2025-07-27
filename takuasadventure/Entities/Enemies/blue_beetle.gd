extends CharacterBody2D

@export var min_slide_angle = 0.0
@export var search_radius: float = 10.0
var patrol_target: Vector2
var direction: Vector2 = Vector2.ZERO
@export var walk_speed: int = 70
@export var acceleration: int = 10
@export var friction: int = 8


func _ready() -> void:
	$Animations.play("BlueBeetle/idle_twl")
	wall_min_slide_angle = min_slide_angle
	motion_mode = MOTION_MODE_FLOATING


func _physics_process(delta: float) -> void:
	direction = direction.normalized()
	if !is_vector2_approx_equal(global_position, patrol_target):#global_position != patrol_target:
		velocity = velocity.move_toward(direction * walk_speed, acceleration)
		print("Global Position: ", global_position)
		print("Patrol Target: ", patrol_target)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	
	move_and_slide()


func find_random_point_in_radius() -> Vector2:
	var target_offset: Vector2
	target_offset.x = randf_range(-search_radius, search_radius)
	target_offset.y = randf_range(-search_radius, search_radius)

	return target_offset
#
func _on_patrol_timer_timeout() -> void:
	var tempvector = find_random_point_in_radius()
	patrol_target = global_position + tempvector
	direction = global_position.direction_to(patrol_target)
	


func is_vector2_approx_equal(a: Vector2, b: Vector2) -> bool:
	var tolerance = 3
	var vec: Vector2 = Vector2.ZERO
	
	vec.x = abs(a.x - b.x)
	vec.y = abs(a.y - b.y)
	
	if vec.x < tolerance and vec.y < tolerance:
		return true
	else:
		return false
