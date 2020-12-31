extends Node2D

var zombiePath = preload("res://Scenes/Entities/Enemy.tscn")
enum states {idle, roundEnd, newRound, inRound}

var state = states.idle

var wave = 0
var waveWaitTimer = 3
var zombiesWave = 5
var zombiesSpawned = 0
var zombiesKilled = 0
var hasPower = false
var canEscape = false

var zombieSpawns = []
var zombieSpawned = false
var roundEnded = false

func _ready() -> void:
	_findspawns()
	pass

func _physics_process(delta: float) -> void:
	pass

func _findspawns():
	for i in range($zombieSpawns.get_child_count()):
		zombieSpawns.append($zombieSpawns.get_child(i))
	pass

func _spawnZombies():
	if (zombiesSpawned != zombiesWave):
		var zombie = zombiePath.instance()
		var zombieSpawnID = int(0) #rand_range(0, zombieSpawns.size())
		var zombieSpawnPoint = zombieSpawns[zombieSpawnID]
		zombie.global_position = zombieSpawnPoint.get_global_position()
		self.add_child(zombie)
	pass

func _on_roundIntervalTimer_timeout() -> void:
	roundEnded = false
	state = states.newRound
	pass


func _on_zombieSpawnInterval_timeout() -> void:
	_spawnZombies()
	zombieSpawned = false
	pass
