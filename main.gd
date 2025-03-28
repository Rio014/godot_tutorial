extends Node

@export var mob_scene: PackedScene # multiple mob will be spawned that's why we did not instantiate like player scene
var score


func game_over():
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()

	$HUD.show_game_over()

func new_game():
	$Music.play()
	# remove all mobs when we start new game
	get_tree().call_group("mobs", "queue_free")

	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

	$HUD.update_score(score)
	$HUD.show_message("Get ready")



func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout():
	# create new mob
	var mob = mob_scene.instantiate()

	# choose random location on Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	#print(mob_spawn_location)

	# set mob's position to random location
	mob.position = mob_spawn_location.position

	var direction = mob_spawn_location.rotation + PI/2
	# add mob rotation to make it more random
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150,250), 0)
	mob.linear_velocity = velocity.rotated(direction)

	# spawn mob by adding it to main scene
	add_child(mob)


func _ready():
	#new_game()
	pass
