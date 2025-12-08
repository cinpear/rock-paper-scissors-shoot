extends Control

@onready var powerup = [10, 10, 10]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_visibility_changed() -> void:
	if ($".".visible == true):
		var rng = RandomNumberGenerator.new()
		print (global.numPowerup)
		if (global.numPowerup == 7):
			$HBoxContainer/Button3.disabled = true
			$HBoxContainer/Button3/ColorRect.visible = false
			for i in range(len(global.powerupBought)):
				if global.powerupBought[i] == false:
					if powerup[0] == 10:
						$HBoxContainer/Button.text = str(i) + "\n" + global.powerupAbility[i]
						powerup[0] = i
					else:
						$HBoxContainer/Button2.text = str(i) + "\n" + global.powerupAbility[i]
						powerup[1] = i
		elif (global.numPowerup == 8):
			$HBoxContainer/Button3.disabled = true
			$HBoxContainer/Button3/ColorRect.visible = false
			$HBoxContainer/Button2.disabled = true
			$HBoxContainer/Button2/ColorRect.visible = false
			for i in range(len(global.powerupBought)):
				if global.powerupBought[i] == false:
					$HBoxContainer/Button.text = str(i) + "\n" + global.powerupAbility[i]
					powerup[0] = i
		else:
			while powerup[2] == 10:
				var rand = rng.randi_range(0, 8)
				if global.powerupBought[rand] == false:
					if powerup[0] == 10:
						powerup[0] = rand
						$HBoxContainer/Button.text = str(rand) + "\n" + global.powerupAbility[rand]
						global.powerupBought[rand] = true
					elif powerup[1] == 10:
						powerup[1] = rand
						$HBoxContainer/Button2.text = str(rand) + "\n" + global.powerupAbility[rand]
						global.powerupBought[rand] = true
					else:
						powerup[2] = rand
						$HBoxContainer/Button3.text = str(rand) + "\n" + global.powerupAbility[rand]
						global.powerupBought[rand] = true
						
					

func close():
	powerup = [10, 10, 10]
	$HBoxContainer/Button.text = ""
	$HBoxContainer/Button2.text = ""
	$HBoxContainer/Button3.text = ""
	$".".visible = false
	$"../ColorRect".visible = false

func _on_close_button_pressed() -> void:
	close()

func addPowerup(num):
	if num == 0:
		global.tieAmount = 1.0
	elif num == 1:
		global.lossAmount = -0.5
	elif num == 2:
		global.chainBonus = true
		pass
	elif num == 3:
		global.gunChance = 10
	elif num == 4:
		# +20% chance to make a loss a tie
		global.lossToTieChance = 2
		pass
	elif num == 5:
		# +10% chance to make a tie a win
		global.tieToWinChance = 1
		pass
	elif num == 6:
		global.winMult = 2.0
	elif num == 7:
		global.lossMult = 0.5
	elif num == 8:
		global.waitTime = 0.5

func _on_button_pressed() -> void:
	global.numPowerup += 1
	if powerup[0] != 10:
		global.powerupBought[powerup[0]] = true
	if powerup[1] != 10:
		global.powerupBought[powerup[1]] = false
	if powerup[2] != 10:
		global.powerupBought[powerup[2]] = false
	addPowerup(powerup[0])
	close()

func _on_button_2_pressed() -> void:
	global.numPowerup += 1
	if powerup[0] != 10:
		global.powerupBought[powerup[0]] = false
	if powerup[1] != 10:
		global.powerupBought[powerup[1]] = true
	if powerup[2] != 10:
		global.powerupBought[powerup[2]] = false
	addPowerup(powerup[1])
	close()

func _on_button_3_pressed() -> void:
	global.numPowerup += 1
	if powerup[0] != 10:
		global.powerupBought[powerup[0]] = false
	if powerup[1] != 10:
		global.powerupBought[powerup[1]] = false
	if powerup[2] != 10:
		global.powerupBought[powerup[2]] = true
	addPowerup(powerup[2])
	close()
