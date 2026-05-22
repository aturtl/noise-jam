# Massive thanks to The Shaggy Dev for the mic tutorial video https://www.youtube.com/watch?v=gS3IuLqmgx4wd

extends Node3D

@export var volume_text: RichTextLabel
@export var record_button: Button
@onready var record_output: AudioStreamPlayer = $Output
var record_stream: AudioStreamWAV
var record_effect: AudioEffectRecord
var record_bus_index: int

var is_recording: bool = false

func _ready():
	record_bus_index = AudioServer.get_bus_index("Record")
	record_effect = AudioServer.get_bus_effect(record_bus_index, 0)


func _process(delta):
	var volume_level: float = db_to_linear(AudioServer.get_bus_peak_volume_left_db(record_bus_index,0))
	volume_text.text = "dB: " + str(volume_level).substr(0,3)


func _on_record_pressed():
	is_recording = !is_recording
	if is_recording:
		start_recording()
	else:
		stop_recording()
		stop_audio()
		play_audio()


func _on_play_pressed():
	play_audio()


func start_recording():
	record_button.text = "Recording"
	record_effect.set_recording_active(true)


func stop_recording():
	print(record_stream)
	record_button.text = "Record"
	record_effect.set_recording_active(false)
	record_stream = record_effect.get_recording()
	print(record_stream)


func play_audio():
	if !record_output:
		return
	record_output.stream = record_stream
	record_output.play()


func stop_audio():
	record_output.stop()
