extends Node2D

@onready var tween = Tween

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://control.tscn")

func _on_button_mouse_entered() -> void:	
	$Button.scale = Vector2(1.05, 1.05)

func _on_button_mouse_exited() -> void:
	$Button.scale = Vector2(1.00, 1.00)
