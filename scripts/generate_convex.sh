# cf. https://github.com/isri-aist/generate_robot_description/blob/main/generate_robot_description.sh

export gen_path="/tmp/g1_description"
export tmp_path="/tmp/generate_g1_description"
export model_name="g1"
export sample_points=2000

exit_if_error()
{
  if [ $? -ne 0 ]
  then
    echo "-- FATAL ERROR: $1"
    exit 1
  fi
}

function generate_convexes()
{
    # Generate convexes (convert to qhull's pointcloud and compute convex hull file)
    for mesh in ${gen_path}/meshes/*.STL
    do
        mesh_name=`basename -- "$mesh"`
        mesh_name="${mesh_name%.*}"
        echo "-- Generating convex hull for ${mesh}"
        gen_convex_dir=${gen_path}/convex/${model_name}
        mkdir -p ${gen_convex_dir}
        mesh_sampling --in ${mesh} --convex ${gen_convex_dir} --type xyz --samples ${sample_points}
        exit_if_error "Failed to sample pointcloud from mesh ${mesh} to ${gen_cloud}"
    done
}

echo "-- Generating convex for ${model_name}"
mkdir -p ${gen_path}
this_dir=`cd $(dirname $0); pwd`
robot_dir=`cd $this_dir/..; pwd`
cp -r ${robot_dir}/meshes ${gen_path}
generate_convexes
