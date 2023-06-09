extends KinematicBody

export var speed = 10
export var jumpHeight = 10
export var sensitivity = 0.4
onready var cam = $Camera
var look_rot = Vector3.ZERO


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		look_rot.y -= event.relative.x * sensitivity
		look_rot.x -= event.relative.y * sensitivity
		look_rot.x = clamp(look_rot.x,-90,90)

func _physics_process(delta):
	
	var InputVec = Vector3(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		0,
		Input.get_action_strength("back") - Input.get_action_strength("front")
	).normalized().rotated(Vector3.UP,rotation.y)
	
	var Velocity = Vector3()
	Velocity.x = InputVec.x
	Velocity.z = InputVec.z
	
	Velocity = move_and_slide(Velocity * speed )
	
	cam.rotation_degrees.x = look_rot.x
	rotation_degrees.y = look_rot.y
	
