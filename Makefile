ENV_DIR = $(shell pwd)

# Simulator executables and directories
QUESTA_HOME = $(QUESTA)
VCS_HOME =
XCELIUM_HOME =

SIM = questa
gui = 0
tests = cfs_algn_test_reg_access

default_test = $(word 1, $(tests))

ifeq ($(SIM), questa)
	BUILD_CMD   = vlog
	SIM_CMD     = vsim
	BUILD_OPTS  = -L $(QUESTA_HOME)/uvm-1.2 \
		-sv -timescale=1ns/1ps \
		-work $(ENV_DIR)/sim/work \
		-l $(ENV_DIR)/logs/compile.log
	SIM_OPTS    = -work work work.testbench \
		-voptargs=+acc $(gui_flag) \
		-l $(ENV_DIR)/logs/sim.log \
		-do "run -all; quit;" \
		-suppress 7067 -suppress 3839
	INCDIR     = +incdir+$(ENV_DIR)/design +incdir+$(ENV_DIR)/tb
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
	@echo "[BUILD] Creating work and logs directories..."
	@mkdir -p $(ENV_DIR)/sim/work $(ENV_DIR)/logs
	@vlib $(ENV_DIR)/sim/work
	@vmap work $(ENV_DIR)/sim/work
	@echo "[BUILD] Compiling design and testbench..."
	@$(BUILD_CMD) $(BUILD_OPTS) $(INCDIR) design/design.sv tb/testbench.sv

run:
	@echo "[SIM] Running simulation(s)..."
	@mkdir -p $(ENV_DIR)/logs
	@for test in $(tests); do \
		$(SIM_CMD) $(SIM_OPTS) +UVM_TESTNAME=$$test; \
	done

waves:
	@echo "[WAVES] Opening GTKWave..."
	@gtkwave *.vcd &

clean:
	@echo "[CLEAN] Removing simulation and log files..."
	@rm -rf $(ENV_DIR)/sim/ $(ENV_DIR)/logs $(ENV_DIR)/work *.vcd transcript *.wlf *.log *.ucdb *.ini

all: clean build run

.PHONY: all build run clean waves