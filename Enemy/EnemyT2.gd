extends KinematicBody2D

var bullet = preload("res://Bullet-Enemy/Bullet-Enemy.tscn")
export (int) var enemyHealth = 1

func _ready():
	$Area2D.connect("area_entered", self, "_colliding")

func _colliding(area):
	if area.is_in_group("right"):
		get_parent().speed = get_parent().speed * -1
	if area.is_in_group("left"):
		get_parent().speed = get_parent().speed * -1

func _process(delta):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(2.0, 30.0)
	yield (get_tree().create_timer(my_random_number), "timeout")
	if GlobalVariables.enemyBulletInstanceCount < 2:
		var bulletInstance = bullet.instance()
		
		bulletInstance.position = Vector2(global_position.x, global_position.y+20)
		get_tree().get_root().add_child(bulletInstance)

func reduceEnemyHealth():
	enemyHealth -= 1
	if enemyHealth == 0:
		GlobalVariables.scoringInformation["currentScore"] +=20
		queue_free()
