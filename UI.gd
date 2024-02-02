extends Panel

signal params_changed(amplitude, frequency);

var amplitude = 0.0;
var frequency = 0.0;
var amp_label;
var freq_label;

func _ready():
	amp_label = get_node("VBoxContainer/Amplitude");
	freq_label = get_node("VBoxContainer/Frequency");


func _on_amplitude_slider_value_changed(value):
	amplitude = value;
	amp_label.text = "amplitude: " + str(amplitude).left(3)

func _on_frequency_slider_value_changed(value):
	frequency = value;
	freq_label.text = "fequency: " + str(frequency).left(3) + " Hz"
	
func _process(_delta_time):
	emit_signal("params_changed", amplitude, frequency);
