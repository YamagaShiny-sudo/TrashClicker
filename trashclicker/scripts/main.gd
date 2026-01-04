extends Node

@onready var score_label: Label = $ScoreLabel

var trash_score : float = 0



#Initialising at the start
func _ready() -> void:
	update_text()



#Updating the label
func update_text() -> void:
	score_label.text = "Trash collected: " + format(trash_score)
	power_label.text = "Power \nCost: " + str(power_cost) + "\nOutput: " + str(output)

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



#Make the any number 1000 to 1k and etc
func format(number : float) -> String:
	var lenght_number = len(str(int(number)))
	if lenght_number < 4:
		if str(number)[-1] == "0":
			return str(int(number))
		else:
			return str("%.1f" % number)
	elif lenght_number < 7:
		return str("%.2f" % (number/10**3), "K")
	elif lenght_number < 10:
		return str("%.2f" % (number/10**6), "M")
	elif lenght_number < 13:
		return str("%.2f" % (number/10**9), "B")
	elif lenght_number < 16:
		return str("%.2f" % (float(number)/10**12), "T")
	elif lenght_number < 19:
		return str("%.2f" % (float(number)/10**15), "Quad")
	return str(number)



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
@onready var build_timer = %BuildTimer
func speed_building_power() -> void:
	build_timer.wait_time /= 2
	speed_building_stop.start()
#Stop the speed building powerUP
func _on_speed_building_stop_timeout() -> void:
	build_timer.wait_time = 1
	speed_building_stop.stop()



#Adding to the score
func addScore(amount:float) -> void:
	trash_score += amount
	update_text()
#Substracting from the score
func subScore(amount:float) -> void:
	trash_score -= amount
	update_text()
