extends Node2D

var effect = ["DoubleSpeed", "AutoClick", "x2", "x3", "x4", "x5"]
var randomChoice = randf_range(0, 5)

@onready var hud = get_node("../HUD")
func _on_fish_button_pressed() -> void:
	if effect[randomChoice] == "DoubleSpeed":
		hud.speed_building_power()
	elif effect[randomChoice] == "AutoClick":
		hud.auto_clicker()
	elif effect[randomChoice] == "x2":
		multi(2)
	elif effect[randomChoice] == "x3":
		multi(3)
	elif effect[randomChoice] == "x4":
		multi(4)
	elif effect[randomChoice] == "x5":
		multi(5)

func multi(n : int) -> void:
	hud.trash_score *= n
	hud.update_text()
