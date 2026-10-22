extends CanvasLayer

@onready var color_rect: ColorRect = ColorRect.new()

func _ready() -> void:
	layer = 128
	color_rect.color = Color(0, 0, 0, 0)
	color_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(color_rect)

func change_scene(target_path: String, duration: float = 0.4) -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	# Fade to black
	var tween_in = create_tween()
	tween_in.tween_property(color_rect, "color:a", 1.0, duration)
	await tween_in.finished
	
	# Change scene
	get_tree().change_scene_to_file(target_path)
	
	# Small pause for game setup
	await get_tree().create_timer(0.1).timeout
	
	# Fade back in
	var tween_out = create_tween()
	tween_out.tween_property(color_rect, "color:a", 0.0, duration)
	await tween_out.finished
	
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
