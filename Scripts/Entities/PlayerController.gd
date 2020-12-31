extends KinematicBody2D

onready var gunNode = get_node("TestGun")

#NOTE: The ammo variable in the player data is ammo stored int the safehouse
#TODO: Make a way to move that to inventory / gun thing
func _ready() -> void:
	PlayerData.Inventory.guns.append(GunDatabase._getgun("1")) 
	PlayerData.Inventory.guns.append(GunDatabase._getgun("2")) 
	gunNode.stats = PlayerData.Inventory.guns[0]
	#gunNode.stats = Inventory.guns[1]
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
	if (!PlayerData.isSliding):
		PlayerData.moveDirection = Vector2(0, 0)
		pass
	if (Input.is_action_pressed("moveRight") && !PlayerData.isSliding && PlayerData.canMove):
		PlayerData.moveDirection.x = 1
		pass
	if (Input.is_action_pressed("moveLeft") && !PlayerData.isSliding && PlayerData.canMove):
		PlayerData.moveDirection.x = -1
		pass
	if (Input.is_action_pressed("moveUp") && !PlayerData.isSliding && PlayerData.canMove):
		PlayerData.moveDirection.y = -1
		pass
	if (Input.is_action_pressed("moveDown") && !PlayerData.isSliding && PlayerData.canMove):
		PlayerData.moveDirection.y = 1
		pass
	if (Input.is_action_pressed("moveSprint") && !PlayerData.isSliding && PlayerData.canMove):
		PlayerData.moveSpeed = PlayerData.sprintMoveSpeed
	else:
		PlayerData.moveSpeed = PlayerData.walkMoveSpeed
	if (Input.is_action_pressed("moveDash") && !PlayerData.isSliding && !PlayerData.canDash && PlayerData.canMove):
		PlayerData.moveSpeed = PlayerData.dashMoveSpeed
		PlayerData.canDash = true
		$dashTimer.start(2)
		pass
	if (Input.is_action_just_pressed("moveSlide") && !PlayerData.isSliding && PlayerData.canMove):
		PlayerData.isSliding = true
		$slidingTimer.start(0.7)
		pass
	if (PlayerData.isSliding):
		PlayerData.moveSpeed = PlayerData.slideMoveSpeed
		pass
	if (Input.is_action_just_pressed("interact") && PlayerData.canInteract && PlayerData.objectToInteract != null):
		pass
	#look_at(get_global_mouse_position())
	move_and_collide(PlayerData.moveDirection * PlayerData.moveSpeed)
	pass

func _weaponcontrol():
	if (Input.is_action_just_pressed("key_1") && PlayerData.Inventory.equippedGun == 2):
		PlayerData.Inventory.guns[1] = gunNode.stats
		gunNode.stats = PlayerData.Inventory.guns[0]
		PlayerData.Inventory.equippedGun = 1
		pass
	if (Input.is_action_just_pressed("key_2") && PlayerData.Inventory.equippedGun == 1):
		PlayerData.Inventory.guns[0] = gunNode.stats
		gunNode.stats = PlayerData.Inventory.guns[1]
		PlayerData.Inventory.equippedGun = 2
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
	PlayerData.isSliding = false
	pass


func _on_dashTimer_timeout() -> void:
	PlayerData.canDash = false
	pass
