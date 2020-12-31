extends KinematicBody2D

onready var gunNode = get_node("TestGun")

var moveSpeed = 10
var walkMoveSpeed = 10
var sprintMoveSpeed = 14
var slideMoveSpeed = 17
var dashMoveSpeed = 145
var moveDirection:Vector2 = Vector2(0, 0)
var isSliding = false
var canMove = true
var canDash = false
var canInteract = false

var Inventory = {
	"moneyUSD":0,
	"moneyGC":0,
	"zombieMoney":0,
	"zombieKills":0,
	"kills":0,
	"level":0,
	"currentExp":0,
	"expToLevel":0,
	"equippedGun":1,
	"guns":[],
	"safehouseGuns":[],
	"ammo":
		{
			"smg":"0",
			"ar":"0",
			"secondary":"0"
		}
}

func _ready() -> void:
	Inventory.guns.append(GunDatabase._getgun("Car15")) 
	Inventory.guns.append(GunDatabase._getgun("Ree45")) 
	gunNode.stats = Inventory.guns[0]
	print(gunNode.stats)
	pass

func _process(_delta: float) -> void:
	#_weaponcontrol()
	#_movement()
	#_spritecontrol()
	pass

func _physics_process(delta: float) -> void:
	_movement()
	_weaponcontrol()
	_spritecontrol()
	if (Input.is_action_just_pressed("ui_right")):
		get_tree().change_scene("res://Scenes/Maps/ZombiesTest.tscn")
		pass
	pass

#Controls player movement and makes the player look at the mouse
func _movement():
	if (!isSliding):
		moveDirection = Vector2(0, 0)
		pass
	if (Input.is_action_pressed("moveRight") && !isSliding && canMove):
		moveDirection.x = 1
		pass
	if (Input.is_action_pressed("moveLeft") && !isSliding && canMove):
		moveDirection.x = -1
		pass
	if (Input.is_action_pressed("moveUp") && !isSliding && canMove):
		moveDirection.y = -1
		pass
	if (Input.is_action_pressed("moveDown") && !isSliding && canMove):
		moveDirection.y = 1
		pass
	if (Input.is_action_pressed("moveSprint") && !isSliding && canMove):
		moveSpeed = sprintMoveSpeed
	else:
		moveSpeed = walkMoveSpeed
	if (Input.is_action_pressed("moveDash") && !isSliding && !canDash && canMove):
		moveSpeed = dashMoveSpeed
		canDash = true
		$dashTimer.start(2)
		pass
	if (Input.is_action_just_pressed("moveSlide") && !isSliding && canMove):
		isSliding = true
		$slidingTimer.start(0.7)
		pass
	if (isSliding):
		moveSpeed = slideMoveSpeed
		pass
	#look_at(get_global_mouse_position())
	move_and_collide(moveDirection * moveSpeed)
	pass

func _weaponcontrol():
	if (Input.is_action_just_pressed("key_1") && Inventory.equippedGun == 2):
		Inventory.guns[1] = gunNode.stats
		gunNode.stats = Inventory.guns[0]
		Inventory.equippedGun = 1
		pass
	if (Input.is_action_just_pressed("key_2") && Inventory.equippedGun == 1):
		Inventory.guns[0] = gunNode.stats
		gunNode.stats = Inventory.guns[1]
		Inventory.equippedGun = 2
		gunNode._checkAttachments()
		pass
	pass

#flips the player's sprite when the mouse's x is less than the player's x
func _spritecontrol():
	var mousePos = get_global_mouse_position()
	if (mousePos.x >= get_global_position().x):
		$CollisionBox/Sprite.flip_h = false
		#gunNode.position.x = 23
	else:
		$CollisionBox/Sprite.flip_h = true
		#gunNode.position.x = -23
	pass


func _on_slidingTimer_timeout() -> void:
	isSliding = false
	pass


func _on_dashTimer_timeout() -> void:
	canDash = false
	pass
