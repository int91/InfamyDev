extends RichTextLabel

func _ready():
	$fadeTimer.start(1.35)
	pass 

func _on_fadeTimer_timeout():
	self.queue_free()
	pass


func _on_Tween_tween_completed(object, key):
	
	pass
