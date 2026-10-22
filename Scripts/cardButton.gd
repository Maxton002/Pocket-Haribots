class_name CardButton
extends Button

@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var scale_duration: float = 0.15

var default_scale: Vector2 = Vector2.ONE
var tween: Tween

func _ready() -> void:
	# Ensure the pivot stays centered even if resized
	pivot_offset = size / 2.0
	resized.connect(func(): pivot_offset = size / 2.0)
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	_animate_scale(hover_scale)

func _on_mouse_exited() -> void:
	_animate_scale(default_scale)

func _animate_scale(target_scale: Vector2) -> void:
	if tween:
		tween.kill()
		
	tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", target_scale, scale_duration)
