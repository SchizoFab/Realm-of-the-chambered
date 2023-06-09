extends KinematicBody

onready var anim_player = $Camera/CanvasLayer/Control/AnimationPlayer
onready var CAM = $Camera
onready var hand = $Camera/CanvasLayer/Control/Sprite
onready var handpos = $Camera/CanvasLayer/Control/Position2D
onready var campos = $Position3D
var spear = preload("res://spear instance.tscn")

const SPEED = 20
const MOUSE_SENS = 100
var keyboardrot = 0
var time = 0
var bobValue = 0
var gravity = -5
var Yvel = 0
func _ready():
	get_tree().call_group("Monsters", "set_camera", self)
	

func _physics_process(delta):
	time += delta
	if Input.is_action_pressed("ui_right"):
		keyboardrot = 1 
	elif Input.is_action_pressed("ui_left"):
		keyboardrot = -1 
	else :
		keyboardrot = 0
	rotation_degrees.y -= MOUSE_SENS * keyboardrot * delta
	var move_vec = Vector3()
	
	bobValue = lerp(bobValue,0,delta * 5)
	if Input.is_action_pressed("front"):
		move_vec.z -= 1
		bobValue = round((abs(move_vec.x) + abs (move_vec.z))/2)
	if Input.is_action_pressed("back"):
		move_vec.z += 1	
		bobValue = round((abs(move_vec.x) + abs (move_vec.z))/2)
	if Input.is_action_pressed("left"):
		move_vec.x -= 1
		bobValue = round((abs(move_vec.x) + abs (move_vec.z))/2)
	if Input.is_action_pressed("right"):
		move_vec.x += 1
		bobValue = round((abs(move_vec.x) + abs (move_vec.z))/2)
	if Input.is_action_just_pressed("Attack"):
		anim_player.play("punch")
		var instance = spear.instance()
		self.get_parent().add_child(instance)
		instance.translation = self .translation
		instance.rotation = self.rotation
	if Input.is_action_just_pressed("jump") && is_on_floor():
		Yvel = -gravity * 2
	elif !is_on_floor():
		Yvel = gravity
	move_vec.y = lerp(move_vec.y,Yvel,delta * 5)
	
	CAM.translation = Vector3(CAM.translation.x,campos.translation.y +( sin(time * 7) * 0.1 * bobValue), CAM.translation.z)
	hand.position = Vector2(handpos.position.x -( sin(time * 5 ) * 2 * bobValue),handpos.position.y +( sin(time * 5 ) * 1 * bobValue) )
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0,1,0),rotation.y)
	move_and_collide(move_vec * SPEED * delta)
		
