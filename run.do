vlib work
vlog master.v +acc
vsim -debugDB master
add schematic -full master
add wave -r *
run -all
