extends Node

@onready var rng = RandomNumberGenerator.new()
var wins = 0.0
var nextPowerup = [2, 20, 30, 40, 60, 80, 160, 320, 640]
var nextPowerupIndex = 0
var allPowerupsBought = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pause_one_sec():
	$game/HBoxContainer/Button.disabled = true
	$game/HBoxContainer/Button2.disabled = true
	$game/HBoxContainer/Button3.disabled = true
	await get_tree().create_timer(1.0).timeout
	$game/HBoxContainer/Button.disabled = false
	$game/HBoxContainer/Button2.disabled = false
	$game/HBoxContainer/Button3.disabled = false

func update_wins():
	$game/Label.text = "Wins: " + str(wins)
	if wins >= 1000:
		print("You win!")
	if allPowerupsBought:
		return
	if wins >= nextPowerup[nextPowerupIndex]:
		roll_powerup()
	$game/Label3.text = "Next Power Up: " + str(nextPowerup[nextPowerupIndex] - wins) + " wins"

func roll_powerup():
	print("here")
	$powerup.visible = true
	$ColorRect.visible = true
	if nextPowerupIndex < 9:
		nextPowerupIndex += 1
		if nextPowerupIndex == 9:
			allPowerupsBought = true
			$game/Label3.text = "Next Power Up: -"
		else:
			$game/Label3.text = "Next Power Up: " + str(nextPowerup[nextPowerupIndex] - wins) + " wins"

# Chose rock
func _on_button_pressed() -> void:
	var move = rng.randi_range(1, 3)
	var gun = rng.randi_range(1, 100)
	if (gun <= global.gunChance):
		$game/Label4.text = "Gun! 🔫"
		$game/Label5.text = "Win!"
		wins += 1.0
	# rock
	elif (move == 1):
		$game/Label4.text = "Rock"
		$game/Label5.text = "Tie"
		wins += 1.0
	# paper
	elif (move == 2):
		$game/Label4.text = "Paper"
		$game/Label5.text = "Loss"
		wins -= 1.0
	# scissors
	else:
		$game/Label4.text = "Scissors"
		$game/Label5.text = "Win!"
		wins += 2.0
	update_wins()
	pause_one_sec()

# Chose paper
func _on_button_2_pressed() -> void:
	var move = rng.randi_range(1, 3)
	var gun = rng.randi_range(1, 100)
	if (gun <= global.gunChance):
		$game/Label4.text = "Gun! 🔫"
		$game/Label5.text = "Win!"
		wins += 1.0
	elif (move == 1):
		$game/Label4.text = "Rock"
		$game/Label5.text = "Win!"
		wins += 1.0
	elif (move == 2):
		$game/Label4.text = "Paper"
		$game/Label5.text = "Tie"
		wins += 0.5
	else:
		$game/Label4.text = "Scissors"
		$game/Label5.text = "Loss"
		wins -= 1.0
	update_wins()
	pause_one_sec()

# Chose scissors
func _on_button_3_pressed() -> void:
	var move = rng.randi_range(1, 3)
	var gun = rng.randi_range(1, 100)
	if (gun <= global.gunChance):
		$game/Label4.text = "Gun! 🔫"
		$game/Label5.text = "Win!"
		wins += 1.0
	elif (move == 1):
		$game/Label4.text = "Rock"
		$game/Label5.text = "Loss"
		wins -= 1.0
	elif (move == 2):
		$game/Label4.text = "Paper"
		$game/Label5.text = "Win!"
		wins += 1.0
	else:
		$game/Label4.text = "Scissors"
		$game/Label5.text = "Tie"
		wins += 0.5
	update_wins()
	pause_one_sec()
