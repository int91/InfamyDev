extends Node2D

var zombiePath = preload("res://Scenes/Entities/Enemy.tscn")

var wave = 1
var waveWaitTimer = 3
var zombiesWave = 5
var zombiesSpawned = 0
var zombiesKilled = 0
var hasPower = false
var canEscape = false

var zombieSpawns = []

func _ready() -> void:
	for i in range($zombieSpawns.get_child_count()):
		zombieSpawns.append($zombieSpawns.get_child(i))
		pass
	$roundIntervalTimer.start(waveWaitTimer)
	print(zombieSpawns)
	pass

func _physics_process(delta: float) -> void:
	if (zombiesKilled == zombiesWave):
		$roundIntervalTimer.start(3)
		zombiesKilled = 0
	pass

func _spawnZombies():
	var zombie = zombiePath.instance()
	var zombieSpawnID = int(rand_range(0, zombieSpawns.size()))
	var zombieSpawnPoint = zombieSpawns[zombieSpawnID]
	zombie.global_position = zombieSpawnPoint.get_global_position()
	self.add_child(zombie)
	pass

func _on_roundIntervalTimer_timeout() -> void:
	wave += 1
	zombiesWave = wave * 5
	$zombieSpawnInterval.start(2)
	pass


func _on_zombieSpawnInterval_timeout() -> void:
	if (zombiesSpawned != zombiesWave):
		$zombieSpawnInterval.start(2)
		zombiesSpawned += 1
		_spawnZombies()
		pass
	pass
