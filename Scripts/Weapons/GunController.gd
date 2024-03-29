extends Sprite

onready var worldNode = get_node("/root/World/")
onready var bulletScene:PackedScene = preload("res://Scenes/Entities/Bullet.tscn")
onready var player = get_node("/root/World/Player")
onready var shootPoint = $shootPoint

enum Firemodes {semi, auto, burst, shotgun}
enum Types {primary, secondary, all}

var canShoot = true
var firstShot = true
var shots = 0

var attachmentSlotNames = ["sightAttachment", "magAttachment", "barrelAttachment", "stockAttachment", "underbarrelAttachment", "ammotypeAttachment"]
var attachmentChangeNames = ["minRecoilChange", "maxRecoilChange", "maxAmmoChange"]

var stats = {

}

#TESTING / RECODE: MAKE A WAY FOR THE GUNS TO HAVE ATTACHMENTS CHECKED WITHOUT ADDING STATS
#PLACEHOLDER IS THE attachmentsChecked - Check

func _ready() -> void:
	#randomize()
	#self.stats = GunDatabase._getgun("Car15")
	pass 

func _physics_process(delta: float) -> void:
	_gunInput()
	if (Input.is_action_pressed("fire1") && canShoot):
		if (self.stats["ammo"] > 0):
			_spawnBullet()
			canShoot = false
			$shootTimer.start((self.stats["firerate"]))
			pass
	if (Input.is_action_just_pressed("reload") && $reloadTimer.is_stopped() && self.stats["ammo"] < self.stats["maxAmmo"]):
		$reloadTimer.start(self.stats["reloadTime"] * self.stats["reloadSpeed"])
		canShoot = false
		pass
	pass

func _gunInput():
	var mpos = get_global_mouse_position()
	look_at(mpos)
	
	if (mpos.x > player.get_global_position().x):
		self.flip_v = false
	else:
		self.flip_v = true
	pass
pass

func _spawnBullet():
	self.stats["ammo"]  -= 1
	
	var direction = Vector2(cos(get_rotation()), sin(get_rotation()))
	
	var distanceFromMe =  self.stats["barrelOffset"]
	var spawnPoint = shootPoint
	var lowSpread
	var highSpread
	if (!firstShot):
		lowSpread = rand_range(self.rotation -  self.stats["minRecoilDisplacement"], self.rotation +  self.stats["minRecoilDisplacement"])
		highSpread = rand_range(self.rotation - self.stats["maxRecoilDisplacement"], self.rotation +  self.stats["maxRecoilDisplacement"])
	else:
		lowSpread = rand_range(self.rotation, self.rotation)
		highSpread = rand_range(self.rotation, self.rotation)
		firstShot = false
		$firstShotTimer.start(0.45)
	
	var bullet = bulletScene.instance()
	bullet.rotation = rand_range(lowSpread, highSpread)
	bullet.direction = Vector2(cos(bullet.rotation), sin(bullet.rotation))
	bullet.damageToDo = self.stats["damage"]
	var world = worldNode
	
	world.add_child(bullet)
	bullet.set_global_position(spawnPoint.get_global_position())
	pass

#Finish attachment change if statements and finish gun controller entirely
func _checkAttachments():
	var attachmentInfo
	if (!self.stats.attachmentsChecked):
		for i in range(attachmentSlotNames.size()):
			if (self.stats[attachmentSlotNames[i]] != null):
				attachmentInfo = AttachmentDatabase._getAttachment(self.stats[attachmentSlotNames[i]])
				if (self.stats.name in attachmentInfo.guns):
					if ("maxAmmoChange" in attachmentInfo):
						self.stats.maxAmmo += attachmentInfo["maxAmmoChange"]
						self.stats.ammo = self.stats.maxAmmo
					if ("maxRecoilChange" in attachmentInfo):
						self.stats.maxRecoilDisplacement += attachmentInfo["maxRecoilChange"]
					if ("minRecoilChange" in attachmentInfo):
						self.stats.minRecoilDisplacement += attachmentInfo["minRecoilChange"]
					if ("damageChange" in attachmentInfo):
						self.stats.damage += attachmentInfo["damageChange"]
					print(self.stats[attachmentSlotNames[i]])
					self.stats.attachmentsChecked = true
			pass
	pass

func _on_shootTimer_timeout() -> void:
	self.canShoot = true
	pass


func _on_reloadTimer_timeout():
	var toReload = self.stats["maxAmmo"] - self.stats["ammo"]
	if (self.stats["reserveAmmo"] > toReload && self.stats["reserveAmmo"] > 0):
		self.stats["ammo"] += toReload
		self.stats["reserveAmmo"] -= toReload
	else:
		self.stats["ammo"] += self.stats["reserveAmmo"]
		self.stats["reserveAmmo"] = 0
	canShoot = true
	pass


func _on_firstShotTimer_timeout():
	firstShot = true
	pass
