extends StaticBody3D

@onready var jump_bubble_mesh = $MeshInstance3D
var hit_intensity = 0.0

func _jiggle() -> void:
	hit_intensity = 0.3

func _process(delta: float) -> void:
	if hit_intensity > 0:
		jump_bubble_mesh.get_active_material(0).set_shader_parameter("hit_intensity", hit_intensity)
		hit_intensity -= delta
		
