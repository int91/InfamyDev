extends Enemy

func _ready() -> void:
	pass 
	
func _process(delta: float) -> void:
	pass

func _takeDamage(damage):
	self.health -= damage
	player.Inventory.zombieMoney += 10
	pass

func _kill():
	self.queue_free()
	get_node("/root/World").zombiesKilled += 1
	player.Inventory.zombieKills += 1
	player.Inventory.zombieMoney += 60
	pass
