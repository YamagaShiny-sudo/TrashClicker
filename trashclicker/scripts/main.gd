extends Node

@onready var score_label: RichTextLabel = $ScoreLabel
@onready var power_label: Label = $RightMargin/RightPanel/ManuelOutputLabel
@onready var goal_label: Label = $RightMargin/RightPanel/GoalLabel

var trash_score : float = 0

#Initialising at the start
func _ready() -> void:
	if OS.has_feature("web"):
		var saved = JavaScriptBridge.eval("localStorage.getItem('trash_score')")
	update_text()


#Updating the label
func update_text() -> void:
	score_label.text = "Poubelles collectées: " + format(trash_score)
	power_label.text = "Poubelles/click: " + format(output)
	goal_label.text = format(trash_score) + "/10.00Quad"

var output = 1
@onready var click_timer: Timer = $Trash/ClickTimer
func _main_button_pressed() -> void:
	if click_timer.time_left <= 0:
		click_timer.start()

@onready var click_sound: AudioStreamPlayer = $Trash/ClickSound
func _on_click_timer_timeout() -> void:
	addScore(output)
	click_sound.play()


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
		return str("%.2f" % (number/10**12), "T")
	elif lenght_number < 19:
		return str("%.2f" % (number/10**15), "Quad")
	elif lenght_number < 22:
		return str("%.2f" % (number/10**17), "Quint")
	return str(number)



#AutoClicker PowerUP
@onready var auto_stop: Timer = %AutoStop
@onready var auto_clicker_timer: Timer = %AutoClickerTimer
func auto_clicker() -> void:
	auto_clicker_timer.start()
	auto_stop.start()
#Press the main button
func _on_auto_clicker_timer_timeout() -> void:
	addScore(output)
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
	if OS.has_feature("web"):
		JavaScriptBridge.eval("localStorage.setItem('trash_score', '" + str(trash_score) + "')")
#Substracting from the score
func subScore(amount:float) -> void:
	trash_score -= amount
	update_text()
	if OS.has_feature("web"):
		JavaScriptBridge.eval("localStorage.setItem('trash_score', '" + str(trash_score) + "')")
