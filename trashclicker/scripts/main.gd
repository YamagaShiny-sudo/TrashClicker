extends Control

@onready var score_label: Label = $ScoreLabel

var trash_score = 0

func _ready() -> void:
	update_text()

func update_text() -> void:
	score_label.text = "Trash collected: " + str(trash_score)
	power_label.text = "Power \nCost: " + str(power_cost) + "\nOutput: " + str(output)
	build_label_1.text = "Building 1 \nCost: " + str(build_cost_1) + "\nOutput: " + str(build_output_1)

var output = 1
func _main_button_pressed() -> void:
	trash_score += output
	update_text()

var power_cost = 2
@onready var power_label: Label = $rightPanel/VScrollBar/VBoxContainer/Power/PowerLabel
func _on_power_upgrade_button_pressed() -> void:
	if trash_score >= power_cost:
		trash_score -= power_cost
		output += 1
		power_cost += 1
		update_text()

var build_cost_1 = 2
var build_output_1 = 0
@onready var build_timer_1: Timer = $rightPanel/VScrollBar/VBoxContainer/Building1/BuildTimer1
@onready var build_label_1: Label = $rightPanel/VScrollBar/VBoxContainer/Building1/BuildLabel1
func _on_build_upgrade_button_1_pressed() -> void:
	if trash_score >= build_cost_1:
		trash_score -= build_cost_1
		build_output_1 += 1
		build_cost_1 += 1
		build_timer_1.start()
		update_text()
		

func _on_build_timer_1_timeout() -> void:
	trash_score += build_output_1
	update_text()
	build_timer_1.start()
