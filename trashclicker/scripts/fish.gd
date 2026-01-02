extends Node2D

var effect = ["DoubleSpeed", "AutoClick", "Multiple"]
var randomChoice = randi_range(0, 2)
var mult = randf_range(1.5, 3)

@onready var hud = get_node("../../HUD")
func _on_fish_button_pressed() -> void:
	if effect[randomChoice] == "DoubleSpeed":
		hud.speed_building_power()
	elif effect[randomChoice] == "AutoClick":
		hud.auto_clicker()
	elif effect[randomChoice] == "Multiple":
		hud.trash_score *= mult
		print(mult)
		hud.update_text()
	queue_free()


var speed = randf_range(100, 300)
var side = 1
func _physics_process(delta : float) -> void:
	position.x -= speed * delta * side

func _on_auto_destroy_timeout() -> void:
	queue_free()
