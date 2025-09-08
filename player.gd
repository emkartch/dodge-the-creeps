extends Area2D

signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	$AnimatedSprite2D.play()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.animation = "swim"
	else:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.rotation = 0
		$CollisionShape2D.rotation = 0
		$AnimatedSprite2D.flip_v = false
		
		if $AnimatedSprite2D.flip_h == true:
			$CollisionShape2D.position.x = 13
		else:
			$CollisionShape2D.position.x = -13
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
		
	if velocity.x != 0:
		$CollisionShape2D.rotation = 1.5708
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$CollisionShape2D.rotation = 0

		if velocity.y > 0:
			$CollisionShape2D.position.x = -13
			if $AnimatedSprite2D.flip_h == false:
				$AnimatedSprite2D.rotation = 1.5708
			else:
				$AnimatedSprite2D.rotation = -1.5708
		else:
			$CollisionShape2D.position.x = 13
			if $AnimatedSprite2D.flip_h == false:
				$AnimatedSprite2D.rotation = -1.5708
			else:
				$AnimatedSprite2D.rotation = 1.5708
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
