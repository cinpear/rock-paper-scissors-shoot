extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func close():
	$".".visible = false
	$"../ColorRect".visible = false

func _on_close_button_pressed() -> void:
	close()

func _on_button_pressed() -> void:
	global.numPowerup += 1
	close()

func _on_button_2_pressed() -> void:
	global.numPowerup += 1
	close()

func _on_button_3_pressed() -> void:
	global.numPowerup += 1
	close()

func _on_visibility_changed() -> void:
	if ($".".visible == true):
		var rng = RandomNumberGenerator.new()
		print (global.numPowerup)
		if (global.numPowerup == 7):
			$HBoxContainer/Button3.disabled = true
			$HBoxContainer/Button3/ColorRect.visible = false
		elif (global.numPowerup == 8):
			$HBoxContainer/Button3.disabled = true
			$HBoxContainer/Button3/ColorRect.visible = false
			$HBoxContainer/Button2.disabled = true
			$HBoxContainer/Button2/ColorRect.visible = false
