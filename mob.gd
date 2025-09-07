extends RigidBody2D

func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	var mob_random = mob_types.pick_random()
	if mob_random == "fly":
		$CollisionShape2D_walk_swim.disabled = true
		$CollisionShape2D_fly.disabled = false
	else:
		
		$CollisionShape2D_walk_swim.disabled = false
		$CollisionShape2D_fly.disabled = true
	$AnimatedSprite2D.animation = mob_random
	$AnimatedSprite2D.play()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
