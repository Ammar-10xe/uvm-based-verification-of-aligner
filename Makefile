ENV_DIR = $(shell pwd)

# Simulator executables and directories
QUESTA_HOME = $(QUESTA)
VCS_HOME =
XCELIUM_HOME =

SIM = questa
gui = 0
test = cfs_algn_test_reg_access

ifeq ($(SIM), questa)
	BUILD_CMD   = vlog
	SIM_CMD     = vsim
	BUILD_OPTS  = -L $(QUESTA_HOME)/uvm-1.2 
	BUILD_OPTS += -sv -timescale=1ns/1ps
	BUILD_OPTS += -work $(ENV_DIR)/sim/work
	BUILD_OPTS += -l $(ENV_DIR)/logs/compile.log
	SIM_OPTS    = -work $(ENV_DIR)/sim/work work.testbench 
	SIM_OPTS   += -voptargs=+acc $(gui_flag)
	SIM_OPTS   += -l $(ENV_DIR)/logs/sim.log
	SIM_OPTS   += -do "run -all;"
	SIM_OPTS   += -suppress 7067 -suppress 3839
	INCDIR     = +incdir+$(ENV_DIR)/design
	INCDIR    += +incdir+$(ENV_DIR)/tb
	ifeq ($(gui), 1)
	gui_flag = -gui
	else 
	gui_flag = -c
	endif
else ifeq ($(SIM), vcs)
	BUILD_CMD = vcs
else ifeq ($(SIM), xcelium)
	BUILD_CMD = xrun
endif

build:
	vlib work
	mkdir -p $(ENV_DIR)/sim/work $(ENV_DIR)/logs
	$(BUILD_CMD) $(BUILD_OPTS) $(INCDIR) design/design.sv tb/testbench.sv

run:
	mkdir -p $(ENV_DIR)/logs
	$(SIM_CMD) $(SIM_OPTS) +UVM_TESTNAME=$(test)

clean:
	rm -rf $(ENV_DIR)/sim/work $(ENV_DIR)/logs $(ENV_DIR)/work *.vcd transcript

all: clean build run