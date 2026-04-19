extends Label

@export var array_text : Array[String]
@onready var timer: Timer = $"../Timer"
var text_index = randi_range(0, len(array_text)-1)
var actif : int

func _ready() -> void:
	text_index = randi_range(0, len(array_text)-1)
	actif = text_index
	await get_tree().create_timer(0.1).timeout
	scroll_text(array_text[text_index])

func scroll_text(input_text:String) -> void:
	self.visible_characters = 0
	self.text = input_text
	
	for i in text.length()+1:
		visible_characters +=1
		await get_tree().create_timer(0.1).timeout

func _on_timer_timeout() -> void:
	for i in text.length()+1:
		visible_characters -=1
		await get_tree().create_timer(0.1).timeout
	text_index = randi_range(0, len(array_text)-1)
	#If statement to not show the same thing by doing +1 or -1 in the index
	if actif == text_index:
		if len(array_text)-1 < actif + 1:
			text_index-=1
			actif = text_index
		else:
			text_index+=1
			actif = text_index
	scroll_text(array_text[text_index])
