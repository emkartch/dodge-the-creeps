extends RigidBody2D

func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	var mob_random = mob_types.pick_random()
	
	$CollisionShape2D_anglerfish.disabled = true
	$CollisionShape2D_eel.disabled = true
	$CollisionShape2D_jellyfish.disabled = true
	$CollisionShape2D_octopus.disabled = true
	$CollisionShape2D_swordfish.disabled = true
	$CollisionShape2D_turtle.disabled = true
	
	if mob_random == "anglerfish":
		$CollisionShape2D_anglerfish.disabled = false
	elif mob_random == "eel":
		$CollisionShape2D_eel.disabled = false
	elif mob_random == "jellyfish":
		$CollisionShape2D_jellyfish.disabled = false
		$CollisionShape2D_jellyfish.rotation = 1.5708
		$AnimatedSprite2D.rotation = 1.5708
	elif mob_random == "octopus":
		$CollisionShape2D_octopus.disabled = false
		$CollisionShape2D_octopus.rotation = 1.5708
		$AnimatedSprite2D.rotation = 1.5708
	elif mob_random == "swordfish":
		$CollisionShape2D_swordfish.disabled = false
	elif mob_random == "turtle":
		$CollisionShape2D_turtle.disabled = false
		
	$AnimatedSprite2D.animation = mob_random
	$AnimatedSprite2D.play()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
