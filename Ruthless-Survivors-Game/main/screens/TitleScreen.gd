extends "res://main/Screen.gd"

signal play_single_player
signal play_local
signal play_online
signal exit_game

func _on_LocalButton_pressed() -> void:
	emit_signal("play_local")

func _on_OnlineButton_pressed() -> void:
	emit_signal("play_online")

func _on_ExitButton_pressed() -> void:
	emit_signal("exit_game")

func _on_CreditsButton_pressed() -> void:
	ui_layer.show_screen("CreditsScreen")

func _on_SinglePlayerButton_pressed() -> void:
	emit_signal("play_single_player")
