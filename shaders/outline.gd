@tool

extends MeshInstance3D

const outline_material = preload("res://shaders/outline_material.tres")
@export_range( 0.0, 0.3, 0.000001, "or_greater", "or_less" ) var outline_width: float = 0.005:
	set( value ):
		outline_width = value
		mesh_instance_outline()

# This is a button in disguise as a checkbox
@export var delete_this_outline: bool = false:
	set( value ):
		delete_this_outline = false
		delete_outline()
		print( "Outline deleted for node '" + name + "'. So long, sucker!" )

func mesh_instance_outline():
	if get_parent() == null: return
	delete_outline()
	
	var dup_mesh_inst: MeshInstance3D = MeshInstance3D.new()
	dup_mesh_inst.name = name + "_outline"
	dup_mesh_inst.transform = transform
	dup_mesh_inst.mesh = mesh.create_outline( outline_width )
	dup_mesh_inst.skeleton = skeleton
	dup_mesh_inst.skin = skin
	for i in range( 0, dup_mesh_inst.mesh.get_surface_count() ):
		dup_mesh_inst.mesh.surface_set_material( i, outline_material )
	
	# Deferred call gives parent time to "set up children". Prevents error.
	get_parent().add_child.call_deferred( dup_mesh_inst )

func delete_outline():
	if get_parent() == null: return
	for sibling in get_parent().get_children():
		if !sibling.name == ( name + "_outline" ): continue
		sibling.free()

func _ready():
	mesh_instance_outline()
