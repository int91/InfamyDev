extends Node

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
var objectToInteract = null

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

func _ready():
	pass
