extends Spatial
onready var castCheck = $spear/RayCast

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if !castCheck.is_colliding():
		self.translation += self.get_global_transform().basis.z * -20 * delta 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
