extends CharacterBody2D

@export var animation_tree: AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

var direction: Vector2
var speed = 125
var friction = 1.75
var can_go: bool = false
var is_carried: bool = false

func _ready() -> void:
	$Indicator.visible = false


func _physics_process(delta: float) -> void:
	#if can_go:
		#velocity = velocity.move_toward(Vector2.ZERO, friction)
	#
		if get_current_animation() == "carried":
			self.global_position = GlobalVariables.player_position_reference
	
		move_and_slide()
		
	

func carried(player_position):
	animation_state.travel("carried")

func throw(player_aim_direction: Vector2):
	animation_state.travel("throwable_falling")
	velocity = player_aim_direction * speed

#func _input(_event: InputEvent) -> void:
	#if Input.is_key_pressed(KEY_X):
		#can_go = true
		#
		##direction.x = randi_range(-1, 1)
		##direction.y = randi_range(-1, 1)
		#direction.x = 0
		#direction.y = -1
		#direction = direction.normalized()
		#velocity = direction * speed
		#animation_state.travel("throwable_falling")
#
	#if Input.is_key_pressed(KEY_Z):
		#can_go = true
		#
		##direction.x = randi_range(-1, 1)
		##direction.y = randi_range(-1, 1)
		#direction.x = 0
		#direction.y = 1
		#direction = direction.normalized()
		#velocity = direction * speed
		#animation_state.travel("throwable_falling")


func _on_timer_timeout() -> void:
	if get_current_animation() != "carried" and \
	get_current_animation() != "throwable_falling":
		if GlobalVariables.targeted_object == self:
			animation_state.travel("targeted")
		else:
			animation_state.travel("idle")
			
func get_current_animation():
	return animation_state.get_current_node()
