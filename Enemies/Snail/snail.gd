extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var speed : float = 30.0
@export var hit_state : State
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var sprite : Sprite2D = $Sprite2D
@onready var timer : Timer = $WallTimer
var recently_turned : bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if(direction == Vector2.ZERO):	
		direction = starting_move_direction
	
	if is_on_wall() && recently_turned == false:
		timer.start()
		recently_turned = true
		direction = -direction
		print(direction,recently_turned)
		
	if direction && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_facing_direction()

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = true
	elif direction.x < 0:
		sprite.flip_h = false
	
func _on_wall_timer_timeout():
	recently_turned = false
