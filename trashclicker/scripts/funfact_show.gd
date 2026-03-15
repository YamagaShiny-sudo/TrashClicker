extends Label

@export var array_text : Array[String]

func _ready() -> void:
	var text_index = randi_range(0, len(array_text)-1)
	scroll_text(array_text[text_index])

func scroll_text(input_text:String) -> void:
	self.visible_characters = 0
	self.text = input_text
	
	for i in text.length()+1:
		visible_characters +=1
		await get_tree().create_timer(0.1).timeout

func _on_timer_timeout() -> void:
	for i in text.length():
		visible_characters -=1
		await get_tree().create_timer(0.1).timeout
	var text_index = randi_range(0, len(array_text)-1)
	scroll_text(array_text[text_index])
