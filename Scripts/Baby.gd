extends KinematicBody2D

var direction = randi() % 4 + 1
var collision_info
var BABY_CAN_MOVE = 1

func _ready():
	$MovementTime.start()
	$BabyTimeout.start()
	pass

func _process(delta):
	#print(direction)
	var velocity = Vector2()
	if BABY_CAN_MOVE:
		$AnimatedSprite.play("Walking_Down")
		if direction == 1:
			velocity.x += 1
		
		if direction == 2:
			velocity.x -= 1
		
		if direction == 3:
			velocity.y -= 1
		
		if direction == 4:
			velocity.y += 1
		
		if velocity.length() > 0:
			velocity = velocity.normalized() * global.baby_speed
		
		collision_info = move_and_collide(velocity * delta)
		
		if collision_info:
			direction = randi() % 4 + 1
		
		position += velocity * delta

func _on_BabyCollisionArea_body_entered(body):
	print(body.get_name())


func _on_MovementTime_timeout():
	direction = randi() % 4 + 1
	$MovementTime.start()


func _on_BabyTimeout_timeout():
	if BABY_CAN_MOVE:
		BABY_CAN_MOVE = 0
		print("Baby cant move")
		$AnimatedSprite.play("Standing_Down")
	else:
		BABY_CAN_MOVE = 1
		print("Baby can move")
