tool
extends Spatial

var time = 0
export var enabled: bool = !Engine.is_editor_hint() setget enable
onready var cam: Camera = get_camera()

func enable(new_value):
	enabled = new_value
	time = 0
	rotation_degrees = Vector3(0,0,0)

func _process(delta):
	if enabled:
		time+=0.01
		rotate_y(1 * delta)
		rotate_x(sin(time)/2 * delta)
		cam.size += sin(time)*5.0 * delta
	else:
		rotation_degrees = Vector3(0,0,0)
		cam.size = 10.0;
	
func get_camera():
	if Engine.is_editor_hint():
		return get_tree().edited_scene_root.get_node("Camera")
	else:
		return get_tree().current_scene.get_node("Camera")
