extends CharacterBody2D

@export var animation_tree: AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

var direction: Vector2
var speed = 175
var friction = 2.15
var can_go: bool = false
var is_carried: bool = false
var world_parent

func _ready() -> void:
	$Indicator.visible = false
	world_parent = get_parent()


func _physics_process(delta: float) -> void:
	if get_current_animation() == "throw":
		velocity = velocity.move_toward(Vector2.ZERO, friction)

		move_and_slide()
		
	

func carried(player):
	if GlobalVariables.carried_object != null:
		return
	if get_current_animation() != "throw" and \
	get_current_animation() != "drop":
		animation_state.travel("carried")
		reparent(player, false)
		self.position = Vector2(0, -1)
		GlobalVariables.carried_object = self

func throw(player_aim_direction: Vector2):
	animation_state.travel("throw")
	reparent(world_parent, true)
	velocity = player_aim_direction.normalized() * speed
	GlobalVariables.carried_object = null

func drop():
	animation_state.travel("drop")
	reparent(world_parent, true)
	GlobalVariables.carried_object = null

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


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox"):
		area.get_parent().on_hurtbox_hit()
