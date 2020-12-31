extends Enemy

func _ready() -> void:
	pass 
	
func _physics_process(delta):
	pass

func _takeDamage(damage):
	self.health -= damage
	PlayerData.Inventory.zombieMoney += 10
	pass

func _kill():
	self.queue_free()
	get_node("/root/World").zombiesKilled += 1
	PlayerData.Inventory.zombieKills += 1
	PlayerData.Inventory.zombieMoney += 60
	pass
