tool
extends Spatial

export var ball_size = 1.5 setget change_size
export var ball_color = Color.red setget change_color
export var line_color = Color.blue setget change_line_color
export var line_size = 0.5 setget change_line_size
onready var parent_ball = get_parent()
export var disable_line = false setget change_line_enabled

func _ready():
	if parent_ball.get_class() != "Ball":
		$MeshInstance2.visible = false
		parent_ball = null
	elif disable_line:
		$MeshInstance2.visible = false
	else:
		$MeshInstance2.visible = true
		
func change_line_enabled(new_value):
	var p = get_parent();
	if p != null and p.get_class() == "Ball":
		parent_ball = p
	disable_line = new_value
	$MeshInstance2.visible = !new_value

func get_class():
	return "Ball"
			
func get_z_index():
	return $ZIndex.z_index
		
func change_size(new_value):
	ball_size = new_value
	if($MeshInstance != null):
		$MeshInstance.mesh.size = Vector2(new_value, new_value)
		
func change_line_size(new_value):
	line_size = new_value
	$MeshInstance2.material_override.set_shader_param("line_width", new_value)
	
func change_color(new_value):
	ball_color = new_value
	if($MeshInstance != null):
		$MeshInstance.material_override.set_shader_param("color", new_value)

func change_line_color(new_value):
	line_color = new_value
	$MeshInstance2.material_override.set_shader_param("color", new_value)
	
func _process(_delta):
	if(parent_ball != null && transform.origin != Vector3(0,0,0)):
		var target_pos = parent_ball.global_transform.origin
		var pos = lerp(target_pos, global_transform.origin, 0.5)
		var dist = (target_pos - global_transform.origin).length()
		$MeshInstance2.scale.y = dist
		$MeshInstance2.look_at_from_position(pos, target_pos, parent_ball.global_transform.basis.y)
		$MeshInstance2.rotation_degrees.x += 90
