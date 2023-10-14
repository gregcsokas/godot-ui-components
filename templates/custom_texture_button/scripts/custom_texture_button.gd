class_name CustomTextureButton
extends BaseButton

@export var button_text = "Button Text"

@export_color_no_alpha var text_color : Color = Color("009fc0")
@export_color_no_alpha var text_hover_color : Color = Color("009fc0")
@export_color_no_alpha var text_pressed_color : Color = Color("00d3ff")

@export_color_no_alpha var base_color : Color = Color("ffffff")
@export_color_no_alpha var hover_color : Color = Color("000000")

@export_range(0.0, 1.0) var base_alpha : float = 0.00
@export_range(0.0, 1.0) var hover_alpha : float = 0.5

@export_range(0.0, 1.0) var base_text_alpha : float = 0.00
@export_range(0.0, 1.0) var hover_text_alpha : float = 1.0

@onready var control : Node = get_node("Control")
@onready var color_rect : Node = get_node("Control/ColorRect")
@onready var label : Node = get_node("Control/Label")


func _ready() -> void:
	label.text = button_text
	label.set("theme_override_colors/font_color", Color(text_color.r, text_color.g, text_color.b, base_text_alpha))
	color_rect.color = Color(base_color.r, base_color.g, base_color.b, base_alpha)


func _on_mouse_entered() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_parallel(true)

	tween.tween_property(
		color_rect,
		"color",
		Color(hover_color.r, hover_color.g, hover_color.b, hover_alpha),
		0.50
		).set_ease(Tween.EASE_IN_OUT)


	tween.tween_property(
		control,
		"position",
		Vector2(0, 266),
		0.50
		).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		label,
		"theme_override_colors/font_color",
		Color(text_hover_color.r, text_hover_color.g, text_hover_color.b, hover_text_alpha),
		0.50
		).set_ease(Tween.EASE_IN_OUT)


func _on_mouse_exited() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel(true)

	tween.tween_property(
		color_rect,
		"color",
		Color(base_color.r, base_color.g, base_color.b, base_alpha),
		0.25
		).set_ease(Tween.EASE_OUT)

	tween.tween_property(
		control,
		"position",
		Vector2(0, 308),
		0.25
		).set_ease(Tween.EASE_OUT)

	tween.tween_property(label,
		"theme_override_colors/font_color",
		Color(text_color.r, text_color.g, text_color.b, base_text_alpha),
		0.25
		).set_ease(Tween.EASE_OUT)


func _on_button_down() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_CIRC)
	
	tween.tween_property(label,
		"modulate",
		Color(text_pressed_color.r, text_pressed_color.g, text_pressed_color.b, hover_alpha),
		0.0
		).set_ease(Tween.EASE_IN_OUT)


func _on_button_up() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_CIRC)
	
	if is_hovered():
		tween.tween_property(label,
			"modulate",
			Color(text_color.r, text_color.g, text_color.b, hover_alpha),
			0.0
			).set_ease(Tween.EASE_IN_OUT)
