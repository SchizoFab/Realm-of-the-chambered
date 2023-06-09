extends Spatial

var time = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	time += delta
	
	
	self.translation = Vector3(self.translation.x,sin( time  *4 )  * 1 ,self.translation.z)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
