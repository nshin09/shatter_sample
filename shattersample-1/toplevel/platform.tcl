# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\Jun_H\shattersample-1\toplevel\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\Jun_H\shattersample-1\toplevel\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {toplevel}\
-hw {C:\Users\Jun_H\fuckeverything\fuckeverything\toplevel.xsa}\
-out {C:/Users/Jun_H/shattersample-1}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {toplevel}
platform generate -quick
platform clean
platform generate
platform active {toplevel}
platform config -updatehw {C:/Users/Jun_H/fuckeverything/fuckeverything/toplevel.xsa}
platform clean
platform generate
platform config -updatehw {C:/Users/Jun_H/fuckeverything/fuckeverything/toplevel.xsa}
platform clean
platform generate
