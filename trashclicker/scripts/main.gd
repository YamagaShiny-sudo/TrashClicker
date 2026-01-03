extends Node

@onready var score_label: Label = $ScoreLabel

var trash_score = 0



#Initialising at the start
func _ready() -> void:
	update_text()



#Updating the label
func update_text() -> void:
	format_score(trash_score)
	power_label.text = "Power \nCost: " + str(power_cost) + "\nOutput: " + str(output)
	build_label_1.text = "Building 1 \nCost: " + str(build_cost_1) + "\nOutput: " + str(build_output_1)

var output = 1
func _main_button_pressed() -> void:
	addScore(output)

var power_cost = 2
@onready var power_label: Label = $RightMargin/RightPanel/ScrollUpgrade/BoxUpgrade/Power/PowerLabel
func _on_power_upgrade_button_pressed() -> void:
	if trash_score >= power_cost:
		subScore(power_cost)
		output += 1
		power_cost += 1



#Building insitialisation
var build_cost_1 = 2
var build_output_1 = 0
@onready var build_timer: Timer = %BuildTimer
@onready var build_label_1: Label = $RightMargin/RightPanel/ScrollUpgrade/BoxUpgrade/Building1/BuildLabel1
func _on_build_upgrade_button_1_pressed() -> void:
	if trash_score >= build_cost_1:
		subScore(build_cost_1)
		build_output_1 += 1
		build_cost_1 += 1
		build_timer.start()
#Building adding score
func _on_build_timer_timeout() -> void:
	addScore(build_output_1)



#Make the score 1000 to 1k and etc
func format_score(score : int) -> void:
	var lenght_score = len(str(score))
	if lenght_score < 4:
		score_label.text = "Trash collected: " + str(score)
	elif lenght_score < 7:
		score_label.text = "Trash collected: " + str("%.2f" % (float(score)/10**3), "K")
	elif lenght_score < 10:
		score_label.text = "Trash collected: " + str("%.2f" % (float(score)/10**6), "M")
	elif lenght_score < 13:
		score_label.text = "Trash collected: " + str("%.2f" % (float(score)/10**9), "B")
	elif lenght_score < 16:
		score_label.text = "Trash collected: " + str("%.2f" % (float(score)/10**12), "T")
	elif lenght_score < 19:
		score_label.text = "Trash collected: " + str("%.2f" % (float(score)/10**15), "Quad")



#AutoClicker PowerUP
@onready var auto_stop: Timer = %AutoStop
@onready var auto_clicker_timer: Timer = %AutoClickerTimer
func auto_clicker() -> void:
	auto_clicker_timer.start()
	auto_stop.start()
#Press the main button
func _on_auto_clicker_timer_timeout() -> void:
	_main_button_pressed()
#Stop the AutoClicker
func _on_auto_stop_timeout() -> void:
	auto_clicker_timer.stop()
	auto_stop.stop()



#Speed Building PowerUP
@onready var speed_building_stop: Timer = %SpeedBuildingStop
func speed_building_power() -> void:
	build_timer.wait_time /= 2
	speed_building_stop.start()
#Stop the speed building powerUP
func _on_speed_building_stop_timeout() -> void:
	build_timer.wait_time = 1
	speed_building_stop.stop()



#Adding to the score
func addScore(amount:int) -> void:
	trash_score += amount
	update_text()
#Substracting from the score
func subScore(amount:int) -> void:
	trash_score -= amount
	update_text()
