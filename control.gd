extends Node

@onready var rng = RandomNumberGenerator.new()
var wins = 0.0
var nextPowerup = [10, 20, 30, 40, 60, 80, 160, 320, 640]
var nextPowerupIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pause_one_sec():
	$HBoxContainer/Button.disabled = true
	$HBoxContainer/Button2.disabled = true
	$HBoxContainer/Button3.disabled = true
	await get_tree().create_timer(1.0).timeout
	$HBoxContainer/Button.disabled = false
	$HBoxContainer/Button2.disabled = false
	$HBoxContainer/Button3.disabled = false

func update_wins():
	$Label.text = "Wins: " + str(wins)
	if wins >= nextPowerup[nextPowerupIndex]:
		roll_powerup()
	$Label3.text = "Next Power Up: " + str(nextPowerup[nextPowerupIndex] - wins) + " wins"
	if wins >= 1000:
		print("You win!")

func roll_powerup():
	if nextPowerupIndex < 9:
		nextPowerupIndex += 1
		$Label3.text = "Next Power Up: " + str(nextPowerup[nextPowerupIndex] - wins) + " wins"
		print("congrats you get a powerup in my heart!")

# Chose rock
func _on_button_pressed() -> void:
	var move = rng.randi_range(1, 3)
	# rock
	if (move == 1):
		$Label4.text = "Rock"
		$Label5.text = "Tie"
		wins += 0.5
	# paper
	elif (move == 2):
		$Label4.text = "Paper"
		$Label5.text = "Loss"
		wins -= 1.0
	# scissors
	else:
		$Label4.text = "Scissors"
		$Label5.text = "Win!"
		wins += 1.0
	update_wins()
	pause_one_sec()

# Chose paper
func _on_button_2_pressed() -> void:
	var move = rng.randi_range(1, 3)
	if (move == 1):
		$Label4.text = "Rock"
		$Label5.text = "Win!"
		wins += 1.0
	elif (move == 2):
		$Label4.text = "Paper"
		$Label5.text = "Tie"
		wins += 0.5
	else:
		$Label4.text = "Scissors"
		$Label5.text = "Loss"
		wins -= 1.0
	update_wins()
	pause_one_sec()

# Chose scissors
func _on_button_3_pressed() -> void:
	var move = rng.randi_range(1, 3)
	if (move == 1):
		$Label4.text = "Rock"
		$Label5.text = "Loss"
		wins -= 1.0
	elif (move == 2):
		$Label4.text = "Paper"
		$Label5.text = "Win!"
		wins += 1.0
	else:
		$Label4.text = "Scissors"
		$Label5.text = "Tie"
		wins += 0.5
	update_wins()
	pause_one_sec()
