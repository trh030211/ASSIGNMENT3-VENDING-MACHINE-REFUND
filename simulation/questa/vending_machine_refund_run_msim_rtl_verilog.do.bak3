transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/FPGA/AS3/LAB3/RTL {D:/FPGA/AS3/LAB3/RTL/vending_machine_refund.v}

vlog -vlog01compat -work work +incdir+D:/FPGA/AS3/LAB3/SIM {D:/FPGA/AS3/LAB3/SIM/vending_machine_refund_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  vending_machine_refund_tb

add wave *
view structure
view signals
run 1 us
