extends KinematicBody2D

onready var SelfDestructTimer = $SelfDestructTimer

var speed = 1200
var direction = Vector2()
var damageToDo = 0

func _ready() -> void:
	pass

func _moveBullet():
	var err = move_and_slide(direction * speed)
	if (!err):
		print("bullet error")
		pass
	pass

func _process(_delta: float) -> void:
	_moveBullet()
	pass

func _on_SelfDestructTimer_timeout() -> void:
	self.SelfDestructTimer.stop()
	self.queue_free()
	pass


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemies"):
		area.get_parent()._takeDamage(damageToDo)
		pass
	self.queue_free()
	pass
