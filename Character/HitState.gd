extends State

class_name HitState

@export var damageable : Damageable
@export var dead_state : State
@export var dead_animation : String = "dead"
@export var knockback_speed : float = 100.00
@export var return_state : State

@onready var timer : Timer = $Timer

func _ready():
	damageable.connect("on_hit", on_damagable_hit)
	
func on_enter():
	timer.start()
	
func on_damagable_hit(node : Node, damage_amount : int, knockback_direction : Vector2):
	if(damageable.health > 0):
		character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state",self)
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation)

func on_exit():
	character.velocity = Vector2.ZERO

func _on_timer_timeout():
	next_state = return_state
