extends Popup

var flag

func _ready():
	flag = false
	pass 

func _on_ScoreButton_pressed():
	if(flag == false):
		popup()
		self.set_position(self.get_position() + Vector2(-400, -300))
		flag = true
