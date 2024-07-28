extends State

@export var return_state : State
@export var attack_one_animation : String = "attack_one"
@export var attack_two_animation : String = "attack_two"
@export var return_state_animation : String = "move"

@onready var timer : Timer = $Timer

func state_input(event : InputEvent):
	if(event.is_action_pressed("attack")):
		timer.start()
	

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == attack_one_animation):
		if(timer.is_stopped()):
			next_state = return_state
			playback.travel(return_state_animation)
		else: 
			playback.travel(attack_two_animation)
			
	elif(anim_name == attack_two_animation):
		next_state = return_state
		playback.travel(return_state_animation)
