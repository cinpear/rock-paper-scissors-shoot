extends Node

@onready var rng = RandomNumberGenerator.new()
var wins = 0.0
var nextPowerup = [2, 4, 6, 8, 10, 12, 14, 16, 18]
# var nextPowerup = [10, 20, 30, 40, 60, 80, 160, 320, 640]
var nextPowerupIndex = 0
var chainWin = 0

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
	await get_tree().create_timer(global.waitTime).timeout
	$game/HBoxContainer/Button.disabled = false
	$game/HBoxContainer/Button2.disabled = false
	$game/HBoxContainer/Button3.disabled = false

func update_wins():
	$game/Label.text = "Wins: " + str(wins)
	if wins >= 1000:
		print("You win!")
	if (global.numPowerup == 9):
		print("allbought")
		return
	else:
		$game/Label3.text = "Next Power Up: " + str(nextPowerup[nextPowerupIndex] - wins) + " wins"
	if wins >= nextPowerup[nextPowerupIndex]:
		roll_powerup()

func roll_powerup():
	print("here")
	$powerup.visible = true
	$ColorRect.visible = true
	if global.numPowerup == 9:
		$game/Label3.text = "Next Power Up: -"
	else:
		nextPowerupIndex += 1
		if nextPowerupIndex < 9:
			$game/Label3.text = "Next Power Up: " + str(nextPowerup[nextPowerupIndex] - wins) + " wins"
		else:
			$game/Label3.text = "Next Power Up: -"

# Chose rock
func _on_button_pressed() -> void:
	print("pressed")
	var move = rng.randi_range(1, 3)
	var gun = rng.randi_range(1, 100)
	if (gun <= global.gunChance):
		$game/Label4.text = "Gun! 🔫"
		$game/Label5.text = "Win!"
		$game/updateLabel2.text = "+" + str(global.winAmount * global.winMult + chainWin) + " wins"
		wins += global.winAmount * global.winMult + chainWin
		if global.chainBonus:
			chainWin += 1
	# rock
	elif (move == 1):
		if global.tieToWinChance > 0:
			var chance = rng.randi_range(1, 10)
			if chance <= global.tieToWinChance:
				$game/Label4.text = "Scissors"
				$game/Label5.text = "Tie -> Win!"
				$game/updateLabel2.text = "+" + str(global.winAmount * global.winMult + chainWin) + " wins"
				wins += global.winAmount * global.winMult + chainWin
				if global.chainBonus:
					chainWin += 1
			else:
				$game/Label4.text = "Rock"
				$game/Label5.text = "Tie"
				$game/updateLabel2.text = "+" + str(global.tieAmount * global.winMult) + " wins"
				wins += global.tieAmount * global.winMult
				chainWin = 0
		else:
			print("here1")
			$game/Label4.text = "Rock"
			$game/Label5.text = "Tie"
			$game/updateLabel2.text = "+" + str(global.tieAmount * global.winMult) + " wins"
			wins += global.tieAmount * global.winMult
			chainWin = 0
	# paper
	elif (move == 2):
		print("here2")
		if global.lossToTieChance > 0:
			var chance = rng.randi_range(1, 10)
			if chance <= global.lossToTieChance:
				$game/Label4.text = "Paper"
				$game/Label5.text = "Loss -> Tie"
				$game/updateLabel2.text = "+" + str(global.tieAmount * global.winMult) + " wins"
				wins += global.tieAmount * global.winMult
				chainWin = 0
			else:
				$game/Label4.text = "Paper"
				$game/Label5.text = "Loss"
				$game/updateLabel2.text = str(global.lossAmount * global.lossMult) + " wins"
				wins += global.lossAmount * global.lossMult
				chainWin = 0
		else:
			$game/Label4.text = "Paper"
			$game/Label5.text = "Loss"
			$game/updateLabel2.text = str(global.lossAmount * global.lossMult) + " wins"
			wins += global.lossAmount * global.lossMult
			chainWin = 0
	# scissors
	else:
		print("here3")
		$game/Label4.text = "Scissors"
		$game/Label5.text = "Win!"
		$game/updateLabel2.text = "+" + str(global.winAmount * global.winMult + chainWin) + " wins"
		wins += global.winAmount * global.winMult + chainWin
		if global.chainBonus:
			chainWin += 1
	update_wins()
	pause_one_sec()

# Chose paper
func _on_button_2_pressed() -> void:
	var move = rng.randi_range(1, 3)
	var gun = rng.randi_range(1, 100)
	if (gun <= global.gunChance):
		$game/Label4.text = "Gun! 🔫"
		$game/Label5.text = "Win!"
		$game/updateLabel2.text = "+" + str(global.winAmount * global.winMult + chainWin) + " wins"
		wins += global.winAmount * global.winMult + chainWin
		if global.chainBonus:
			chainWin += 1
	elif (move == 1):
		$game/Label4.text = "Rock"
		$game/Label5.text = "Win!"
		$game/updateLabel2.text = "+" + str(global.winAmount * global.winMult + chainWin) + " wins"
		wins += global.winAmount * global.winMult + chainWin
		if global.chainBonus:
			chainWin += 1
	elif (move == 2):
		if global.tieToWinChance > 0:
			var chance = rng.randi_range(1, 10)
			if chance <= global.tieToWinChance:
				$game/Label4.text = "Paper"
				$game/Label5.text = "Tie -> Win!"
				$game/updateLabel2.text = "+" + str(global.winAmount * global.winMult + chainWin) + " wins"
				wins += global.winAmount * global.winMult + chainWin
				if global.chainBonus:
					chainWin += 1
			else:
				$game/Label4.text = "Paper"
				$game/Label5.text = "Tie"
				$game/updateLabel2.text = "+" + str(global.tieAmount * global.winMult) + " wins"
				wins += global.tieAmount * global.winMult
				chainWin = 0
		else:
			$game/Label4.text = "Paper"
			$game/Label5.text = "Tie"
			$game/updateLabel2.text = "+" + str(global.tieAmount * global.winMult) + " wins"
			wins += global.tieAmount * global.winMult
			chainWin = 0
	else:
		if global.lossToTieChance > 0:
			var chance = rng.randi_range(1, 10)
			if chance <= global.laossToTieChance:
				$game/Label4.text = "Scissors"
				$game/Label5.text = "Loss -> Tie"
				$game/updateLabel2.text = "+" + str(global.tieAmount * global.winMult) + " wins"
				wins += global.tieAmount * global.winMult
				chainWin = 0
			else:
				$game/Label4.text = "Scissors"
				$game/Label5.text = "Loss"
				$game/updateLabel2.text = str(global.lossAmount * global.lossMult) + " wins"
				wins += global.lossAmount * global.lossMult
				chainWin = 0
		else:
			$game/Label4.text = "Scissors"
			$game/Label5.text = "Loss"
			$game/updateLabel2.text = str(global.lossAmount * global.lossMult) + " wins"
			wins += global.lossAmount * global.lossMult
			chainWin = 0
	update_wins()
	pause_one_sec()

# Chose scissors
func _on_button_3_pressed() -> void:
	var move = rng.randi_range(1, 3)
	var gun = rng.randi_range(1, 100)
	if (gun <= global.gunChance):
		$game/Label4.text = "Gun! 🔫"
		$game/Label5.text = "Win!"
		$game/updateLabel2.text = "+" + str(global.winAmount * global.winMult + chainWin) + " wins"
		wins += global.winAmount * global.winMult + chainWin
		if global.chainBonus:
			chainWin += 1
	elif (move == 1):
		if global.lossToTieChance > 0:
			var chance = rng.randi_range(1, 10)
			if chance <= global.lossToTieChance:
				$game/Label4.text = "Rock"
				$game/Label5.text = "Loss -> Tie"
				$game/updateLabel2.text = "+" + str(global.tieAmount * global.winMult) + " wins"
				wins += global.tieAmount * global.winMult
				chainWin = 0
		else:
			$game/Label4.text = "Rock"
			$game/Label5.text = "Loss"
			$game/updateLabel2.text = str(global.lossAmount * global.lossMult) + " wins"
			wins += global.lossAmount * global.lossMult + chainWin
			chainWin = 0
	elif (move == 2):
		$game/Label4.text = "Paper"
		$game/Label5.text = "Win!"
		$game/updateLabel2.text = "+" + str(global.winAmount * global.winMult + chainWin) + " wins"
		wins += global.winAmount * global.winMult + chainWin
		if global.chainBonus:
			chainWin += 1
	else:
		if global.tieToWinChance > 0:
			var chance = rng.randi_range(1, 10)
			if chance <= global.tieToWinChance:
				$game/Label4.text = "Paper"
				$game/Label5.text = "Tie -> Win!"
				$game/updateLabel2.text = "+" + str(global.winAmount * global.winMult + chainWin) + " wins"
				wins += global.winAmount * global.winMult + chainWin
				if global.chainBonus:
					chainWin += 1
			else:
				$game/Label4.text = "Scissors"
				$game/Label5.text = "Tie"
				$game/updateLabel2.text = "+" + str(global.tieAmount * global.winMult) + " wins"
				wins += global.tieAmount * global.winMult
				chainWin = 0
				
		else:
			$game/Label4.text = "Scissors"
			$game/Label5.text = "Tie"
			$game/updateLabel2.text = "+" + str(global.tieAmount * global.winMult) + " wins"
			wins += global.tieAmount * global.winMult
			chainWin = 0
	update_wins()
	pause_one_sec()
