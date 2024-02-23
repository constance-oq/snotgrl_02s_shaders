extends ArrayMesh

@export var mesh : ArrayMesh;	# Possible to deprecate in favour of "extends"
	
func smooth_all_normals( mesh: ArrayMesh ):
	for i in range( mesh.get_surface_count() ):
		surface_smooth_all_normals( mesh, i )

func surface_smooth_all_normals( mesh: ArrayMesh, surface: int ):
	# Optimization VERY possible
	var mdt: MeshDataTool = MeshDataTool.new()
	mdt.create_from_surface( mesh, 0 )
	var vert_count = mdt.get_vertex_count()
	
	var new_normals : Array[ Vector3 ] = []
	
	for vert in range( vert_count ):
		var same_pos_verts = get_same_pos_verts( mdt, vert )
		var mean = smooth_normals_by_verts( mdt, vert, same_pos_verts )
		new_normals.append( mean )
		
	for i in range( len( new_normals ) ):
		mdt.set_vertex_normal( i, new_normals[ i ] )
		
	mdt.commit_to_surface( mesh, surface )

func get_same_pos_verts(
	mdt: MeshDataTool,
	vert: int
):
	var vert_count = mdt.get_vertex_count()
	var same_pos_verts: Array[ int ] = []
	
	for other_vert in range( 0, vert_count ):
		if other_vert == vert: continue;
		var same_pos: bool = (
			mdt.get_vertex( vert ) 
			== mdt.get_vertex( other_vert )
		)
		if !same_pos: continue;
		same_pos_verts.append( other_vert )
	return same_pos_verts

func smooth_normals_by_verts(
	mdt : MeshDataTool,
	this_vert_index : int,
	other_vert_indices : Array[ int ],
):
	var mean : Vector3 = Vector3.ZERO
	var normals : Array[ Vector3 ] = []
	
	normals.append( mdt.get_vertex_normal( this_vert_index ) )
	for i in other_vert_indices:
		normals.append( mdt.get_vertex_normal( i ) )

	for normal in normals:
		mean += normal;
	mean /= len( normals )
	return mean
