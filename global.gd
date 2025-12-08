extends Node

var powerupBought = [false, false, false, false, false, false, false, false, false]
var tieAmount = 0.5
var lossAmount = -1.0
var winAmount = 1.0
var winMult = 1.0
var gunChance = 100
var numPowerup = 0

var powerupAbility = [
	"Tie = +1 win",
	"Loss = -0.5 wins",
	"Chain bonus unlocked (+1 for every win you chain)",
	"Gun Chance = 10%",
	"+20% chance to make a loss a tie",
	"+10% chance to make a tie a win",
	"Win x2 (excluding chain)",
	"Loss x0.5",
	"Wait time = 0.5s"
]
