extends KinematicBody2D
class_name Enemy

onready var player = get_node("/root/World/Player")
export var speed = 10
var health = 100
const eps = 1
var points = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.health <= 0:
		_kill()
	# refresh the points in the path
	points = get_node("../Navigation2D").get_simple_path(self.get_global_position(), player.get_global_position(), false)
	# if the path has more than one point
	if points.size() > 1:
		var distance = points[1] - get_global_position()
		var direction = distance.normalized() # direction of movement
		if distance.length() > eps or points.size() > 2:
			self.move_and_collide(direction*speed)
		else:
			self.move_and_collide(Vector2(0, 0)) # close enough - stop moving
		#self.update() # we update the node so it has to draw it self again
	pass

func _takeDamage(damage):
	self.health -= damage
	pass

func _kill():
	self.queue_free()
	#get_node("/root/World").zombiesKilled += 1
	pass

#func _draw():
	# if there are points to draw
	#if points.size() > 1:
		#for p in points:
			#draw_circle(p - get_global_position(), 8, Color(1, 0, 0)) # we draw a circle (convert to global position first)
