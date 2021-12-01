extends KinematicBody2D
class_name yusong

export (int) var speed = 85
export (int) var jump_speed = -80
export (int) var gravity = 400
export (float, 0, 1.0) var friction = 0.25
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO
var talking = false

func _ready():
	pass

func talk(speech):
	# make the player talk
	talking = true
	$PlayerSpeech/AnimationPlayer.stop()
	$PlayerSpeech/SpeechTimer.stop()
	$PlayerSpeech/Speechtext.parse_bbcode(speech)
	yield(get_tree(), "idle_frame") 
	yield(get_tree(), "idle_frame") # super hack -- because bbcode length isn't ready right away?
	var speech_length = $PlayerSpeech/Speechtext.get_total_character_count()
	var speech_time = float(speech_length/10)
	$PlayerSpeech/SpeechTimer.wait_time = speech_time
	$PlayerSpeech/AnimationPlayer.play("show_text")
	
	
func reset_speech():
	# clear player speech
	$PlayerSpeech/Speechtext.parse_bbcode("")

func get_input():
	var dir = 0
	if Input.is_action_pressed("move_right"):
		dir += 1
		$AnimatedSprite.scale.x = 1
	if Input.is_action_pressed("move_left"):
		dir -= 1
		$AnimatedSprite.scale.x = -1
	if dir != 0:
		$AnimatedSprite.play("walk")
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		if talking:
			$AnimatedSprite.play("talking")
		else:
			$AnimatedSprite.play("idle")
		
		# moving!
		velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed

func _on_SpeechTimer_timeout():
	$PlayerSpeech/AnimationPlayer.play("hide_text")
	talking = false
